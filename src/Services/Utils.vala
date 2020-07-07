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
namespace Planitis.Services.Utils {
    public class Base : Object {
        private MainWindow win;
        private Widgets.InfoGrid infogrid;
        private Widgets.BuildGrid buildgrid;
        private Widgets.ResGrid resgrid;

        public Base (MainWindow win, Widgets.InfoGrid infogrid, Widgets.BuildGrid buildgrid, Widgets.ResGrid resgrid) {
            this.win = win;
            this.resgrid = resgrid;
            this.buildgrid = buildgrid;
            this.infogrid = infogrid;
        }

        public void update_base_values () {
            infogrid.m_res = (infogrid.m_res + ((resgrid.sym_level + 1) * (1.55 * buildgrid.m_mine_level))).clamp(0, infogrid.m_total);
            infogrid.c_res = (infogrid.c_res + ((resgrid.syc_level + 1) * (1.25 * buildgrid.c_mine_level))).clamp(0, infogrid.c_total);
            infogrid.h_res = (infogrid.h_res + ((resgrid.syh_level + 1) * (1.10 * buildgrid.h_mine_level))).clamp(0, infogrid.h_total);
            update_pb_values ();
            update_help_tooltips ();
            update_buttons ();
            set_settings ();
        }

        public void update_help_tooltips () {
            buildgrid.pm_m = ((50 * (buildgrid.m_mine_level + 1)));
            buildgrid.pm_c = ((20 * (buildgrid.c_mine_level + 1)));
            buildgrid.pc_m = ((20 * (buildgrid.m_mine_level + 1)));
            buildgrid.pc_c = ((50 * (buildgrid.c_mine_level + 1)));
            buildgrid.ps_m = ((100 * (buildgrid.stm_level + 1)));
            buildgrid.ps_c = ((100 * (buildgrid.stc_level + 1)));
            buildgrid.ps_h = ((100 * (buildgrid.sth_level + 1)));
            buildgrid.ph_c = ((10 * (buildgrid.ph_level + 1)));
            buildgrid.ph_h = ((10 * (buildgrid.ph_level + 1)));
            resgrid.l_m = ((200 * (resgrid.l_level + 1)));
            resgrid.l_c = ((200 * (resgrid.l_level + 1)));
            resgrid.l_h = ((100 * (resgrid.l_level + 1)));
            resgrid.sm_c = ((200 * (resgrid.sym_level + 1)));
            resgrid.sm_h = ((200 * (resgrid.sym_level + 1)));
            resgrid.sc_c = ((200 * (resgrid.syc_level + 1)));
            resgrid.sc_h = ((200 * (resgrid.syc_level + 1)));
            resgrid.sh_c = ((200 * (resgrid.syh_level + 1)));
            resgrid.sh_h = ((200 * (resgrid.syh_level + 1)));
            resgrid.phs_c = ((100 * (resgrid.phs_level + 1)));
            resgrid.phs_h = ((100 * (resgrid.phs_level + 1)));
            buildgrid.help_pm.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(buildgrid.pm_m, buildgrid.pm_c)));
            buildgrid.help_pc.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(buildgrid.pc_m, buildgrid.pc_c)));
            buildgrid.help_ph.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(buildgrid.pm_m, buildgrid.pc_c)));
            buildgrid.help_phh.set_tooltip_text (_("""To build the next level, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(buildgrid.ph_c, buildgrid.ph_h)));
            buildgrid.help_sm.set_tooltip_text (_("""To build the next level, %.0f of Mineral is needed""".printf(buildgrid.ps_m)));
            buildgrid.help_sc.set_tooltip_text (_("""To build the next level, %.0f of Crystal is needed""".printf(buildgrid.ps_c)));
            buildgrid.help_sh.set_tooltip_text (_("""To build the next level, %.0f of Hydrogen is needed""".printf(buildgrid.ps_h)));
            resgrid.help_l.set_tooltip_text (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(resgrid.l_m, resgrid.l_c, resgrid.l_h)));
            resgrid.help_sym.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(resgrid.sm_c, resgrid.sm_h)));
            resgrid.help_syc.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(resgrid.sc_c, resgrid.sc_h)));
            resgrid.help_syh.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(resgrid.sh_c, resgrid.sh_h)));
            resgrid.help_phs.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(resgrid.phs_c, resgrid.phs_h)));
        }
    
        public void update_buttons () {
            // Mineral Mine button
            if (infogrid.m_res >= (50 * (buildgrid.m_mine_level + 1)) && infogrid.c_res >= (20 * (buildgrid.m_mine_level + 1)) && buildgrid.m_mine_level < buildgrid.m_total_mine) {
                buildgrid.button_m.sensitive = true;
            } else {
                buildgrid.button_m.sensitive = false;
            }
            
            // Crystal Mine button
            if (infogrid.m_res >= (20 * (buildgrid.c_mine_level + 1)) && infogrid.c_res >= (50 * (buildgrid.c_mine_level + 1)) && buildgrid.c_mine_level < buildgrid.c_total_mine) {
                buildgrid.button_c.sensitive = true;
            } else {
                buildgrid.button_c.sensitive = false;
            }
            
            // Hydrogen Mine button
            if (infogrid.m_res >= (50 * (buildgrid.c_mine_level + 1)) && infogrid.c_res >= (50 * (buildgrid.c_mine_level + 1)) && buildgrid.h_mine_level < buildgrid.h_total_mine) {
                buildgrid.button_h.sensitive = true;
            } else {
                buildgrid.button_h.sensitive = false;
            }
            
            // Mineral Storage button
            if (infogrid.m_res >= (100 * (buildgrid.stm_level + 1)) && buildgrid.stm_level < buildgrid.stm_total) {
                buildgrid.button_stm.sensitive = true;
            } else {
                buildgrid.button_stm.sensitive = false;
            }
            
            // Crystal Storage button
            if (infogrid.c_res >= (100 * (buildgrid.stc_level + 1)) && buildgrid.stc_level < buildgrid.stc_total) {
                buildgrid.button_stc.sensitive = true;
            } else {
                buildgrid.button_stc.sensitive = false;
            }
            
            // Hydrogen Storage button
            if (infogrid.h_res >= (100 * (buildgrid.sth_level + 1)) && buildgrid.sth_level < buildgrid.sth_total) {
                buildgrid.button_sth.sensitive = true;
            } else {
                buildgrid.button_sth.sensitive = false;
            }
            
            // Population Housing button
            if (infogrid.c_res >= (10 * (buildgrid.ph_level + 1)) && infogrid.m_res >= (10 * (buildgrid.ph_level + 1)) && buildgrid.ph_level < buildgrid.ph_total) {
                buildgrid.button_ph.sensitive = true;
            } else {
                buildgrid.button_ph.sensitive = false;
            }
            
            // Lab button
            if (infogrid.m_res >= (200 * (resgrid.l_level + 1)) && infogrid.c_res >= (200 * (resgrid.l_level + 1)) && infogrid.h_res >= (100 * (resgrid.l_level + 1)) && resgrid.l_level < resgrid.l_total) {
                resgrid.button_l.sensitive = true;
            } else {
                resgrid.button_l.sensitive = false;
            }
            
            // Mineral Synthesizer button
            if (infogrid.c_res >= (200 * (resgrid.sym_level + 1)) && infogrid.h_res >= (200 * (resgrid.sym_level + 1)) && resgrid.l_level >= 1 && resgrid.sym_level < resgrid.sym_total) {
                resgrid.button_sym.sensitive = true;
            } else {
                resgrid.button_sym.sensitive = false;
            }
            
            // Crystal Synthesizer button
            if (infogrid.c_res >= (200 * (resgrid.syc_level + 1)) && infogrid.h_res >= (200 * (resgrid.syc_level + 1)) && resgrid.l_level >= 2 && resgrid.syc_level < resgrid.syc_total) {
                resgrid.button_syc.sensitive = true;
            } else {
                resgrid.button_syc.sensitive = false;
            }
            
            // Hydrogen Synthesizer button
            if (infogrid.c_res >= (200 * (resgrid.syh_level + 1)) && infogrid.h_res >= (200 * (resgrid.syc_level + 1)) && resgrid.l_level >= 3 && resgrid.syh_level < resgrid.syh_total) {
                resgrid.button_syh.sensitive = true;
            } else {
                resgrid.button_syh.sensitive = false;
            }
            
            // Population Housing Upgrade button
            if (infogrid.c_res >= (100 * (resgrid.phs_level + 1)) && infogrid.h_res >= (100 * (resgrid.phs_level + 1)) && resgrid.l_level >= 1 && resgrid.phs_level < resgrid.phs_total) {
                resgrid.button_phs.sensitive = true;
            } else {
                resgrid.button_phs.sensitive = false;
            }
        }

        public void update_pb_values () {
            infogrid.population_desc.set_label ("%0.f".printf(infogrid.ph_res));
            infogrid.mpb.set_fraction(infogrid.m_res/infogrid.m_total);
            infogrid.mpb.set_text ("""%.2f/%.2f""".printf(infogrid.m_res, infogrid.m_total));
            infogrid.cpb.set_fraction(infogrid.c_res/infogrid.c_total);
            infogrid.cpb.set_text ("""%.2f/%.2f""".printf(infogrid.c_res, infogrid.c_total));
            infogrid.hpb.set_fraction(infogrid.h_res/infogrid.h_total);
            infogrid.hpb.set_text ("""%.2f/%.2f""".printf(infogrid.h_res, infogrid.h_total));
            
            buildgrid.mpm.set_text ("""%.0f/%.0f""".printf(buildgrid.m_mine_level, buildgrid.m_total_mine));
            buildgrid.mpm.set_fraction (buildgrid.m_mine_level/buildgrid.m_total_mine);
            buildgrid.cpm.set_text ("""%.0f/%.0f""".printf(buildgrid.c_mine_level, buildgrid.c_total_mine));
            buildgrid.cpm.set_fraction (buildgrid.c_mine_level/buildgrid.c_total_mine);
            buildgrid.hpm.set_text ("""%.0f/%.0f""".printf(buildgrid.h_mine_level, buildgrid.h_total_mine));
            buildgrid.hpm.set_fraction (buildgrid.h_mine_level/buildgrid.h_total_mine);
            buildgrid.stmpm.set_text ("""%.0f/%.0f""".printf(buildgrid.stm_level, buildgrid.stm_total));
            buildgrid.stmpm.set_fraction (buildgrid.stm_level/buildgrid.stm_total);
            buildgrid.stcpm.set_text ("""%.0f/%.0f""".printf(buildgrid.stc_level, buildgrid.stc_total));
            buildgrid.stcpm.set_fraction (buildgrid.stc_level/buildgrid.stc_total);
            buildgrid.sthpm.set_text ("""%.0f/%.0f""".printf(buildgrid.sth_level, buildgrid.sth_total));
            buildgrid.sthpm.set_fraction (buildgrid.sth_level/buildgrid.sth_total);
            buildgrid.phpm.set_text ("""%.0f/%.0f""".printf(buildgrid.ph_level, buildgrid.ph_total));
            buildgrid.phpm.set_fraction (buildgrid.ph_level/buildgrid.ph_total);
            
            resgrid.lpm.set_text ("""%.0f/%.0f""".printf(resgrid.l_level, resgrid.l_total));
            resgrid.lpm.set_fraction (resgrid.l_level/resgrid.l_total);
            resgrid.sympm.set_text ("""%.0f/%.0f""".printf(resgrid.sym_level, resgrid.sym_total));
            resgrid.sympm.set_fraction (resgrid.sym_level/resgrid.sym_total);
            resgrid.sycpm.set_text ("""%.0f/%.0f""".printf(resgrid.syc_level, resgrid.syc_total));
            resgrid.sycpm.set_fraction (resgrid.syc_level/resgrid.syc_total);
            resgrid.syhpm.set_text ("""%.0f/%.0f""".printf(resgrid.syh_level, resgrid.syh_total));
            resgrid.syhpm.set_fraction (resgrid.syh_level/resgrid.syh_total);
            resgrid.phspm.set_text ("""%.0f/%.0f""".printf(resgrid.phs_level, resgrid.phs_total));
            resgrid.phspm.set_fraction (resgrid.phs_level/resgrid.phs_total);
        }

        public void reset_all () {
            infogrid.m_res = 100.0;
            infogrid.c_res = 100.0;
            infogrid.h_res = 0.0;
            infogrid.ph_res = 1000.0;
            infogrid.m_total = 1000.0;
            infogrid.c_total = 1000.0;
            infogrid.h_total = 1000.0;
            buildgrid.m_mine_level = 1.0;
            buildgrid.c_mine_level = 1.0;
            buildgrid.h_mine_level = 0.0;
            buildgrid.stm_level = 0.0;
            buildgrid.stc_level = 0.0;
            buildgrid.sth_level = 0.0;
            resgrid.l_level = 0.0;
            buildgrid.ph_level = 1.0;
            resgrid.phs_level = 0.0;
            resgrid.sym_level = 0.0;
            resgrid.syc_level = 0.0;
            resgrid.syh_level = 0.0;
            infogrid.planet_name = infogrid.planet_name_gen ();
            infogrid.header.set_label (infogrid.planet_name);
            infogrid.planet_diameter = infogrid.planet_diameter_gen ();
            infogrid.size_diameter_desc.set_label (infogrid.planet_diameter);
            infogrid.planet_type = infogrid.planet_type_gen ();
            infogrid.type_of_planet_desc.set_label (infogrid.planet_type);
            infogrid.planet_atm = infogrid.planet_atm_gen ();
            infogrid.type_of_atm_desc.set_label (infogrid.planet_atm);
            infogrid.population_desc.set_label ("%0.f".printf(infogrid.ph_res));
            infogrid.mpb.set_fraction (infogrid.m_res/infogrid.m_total);
            infogrid.cpb.set_fraction (infogrid.c_res/infogrid.c_total);
            infogrid.hpb.set_fraction (infogrid.h_res/infogrid.h_total);
            
            // Fixes broken savegame
            if (buildgrid.m_mine_level < 1.0) {
                buildgrid.m_mine_level = 1.0;
            }
            if (buildgrid.c_mine_level < 1.0) {
                buildgrid.c_mine_level = 1.0;
            }
            
            update_base_values ();
        }

        public void set_settings () {
            int x, y, w, h;
            win.get_position (out x, out y);
            win.get_size (out w, out h);

            Planitis.Application.gsettings.set_int("window-x", x);
            Planitis.Application.gsettings.set_int("window-y", y);
            Planitis.Application.gsettings.set_int("window-width", w);
            Planitis.Application.gsettings.set_int("window-height", h);
        }
    }

    public class Label : Gtk.Label {
        public Label (string text) {
            label = text;
            halign = Gtk.Align.END;
            margin_start = 12;
        }
    }

    public class SettingsSwitch : Gtk.Switch {
        public SettingsSwitch (string setting) {

            halign = Gtk.Align.START;
            Planitis.Application.gsettings.bind (setting, this, "active", SettingsBindFlags.DEFAULT);
        }
    }

    public class ExplodyDialog : Granite.MessageDialog {
        public MainWindow win;
        public Services.Utils.Base base_utils;

        public ExplodyDialog (MainWindow win) {
            Object (
                image_icon: new ThemedIcon ("dialog-warning"),
                primary_text: (_("Reset Your Game?")),
                secondary_text: (_("If you reset, the planet will be issued a Planet Buster™ and you'll move to another planet, newly colonized. Proceed?"))
            );
            
            this.win = win;
            base_utils = new Services.Utils.Base (this.win, this.win.infogrid, this.win.buildgrid, this.win.resgrid);
            this.transient_for = this.win;
            this.modal = true;
        }
        construct {
            var save = add_button ((_("Yes, destroy!")), Gtk.ResponseType.OK);
            var save_context = save.get_style_context ();
            save_context.add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            save_context.add_class ("pl-destructive");
            var cws = add_button ((_("No, don't!")), Gtk.ResponseType.NO);

            response.connect ((response_id) => {
                switch (response_id) {
                    case Gtk.ResponseType.OK:
                        base_utils.reset_all ();
                        base_utils.update_pb_values ();
                        base_utils.update_help_tooltips ();
                        base_utils.update_buttons ();
                        this.close ();
                        break;
                    case Gtk.ResponseType.NO:
                        this.close ();
                        break;
                    case Gtk.ResponseType.CANCEL:
                    case Gtk.ResponseType.CLOSE:
                    case Gtk.ResponseType.DELETE_EVENT:
                        this.close ();
                        return;
                    default:
                        assert_not_reached ();
                }
            });
        }
    }
}
