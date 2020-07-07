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
    public class MainWindow : Hdy.Window {
        public Gtk.Application app { get; construct; }
        public bool resetted = false;
        public double m_res;
        public double c_res;
        public double h_res;
        public double ph_res;
        public double m_total = 1000.0;
        public double c_total = 1000.0;
        public double h_total = 1000.0;
        public double pp_total = 10000000000.0;
        public double m_mine_level;
        public double m_total_mine = 100.0;
        public double c_mine_level;
        public double c_total_mine = 100.0;
        public double h_mine_level;
        public double h_total_mine = 100.0;
        public double ph_level;
        public double ph_total = 1000.0;
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
        public double phs_level;
        public double phs_total = 12.0;
        public double diameter;
        public double pm_m;
        public double pm_c;
        public double pc_m;
        public double pc_c;
        public double ps_m;
        public double ps_c;
        public double ps_h;
        public double ph_c;
        public double ph_h;
        public double l_m;
        public double l_c;
        public double l_h;
        public double sm_c;
        public double sm_h;
        public double sc_c;
        public double sc_h;
        public double sh_c;
        public double sh_h;
        public double phs_c;
        public double phs_h;
        public string planet_name = "";
        public string planet_type = "";
        public string planet_atm = "";
        public string planet_diameter = "";
        public Gtk.ProgressBar mpb;
        public Gtk.ProgressBar cpb;
        public Gtk.ProgressBar hpb;
        public Gtk.ProgressBar mpm;
        public Gtk.ProgressBar cpm;
        public Gtk.ProgressBar hpm;
        public Gtk.ProgressBar stmpm;
        public Gtk.ProgressBar stcpm;
        public Gtk.ProgressBar sthpm;
        public Gtk.ProgressBar sympm;
        public Gtk.ProgressBar sycpm;
        public Gtk.ProgressBar syhpm;
        public Gtk.ProgressBar phpm;
        public Gtk.ProgressBar phspm;
        public Gtk.ProgressBar lpm;
        public Gtk.Image help_pm;
        public Gtk.Image help_pc;
        public Gtk.Image help_ph;
        public Gtk.Image help_phh;
        public Gtk.Image help_sm;
        public Gtk.Image help_sc;
        public Gtk.Image help_sh;
        public Gtk.Image help_l;
        public Gtk.Image help_sym;
        public Gtk.Image help_syc;
        public Gtk.Image help_syh;
        public Gtk.Image help_phs;
        public Gtk.Button button_m;
        public Gtk.Button button_c;
        public Gtk.Button button_h;
        public Gtk.Button button_ph;
        public Gtk.Button button_stm;
        public Gtk.Button button_stc;
        public Gtk.Button button_sth;
        public Gtk.Button button_l;
        public Gtk.Button button_sym;
        public Gtk.Button button_syc;
        public Gtk.Button button_syh;
        public Gtk.Button button_phs;
        public Gtk.Label type_of_planet_desc;
        public Gtk.Label type_of_atm_desc;
        public Gtk.Label size_diameter_desc;
        public Gtk.Label population_desc;
        public Granite.HeaderLabel header;
        public Hdy.Leaflet leaflet;
        public Gtk.Grid grid;
        public Gtk.Grid sgrid;
        public int window_x;
        public int window_y;
        public Hdy.HeaderBar titlebar;
        public Hdy.HeaderBar fauxtitlebar;
        public MainWindow (Gtk.Application app) {
            GLib.Object (
                application: app,
                app: app,
                icon_name: "com.github.lainsce.planitis",
                title: "Planitis"
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
            
            header = new Granite.HeaderLabel (_(planet_name));
            header.get_style_context ().add_class ("pl-planet-name");
            var type_of_planet = new Label (_("Type:"));
            type_of_planet_desc = new Gtk.Label ("");
            type_of_planet_desc.label = planet_type;
            type_of_planet_desc.halign = Gtk.Align.START;
            var type_of_atm = new Label (_("Atmosphere:"));
            type_of_atm_desc = new Gtk.Label ("");
            type_of_atm_desc.label = planet_atm;
            type_of_atm_desc.halign = Gtk.Align.START;
            var size_diameter = new Label (_("Diameter:"));
            size_diameter_desc = new Gtk.Label ("");
            size_diameter_desc.label = planet_diameter;
            size_diameter_desc.halign = Gtk.Align.START;
            var population = new Label (_("Population:"));
            population_desc = new Gtk.Label ("");
            population_desc.label = "%0.f".printf(ph_res);
            population_desc.halign = Gtk.Align.START;
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
            grid.attach (population, 0, 5, 1, 1);
            grid.attach (population_desc, 1, 5, 1, 1);
            grid.attach (sep2, 0, 6, 5, 1);
            grid.attach (mineral_label, 0, 7, 1, 1);
            grid.attach (mpb, 1, 7, 4, 1);
            grid.attach (crystal_label, 0, 8, 1, 1);
            grid.attach (cpb, 1, 8, 4, 1);
            grid.attach (h_label, 0, 9, 1, 1);
            grid.attach (hpb, 1, 9, 4, 1);
            
            return grid;
        }
        
        private Gtk.Widget get_building_grid () {
            var grid = new Gtk.Grid ();
            grid.expand = true;
            grid.row_spacing = 6;
            grid.column_spacing = 12;
            
            var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep.margin_bottom = 12;
            var sep2 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep2.margin_top = 12;
            sep2.margin_bottom = 12;
            var sep3 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep3.margin_top = 12;
            sep3.margin_bottom = 12;
            
            var titlebar = new Granite.HeaderLabel (_("Buildings & Storage"));
            var mineral_label = new Label (_("Mineral Mine:"));
            var crystal_label = new Label (_("Crystal Mine:"));
            var h_label = new Label (_("Hydrogen Mine:"));
            
            mpm = new Gtk.ProgressBar ();
            mpm.hexpand = true;
            mpm.fraction = m_mine_level/m_total_mine;
            mpm.set_show_text (true);
            mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));
            
            cpm = new Gtk.ProgressBar ();
            cpm.hexpand = true;
            cpm.fraction = c_mine_level/c_total_mine;
            cpm.set_show_text (true);
            cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));
            
            hpm = new Gtk.ProgressBar ();
            hpm.hexpand = true;
            hpm.fraction = h_mine_level/h_total_mine;
            hpm.set_show_text (true);
            hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));
            
            button_m = new Gtk.Button.with_label (_("Build!"));
            button_m.sensitive = false;
            help_pm = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_pm.halign = Gtk.Align.START;
            help_pm.hexpand = true;
            help_pm.tooltip_text = (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pm_c)));
            
            button_c = new Gtk.Button.with_label (_("Build!"));
            button_c.sensitive = false;
            help_pc = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_pc.halign = Gtk.Align.START;
            help_pc.hexpand = true;
            help_pc.tooltip_text = (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pc_m, pc_c)));
            
            button_h = new Gtk.Button.with_label (_("Build!"));
            button_h.sensitive = false;
            help_ph = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_ph.halign = Gtk.Align.START;
            help_ph.hexpand = true;
            help_ph.tooltip_text = (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pc_c)));
            
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
                    help_pm.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pm_c)));
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
                    help_pc.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pc_m, pc_c)));
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
                    help_ph.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pc_c)));
                }
            });
            
            var stm_label = new Label (_("Mineral Storage:"));
            var stc_label = new Label (_("Crystal Storage:"));
            var sth_label = new Label (_("Hydrogen Storage:"));
            
            stmpm = new Gtk.ProgressBar ();
            stmpm.hexpand = true;
            stmpm.fraction = stm_level/stm_total;
            stmpm.set_show_text (true);
            stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));
            
            stcpm = new Gtk.ProgressBar ();
            stcpm.hexpand = true;
            stcpm.fraction = stc_level/stc_total;
            stcpm.set_show_text (true);
            stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));
            
            sthpm = new Gtk.ProgressBar ();
            sthpm.hexpand = true;
            sthpm.fraction = sth_level/sth_total;
            sthpm.set_show_text (true);
            sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));
            
            button_stm = new Gtk.Button.with_label (_("Build!"));
            button_stm.sensitive = false;
            help_sm = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_sm.halign = Gtk.Align.START;
            help_sm.hexpand = true;
            help_sm.tooltip_text = (_("""To build the next level, %.0f of Mineral is needed""".printf(ps_m)));
            
            button_stc = new Gtk.Button.with_label (_("Build!"));
            button_stc.sensitive = false;
            help_sc = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_sc.halign = Gtk.Align.START;
            help_sc.hexpand = true;
            help_sc.tooltip_text = (_("""To build the next level, %.0f of Crystal is needed""".printf(ps_c)));
            
            button_sth = new Gtk.Button.with_label (_("Build!"));
            button_sth.sensitive = false;
            help_sh = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_sh.halign = Gtk.Align.START;
            help_sh.hexpand = true;
            help_sh.tooltip_text = (_("""To build the next level, %.0f of Hydrogen is needed""".printf(ps_h)));
            
            button_stm.clicked.connect (() => {
                if (m_res >= (100 * (stm_level + 1))) {
                    stm_level += 1;
                    m_total = (m_total * (stm_level + 1));
                    m_res -= (100 * (stm_level + 1));
                    stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));
                    stmpm.set_fraction (stm_level/stm_total);
                    update_m_value ();
                    update_base_values ();
                    help_sm.set_tooltip_text (_("""To build the next level, %.0f of Mineral is needed""".printf(ps_m)));
                }
            });
            
            button_stc.clicked.connect (() => {
                if (c_res >= (100 * (stc_level + 1))) {
                    stc_level += 1;
                    c_total = (c_total * stc_level);
                    c_res -= (100 * (stc_level + 1));
                    stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));
                    stcpm.set_fraction (stc_level/stc_total);
                    update_c_value ();
                    update_base_values ();
                    help_sc.set_tooltip_text (_("""To build the next level, %.0f of Crystal is needed""".printf(ps_c)));
                }
            });
            
            button_sth.clicked.connect (() => {
                if (h_res >= (100 * (sth_level + 1))) {
                    sth_level += 1;
                    h_total = (h_total * sth_level);
                    h_res -= (100 * (sth_level + 1));
                    sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));
                    sthpm.set_fraction (sth_level/sth_total);
                    update_h_value ();
                    update_base_values ();
                    help_sh.set_tooltip_text (_("""To build the next level, %.0f of Hydrogen is needed""".printf(ps_h)));
                }
            });
            
            var ph_label = new Label (_("Population Housing:"));
            
            phpm = new Gtk.ProgressBar ();
            phpm.hexpand = true;
            phpm.fraction = ph_level/ph_total;
            phpm.set_show_text (true);
            phpm.set_text ("""%.0f/%.0f""".printf(ph_level, ph_total));
            
            button_ph = new Gtk.Button.with_label (_("Build!"));
            button_ph.sensitive = false;
            help_phh = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_phh.halign = Gtk.Align.START;
            help_phh.hexpand = true;
            help_phh.tooltip_text = (_("""To build the next level, %.0f of Hydrogen is needed""".printf(ps_h)));
            
            button_ph.clicked.connect (() => {
                if (c_res >= (10 * (ph_level + 1)) && m_res >= (10 * (ph_level + 1))) {
                    ph_level += 1;
                    ph_res += ((10 * phs_level) * (ph_level + 1));
                    m_res -= (10 * (ph_level + 1));
                    c_res -= (10 * (ph_level + 1));
                    population_desc.label = "%0.f".printf(ph_res);
                    phpm.set_text ("""%.0f/%.0f""".printf(ph_level, ph_total));
                    phpm.set_fraction (ph_level/ph_total);
                    update_h_value ();
                    update_base_values ();
                    help_phh.set_tooltip_text (_("""To build the next level, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(ph_c, ph_h)));
                }
            });
            
            grid.attach (titlebar, 0, 0, 6, 1);
            grid.attach (sep, 0, 1, 6, 1);
            grid.attach (mineral_label, 0, 2, 1, 1);
            grid.attach (mpm, 1, 2, 3, 1);
            grid.attach (button_m, 4, 2, 1, 1);
            grid.attach (help_pm, 5, 2, 1, 1);
            grid.attach (crystal_label, 0, 3, 1, 1);
            grid.attach (cpm, 1, 3, 3, 1);
            grid.attach (button_c, 4, 3, 1, 1);
            grid.attach (help_pc, 5, 3, 1, 1);
            grid.attach (h_label, 0, 4, 1, 1);
            grid.attach (hpm, 1, 4, 3, 1);
            grid.attach (button_h, 4, 4, 1, 1);
            grid.attach (help_ph, 5, 4, 1, 1);
            grid.attach (sep2, 0, 5, 5, 1);
            grid.attach (stm_label, 0, 6, 1, 1);
            grid.attach (stmpm, 1, 6, 3, 1);
            grid.attach (button_stm, 4, 6, 1, 1);
            grid.attach (help_sm, 5, 6, 1, 1);
            grid.attach (stc_label, 0, 7, 1, 1);
            grid.attach (stcpm, 1, 7, 3, 1);
            grid.attach (button_stc, 4, 7, 1, 1);
            grid.attach (help_sc, 5, 7, 1, 1);
            grid.attach (sth_label, 0, 8, 1, 1);
            grid.attach (sthpm, 1, 8, 3, 1);
            grid.attach (button_sth, 4, 8, 1, 1);
            grid.attach (help_sh, 5, 8, 1, 1);
            grid.attach (sep3, 0, 9, 6, 1);
            grid.attach (ph_label, 0, 10, 1, 1);
            grid.attach (phpm, 1, 10, 3, 1);
            grid.attach (button_ph, 4, 10, 1, 1);
            grid.attach (help_phh, 5, 10, 1, 1);
            
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
            var sep3 = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            sep3.margin_top = 12;
            sep3.margin_bottom = 12;
            
            var header = new Granite.HeaderLabel (_("Research Lab & Technologies"));
            var lab_label = new Label (_("Research Lab:"));
            
            lpm = new Gtk.ProgressBar ();
            lpm.hexpand = true;
            lpm.fraction = l_level/l_total;
            lpm.set_show_text (true);
            lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
            
            button_l = new Gtk.Button.with_label (_("Build!"));
            button_l.sensitive = false;
            help_l = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_l.halign = Gtk.Align.START;
            help_l.hexpand = true;
            help_l.tooltip_text = (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(l_m, l_c, l_h)));
            
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
                    help_l.set_tooltip_text (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(l_m, l_c, l_h)));
                }
            });
            
            var sym_label = new Label (_("Synthesizer of Minerals:"));
            
            sympm = new Gtk.ProgressBar ();
            sympm.hexpand = true;
            sympm.fraction = sym_level/sym_total;
            sympm.set_show_text (true);
            sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
            
            button_sym = new Gtk.Button.with_label (_("Research!"));
            button_sym.sensitive = false;
            button_sym.vexpand = false;
            help_sym = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_sym.halign = Gtk.Align.START;
            help_sym.hexpand = true;
            help_sym.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(sm_c, sm_h)));
            
            button_sym.clicked.connect (() => {
                if (c_res >= (200 * (sym_level + 1)) && h_res >= (200 * (sym_level + 1)) && l_level >= 1 ) {
                    sym_level += 1;
                    c_res -= (200 * (sym_level + 1));
                    h_res -= (200 * (sym_level + 1));
                    sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
                    sympm.set_fraction (sym_level/sym_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                    help_sym.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(sm_c, sm_h)));
                }
            });
            
            var syc_label = new Label (_("Synthesizer of Crystals:"));
            
            sycpm = new Gtk.ProgressBar ();
            sycpm.hexpand = true;
            sycpm.fraction = syc_level/syc_total;
            sycpm.set_show_text (true);
            sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
            
            button_syc = new Gtk.Button.with_label (_("Research!"));
            button_syc.sensitive = false;
            button_syc.vexpand = false;
            help_syc = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_syc.halign = Gtk.Align.START;
            help_syc.hexpand = true;
            help_syc.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(sc_c, sc_h)));
            
            button_syc.clicked.connect (() => {
                if (c_res >= (200 * (syc_level + 1)) && h_res >= (200 * (syc_level + 1)) && l_level >= 2) {
                    syc_level += 1;
                    c_res -= (200 * (syc_level + 1));
                    h_res -= (200 * (syc_level + 1));
                    sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
                    sycpm.set_fraction (syc_level/syc_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                    help_syc.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(sc_c, sc_h)));
                }
            });
            
            var syh_label = new Label (_("Synthesizer of Hydrogen:"));
            
            syhpm = new Gtk.ProgressBar ();
            syhpm.hexpand = true;
            syhpm.fraction = syh_level/syh_total;
            syhpm.set_show_text (true);
            syhpm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
            
            button_syh = new Gtk.Button.with_label (_("Research!"));
            button_syh.sensitive = false;
            button_syh.vexpand = false;
            help_syh = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_syh.halign = Gtk.Align.START;
            help_syh.hexpand = true;
            help_syh.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(sh_c, sh_h)));
            
            button_syh.clicked.connect (() => {
                if (c_res >= (200 * (syh_level + 1)) && h_res >= (200 * (syh_level + 1)) && l_level >= 3) {
                    syh_level += 1;
                    c_res -= (200 * (syh_level + 1));
                    h_res -= (200 * (syh_level + 1));
                    syhpm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
                    syhpm.set_fraction (syh_level/syh_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                    help_syh.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(sh_c, sh_h)));
                }
            });
            
            var phs_label = new Label ((_("Population Housing Upgrade:")));
            
            phspm = new Gtk.ProgressBar ();
            phspm.hexpand = true;
            phspm.fraction = phs_level/phs_total;
            phspm.set_show_text (true);
            phspm.set_text ("""%.0f/%.0f""".printf(phs_level, phs_total));
            
            button_phs = new Gtk.Button.with_label (_("Research!"));
            button_phs.sensitive = false;
            button_phs.vexpand = false;
            help_phs = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            help_phs.halign = Gtk.Align.START;
            help_phs.hexpand = true;
            help_phs.tooltip_text = (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(phs_c, phs_h)));
            
            button_phs.clicked.connect (() => {
                if (c_res >= (100 * (phs_level + 1)) && h_res >= (100 * (phs_level + 1)) && l_level >= 1) {
                    phs_level += 1;
                    c_res -= (100 * (phs_level + 1));
                    h_res -= (100 * (phs_level + 1));
                    phspm.set_text ("""%.0f/%.0f""".printf(phs_level, phs_total));
                    phspm.set_fraction (phs_level/phs_total);
                    update_c_value ();
                    update_h_value ();
                    update_base_values ();
                    help_phs.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(phs_c, phs_h)));
                }
            });
            
            var res_sym = res_info_widget ();
            var res_syc = res_info_widget ();
            var res_syh = res_info_widget ();
            var res_phs = res_info_widget ();
            
            grid.attach (header, 0, 0, 6, 1);
            grid.attach (sep, 0, 1, 6, 1);
            grid.attach (lab_label, 0, 2, 1, 1);
            grid.attach (lpm, 1, 2, 3, 1);
            grid.attach (button_l, 4, 2, 1, 1);
            grid.attach (help_l, 5, 2, 1, 1);
            grid.attach (sep2, 0, 4, 5, 1);
            grid.attach (sym_label, 0, 5, 1, 2);
            grid.attach (sympm, 1, 5, 3, 1);
            grid.attach (res_sym, 1, 6, 1, 1);
            grid.attach (button_sym, 4, 5, 1, 2);
            grid.attach (help_sym, 5, 5, 1, 2);
            grid.attach (syc_label, 0, 7, 1, 2);
            grid.attach (sycpm, 1, 7, 3, 1);
            grid.attach (res_syc, 1, 8, 1, 1);
            grid.attach (button_syc, 4, 7, 1, 2);
            grid.attach (help_syc, 5, 7, 1, 2);
            grid.attach (syh_label, 0, 9, 1, 2);
            grid.attach (syhpm, 1, 9, 3, 1);
            grid.attach (res_syh, 1, 10, 1, 1);
            grid.attach (button_syh, 4, 9, 1, 2);
            grid.attach (help_syh, 5, 9, 1, 2);
            grid.attach (sep3, 0, 11, 5, 1);
            grid.attach (phs_label, 0, 12, 1, 2);
            grid.attach (phspm, 1, 12, 3, 1);
            grid.attach (res_phs, 1, 13, 1, 1);
            grid.attach (button_phs, 4, 12, 1, 2);
            grid.attach (help_phs, 5, 12, 1, 2);
            
            return grid;
        }
        
        construct {
            if (resetted) {
                m_res = 100.0;
                c_res = 100.0;
                h_res = 0.0;
                ph_res = 1000.0;
                m_total = 1000.0;
                c_total = 1000.0;
                h_total = 1000.0;
                m_mine_level = 1.0;
                c_mine_level = 1.0;
                h_mine_level = 0.0;
                stm_level = 0.0;
                stc_level = 0.0;
                sth_level = 0.0;
                l_level = 0.0;
                ph_level = 1.0;
                sym_level = 0.0;
                syc_level = 0.0;
                syh_level = 0.0;
                phs_level = 0.0;
                planet_name = planet_name_gen ();
                planet_diameter = planet_diameter_gen ();
                planet_type = planet_type_gen ();
                planet_atm = planet_atm_gen ();
                set_gsettings ();
                resetted = false;
            } else {
                get_gsettings ();
                
                // Fixes broken savegame
                if (m_mine_level < 1.0) {
                    m_mine_level = 1.0;
                }
                if (c_mine_level < 1.0) {
                    c_mine_level = 1.0;
                }
                set_gsettings ();
            }

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/lainsce/planitis/app.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/lainsce/planitis");
            
            var titlebar = new Hdy.HeaderBar();
            titlebar.hexpand = true;
            titlebar.set_size_request (200,45);
            titlebar.decoration_layout = ":maximize";
            titlebar.get_style_context ().add_class ("pl-toolbar");
            titlebar.has_subtitle = false;
            titlebar.set_show_close_button (true);
            titlebar.title = "Planitis";
            
            var prefs_button = new Gtk.Button ();
            prefs_button.set_image (new Gtk.Image.from_icon_name ("explosion-symbolic", Gtk.IconSize.BUTTON));
            prefs_button.get_style_context ().add_class ("destructive-button");
            prefs_button.has_tooltip = true;
            prefs_button.tooltip_text = (_("Reset Game"));
            
            prefs_button.clicked.connect (reset_cb);
            
            titlebar.pack_end (prefs_button);
            
            var main_stack = new Gtk.Stack ();
            main_stack.margin = 12;
            var main_stackswitcher = new Gtk.StackSwitcher ();
            main_stackswitcher.set_size_request (185,-1);
            main_stackswitcher.orientation = Gtk.Orientation.VERTICAL;
            main_stackswitcher.valign = Gtk.Align.CENTER;
            main_stackswitcher.get_style_context ().add_class ("pl-switcher");
            main_stackswitcher.stack = main_stack;
            main_stackswitcher.halign = Gtk.Align.CENTER;
            main_stackswitcher.homogeneous = true;
            main_stackswitcher.margin_top = 6;
            main_stackswitcher.margin_start = main_stackswitcher.margin_end = 12;
            
            main_stack.add_titled (get_info_grid (), "info", (_("INFO")));
            main_stack.add_titled (get_building_grid (), "mine", (_("BUILDINGS")));
            main_stack.add_titled (get_lab_grid (), "lab", (_("RESEARCH")));

            var column_header = new Gtk.Label (_("VIEWS"));
            column_header.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            column_header.halign = Gtk.Align.START;
            column_header.margin_start = 9;

            var column = new Gtk.Grid ();
            column.orientation = Gtk.Orientation.VERTICAL;
            column.vexpand = true;
            column.add (column_header);
            column.add (main_stackswitcher);
            column.get_style_context ().add_class ("pl-column");
            column.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            
            fauxtitlebar = new Hdy.HeaderBar ();
            fauxtitlebar.set_size_request (200,45);
            fauxtitlebar.show_close_button = true;
            fauxtitlebar.has_subtitle = false;
            fauxtitlebar.get_style_context ().add_class ("pl-column");
            fauxtitlebar.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            
            sgrid = new Gtk.Grid ();
            sgrid.attach (fauxtitlebar, 0, 0, 1, 1);
            sgrid.attach (column, 0, 1, 1, 1);
            sgrid.show_all ();
            
            grid = new Gtk.Grid ();
            grid.attach (titlebar, 1, 0, 1, 1);
            grid.attach (main_stack, 1, 1, 1, 1);
            grid.show_all ();
            
            var separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            var separator_cx = separator.get_style_context ();
            separator_cx.add_class ("vsep");

            leaflet = new Hdy.Leaflet ();
            leaflet.add (sgrid);
            leaflet.add (separator);
            leaflet.add (grid);
            leaflet.transition_type = Hdy.LeafletTransitionType.UNDER;
            leaflet.show_all ();
            leaflet.can_swipe_back = true;
            leaflet.set_visible_child (grid);
            
            leaflet.child_set_property (separator, "allow-visible", false);

            update ();
            leaflet.notify["folded"].connect (() => {
                update ();
            });
            
            this.add (leaflet);
            this.set_size_request (360, 435);
            this.get_style_context ().add_class ("pl-window");
            this.show_all ();

            update_base_values ();
            
            Timeout.add_seconds (10, () => {
                update_base_values ();
                return true;
            });
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
            resetted = true;
            var dialog = new Dialog ();
            dialog.transient_for = this;
            dialog.modal = true;
            
            dialog.response.connect ((response_id) => {
                switch (response_id) {
                    case Gtk.ResponseType.OK:
                        m_res = 100.0;
                        c_res = 100.0;
                        h_res = 0.0;
                        ph_res = 1000.0;
                        m_total = 1000.0;
                        c_total = 1000.0;
                        h_total = 1000.0;
                        m_mine_level = 1.0;
                        c_mine_level = 1.0;
                        h_mine_level = 0.0;
                        stm_level = 0.0;
                        stc_level = 0.0;
                        sth_level = 0.0;
                        l_level = 0.0;
                        ph_level = 1.0;
                        phs_level = 0.0;
                        sym_level = 0.0;
                        syc_level = 0.0;
                        syh_level = 0.0;
                        planet_name = planet_name_gen ();
                        header.set_label (planet_name);
                        planet_diameter = planet_diameter_gen ();
                        size_diameter_desc.set_label (planet_diameter);
                        planet_type = planet_type_gen ();
                        type_of_planet_desc.set_label (planet_type);
                        planet_atm = planet_atm_gen ();
                        type_of_atm_desc.set_label (planet_atm);
                        population_desc.set_label ("%0.f".printf(ph_res));
                        mpb.set_fraction (m_res/m_total);
                        cpb.set_fraction (c_res/c_total);
                        hpb.set_fraction (h_res/h_total);
                        set_gsettings ();
                        
                        // Fixes broken savegame
                        if (m_mine_level < 1.0) {
                            m_mine_level = 1.0;
                        }
                        if (c_mine_level < 1.0) {
                            c_mine_level = 1.0;
                        }
                        
                        update_m_value ();
                        update_c_value ();
                        update_h_value ();
                        update_pb_values ();
                        update_help_tooltips ();
                        update_buttons ();
                        dialog.close ();
                        break;
                    case Gtk.ResponseType.NO:
                        dialog.close ();
                        break;
                    case Gtk.ResponseType.CANCEL:
                    case Gtk.ResponseType.CLOSE:
                    case Gtk.ResponseType.DELETE_EVENT:
                        dialog.close ();
                        return;
                    default:
                        assert_not_reached ();
                }
            });
            
            
            dialog.run ();
        }
        
        string planet_name_gen () {
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
        string planet_type_gen () {
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
        string planet_atm_gen () {
            string[] types = { _("Nitrogenic"), _("Nitrogen & Oxygen"), "Sulfuric",
            _("Methane"), _("Beryllic"), _("Carbon Dioxide"),
            _("Argonic"), _("Helium"), _("Hydrogenic") };
            int random_index = Random.int_range (0,8);
            string planet_atm = types[random_index];
            
            return planet_atm;
        }
        string planet_diameter_gen () {
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
        
        public void update_base_values () {
            m_res = (m_res + ((sym_level + 1) * (1.55 * m_mine_level))).clamp(0, m_total);
            c_res = (c_res + ((syc_level + 1) * (1.25 * c_mine_level))).clamp(0, c_total);
            h_res = (h_res + ((syh_level + 1) * (1.10 * h_mine_level))).clamp(0, h_total);
            update_m_value ();
            update_c_value ();
            update_h_value ();
            update_pb_values ();
            update_help_tooltips ();
            update_buttons ();
            set_gsettings ();
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
        
        public void update_pb_values () {
            mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));
            mpm.set_fraction (m_mine_level/m_total_mine);
            cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));
            cpm.set_fraction (c_mine_level/c_total_mine);
            hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));
            hpm.set_fraction (h_mine_level/h_total_mine);
            
            stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));
            stmpm.set_fraction (stm_level/stm_total);
            stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));
            stcpm.set_fraction (stc_level/stc_total);
            sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));
            sthpm.set_fraction (sth_level/sth_total);
            population_desc.set_label ("%0.f".printf(ph_res));
            phpm.set_text ("""%.0f/%.0f""".printf(ph_level, ph_total));
            phpm.set_fraction (ph_level/ph_total);
            
            lpm.set_text ("""%.0f/%.0f""".printf(l_level, l_total));
            lpm.set_fraction (l_level/l_total);
            
            sympm.set_text ("""%.0f/%.0f""".printf(sym_level, sym_total));
            sympm.set_fraction (sym_level/sym_total);
            sycpm.set_text ("""%.0f/%.0f""".printf(syc_level, syc_total));
            sycpm.set_fraction (syc_level/syc_total);
            syhpm.set_text ("""%.0f/%.0f""".printf(syh_level, syh_total));
            syhpm.set_fraction (syh_level/syh_total);
            phspm.set_text ("""%.0f/%.0f""".printf(phs_level, phs_total));
            phspm.set_fraction (phs_level/phs_total);
        }
        
        public void update_buttons () {
            // Mineral Mine button
            if (m_res >= (50 * (m_mine_level + 1)) && c_res >= (20 * (m_mine_level + 1)) && m_mine_level < m_total_mine) {
                button_m.sensitive = true;
            } else {
                button_m.sensitive = false;
            }
            
            // Crystal Mine button
            if (m_res >= (20 * (c_mine_level + 1)) && c_res >= (50 * (c_mine_level + 1)) && c_mine_level < c_total_mine) {
                button_c.sensitive = true;
            } else {
                button_c.sensitive = false;
            }
            
            // Hydrogen Mine button
            if (m_res >= (50 * (c_mine_level + 1)) && c_res >= (50 * (c_mine_level + 1)) && h_mine_level < h_total_mine) {
                button_h.sensitive = true;
            } else {
                button_h.sensitive = false;
            }
            
            // Mineral Storage button
            if (m_res >= (100 * (stm_level + 1)) && stm_level < stm_total) {
                button_stm.sensitive = true;
            } else {
                button_stm.sensitive = false;
            }
            
            // Crystal Storage button
            if (c_res >= (100 * (stc_level + 1)) && stc_level < stc_total) {
                button_stc.sensitive = true;
            } else {
                button_stc.sensitive = false;
            }
            
            // Hydrogen Storage button
            if (h_res >= (100 * (sth_level + 1)) && sth_level < sth_total) {
                button_sth.sensitive = true;
            } else {
                button_sth.sensitive = false;
            }
            
            // Population Housing button
            if (c_res >= (10 * (ph_level + 1)) && m_res >= (10 * (ph_level + 1)) && ph_level < ph_total) {
                button_ph.sensitive = true;
            } else {
                button_ph.sensitive = false;
            }
            
            // Lab button
            if (m_res >= (200 * (l_level + 1)) && c_res >= (200 * (l_level + 1)) && h_res >= (100 * (l_level + 1)) && l_level < l_total) {
                button_l.sensitive = true;
            } else {
                button_l.sensitive = false;
            }
            
            // Mineral Synthesizer button
            if (c_res >= (200 * (sym_level + 1)) && h_res >= (200 * (sym_level + 1)) && l_level >= 1 && sym_level < sym_total) {
                button_sym.sensitive = true;
            } else {
                button_sym.sensitive = false;
            }
            
            // Crystal Synthesizer button
            if (c_res >= (200 * (syc_level + 1)) && h_res >= (200 * (syc_level + 1)) && l_level >= 2 && syc_level < syc_total) {
                button_syc.sensitive = true;
            } else {
                button_syc.sensitive = false;
            }
            
            // Hydrogen Synthesizer button
            if (c_res >= (200 * (syh_level + 1)) && h_res >= (200 * (syc_level + 1)) && l_level >= 3 && syh_level < syh_total) {
                button_syh.sensitive = true;
            } else {
                button_syh.sensitive = false;
            }
            
            // Population Housing Upgrade button
            if (c_res >= (100 * (phs_level + 1)) && h_res >= (100 * (phs_level + 1)) && l_level >= 1 && phs_level < phs_total) {
                button_phs.sensitive = true;
            } else {
                button_phs.sensitive = false;
            }
            
        }
        
        public void update_help_tooltips () {
            pm_m = ((50 * (this.m_mine_level + 1)));
            pm_c = ((20 * (this.c_mine_level + 1)));
            pc_m = ((20 * (this.m_mine_level + 1)));
            pc_c = ((50 * (this.c_mine_level + 1)));
            ps_m = ((100 * (this.stm_level + 1)));
            ps_c = ((100 * (this.stc_level + 1)));
            ps_h = ((100 * (this.sth_level + 1)));
            ph_c = ((10 * (this.ph_level + 1)));
            ph_h = ((10 * (this.ph_level + 1)));
            l_m = ((200 * (this.l_level + 1)));
            l_c = ((200 * (this.l_level + 1)));
            l_h = ((100 * (this.l_level + 1)));
            sm_c = ((200 * (this.sym_level + 1)));
            sm_h = ((200 * (this.sym_level + 1)));
            sc_c = ((200 * (this.syc_level + 1)));
            sc_h = ((200 * (this.syc_level + 1)));
            sh_c = ((200 * (this.syh_level + 1)));
            sh_h = ((200 * (this.syh_level + 1)));
            phs_c = ((100 * (this.phs_level + 1)));
            phs_h = ((100 * (this.phs_level + 1)));
            help_pm.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pm_c)));
            help_pc.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pc_m, pc_c)));
            help_ph.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pc_c)));
            help_phh.set_tooltip_text (_("""To build the next level, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(ph_c, ph_h)));
            help_sm.set_tooltip_text (_("""To build the next level, %.0f of Mineral is needed""".printf(ps_m)));
            help_sc.set_tooltip_text (_("""To build the next level, %.0f of Crystal is needed""".printf(ps_c)));
            help_sh.set_tooltip_text (_("""To build the next level, %.0f of Hydrogen is needed""".printf(ps_h)));
            help_l.set_tooltip_text (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(l_m, l_c, l_h)));
            help_sym.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(sm_c, sm_h)));
            help_syc.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(sc_c, sc_h)));
            help_syh.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(sh_c, sh_h)));
            help_phs.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(phs_c, phs_h)));
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
            this.get_position (out this.window_x, out this.window_y);
            
            Planitis.Application.gsettings.set_int ("window-x", this.window_x);
            Planitis.Application.gsettings.set_int ("window-y", this.window_y);
            set_gsettings ();
            return false;
        }
        
        public void set_gsettings () {
            Planitis.Application.gsettings.set_double ("metal", this.m_res);
            Planitis.Application.gsettings.set_double ("crystal", this.c_res);
            Planitis.Application.gsettings.set_double ("hydrogen", this.h_res);
            Planitis.Application.gsettings.set_double ("population", this.ph_res);
            Planitis.Application.gsettings.set_double ("ph-level", this.ph_level);
            Planitis.Application.gsettings.set_double ("metal-mine", this.m_mine_level);
            Planitis.Application.gsettings.set_double ("crystal-mine", this.c_mine_level);
            Planitis.Application.gsettings.set_double ("hydrogen-mine", this.h_mine_level);
            Planitis.Application.gsettings.set_double ("stm-level", this.stm_level);
            Planitis.Application.gsettings.set_double ("stc-level", this.stc_level);
            Planitis.Application.gsettings.set_double ("sth-level", this.sth_level);
            Planitis.Application.gsettings.set_double ("lab-level", this.l_level);
            Planitis.Application.gsettings.set_double ("sym-level", this.sym_level);
            Planitis.Application.gsettings.set_double ("syc-level", this.syc_level);
            Planitis.Application.gsettings.set_double ("syh-level", this.syh_level);
            Planitis.Application.gsettings.set_double ("phs-level", this.phs_level);
            
            Planitis.Application.gsettings.set_string ("planet-name", this.planet_name);
            Planitis.Application.gsettings.set_string ("planet-type", this.planet_type);
            Planitis.Application.gsettings.set_string ("planet-atm", this.planet_atm);
            Planitis.Application.gsettings.set_string ("planet-diameter", this.planet_diameter);
        }
        
        public void get_gsettings () {
            m_res = Planitis.Application.gsettings.get_double("metal");
            c_res = Planitis.Application.gsettings.get_double("crystal");
            h_res = Planitis.Application.gsettings.get_double("hydrogen");
            ph_res = Planitis.Application.gsettings.get_double("population");
            ph_level = Planitis.Application.gsettings.get_double("ph-level");
            m_total = (m_total * (Planitis.Application.gsettings.get_double("stm-level") + 1));
            c_total = (c_total * (Planitis.Application.gsettings.get_double("stc-level") + 1));
            h_total = (h_total * (Planitis.Application.gsettings.get_double("sth-level") + 1));
            m_mine_level = Planitis.Application.gsettings.get_double("metal-mine");
            c_mine_level = Planitis.Application.gsettings.get_double("crystal-mine");
            h_mine_level = Planitis.Application.gsettings.get_double("hydrogen-mine");
            stm_level = Planitis.Application.gsettings.get_double("stm-level");
            stc_level = Planitis.Application.gsettings.get_double("stc-level");
            sth_level = Planitis.Application.gsettings.get_double("sth-level");
            l_level = Planitis.Application.gsettings.get_double("lab-level");
            sym_level = Planitis.Application.gsettings.get_double("sym-level");
            syc_level = Planitis.Application.gsettings.get_double("syc-level");
            syh_level = Planitis.Application.gsettings.get_double("syh-level");
            phs_level = Planitis.Application.gsettings.get_double("phs-level");

            planet_name = Planitis.Application.gsettings.get_string("planet-name");
            planet_type = Planitis.Application.gsettings.get_string("planet-type");
            planet_atm = Planitis.Application.gsettings.get_string("planet-atm");
            planet_diameter = Planitis.Application.gsettings.get_string("planet-diameter");
        }
    }
    
    private class Label : Gtk.Label {
        public Label (string text) {
            label = text;
            halign = Gtk.Align.END;
            margin_start = 12;
        }
    }
    
    public class Dialog : Granite.MessageDialog {
        public MainWindow win;
        public Dialog () {
            Object (
                image_icon: new ThemedIcon ("dialog-warning"),
                primary_text: (_("Reset Your Game?")),
                secondary_text: (_("If you reset, the planet will be issued a Planet Buster™ and you'll move to another planet, newly colonized. Proceed?"))
            );
        }
        construct {
            var save = add_button ((_("Yes, destroy!")), Gtk.ResponseType.OK);
            var save_context = save.get_style_context ();
            save_context.add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            save_context.add_class ("pl-destructive");
            var cws = add_button ((_("No, don't!")), Gtk.ResponseType.NO);
        }
    }
}
