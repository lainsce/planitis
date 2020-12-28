/*
* Copyright (c) 2019 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

namespace Planitis {
    public class MainWindow : Hdy.ApplicationWindow {
        public Gtk.Application app { get; construct; }
        public Services.Utils.Base base_utils;
        public Services.GameSaveManager gsm;
        public bool resetted = false;
        public Hdy.Leaflet leaflet;
        public Gtk.Overlay grid;
        public Gtk.Grid sgrid;
        public Hdy.HeaderBar titlebar;
        public Hdy.HeaderBar fauxtitlebar;
        public Gtk.Box main_frame_grid;
        public Gtk.Button back_button;
        public Gtk.Button next_button;
        public Gtk.Label planet_header;
        public Gtk.ProgressBar mpbs;
        public Gtk.ProgressBar cpbs;
        public Gtk.ProgressBar hpbs;

        public Widgets.InfoGrid infogrid;
        public Widgets.BuildGrid buildgrid;
        public Widgets.ResGrid resgrid;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                app: application,
                icon_name: "com.github.lainsce.planitis",
                title: "Planitis"
            );

            if (Planitis.Application.gsettings.get_boolean("dark-mode")) {
                Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
                titlebar.get_style_context ().add_class ("pl-toolbar-dark");
                main_frame_grid.get_style_context ().add_class ("pl-window-dark");
            } else {
                Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = false;
                titlebar.get_style_context ().remove_class ("pl-toolbar-dark");
                main_frame_grid.get_style_context ().remove_class ("pl-window-dark");
            }

            if (Planitis.Application.grsettings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK) {
                Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
                titlebar.get_style_context ().add_class ("pl-toolbar-dark");
                main_frame_grid.get_style_context ().add_class ("pl-window-dark");
            } else if (Planitis.Application.grsettings.prefers_color_scheme == Granite.Settings.ColorScheme.NO_PREFERENCE) {
                Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = false;
                titlebar.get_style_context ().remove_class ("pl-toolbar-dark");
                main_frame_grid.get_style_context ().remove_class ("pl-window-dark");
            }

            Planitis.Application.grsettings.notify["prefers-color-scheme"].connect (() => {
                if (Planitis.Application.grsettings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK) {
                    Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
                    titlebar.get_style_context ().add_class ("pl-toolbar-dark");
                    main_frame_grid.get_style_context ().add_class ("pl-window-dark");
                } else if (Planitis.Application.grsettings.prefers_color_scheme == Granite.Settings.ColorScheme.NO_PREFERENCE) {
                    Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = false;
                    titlebar.get_style_context ().remove_class ("pl-toolbar-dark");
                    main_frame_grid.get_style_context ().remove_class ("pl-window-dark");
                }
            });
        }

        construct {
            Hdy.init ();
            gsm = new Services.GameSaveManager (this);

            Planitis.Application.gsettings.changed.connect (() => {
                if (Planitis.Application.gsettings.get_boolean("dark-mode")) {
                    Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
                    titlebar.get_style_context ().add_class ("pl-toolbar-dark");
                    main_frame_grid.get_style_context ().add_class ("pl-window-dark");
                } else {
                    Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = false;
                    titlebar.get_style_context ().remove_class ("pl-toolbar-dark");
                    main_frame_grid.get_style_context ().remove_class ("pl-window-dark");
                }
            });

            int x = Planitis.Application.gsettings.get_int("window-x");
            int y = Planitis.Application.gsettings.get_int("window-y");
            int h = Planitis.Application.gsettings.get_int("window-height");
            int w = Planitis.Application.gsettings.get_int("window-width");
            if (x != -1 && y != -1) {
                this.move (x, y);
            }
            if (w != 0 && h != 0) {
                this.resize (w, h);
            }

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/lainsce/planitis/app.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/lainsce/planitis");

            var provider2 = new Gtk.CssProvider ();
            string res1 = "\"resource:///com/github/lainsce/planitis/res/bg1.png\"";
            string res2 = "\"resource:///com/github/lainsce/planitis/res/bg2.png\"";
            string css = """
                .pl-window {
                    background-image: url(%s);
                    background-repeat: repeat;
                }
                .pl-window-dark {
                    background-image: url(%s);
                    background-repeat: repeat;
                }
             """.printf(res1, res2);
             try {
                provider2.load_from_data(css, -1);
             } catch (GLib.Error e) {
                warning ("Failed to parse css style : %s", e.message);
             }
             Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),provider2,
                                                                  Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            titlebar = new Hdy.HeaderBar() {
                title = "Planitis",
                hexpand = true,
                decoration_layout = ":maximize",
                has_subtitle = false,
                show_close_button = true,
                valign = Gtk.Align.START
            };
            titlebar.set_size_request (200,38);
            titlebar.get_style_context ().add_class ("pl-toolbar");

            back_button = new Gtk.Button () {
                has_tooltip = true,
                image = new Gtk.Image.from_icon_name ("go-previous-symbolic", Gtk.IconSize.BUTTON),
                tooltip_text = (_("See Info"))
            };
            titlebar.pack_start (back_button);
            back_button.clicked.connect (() => {
                leaflet.set_visible_child (sgrid);
            });

            var explody_button = new Gtk.Button () {
                image = new Gtk.Image.from_icon_name ("explosion-symbolic", Gtk.IconSize.BUTTON),
                has_tooltip = true,
                always_show_image = true,
                tooltip_text = (_("Resets the Game")),
                label = (_("Explode the Planet"))
            };
            explody_button.get_style_context ().add_class ("flat");
            explody_button.get_style_context ().add_class ("destructive-button");
            explody_button.clicked.connect (reset_cb);
            
            var actionbar = new Gtk.ActionBar ();
            actionbar.add (explody_button);
            actionbar.get_style_context ().add_class ("pl-bar");
            actionbar.get_style_context ().add_class ("flat");
            actionbar.get_style_context ().add_class ("inline-toolbar");

            var main_stack = new Gtk.Stack () {
                margin = 12,
                homogeneous = false
            };

            var main_stackswitcher = new Gtk.StackSwitcher () {
                orientation = Gtk.Orientation.VERTICAL,
                valign = Gtk.Align.CENTER,
                stack = main_stack,
                homogeneous = true,
                margin_top = 6,
                margin_end = 2
            };
            main_stackswitcher.set_size_request (185,-1);
            main_stackswitcher.get_style_context ().add_class ("pl-switcher");

            if (resetted) {
                resetted = false;
            } else {
                gsm.load_from_file ();
            }

            infogrid = new Widgets.InfoGrid (this);
            resgrid = new Widgets.ResGrid (this);
            buildgrid = new Widgets.BuildGrid (this);

            gsm.load_from_file ();

            base_utils = new Services.Utils.Base (this);

            base_utils.update_base_values ();
            gsm.save_game ();
            Timeout.add_seconds (10, () => {
                base_utils.update_base_values ();
                gsm.save_game ();

                if (
                    buildgrid.m_mine_level == 100.0 &&
                    buildgrid.c_mine_level == 100.0 &&
                    buildgrid.h_mine_level == 100.0 &&
                    resgrid.l_level == 12.0 &&
                    resgrid.sym_level == 12.0 &&
                    resgrid.syc_level == 12.0 &&
                    resgrid.syh_level == 12.0 &&
                    resgrid.phs_level == 12.0
                ) {
                    win_cb ();
                }
                return true;
            });

            main_stack.add_titled (infogrid, "info", (_("INFO")));
            main_stack.add_titled (buildgrid, "mine", (_("BUILDINGS")));
            main_stack.add_titled (resgrid, "lab", (_("RESEARCH")));

            var column_header = new Gtk.Label (_("VIEWS")) {
                halign = Gtk.Align.START,
                margin_start = 9
            };
            column_header.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            planet_header = new Gtk.Label (_("%s".printf(infogrid.planet_name.up()))) {
                halign = Gtk.Align.START,
                margin_start = 9
            };
            planet_header.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            mpbs = new Gtk.ProgressBar () {
                hexpand = true,
                fraction = infogrid.m_res/infogrid.m_total,
                show_text = true,
                text = """Metal: %.2f""".printf(infogrid.m_res)
            };
            mpbs.get_style_context ().add_class ("pl-progressbar");
            cpbs = new Gtk.ProgressBar () {
                fraction = infogrid.c_res/infogrid.c_total,
                show_text = true,
                text = """Crystal: %.2f""".printf(infogrid.c_res)
            };
            cpbs.get_style_context ().add_class ("pl-progressbar");
            hpbs = new Gtk.ProgressBar () {
                fraction = infogrid.h_res/infogrid.h_total,
                show_text = true,
                text = """H²: %.2f""".printf(infogrid.h_res)
            };
            hpbs.get_style_context ().add_class ("pl-progressbar");

            var stats_box = new Gtk.Grid () {
                orientation = Gtk.Orientation.VERTICAL,
                row_spacing = 6,
                margin = 6,
                valign = Gtk.Align.CENTER
            };
            stats_box.add (mpbs);
            stats_box.add (cpbs);
            stats_box.add (hpbs);

            var column = new Gtk.Grid () {
                orientation = Gtk.Orientation.VERTICAL,
                vexpand = true,
                hexpand_set = true
            };
            column.add (planet_header);
            column.add (stats_box);
            column.add (column_header);
            column.add (main_stackswitcher);
            column.get_style_context ().add_class ("pl-column");

            fauxtitlebar = new Hdy.HeaderBar () {
                show_close_button = true,
                has_subtitle = false
            };
            fauxtitlebar.set_size_request (-1,38);
            fauxtitlebar.get_style_context ().add_class ("pl-column-bar");
            fauxtitlebar.get_style_context ().add_class ("pl-toolbar");

            next_button = new Gtk.Button () {
                has_tooltip = true,
                image = new Gtk.Image.from_icon_name ("go-next-symbolic", Gtk.IconSize.BUTTON),
                tooltip_text = (_("Back to Game"))
            };
            fauxtitlebar.pack_end (next_button);
            next_button.clicked.connect (() => {
                leaflet.set_visible_child (grid);
            });
            next_button.get_style_context ().add_class ("pl-button");

            sgrid = new Gtk.Grid ();
            sgrid.attach (fauxtitlebar, 0, 0);
            sgrid.attach (column, 0, 1);
            sgrid.attach (actionbar, 0, 2);
            sgrid.set_size_request (200,-1);
            sgrid.show_all ();

            main_frame_grid = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                expand = true
            };
            main_frame_grid.get_style_context ().add_class ("pl-window");
            main_frame_grid.add (main_stack);

            grid = new Gtk.Overlay ();
            grid.add (main_frame_grid);
            grid.add_overlay (titlebar);
            grid.show_all ();

            leaflet = new Hdy.Leaflet () {
                transition_type = Hdy.LeafletTransitionType.UNDER,
                can_swipe_back = true
            };
            leaflet.add (sgrid);
            leaflet.add (grid);
            leaflet.set_visible_child (grid);
            leaflet.show_all ();

            update ();
            leaflet.notify["folded"].connect (() => {
                update ();
            });

            this.add (leaflet);
            this.set_size_request (360, 435);
            this.show_all ();
        }

        public override bool delete_event (Gdk.EventAny event) {
            int x, y, w, h;
            get_position (out x, out y);
            get_size (out w, out h);

            Planitis.Application.gsettings.set_int("window-x", x);
            Planitis.Application.gsettings.set_int("window-y", y);
            Planitis.Application.gsettings.set_int("window-width", w);
            Planitis.Application.gsettings.set_int("window-height", h);
            gsm.save_game ();
            return false;
        }

        private void update () {
            if (leaflet != null && leaflet.get_folded ()) {
                // On Mobile size, so.... have to have no buttons anywhere.
                fauxtitlebar.set_decoration_layout (":");
                titlebar.set_decoration_layout (":");
                back_button.visible = true;
                back_button.no_show_all = false;
                next_button.visible = true;
                next_button.no_show_all = false;
                fauxtitlebar.hexpand = true;
            } else {
                // Else you're on Desktop size, so business as usual.
                fauxtitlebar.set_decoration_layout ("close:");
                titlebar.set_decoration_layout (":maximize");
                back_button.visible = false;
                back_button.no_show_all = true;
                next_button.visible = false;
                next_button.no_show_all = true;
                fauxtitlebar.hexpand = false;
            }
        }

        public void reset_cb () {
            if (resetted) {
                base_utils.reset_all ();
                resetted = true;
            }

            var dialog = new Services.Utils.ExplodyDialog (this);
            dialog.run ();
        }

        public void win_cb () {
            var dialog = new Services.Utils.WinnerDialog (this);
            dialog.run ();
        }
    }
}
