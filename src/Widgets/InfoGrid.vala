/*
* Copyright (c) 2020 Lains
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
*
*/
namespace Planitis {
    public class Widgets.InfoGrid : Gtk.Grid {
        private MainWindow win;
        public Granite.HeaderLabel header;
        public Gtk.Label type_of_planet_desc;
        public Gtk.Label type_of_atm_desc;
        public Gtk.Label size_diameter_desc;
        public Gtk.Label population_desc;
        public Gtk.ProgressBar mpb;
        public Gtk.ProgressBar cpb;
        public Gtk.ProgressBar hpb;

        public string planet_name = "";
        public string planet_type = "";
        public string planet_atm = "";
        public string planet_diameter = "";
        public double m_res;
        public double c_res;
        public double h_res;
        public double ph_res;
        public double diameter;
        public double m_total = 1000.0;
        public double c_total = 1000.0;
        public double h_total = 1000.0;

        public InfoGrid (MainWindow win) {
            m_res = Planitis.Application.gsettings.get_double("metal");
            c_res = Planitis.Application.gsettings.get_double("crystal");
            h_res = Planitis.Application.gsettings.get_double("hydrogen");
            ph_res = Planitis.Application.gsettings.get_double("population");
            m_total = (m_total * (Planitis.Application.gsettings.get_double("stm-level") + 1));
            c_total = (c_total * (Planitis.Application.gsettings.get_double("stc-level") + 1));
            h_total = (h_total * (Planitis.Application.gsettings.get_double("sth-level") + 1));

            planet_name = Planitis.Application.gsettings.get_string("planet-name");
            planet_type = Planitis.Application.gsettings.get_string("planet-type");
            planet_atm = Planitis.Application.gsettings.get_string("planet-atm");
            planet_diameter = Planitis.Application.gsettings.get_string("planet-diameter");

            this.win = win;
            this.expand = true;
            this.row_spacing = 6;
            this.column_spacing = 12;
            
            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;
            
            header = new Granite.HeaderLabel (_(planet_name));
            header.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            header.get_style_context ().add_class ("pl-planet-name");
            var type_of_planet = new Services.Utils.Label (_("Type:"));
            type_of_planet_desc = new Gtk.Label ("");
            type_of_planet_desc.label = planet_type;
            type_of_planet_desc.halign = Gtk.Align.START;
            var type_of_atm = new Services.Utils.Label (_("Atmosphere:"));
            type_of_atm_desc = new Gtk.Label ("");
            type_of_atm_desc.label = planet_atm;
            type_of_atm_desc.halign = Gtk.Align.START;
            var size_diameter = new Services.Utils.Label (_("Diameter:"));
            size_diameter_desc = new Gtk.Label ("");
            size_diameter_desc.label = planet_diameter;
            size_diameter_desc.halign = Gtk.Align.START;
            var population = new Services.Utils.Label (_("Population:"));
            population_desc = new Gtk.Label ("");
            population_desc.label = "%0.f".printf(ph_res);
            population_desc.halign = Gtk.Align.START;
            var mineral_label = new Services.Utils.Label (_("Mineral:"));
            var crystal_label = new Services.Utils.Label (_("Crystal:"));
            var h_label = new Services.Utils.Label (_("Hydrogen:"));
            
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
            
            this.attach (header, 0, 0, 5, 1);
            this.attach (sep, 0, 1, 5, 1);
            this.attach (type_of_planet, 0, 2, 1, 1);
            this.attach (type_of_planet_desc, 1, 2, 1, 1);
            this.attach (type_of_atm, 0, 3, 1, 1);
            this.attach (type_of_atm_desc, 1, 3, 1, 1);
            this.attach (size_diameter, 0, 4, 1, 1);
            this.attach (size_diameter_desc, 1, 4, 1, 1);
            this.attach (population, 0, 5, 1, 1);
            this.attach (population_desc, 1, 5, 1, 1);
            this.attach (sep2, 0, 6, 5, 1);
            this.attach (mineral_label, 0, 7, 1, 1);
            this.attach (mpb, 1, 7, 4, 1);
            this.attach (crystal_label, 0, 8, 1, 1);
            this.attach (cpb, 1, 8, 4, 1);
            this.attach (h_label, 0, 9, 1, 1);
            this.attach (hpb, 1, 9, 4, 1);
            this.show_all ();
        }
        public string planet_name_gen () {
            int length = 3; // Planet names are only 6 characters long
            string vowels = "aeiou";
            string cons = "qwrtypsdfghjklzxcvbnm";
            planet_name = "";
            for(int i=0; i<length; i++){
                int random_vindex = Random.int_range (0,vowels.length);
                int random_cindex = Random.int_range (0,cons.length);
                string vch = vowels.get_char (vowels.index_of_nth_char (random_vindex)).to_string();
                string cch = cons.get_char (cons.index_of_nth_char (random_cindex)).to_string();
                planet_name += cch + vch;
            }
            return planet_name.get_char (0).toupper ().to_string () + planet_name.slice(1,planet_name.length);
        }
        public string planet_type_gen () {
            string[] types = { _("Temperate Terrestrial"), _("Polarian Terrestrial"), _("Chthonian Terrestrial"),
            _("Temperate Gas Giant"), _("Polarian Gas Giant"), _("Chthonian Gas Giant"),
            _("Temperate Dwarf"), _("Polarian Dwarf"), _("Chthonian Dwarf"),
            _("Incognito") };
            // Diameter values in these if statements generated based on NASA info
            if (diameter > 1.0 && diameter < 2400.00) {
                int random_index = Random.int_range(6,8);
                string planet_type = types[random_index];
                return planet_type;
            } else if (diameter > 2400.00 && diameter < 12742.00 ) {
                int random_index = Random.int_range(0,2);
                string planet_type = types[random_index];
                return planet_type;
            } else if (diameter > 12742.00 && diameter < 49244.00) {
                int random_index = Random.int_range(3,5);
                string planet_type = types[random_index];
                return planet_type;
            } else {
                string planet_type = types[9];
                return planet_type;
            }
        }
        public string planet_atm_gen () {
            string[] types = { _("Nitrogenic"), _("Nitrogen & Oxygen"), "Sulfuric",
            _("Methane"), _("Beryllic"), _("Carbon Dioxide"),
            _("Argonic"), _("Helium"), _("Hydrogenic") };
            int random_index = Random.int_range (0,8);
            string planet_atm = types[random_index];
            
            return planet_atm;
        }
        public string planet_diameter_gen () {
            int random_index = Random.int_range (2,1000);
            diameter = ((Math.PI * Math.pow (random_index, 2)) * 2)/100;
            string planet_diameter = """%.2f""".printf (diameter);
            planet_diameter = insert_separators (planet_diameter) + " km";
            
            return planet_diameter;
        }
        private string insert_separators (string s) {
            unichar decimal_symbol = '.';
            unichar separator_symbol = ',';
            var builder = new StringBuilder (s);
            var decimalPos = s.last_index_of_char (decimal_symbol);
            if (decimalPos == -1){
                decimalPos = s.length;
            }
            for (int i = decimalPos - 3; i > 0; i -= 3) {
                builder.insert_unichar (i, separator_symbol);
            }
            return builder.str;
        }
    }
}
