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

namespace Reganam {
    public class MainWindow : Gtk.Window {
        public double m_res = 0.0;
        public double c_res = 0.0;
        public double h_res = 0.0;
        public double l_res = 0.0;
        public double m_total = 1000.0;
        public double c_total = 1000.0;
        public double h_total = 1000.0;
        public double m_mine_level = 0.0;
        public double m_total_mine = 100.0;
        public double c_mine_level = 0.0;
        public double c_total_mine = 100.0;
        public double h_mine_level = 0.0;
        public double h_total_mine = 100.0;
        public double l_level = 0.0;
        public double l_total = 12.0;
        public Gtk.ProgressBar mpb;
        public Gtk.ProgressBar cpb;
        public Gtk.ProgressBar hpb;
        public Gtk.ProgressBar lpm;
        public Gtk.Separator sep;
        public MainWindow (Gtk.Application app) {
            GLib.Object (
                         application: app,
                         icon_name: "com.github.lainsce.reganam",
                         height_request: 600,
                         width_request: 800,
                         title: "Reganam"
            );
            this.get_style_context().add_class("rounded");

            var settings = AppSettings.get_default ();
            if (settings.metal == 0.0 &&
                settings.crystal == 0.0 &&
                settings.hydrogen == 0.0 &&
                settings.metal_mine == 0.0 &&
                settings.crystal_mine == 0.0 &&
                settings.hydrogen_mine == 0.0 &&
                settings.lab_level == 0.0) {
                    m_res = 100.0;
                    c_res = 100.0;
                    h_res = 0.0;
                    m_mine_level = 0.0;
                    c_mine_level = 0.0;
                    h_mine_level = 0.0;
                    l_level = 0.0;
            } else {
                m_res = settings.metal;
                c_res = settings.crystal;
                h_res = settings.hydrogen;
                m_mine_level = settings.metal_mine;
                c_mine_level = settings.crystal_mine;
                h_mine_level = settings.hydrogen_mine;
                l_level = settings.lab_level;
            }
        }

        private Gtk.Widget get_info_grid () {
            var textstyle_grid = new Gtk.Grid ();
            textstyle_grid.expand = true;
            textstyle_grid.row_spacing = 6;
            textstyle_grid.column_spacing = 12;

            sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.hexpand = true;
            sep.margin_start = 12;

            var header_planet = new Granite.HeaderLabel (_("PlanetName"));
            var type_of_planet = new Label (_("Type: Warm Terra"));
            var type_of_atm = new Label (_("Atmosphere: Nitrogen & Oxygen"));
            var mineral_label = new Label (_("Mineral:"));
            var crystal_label = new Label (_("Crystal:"));
            var h_label = new Label (_("Hydrogen:"));

            mpb = new Gtk.ProgressBar ();
            mpb.hexpand = true;
            mpb.fraction = m_res/m_total;
            mpb.set_show_text (true);
            mpb.set_text ("""%.2f/%.2f""".printf(m_res, m_total));

            cpb = new Gtk.ProgressBar ();
            cpb.hexpand = true;
            cpb.fraction = c_res/c_total;
            cpb.set_show_text (true);
            cpb.set_text ("""%.2f/%.2f""".printf(c_res, c_total));

            hpb = new Gtk.ProgressBar ();
            hpb.hexpand = true;
            hpb.fraction = h_res/h_total;
            hpb.set_show_text (true);
            hpb.set_text ("""%.2f/%.2f""".printf(h_res, h_total));

            textstyle_grid.attach (header_planet, 0, 0, 5, 1);
            textstyle_grid.attach (type_of_planet, 0, 2, 3, 1);
            textstyle_grid.attach (type_of_atm, 0, 3, 3, 1);
            textstyle_grid.attach (sep, 0, 4, 5, 1);
            textstyle_grid.attach (mineral_label, 0, 5, 3, 1);
            textstyle_grid.attach (mpb, 1, 5, 4, 1);
            textstyle_grid.attach (crystal_label, 0, 6, 3, 1);
            textstyle_grid.attach (cpb, 1, 6, 4, 1);
            textstyle_grid.attach (h_label, 0, 7, 3, 1);
            textstyle_grid.attach (hpb, 1, 7, 4, 1);

            return textstyle_grid;
        }

        private Gtk.Widget get_mine_grid () {
            var textstyle_grid = new Gtk.Grid ();
            textstyle_grid.expand = true;
            textstyle_grid.row_spacing = 6;
            textstyle_grid.column_spacing = 12;

            sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.hexpand = true;
            sep.margin_start = 12;

            var header_planet = new Granite.HeaderLabel (_("Mines & Storage"));
            var mineral_label = new Label (_("Mineral Mine:"));
            var crystal_label = new Label (_("Crystal Mine:"));
            var h_label = new Label (_("Hydrogen Mine:"));

            var mpm = new Gtk.ProgressBar ();
            mpm.hexpand = true;
            mpm.fraction = m_mine_level/m_total_mine;
            mpm.set_show_text (true);
            mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));

            var cpm = new Gtk.ProgressBar ();
            cpm.hexpand = true;
            cpm.fraction = c_mine_level/c_total_mine;
            cpm.set_show_text (true);
            cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));

            var hpm = new Gtk.ProgressBar ();
            hpm.hexpand = true;
            hpm.fraction = h_mine_level/h_total_mine;
            hpm.set_show_text (true);
            hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));

            var button_m = new Gtk.Button.with_label (_("Build!"));
            var button_c = new Gtk.Button.with_label (_("Build!"));
            var button_h = new Gtk.Button.with_label (_("Build!"));

            button_m.clicked.connect (() => {
                if (m_res >= (50 * m_mine_level) && c_res >= (20 * m_mine_level)) {
                    m_mine_level += 1;
                    m_res -= 50;
                    c_res -= 30;
                    mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));
                    mpm.set_fraction (m_mine_level/m_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            button_c.clicked.connect (() => {
                if (m_res >= (20 * c_mine_level) && c_res >= (50 * c_mine_level)) {
                    c_mine_level += 1;
                    m_res -= 20;
                    c_res -= 50;
                    cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));
                    cpm.set_fraction (c_mine_level/c_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            button_h.clicked.connect (() => {
                if (m_res >= (150 * m_mine_level) && c_res >= (150 * m_mine_level)) {
                    h_mine_level += 1;
                    m_res -= 150;
                    c_res -= 150;
                    hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));
                    hpm.set_fraction (h_mine_level/h_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            textstyle_grid.attach (header_planet, 0, 0, 5, 1);
            textstyle_grid.attach (sep, 0, 1, 5, 1);
            textstyle_grid.attach (mineral_label, 0, 2, 1, 1);
            textstyle_grid.attach (mpm, 1, 2, 3, 1);
            textstyle_grid.attach (button_m, 4, 2, 1, 1);
            textstyle_grid.attach (crystal_label, 0, 3, 1, 1);
            textstyle_grid.attach (cpm, 1, 3, 3, 1);
            textstyle_grid.attach (button_c, 4, 3, 1, 1);
            textstyle_grid.attach (h_label, 0, 4, 1, 1);
            textstyle_grid.attach (hpm, 1, 4, 3, 1);
            textstyle_grid.attach (button_h, 4, 4, 1, 1);

            return textstyle_grid;
        }

        private Gtk.Widget get_lab_grid () {
            var textstyle_grid = new Gtk.Grid ();
            textstyle_grid.expand = true;
            textstyle_grid.row_spacing = 6;
            textstyle_grid.column_spacing = 12;

            sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.hexpand = true;
            sep.margin_start = 12;

            var header_planet = new Granite.HeaderLabel (_("Research Lab & Technologies"));
            var lab_label = new Label (_("Research Lab:"));

            lpm = new Gtk.ProgressBar ();
            lpm.hexpand = true;
            lpm.fraction = l_res/l_total;
            lpm.set_show_text (true);
            lpm.set_text ("""%.0f/%.0f""".printf(l_res, l_total));

            var button_l = new Gtk.Button.with_label (_("Build!"));

            button_l.clicked.connect (() => {
                if (m_res >= (200 * l_level) && c_res >= (200 * l_level) && h_res >= (100 * l_level)) {
                    l_level += 1;
                    m_res -= 200;
                    c_res -= 200;
                    h_res -= 100;
                    lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
                    lpm.set_fraction (l_level/l_total);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            textstyle_grid.attach (header_planet, 0, 0, 5, 1);
            textstyle_grid.attach (lab_label, 0, 2, 1, 1);
            textstyle_grid.attach (lpm, 1, 2, 3, 1);
            textstyle_grid.attach (button_l, 4, 2, 1, 1);
            textstyle_grid.attach (sep, 0, 4, 5, 1);

            return textstyle_grid;
        }

        construct {
             var header = new Gtk.HeaderBar();
             header.has_subtitle = false;
             header.set_show_close_button (true);
             header.title = this.title;
             this.set_titlebar(header);

             var main_stack = new Gtk.Stack ();
             main_stack.margin = 12;
             var main_stackswitcher = new Gtk.StackSwitcher ();
             main_stackswitcher.stack = main_stack;
             main_stackswitcher.halign = Gtk.Align.CENTER;
             main_stackswitcher.homogeneous = true;
             main_stackswitcher.margin = 12;
             main_stackswitcher.margin_top = 0;

             main_stack.add_titled (get_info_grid (), "info", _("Info"));
             main_stack.add_titled (get_mine_grid (), "mine", _("Mines"));
             main_stack.add_titled (get_lab_grid (), "lab", _("Research"));

             var main_grid = new Gtk.Grid ();
             main_grid.expand = true;
             main_grid.margin_top = 6;
             main_grid.attach (main_stackswitcher, 0, 0, 1, 1);
             main_grid.attach (main_stack, 0, 1, 1, 1);

             this.add (main_grid);
             this.show_all ();

             update_base_values ();

             Timeout.add_seconds (10, () => {
                update_base_values ();
             });
        }

        public void update_base_values () {
            m_res += 1.55;
            c_res += 1.25;
            h_res += 0.00;
            update_m_value ();
            update_c_value ();
            update_h_value ();
            if (m_mine_level > 0 || c_mine_level > 0) {
                m_res += (1.55 * m_mine_level);
                c_res += (1.25 * c_mine_level);
                update_m_value ();
                update_c_value ();
                if (h_mine_level > 0) {
                    h_res += (1.10 * h_mine_level);
                    update_h_value ();
                }
            }
        }

        public void update_m_value () {
            mpb.set_fraction(m_res/m_total);
            mpb.set_text ("""%.2f/%.2f""".printf(m_res, m_total));
        }

        public void update_c_value () {
            cpb.set_fraction(c_res/c_total);
            cpb.set_text ("""%.2f/%.2f""".printf(c_res, c_total));
        }

        public void update_h_value () {
            hpb.set_fraction(h_res/h_total);
            hpb.set_text ("""%.2f/%.2f""".printf(h_res, h_total));
        }

        public override bool delete_event (Gdk.EventAny event) {
            var settings = AppSettings.get_default ();
            int x, y;
            this.get_position (out x, out y);
            settings.window_x = x;
            settings.window_y = y;
            settings.metal = m_res;
            settings.crystal = c_res;
            settings.hydrogen = h_res;
            settings.metal_mine = m_mine_level;
            settings.crystal_mine = c_mine_level;
            settings.hydrogen_mine = h_mine_level;
            settings.lab_level = l_level;
            return false;
        }
    }

    private class Label : Gtk.Label {
        public Label (string text) {
            label = text;
            halign = Gtk.Align.START;
            margin_start = 12;
        }
    }
}
