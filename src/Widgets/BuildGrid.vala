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
    public class Widgets.BuildGrid : Gtk.Grid {
        private MainWindow win;
        private Widgets.InfoGrid infogrid;
        private Widgets.ResGrid resgrid;
        private Services.Utils.Base base_utils;

        public Gtk.ProgressBar mpm;
        public Gtk.ProgressBar cpm;
        public Gtk.ProgressBar hpm;
        public Gtk.ProgressBar stmpm;
        public Gtk.ProgressBar stcpm;
        public Gtk.ProgressBar sthpm;
        public Gtk.ProgressBar phpm;
        public Gtk.Image help_pm;
        public Gtk.Image help_pc;
        public Gtk.Image help_ph;
        public Gtk.Image help_phh;
        public Gtk.Image help_sm;
        public Gtk.Image help_sc;
        public Gtk.Image help_sh;
        public Gtk.Button button_m;
        public Gtk.Button button_c;
        public Gtk.Button button_h;
        public Gtk.Button button_ph;
        public Gtk.Button button_stm;
        public Gtk.Button button_stc;
        public Gtk.Button button_sth;

        public double pp_total = 10000000000.0;
        public double m_mine_level = 1.0;
        public double m_total_mine = 100.0;
        public double c_mine_level = 1.0;
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
        public double pm_m;
        public double pm_c;
        public double pc_m;
        public double pc_c;
        public double ps_m;
        public double ps_c;
        public double ps_h;
        public double ph_c;
        public double ph_h;

        public BuildGrid (MainWindow win, Widgets.InfoGrid infogrid, Widgets.ResGrid resgrid) {
            this.win = win;
            this.infogrid = infogrid;
            this.resgrid = resgrid;
            this.expand = true;
            this.row_spacing = 6;
            this.column_spacing = 12;

            infogrid.m_total = (infogrid.m_total * (stm_level + 1));
            infogrid.c_total = (infogrid.c_total * (stc_level + 1));
            infogrid.h_total = (infogrid.h_total * (sth_level + 1));
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
            
            var titlebar = new Granite.HeaderLabel (_("Buildings & Storage"));
            var mineral_label = new Services.Utils.Label (_("Mineral Mine:"));
            var crystal_label = new Services.Utils.Label (_("Crystal Mine:"));
            var h_label = new Services.Utils.Label (_("Hydrogen Mine:"));
            
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
                if (infogrid.m_res >= (50 * (m_mine_level + 1)) && infogrid.c_res >= (20 * (m_mine_level + 1))) {
                    m_mine_level += 1;
                    infogrid.m_res -= (50 * (m_mine_level + 1));
                    infogrid.c_res -= (30 * (m_mine_level + 1));
                    mpm.set_text ("""%.0f/%.0f""".printf(m_mine_level, m_total_mine));
                    mpm.set_fraction (m_mine_level/m_total_mine);
                    base_utils.update_base_values ();
                    help_pm.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pm_c)));
                    win.gsm.save_game ();
                }
            });
            
            button_c.clicked.connect (() => {
                if (infogrid.m_res >= (20 * (c_mine_level + 1)) && infogrid.c_res >= (50 * (c_mine_level + 1))) {
                    c_mine_level += 1;
                    infogrid.m_res -= (20 * (c_mine_level + 1));
                    infogrid.c_res -= (50 * (c_mine_level + 1));
                    cpm.set_text ("""%.0f/%.0f""".printf(c_mine_level, c_total_mine));
                    cpm.set_fraction (c_mine_level/c_total_mine);
                    base_utils.update_base_values ();
                    help_pc.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pc_m, pc_c)));
                    win.gsm.save_game ();
                }
            });
            
            button_h.clicked.connect (() => {
                if (infogrid.m_res >= (50 * (h_mine_level + 1)) && infogrid.c_res >= (50 * (h_mine_level + 1))) {
                    h_mine_level += 1;
                    infogrid.m_res -= (50 * (h_mine_level + 1));
                    infogrid.c_res -= (50 * (h_mine_level + 1));
                    hpm.set_text ("""%.0f/%.0f""".printf(h_mine_level, h_total_mine));
                    hpm.set_fraction (h_mine_level/h_total_mine);
                    base_utils.update_base_values ();
                    help_ph.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(pm_m, pc_c)));
                    win.gsm.save_game ();
                }
            });
            
            var stm_label = new Services.Utils.Label (_("Mineral Storage:"));
            var stc_label = new Services.Utils.Label (_("Crystal Storage:"));
            var sth_label = new Services.Utils.Label (_("Hydrogen Storage:"));
            
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
                if (infogrid.m_res >= (100 * (stm_level + 1))) {
                    stm_level += 1;
                    infogrid.m_total = (infogrid.m_total * (stm_level + 1));
                    infogrid.m_res -= (100 * (stm_level + 1));
                    stmpm.set_text ("""%.0f/%.0f""".printf(stm_level, stm_total));
                    stmpm.set_fraction (stm_level/stm_total);
                    base_utils.update_base_values ();
                    help_sm.set_tooltip_text (_("""To build the next level, %.0f of Mineral is needed""".printf(ps_m)));
                    win.gsm.save_game ();
                }
            });
            
            button_stc.clicked.connect (() => {
                if (infogrid.c_res >= (100 * (stc_level + 1))) {
                    stc_level += 1;
                    infogrid.c_total = (infogrid.c_total * stc_level);
                    infogrid.c_res -= (100 * (stc_level + 1));
                    stcpm.set_text ("""%.0f/%.0f""".printf(stc_level, stc_total));
                    stcpm.set_fraction (stc_level/stc_total);
                    base_utils.update_base_values ();
                    help_sc.set_tooltip_text (_("""To build the next level, %.0f of Crystal is needed""".printf(ps_c)));
                    win.gsm.save_game ();
                }
            });
            
            button_sth.clicked.connect (() => {
                if (infogrid.h_res >= (100 * (sth_level + 1))) {
                    sth_level += 1;
                    infogrid.h_total = (infogrid.h_total * sth_level);
                    infogrid.h_res -= (100 * (sth_level + 1));
                    sthpm.set_text ("""%.0f/%.0f""".printf(sth_level, sth_total));
                    sthpm.set_fraction (sth_level/sth_total);
                    base_utils.update_base_values ();
                    help_sh.set_tooltip_text (_("""To build the next level, %.0f of Hydrogen is needed""".printf(ps_h)));
                    win.gsm.save_game ();
                }
            });
            
            var ph_label = new Services.Utils.Label (_("Population Housing:"));
            
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
                if (infogrid.c_res >= (10 * (ph_level + 1)) && infogrid.m_res >= (10 * (ph_level + 1))) {
                    ph_level += 1;
                    infogrid.ph_res += ((10 * resgrid.phs_level) * (ph_level + 1));
                    infogrid.m_res -= (10 * (ph_level + 1));
                    infogrid.c_res -= (10 * (ph_level + 1));
                    infogrid.population_desc.label = "%0.f".printf(infogrid.ph_res);
                    phpm.set_text ("""%.0f/%.0f""".printf(ph_level, ph_total));
                    phpm.set_fraction (ph_level/ph_total);
                    base_utils.update_base_values ();
                    help_phh.set_tooltip_text (_("""To build the next level, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(ph_c, ph_h)));
                    win.gsm.save_game ();
                }
            });
            
            this.attach (titlebar, 0, 0, 6, 1);
            this.attach (sep, 0, 1, 6, 1);
            this.attach (mineral_label, 0, 2, 1, 1);
            this.attach (mpm, 1, 2, 3, 1);
            this.attach (button_m, 4, 2, 1, 1);
            this.attach (help_pm, 5, 2, 1, 1);
            this.attach (crystal_label, 0, 3, 1, 1);
            this.attach (cpm, 1, 3, 3, 1);
            this.attach (button_c, 4, 3, 1, 1);
            this.attach (help_pc, 5, 3, 1, 1);
            this.attach (h_label, 0, 4, 1, 1);
            this.attach (hpm, 1, 4, 3, 1);
            this.attach (button_h, 4, 4, 1, 1);
            this.attach (help_ph, 5, 4, 1, 1);
            this.attach (sep2, 0, 5, 5, 1);
            this.attach (stm_label, 0, 6, 1, 1);
            this.attach (stmpm, 1, 6, 3, 1);
            this.attach (button_stm, 4, 6, 1, 1);
            this.attach (help_sm, 5, 6, 1, 1);
            this.attach (stc_label, 0, 7, 1, 1);
            this.attach (stcpm, 1, 7, 3, 1);
            this.attach (button_stc, 4, 7, 1, 1);
            this.attach (help_sc, 5, 7, 1, 1);
            this.attach (sth_label, 0, 8, 1, 1);
            this.attach (sthpm, 1, 8, 3, 1);
            this.attach (button_sth, 4, 8, 1, 1);
            this.attach (help_sh, 5, 8, 1, 1);
            this.attach (sep3, 0, 9, 6, 1);
            this.attach (ph_label, 0, 10, 1, 1);
            this.attach (phpm, 1, 10, 3, 1);
            this.attach (button_ph, 4, 10, 1, 1);
            this.attach (help_phh, 5, 10, 1, 1);
            this.show_all ();
        }

        public void load_base_values (
            double ma_level,
            double ca_level,
            double ha_level,
            double stma_level,
            double stca_level,
            double stha_level,
            double pha_level
         ) {

            if (this != null) {
                m_mine_level = ma_level;
                c_mine_level = ca_level;
                h_mine_level = ha_level;
                stm_level = stma_level;
                stc_level = stca_level;
                sth_level = stha_level;
                ph_level = pha_level;
            }
            
        }
    }
}