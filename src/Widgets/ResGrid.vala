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
    public class Widgets.ResGrid : Gtk.Grid {
        private MainWindow win;
        private Widgets.InfoGrid infogrid;
        private Services.Utils.Base base_utils;

        public Gtk.ProgressBar lpm;
        public Gtk.ProgressBar sympm;
        public Gtk.ProgressBar sycpm;
        public Gtk.ProgressBar syhpm;
        public Gtk.ProgressBar phspm;
        public Gtk.Image help_l;
        public Gtk.Image help_sym;
        public Gtk.Image help_syc;
        public Gtk.Image help_syh;
        public Gtk.Image help_phs;
        public Gtk.Button button_l;
        public Gtk.Button button_sym;
        public Gtk.Button button_syc;
        public Gtk.Button button_syh;
        public Gtk.Button button_phs;

        public double l_level;
        public double l_total = 12.0;
        public double sym_level;
        public double sym_total = 12.0;
        public double syc_level;
        public double syc_total = 12.0;
        public double syh_level;
        public double syh_total = 12.0;
        public double phs_level;
        public double phs_total = 12.0;
        public double l_m;
        public double l_c;
        public double l_h;
        public double phs_c;
        public double phs_h;
        public double sm_c;
        public double sm_h;
        public double sc_c;
        public double sc_h;
        public double sh_c;
        public double sh_h;

        public ResGrid (MainWindow win, Widgets.InfoGrid infogrid) {
            l_level = Planitis.Application.gsettings.get_double("lab-level");
            sym_level = Planitis.Application.gsettings.get_double("sym-level");
            syc_level = Planitis.Application.gsettings.get_double("syc-level");
            syh_level = Planitis.Application.gsettings.get_double("syh-level");
            phs_level = Planitis.Application.gsettings.get_double("phs-level");

            this.win = win;
            this.infogrid = infogrid;
            this.expand = true;
            this.row_spacing = 6;
            this.column_spacing = 12;
        }
        construct {
            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;
            var sep3 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep3.margin_top = 12;
            sep3.margin_bottom = 12;
            
            var header = new Granite.HeaderLabel (_("Research Lab & Technologies"));
            var lab_label = new Services.Utils.Label (_("Research Lab:"));
            
            lpm = new Gtk.ProgressBar ();
            lpm.hexpand = true;
            lpm.fraction = l_level/l_total;
            lpm.set_show_text (true);
            lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
            
            button_l = new Gtk.Button.with_label (_("Build!"));
            button_l.valign = Gtk.Align.CENTER;
            button_l.sensitive = false;
            help_l = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_l.halign = Gtk.Align.START;
            
            help_l.hexpand = true;
            help_l.tooltip_text = (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(l_m, l_c, l_h)));
            
            button_l.clicked.connect (() => {
                if (infogrid.m_res >= (200 * (l_level + 1)) && infogrid.c_res >= (200 * (l_level + 1)) && infogrid.h_res >= (100 * (l_level + 1))) {
                    l_level += 1;
                    infogrid.m_res -= 200;
                    infogrid.c_res -= 200;
                    infogrid.h_res -= 100;
                    lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
                    lpm.set_fraction (l_level/l_total);
                    infogrid.update_m_value ();
                    infogrid.update_c_value ();
                    infogrid.update_h_value ();
                    base_utils.update_base_values ();
                    help_l.set_tooltip_text (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(l_m, l_c, l_h)));
                    Planitis.Application.gsettings.set_double ("lab-level", l_level);
                }
            });
            
            var sym_label = new Services.Utils.Label (_("Synthesizer of Minerals:"));
            
            sympm = new Gtk.ProgressBar ();
            sympm.hexpand = true;
            sympm.fraction = sym_level/sym_total;
            sympm.set_show_text (true);
            sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
            
            button_sym = new Gtk.Button.with_label (_("Research!"));
            button_sym.valign = Gtk.Align.CENTER;
            button_sym.sensitive = false;
            button_sym.vexpand = false;
            help_sym = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_sym.halign = Gtk.Align.START;
            help_sym.hexpand = true;
            help_sym.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(sm_c, sm_h)));
            
            button_sym.clicked.connect (() => {
                if (infogrid.c_res >= (200 * (sym_level + 1)) && infogrid.h_res >= (200 * (sym_level + 1)) && l_level >= 1 ) {
                    sym_level += 1;
                    infogrid.c_res -= (200 * (sym_level + 1));
                    infogrid.h_res -= (200 * (sym_level + 1));
                    sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
                    sympm.set_fraction (sym_level/sym_total);
                    infogrid.update_c_value ();
                    infogrid.update_h_value ();
                    base_utils.update_base_values ();
                    help_sym.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(sm_c, sm_h)));
                    Planitis.Application.gsettings.set_double ("sym-level", sym_level);
                }
            });
            
            var syc_label = new Services.Utils.Label (_("Synthesizer of Crystals:"));
            
            sycpm = new Gtk.ProgressBar ();
            sycpm.hexpand = true;
            sycpm.fraction = syc_level/syc_total;
            sycpm.set_show_text (true);
            sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
            
            button_syc = new Gtk.Button.with_label (_("Research!"));
            button_syc.valign = Gtk.Align.CENTER;
            button_syc.sensitive = false;
            button_syc.vexpand = false;
            help_syc = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_syc.halign = Gtk.Align.START;
            help_syc.hexpand = true;
            help_syc.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(sc_c, sc_h)));
            
            button_syc.clicked.connect (() => {
                if (infogrid.c_res >= (200 * (syc_level + 1)) && infogrid.h_res >= (200 * (syc_level + 1)) && l_level >= 2) {
                    syc_level += 1;
                    infogrid.c_res -= (200 * (syc_level + 1));
                    infogrid.h_res -= (200 * (syc_level + 1));
                    sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
                    sycpm.set_fraction (syc_level/syc_total);
                    infogrid.update_c_value ();
                    infogrid.update_h_value ();
                    base_utils.update_base_values ();
                    help_syc.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(sc_c, sc_h)));
                    Planitis.Application.gsettings.set_double ("syc-level", syc_level);
                }
            });
            
            var syh_label = new Services.Utils.Label (_("Synthesizer of Hydrogen:"));
            
            syhpm = new Gtk.ProgressBar ();
            syhpm.hexpand = true;
            syhpm.fraction = syh_level/syh_total;
            syhpm.set_show_text (true);
            syhpm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
            
            button_syh = new Gtk.Button.with_label (_("Research!"));
            button_syh.valign = Gtk.Align.CENTER;
            button_syh.sensitive = false;
            button_syh.vexpand = false;
            help_syh = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_syh.halign = Gtk.Align.START;
            help_syh.hexpand = true;
            help_syh.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(sh_c, sh_h)));
            
            button_syh.clicked.connect (() => {
                if (infogrid.c_res >= (200 * (syh_level + 1)) && infogrid.h_res >= (200 * (syh_level + 1)) && l_level >= 3) {
                    syh_level += 1;
                    infogrid.c_res -= (200 * (syh_level + 1));
                    infogrid.h_res -= (200 * (syh_level + 1));
                    syhpm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
                    syhpm.set_fraction (syh_level/syh_total);
                    infogrid.update_c_value ();
                    infogrid.update_h_value ();
                    base_utils.update_base_values ();
                    help_syh.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(sh_c, sh_h)));
                    Planitis.Application.gsettings.set_double ("syh-level", syh_level);
                }
            });
            
            var phs_label = new Services.Utils.Label ((_("Population Housing Upgrade:")));
            
            phspm = new Gtk.ProgressBar ();
            phspm.hexpand = true;
            phspm.fraction = phs_level/phs_total;
            phspm.set_show_text (true);
            phspm.set_text ("""%.0f/%.0f""".printf(phs_level, phs_total));
            
            button_phs = new Gtk.Button.with_label (_("Research!"));
            button_phs.valign = Gtk.Align.CENTER;
            button_phs.sensitive = false;
            button_phs.vexpand = false;
            help_phs = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_phs.halign = Gtk.Align.START;
            help_phs.hexpand = true;
            help_phs.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(phs_c, phs_h)));
            
            button_phs.clicked.connect (() => {
                if (infogrid.c_res >= (100 * (phs_level + 1)) && infogrid.h_res >= (100 * (phs_level + 1)) && l_level >= 1) {
                    phs_level += 1;
                    infogrid.c_res -= (100 * (phs_level + 1));
                    infogrid.h_res -= (100 * (phs_level + 1));
                    phspm.set_text ("""%.0f/%.0f""".printf(phs_level, phs_total));
                    phspm.set_fraction (phs_level/phs_total);
                    infogrid.update_c_value ();
                    infogrid.update_h_value ();
                    base_utils.update_base_values ();
                    help_phs.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(phs_c, phs_h)));
                    Planitis.Application.gsettings.set_double ("phs-level", phs_level);
                }
            });
            
            var res_sym = res_info_widget ();
            var res_syc = res_info_widget ();
            var res_syh = res_info_widget ();
            var res_phs = res_info_widget ();
            
            this.attach (header, 0, 0, 6, 1);
            this.attach (sep, 0, 1, 6, 1);
            this.attach (lab_label, 0, 2, 1, 1);
            this.attach (lpm, 1, 2, 3, 1);
            this.attach (button_l, 4, 2, 1, 1);
            this.attach (help_l, 5, 2, 1, 1);
            this.attach (sep2, 0, 4, 5, 1);
            this.attach (sym_label, 0, 5, 1, 2);
            this.attach (sympm, 1, 5, 3, 1);
            this.attach (res_sym, 1, 6, 1, 1);
            this.attach (button_sym, 4, 5, 1, 2);
            this.attach (help_sym, 5, 5, 1, 2);
            this.attach (syc_label, 0, 7, 1, 2);
            this.attach (sycpm, 1, 7, 3, 1);
            this.attach (res_syc, 1, 8, 1, 1);
            this.attach (button_syc, 4, 7, 1, 2);
            this.attach (help_syc, 5, 7, 1, 2);
            this.attach (syh_label, 0, 9, 1, 2);
            this.attach (syhpm, 1, 9, 3, 1);
            this.attach (res_syh, 1, 10, 1, 1);
            this.attach (button_syh, 4, 9, 1, 2);
            this.attach (help_syh, 5, 9, 1, 2);
            this.attach (sep3, 0, 11, 5, 1);
            this.attach (phs_label, 0, 12, 1, 2);
            this.attach (phspm, 1, 12, 3, 1);
            this.attach (res_phs, 1, 13, 1, 1);
            this.attach (button_phs, 4, 12, 1, 2);
            this.attach (help_phs, 5, 12, 1, 2);
            this.show_all ();
        }

        public Gtk.Widget res_info_widget () {
            var res = new Gtk.Image.from_icon_name ("go-up-symbolic", Gtk.IconSize.MENU);
            res.halign = Gtk.Align.START;
            var res_desc = new Gtk.Label ("Raises production by 8.33% per level");
            
            var grid = new Gtk.Grid ();
            grid.hexpand = true;
            grid.row_spacing = 3;
            grid.column_spacing = 6;
            grid.attach (res, 0, 0, 1, 1);
            grid.attach (res_desc, 1, 0, 1, 1);
            
            grid.get_style_context().add_class("info");
            
            return grid;
        }
    }
}