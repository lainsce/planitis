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
        public Gtk.Grid grid;
        public Gtk.Grid sgrid;
        public Hdy.HeaderBar titlebar;
        public Hdy.HeaderBar fauxtitlebar;
        public Gtk.Box main_frame_grid;

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
            // Ensure use of elementary theme and icons, accent color doesn't matter
            Gtk.Settings.get_default().set_property("gtk-theme-name", "io.elementary.stylesheet.blueberry");
            Gtk.Settings.get_default().set_property("gtk-icon-theme-name", "elementary");
            
            titlebar = new Hdy.HeaderBar() {
                title = "Planitis",
                hexpand = true,
                decoration_layout = ":maximize",
                has_subtitle = false,
                show_close_button = true
            };
            titlebar.set_size_request (200,45);
            titlebar.get_style_context ().add_class ("pl-toolbar");

            var dark_header = new Granite.HeaderLabel (_("Interface"));

            var dark_label = new Gtk.Label (_("Dark Mode:")) {
                halign = Gtk.Align.END
            };

            var dark_sw = new Gtk.Switch ();
            dark_sw.halign = Gtk.Align.START;
            dark_sw.valign = Gtk.Align.CENTER;
            Planitis.Application.gsettings.bind ("dark-mode", dark_sw, "active", GLib.SettingsBindFlags.DEFAULT);

            var menu_grid = new Gtk.Grid () {
                margin = 12,
                row_spacing = 6,
                column_spacing = 12,
                orientation = Gtk.Orientation.VERTICAL
            };
            menu_grid.attach (dark_header,0,0,1,1);
            menu_grid.attach (dark_label,0,1,1,1);
            menu_grid.attach (dark_sw,1,1,1,1);
            menu_grid.show_all ();

            var menu = new Gtk.Popover (null);
            menu.add (menu_grid);

            var menu_button = new Gtk.MenuButton () {
                image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR),
                has_tooltip = true,
                tooltip_text = (_("Settings")),
                popover = menu
            };
            var menu_button_style_context = menu_button.get_style_context ();
            menu_button_style_context.add_class ("tt-button");
            menu_button_style_context.add_class ("image-button");

            titlebar.pack_end (menu_button);
            
            var explody_button = new Gtk.Button () {
                image = new Gtk.Image.from_icon_name ("explosion-symbolic", Gtk.IconSize.BUTTON),
                has_tooltip = true,
                tooltip_text = (_("Reset Game"))
            };
            explody_button.get_style_context ().add_class ("destructive-button");
            explody_button.clicked.connect (reset_cb);
            titlebar.pack_start (explody_button);
            
            var main_stack = new Gtk.Stack () {
                margin = 12
            };

            var main_stackswitcher = new Gtk.StackSwitcher () {
                orientation = Gtk.Orientation.VERTICAL,
                valign = Gtk.Align.CENTER,
                stack = main_stack,
                halign = Gtk.Align.CENTER,
                homogeneous = true,
                margin_top = 6
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
                hexpand = true,
                fraction = infogrid.c_res/infogrid.c_total,
                show_text = true,
                text = """Crystal: %.2f""".printf(infogrid.c_res)
            };
            cpbs.get_style_context ().add_class ("pl-progressbar");
            hpbs = new Gtk.ProgressBar () {
                hexpand = true,
                fraction = infogrid.h_res/infogrid.h_total,
                show_text = true,
                text = """H²: %.2f""".printf(infogrid.h_res)
            };
            hpbs.get_style_context ().add_class ("pl-progressbar");

            var stats_box = new Gtk.Grid () {
                orientation = Gtk.Orientation.VERTICAL,
                row_spacing = 6,
                margin = 6,
                valign = Gtk.Align.CENTER,
                halign = Gtk.Align.CENTER
            };
            stats_box.add (mpbs);
            stats_box.add (cpbs);
            stats_box.add (hpbs);

            var column = new Gtk.Grid () {
                orientation = Gtk.Orientation.VERTICAL,
                vexpand = true
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
            fauxtitlebar.set_size_request (200,45);
            fauxtitlebar.get_style_context ().add_class ("pl-column");
            fauxtitlebar.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            
            sgrid = new Gtk.Grid ();
            sgrid.attach (fauxtitlebar, 0, 0, 1, 1);
            sgrid.attach (column, 0, 1, 1, 1);
            sgrid.show_all ();

            main_frame_grid = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                expand = true
            };
            main_frame_grid.get_style_context ().add_class ("pl-window");
            main_frame_grid.add (main_stack);
            
            grid = new Gtk.Grid ();
            grid.attach (titlebar, 1, 0, 1, 1);
            grid.attach (main_frame_grid, 1, 1, 1, 1);
            grid.show_all ();

            var separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            var separator_cx = separator.get_style_context ();
            separator_cx.add_class ("vsep");

            leaflet = new Hdy.Leaflet () {
                transition_type = Hdy.LeafletTransitionType.UNDER,
                can_swipe_back = true
            };
            leaflet.add (sgrid);
            leaflet.add (separator);
            leaflet.add (grid);
            leaflet.set_visible_child (grid);
            leaflet.child_set_property (separator, "allow-visible", false);
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
            } else {
                // Else you're on Desktop size, so business as usual.
                fauxtitlebar.set_decoration_layout ("close:");
                titlebar.set_decoration_layout (":maximize");
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