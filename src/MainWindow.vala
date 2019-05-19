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
        public double m_res;
        public double c_res;
        public double h_res;
        public double l_res;
        public double sym_res;
        public double syc_res;
        public double syh_res;
        public double m_total = 1000.0;
        public double c_total = 1000.0;
        public double h_total = 1000.0;
        public double m_mine_level;
        public double m_total_mine = 100.0;
        public double c_mine_level;
        public double c_total_mine = 100.0;
        public double h_mine_level;
        public double h_total_mine = 100.0;
        public double stm_level;
        public double stm_total = 10.0;
        public double stc_level;
        public double stc_total = 10.0;
        public double sth_level;
        public double sth_total = 10.0;
        public double l_level;
        public double l_total = 12.0;
        public double sym_level;
        public double sym_total = 12.0;
        public double syc_level;
        public double syc_total = 12.0;
        public double syh_level;
        public double syh_total = 12.0;
        public double diameter;
        public string planet_name = "";
        public string planet_type = "";
        public string planet_atm = "";
        public string planet_diameter = "";
        public Gtk.ProgressBar mpb;
        public Gtk.ProgressBar cpb;
        public Gtk.ProgressBar hpb;
        public MainWindow (Gtk.Application app) {
            GLib.Object (
                         application: app,
                         icon_name: "com.github.lainsce.reganam",
                         height_request: 600,
                         width_request: 800,
                         title: "Reganam"
            );
        }

        private Gtk.Widget get_info_grid () {
            var grid = new Gtk.Grid ();
            grid.expand = true;
            grid.row_spacing = 6;
            grid.column_spacing = 12;

            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;

            var header = new Granite.HeaderLabel (_(planet_name));
            var type_of_planet = new Label (_("Type:"));
            var type_of_planet_desc = new Gtk.Label ("");
            type_of_planet_desc.label = planet_type;
            type_of_planet_desc.halign = Gtk.Align.START;
            var type_of_atm = new Label (_("Atmosphere:"));
            var type_of_atm_desc = new Gtk.Label ("");
            type_of_atm_desc.label = planet_atm;
            type_of_atm_desc.halign = Gtk.Align.START;
            var size_diameter = new Label (_("Diameter:"));
            var size_diameter_desc = new Gtk.Label ("");
            size_diameter_desc.label = planet_diameter;
            size_diameter_desc.halign = Gtk.Align.START;
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

            grid.attach (header, 0, 0, 5, 1);
            grid.attach (sep, 0, 1, 5, 1);
            grid.attach (type_of_planet, 0, 2, 1, 1);
            grid.attach (type_of_planet_desc, 1, 2, 1, 1);
            grid.attach (type_of_atm, 0, 3, 1, 1);
            grid.attach (type_of_atm_desc, 1, 3, 1, 1);
            grid.attach (size_diameter, 0, 4, 1, 1);
            grid.attach (size_diameter_desc, 1, 4, 1, 1);
            grid.attach (sep2, 0, 5, 5, 1);
            grid.attach (mineral_label, 0, 6, 1, 1);
            grid.attach (mpb, 1, 6, 4, 1);
            grid.attach (crystal_label, 0, 7, 1, 1);
            grid.attach (cpb, 1, 7, 4, 1);
            grid.attach (h_label, 0, 8, 1, 1);
            grid.attach (hpb, 1, 8, 4, 1);

            return grid;
        }

        private Gtk.Widget get_mine_grid () {
            var grid = new Gtk.Grid ();
            grid.expand = true;
            grid.row_spacing = 6;
            grid.column_spacing = 12;

            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;

            var header = new Granite.HeaderLabel (_("Mines & Storage"));
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
                if (m_res >= (50 * (m_mine_level + 1)) && c_res >= (20 * (m_mine_level + 1))) {
                    m_mine_level += 1;
                    m_res -= (50 * (m_mine_level + 1));
                    c_res -= (30 * (m_mine_level + 1));
                    mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));
                    mpm.set_fraction (m_mine_level/m_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            button_c.clicked.connect (() => {
                if (m_res >= (20 * (c_mine_level + 1)) && c_res >= (50 * (c_mine_level + 1))) {
                    c_mine_level += 1;
                    m_res -= (20 * (c_mine_level + 1));
                    c_res -= (50 * (c_mine_level + 1));
                    cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));
                    cpm.set_fraction (c_mine_level/c_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            button_h.clicked.connect (() => {
                if (m_res >= (50 * (h_mine_level + 1)) && c_res >= (50 * (h_mine_level + 1))) {
                    h_mine_level += 1;
                    m_res -= (50 * (h_mine_level + 1));
                    c_res -= (50 * (h_mine_level + 1));
                    hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));
                    hpm.set_fraction (h_mine_level/h_total_mine);
                    update_m_value ();
                    update_c_value ();
                    update_base_values ();
                }
            });

            var stm_label = new Label (_("Mineral Storage:"));
            var stc_label = new Label (_("Crystal Storage:"));
            var sth_label = new Label (_("Hydrogen Storage:"));

            var stmpm = new Gtk.ProgressBar ();
            stmpm.hexpand = true;
            stmpm.fraction = stm_level/stm_total;
            stmpm.set_show_text (true);
            stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));

            var stcpm = new Gtk.ProgressBar ();
            stcpm.hexpand = true;
            stcpm.fraction = stc_level/stc_total;
            stcpm.set_show_text (true);
            stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));

            var sthpm = new Gtk.ProgressBar ();
            sthpm.hexpand = true;
            sthpm.fraction = sth_level/sth_total;
            sthpm.set_show_text (true);
            sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));

            var button_stm = new Gtk.Button.with_label (_("Build!"));
            var button_stc = new Gtk.Button.with_label (_("Build!"));
            var button_sth = new Gtk.Button.with_label (_("Build!"));

            button_stm.clicked.connect (() => {
                if (m_res >= (100 * (m_mine_level + 1))) {
                    stm_level += 1;
                    m_total = (m_total * (stm_level + 1));
                    m_res -= (100 * (m_mine_level + 1));
                    stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));
                    stmpm.set_fraction (stm_level/stm_total);
                    update_m_value ();
                    update_base_values ();
                }
            });

            button_stc.clicked.connect (() => {
                if (c_res >= (100 * (c_mine_level + 1))) {
                    stc_level += 1;
                    c_total = (c_total * stc_level);
                    c_res -= (100 * (c_mine_level + 1));
                    stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));
                    stcpm.set_fraction (stc_level/stc_total);
                    update_c_value ();
                    update_base_values ();
                }
            });

            button_sth.clicked.connect (() => {
                if (h_res >= (100 * (h_mine_level + 1))) {
                    stm_level += 1;
                    h_total = (h_total * sth_level);
                    h_res -= (100 * (h_mine_level + 1));
                    sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));
                    sthpm.set_fraction (sth_level/sth_total);
                    update_h_value ();
                    update_base_values ();
                }
            });

            grid.attach (header, 0, 0, 5, 1);
            grid.attach (sep, 0, 1, 5, 1);
            grid.attach (mineral_label, 0, 2, 1, 1);
            grid.attach (mpm, 1, 2, 3, 1);
            grid.attach (button_m, 4, 2, 1, 1);
            grid.attach (crystal_label, 0, 3, 1, 1);
            grid.attach (cpm, 1, 3, 3, 1);
            grid.attach (button_c, 4, 3, 1, 1);
            grid.attach (h_label, 0, 4, 1, 1);
            grid.attach (hpm, 1, 4, 3, 1);
            grid.attach (button_h, 4, 4, 1, 1);
            grid.attach (sep2, 0, 5, 5, 1);
            grid.attach (stm_label, 0, 6, 1, 1);
            grid.attach (stmpm, 1, 6, 3, 1);
            grid.attach (button_stm, 4, 6, 1, 1);
            grid.attach (stc_label, 0, 7, 1, 1);
            grid.attach (stcpm, 1, 7, 3, 1);
            grid.attach (button_stc, 4, 7, 1, 1);
            grid.attach (sth_label, 0, 8, 1, 1);
            grid.attach (sthpm, 1, 8, 3, 1);
            grid.attach (button_sth, 4, 8, 1, 1);

            return grid;
        }

        private Gtk.Widget get_lab_grid () {
            var grid = new Gtk.Grid ();
            grid.expand = true;
            grid.row_spacing = 6;
            grid.column_spacing = 12;

            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;

            var header = new Granite.HeaderLabel (_("Research Lab & Technologies"));
            var lab_label = new Label (_("Research Lab:"));

            var lpm = new Gtk.ProgressBar ();
            lpm.hexpand = true;
            lpm.fraction = l_res/l_total;
            lpm.set_show_text (true);
            lpm.set_text ("""%.0f/%.0f""".printf(l_res, l_total));

            var button_l = new Gtk.Button.with_label (_("Build!"));

            button_l.clicked.connect (() => {
                if (m_res >= (200 * (l_level + 1)) && c_res >= (200 * (l_level + 1)) && h_res >= (100 * (l_level + 1))) {
                    l_level += 1;
                    m_res -= 200;
                    c_res -= 200;
                    h_res -= 100;
                    lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
                    lpm.set_fraction (l_level/l_total);
                    update_m_value ();
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                }
            });

            var sym_label = new Label (_("Synthesize minerals better:"));

            var sympm = new Gtk.ProgressBar ();
            sympm.hexpand = true;
            sympm.fraction = sym_res/sym_total;
            sympm.set_show_text (true);
            sympm.set_text ("""%.0f/%.0f""".printf(sym_res, sym_total));

            var button_sym = new Gtk.Button.with_label (_("Build!"));

            button_sym.clicked.connect (() => {
                if (c_res >= (200 * (l_level + 1)) && h_res >= (100 * (l_level + 1)) && l_level >= 1 ) {
                    sym_level += 1;
                    c_res -= (200 * (l_level + 1));
                    h_res -= (100 * (l_level + 1));
                    sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
                    sympm.set_fraction (sym_level/sym_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                }
            });

            var syc_label = new Label (_("Synthesize crystals better:"));

            var sycpm = new Gtk.ProgressBar ();
            sycpm.hexpand = true;
            sycpm.fraction = syc_res/syc_total;
            sycpm.set_show_text (true);
            sycpm.set_text ("""%.0f/%.0f""".printf(syc_res, syc_total));

            var button_syc = new Gtk.Button.with_label (_("Build!"));

            button_syc.clicked.connect (() => {
                if (c_res >= (100 * (l_level + 1)) && h_res >= (200 * (l_level + 1)) && l_level >= 2) {
                    syc_level += 1;
                    c_res -= (200 * (l_level + 1));
                    h_res -= (100 * (l_level + 1));
                    sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
                    sycpm.set_fraction (syc_level/syc_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                }
            });

            var syh_label = new Label (_("Synthesize hydrogen better:"));

            var syhpm = new Gtk.ProgressBar ();
            syhpm.hexpand = true;
            syhpm.fraction = syh_res/syh_total;
            syhpm.set_show_text (true);
            syhpm.set_text ("""%.0f/%.0f""".printf(syh_res, syh_total));

            var button_syh = new Gtk.Button.with_label (_("Build!"));

            button_syh.clicked.connect (() => {
                if (c_res >= (200 * (l_level + 1)) && h_res >= (200 * (l_level + 1)) && l_level >= 3) {
                    syh_level += 1;
                    c_res -= (200 * (l_level + 1));
                    h_res -= (100 * (l_level + 1));
                    sympm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
                    sympm.set_fraction (syh_level/syh_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                }
            });

            grid.attach (header, 0, 0, 5, 1);
            grid.attach (sep, 0, 1, 5, 1);
            grid.attach (lab_label, 0, 2, 1, 1);
            grid.attach (lpm, 1, 2, 3, 1);
            grid.attach (button_l, 4, 2, 1, 1);
            grid.attach (sep2, 0, 4, 5, 1);
            grid.attach (sym_label, 0, 5, 1, 1);
            grid.attach (sympm, 1, 5, 3, 1);
            grid.attach (button_sym, 4, 5, 1, 1);
            grid.attach (syc_label, 0, 6, 1, 1);
            grid.attach (sycpm, 1, 6, 3, 1);
            grid.attach (button_syc, 4, 6, 1, 1);
            grid.attach (syh_label, 0, 7, 1, 1);
            grid.attach (syhpm, 1, 7, 3, 1);
            grid.attach (button_syh, 4, 7, 1, 1);

            return grid;
        }

        construct {
            var settings = AppSettings.get_default ();
            if (settings.metal == 0.0 &&
                settings.crystal == 0.0 &&
                settings.hydrogen == 0.0 &&
                settings.metal_mine == 0.0 &&
                settings.crystal_mine == 0.0 &&
                settings.hydrogen_mine == 0.0 &&
                settings.lab_level == 0.0 &&
                settings.planet_name == "" &&
                settings.planet_type == "" &&
                settings.planet_atm == "") {
                    m_res = 100.0;
                    c_res = 100.0;
                    h_res = 0.0;
                    m_mine_level = 0.0;
                    c_mine_level = 0.0;
                    h_mine_level = 0.0;
                    stm_level = 0.0;
                    stc_level = 0.0;
                    sth_level = 0.0;
                    l_level = 0.0;
                    sym_level = 0.0;
                    syc_level = 0.0;
                    syh_level = 0.0;
                    planet_name = planet_name_gen ();
                    planet_diameter = planet_diameter_gen ();
                    planet_type = planet_type_gen ();
                    planet_atm = planet_atm_gen ();
            } else {
                    m_res = settings.metal;
                    c_res = settings.crystal;
                    h_res = settings.hydrogen;
                    m_mine_level = settings.metal_mine;
                    c_mine_level = settings.crystal_mine;
                    h_mine_level = settings.hydrogen_mine;
                    stm_level = settings.stm_level;
                    stc_level = settings.stc_level;
                    sth_level = settings.sth_level;
                    l_level = settings.lab_level;
                    sym_level = settings.sym_level;
                    syc_level = settings.syc_level;
                    syh_level = settings.syh_level;
                    planet_name = settings.planet_name;
                    planet_type = settings.planet_type;
                    planet_atm = settings.planet_atm;
                    planet_diameter = settings.planet_diameter;
            }

             var provider = new Gtk.CssProvider ();
             Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
             string css = """
                 @define-color colorPrimary #111111;
                 @define-color textColorPrimary #FAFAFA;
                 window.background {
                    background-image: url("resource:///com/github/lainsce/reganam/res/bg.png");
                    background-repeat: repeat;
                 }
                 button {
                 	background-color: #333;
                 }
                 button:checked {
                 	background-color: #222;
                 }
                 button:active {
                 	background-color: #222;
                 }
                 .titlebutton {
                 	background-color: #111;
                 }
                 label.h4 {
                 	font-size: 1.9em;
                 	color: #8DD6EF;
                 	font-weight: 500;
                 }
                 progressbar .left {
                     background: linear-gradient(90deg, #99DA64, #8DD6EF)
                 }
                 progressbar trough {
                 	background-color: #111;
                 	box-shadow: none;
                 	border: 1px solid #333;
                 }
             """;
             try {
                provider.load_from_data(css, -1);
             } catch (GLib.Error e) {
                warning ("Failed to parse css style : %s", e.message);
             }
             Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),provider,
                                                                  Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
             this.get_style_context().add_class("rounded");
             this.get_style_context().add_class("flat");
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

        string planet_name_gen () {
            int length = 7; // Planet names are only 8 characters long
            string charset = "aeiouptkbdgmnszfv";
            for(int i=0; i<length; i++){
                int random_index = Random.int_range (0,charset.length);
                string ch = charset.get_char (charset.index_of_nth_char (random_index)).to_string();
                planet_name += ch;
            }
            return planet_name.get_char (0).toupper ().to_string () + planet_name.slice(1,planet_name.length);
        }
        string planet_type_gen () {
            string[] types = { "Temperate Terrestrial", "Polarian Terrestrial", "Chthonian Terrestrial",
                               "Temperate Gas Giant", "Polarian Gas Giant", "Chthonian Gas Giant",
                               "Temperate Dwarf", "Polarian Dwarf", "Chthonian Dwarf",
                               "Incognito" };
            // Diameter values in these if statements generated based on NASA info
            if (diameter > 1.0 && diameter < 196349.540849362) {
                int random_index = Random.int_range(6,8);
                string planet_type = types[random_index];
                return planet_type;
            } else if (diameter > 196349.540849362 && diameter < 3141592.65358979 ) {
                int random_index = Random.int_range(0,2);
                string planet_type = types[random_index];
                return planet_type;
            } else if (diameter > 3141592.65358979 && diameter < 6283185.307179586) {
                int random_index = Random.int_range(3,5);
                string planet_type = types[random_index];
                return planet_type;
            } else {
                string planet_type = types[9];
                return planet_type;
            }
        }
        string planet_atm_gen () {
            string[] types = { "Nitrogenic", "Nitrogen & Oxygen", "Sulfuric",
                               "Methane", "Beryllic", "Carbon Dioxide",
                               "Argonic", "Helium", "Hydrogenic" };
            int random_index = Random.int_range(0,8);
            string planet_atm = types[random_index];

            return planet_atm;
        }
        string planet_diameter_gen () {
            int random_index = Random.int_range(1,1000);
            diameter = (Math.PI * Math.pow(random_index, 2)) * 2;
            string planet_diameter = """%.3f""".printf(diameter);
            planet_diameter = insert_separators (planet_diameter) + " km";

            return planet_diameter;
        }
        private string insert_separators (string s) {
		    unichar decimal_symbol = '.';
 		    unichar separator_symbol = ',';
		    var builder = new StringBuilder (s);
		    var decimalPos = s.last_index_of_char(decimal_symbol);
		    if(decimalPos == -1){
			    decimalPos = s.length;
		    }
		    for (int i = decimalPos - 3; i > 0; i-=3) {
	    		builder.insert_unichar (i, separator_symbol);
           	}
		    return builder.str;
        }

        public bool update_base_values () {
            if (m_res != m_total && c_res != c_total) {
                if (m_mine_level > 0 || c_mine_level > 0) {
                    m_res += ((sym_level + 1) * (1.55 * m_mine_level));
                    c_res += ((syc_level + 1) * (1.25 * c_mine_level));
                    update_m_value ();
                    update_c_value ();
                    if (h_res != h_total) {
                        if (h_mine_level > 0) {
                            h_res += ((syh_level + 1) * (1.10 * h_mine_level));
                            update_h_value ();
                        }
                    }
                } else {
                    m_res += 1.55;
                    c_res += 1.25;
                    h_res += 0.00;
                    update_m_value ();
                    update_c_value ();
                    update_h_value ();
                }
                return true;
            } else {
                return false;
            }
            return false;
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
            settings.stm_level = stm_level;
            settings.stc_level = stc_level;
            settings.sth_level = sth_level;
            settings.lab_level = l_level;
            settings.sym_level = sym_level;
            settings.syc_level = syc_level;
            settings.syh_level = syh_level;
            settings.planet_name = planet_name;
            settings.planet_type = planet_type;
            settings.planet_atm = planet_atm;
            settings.planet_diameter = planet_diameter;
            return false;
        }
    }

    private class Label : Gtk.Label {
        public Label (string text) {
            label = text;
            halign = Gtk.Align.END;
            margin_start = 12;
        }
    }
}
