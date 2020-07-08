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

        public Base (MainWindow win) {
            this.win = win;
        }

        public void update_base_values () {
            win.infogrid.m_res = (win.infogrid.m_res + ((win.resgrid.sym_level + 1) * (1.55 * win.buildgrid.m_mine_level))).clamp(0, win.infogrid.m_total);
            win.infogrid.c_res = (win.infogrid.c_res + ((win.resgrid.syc_level + 1) * (1.25 * win.buildgrid.c_mine_level))).clamp(0, win.infogrid.c_total);
            win.infogrid.h_res = (win.infogrid.h_res + ((win.resgrid.syh_level + 1) * (1.10 * win.buildgrid.h_mine_level))).clamp(0, win.infogrid.h_total);
            update_pb_values ();
            update_help_tooltips ();
            update_buttons ();
            set_settings ();
        }

        public void update_help_tooltips () {
            win.buildgrid.pm_m = ((50 * (win.buildgrid.m_mine_level + 1)));
            win.buildgrid.pm_c = ((20 * (win.buildgrid.c_mine_level + 1)));
            win.buildgrid.pc_m = ((20 * (win.buildgrid.m_mine_level + 1)));
            win.buildgrid.pc_c = ((50 * (win.buildgrid.c_mine_level + 1)));
            win.buildgrid.ps_m = ((100 * (win.buildgrid.stm_level + 1)));
            win.buildgrid.ps_c = ((100 * (win.buildgrid.stc_level + 1)));
            win.buildgrid.ps_h = ((100 * (win.buildgrid.sth_level + 1)));
            win.buildgrid.ph_c = ((10 * (win.buildgrid.ph_level + 1)));
            win.buildgrid.ph_h = ((10 * (win.buildgrid.ph_level + 1)));
            win.resgrid.l_m = ((200 * (win.resgrid.l_level + 1)));
            win.resgrid.l_c = ((200 * (win.resgrid.l_level + 1)));
            win.resgrid.l_h = ((100 * (win.resgrid.l_level + 1)));
            win.resgrid.sm_c = ((200 * (win.resgrid.sym_level + 1)));
            win.resgrid.sm_h = ((200 * (win.resgrid.sym_level + 1)));
            win.resgrid.sc_c = ((200 * (win.resgrid.syc_level + 1)));
            win.resgrid.sc_h = ((200 * (win.resgrid.syc_level + 1)));
            win.resgrid.sh_c = ((200 * (win.resgrid.syh_level + 1)));
            win.resgrid.sh_h = ((200 * (win.resgrid.syh_level + 1)));
            win.resgrid.phs_c = ((100 * (win.resgrid.phs_level + 1)));
            win.resgrid.phs_h = ((100 * (win.resgrid.phs_level + 1)));
            win.buildgrid.help_pm.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(win.buildgrid.pm_m, win.buildgrid.pm_c)));
            win.buildgrid.help_pc.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(win.buildgrid.pc_m, win.buildgrid.pc_c)));
            win.buildgrid.help_ph.set_tooltip_text (_("""To build the next level, %.0f of Mineral and %.0f of Crystal is needed""".printf(win.buildgrid.pm_m, win.buildgrid.pc_c)));
            win.buildgrid.help_phh.set_tooltip_text (_("""To build the next level, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(win.buildgrid.ph_c, win.buildgrid.ph_h)));
            win.buildgrid.help_sm.set_tooltip_text (_("""To build the next level, %.0f of Mineral is needed""".printf(win.buildgrid.ps_m)));
            win.buildgrid.help_sc.set_tooltip_text (_("""To build the next level, %.0f of Crystal is needed""".printf(win.buildgrid.ps_c)));
            win.buildgrid.help_sh.set_tooltip_text (_("""To build the next level, %.0f of Hydrogen is needed""".printf(win.buildgrid.ps_h)));
            win.resgrid.help_l.set_tooltip_text (_("""To build the next level, %.0f of Mineral, %.0f of Crystal and %.0f of Hydrogen is needed""".printf(win.resgrid.l_m, win.resgrid.l_c, win.resgrid.l_h)));
            win.resgrid.help_sym.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(win.resgrid.sm_c, win.resgrid.sm_h)));
            win.resgrid.help_syc.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 2 is needed""".printf(win.resgrid.sc_c, win.resgrid.sc_h)));
            win.resgrid.help_syh.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 3 is needed""".printf(win.resgrid.sh_c, win.resgrid.sh_h)));
            win.resgrid.help_phs.set_tooltip_text (_("""To research the next level, %.0f of Crystal, %.0f of Hydrogen and a Research Lab level of 1 is needed""".printf(win.resgrid.phs_c, win.resgrid.phs_h)));
        }
    
        public void update_buttons () {
            // Mineral Mine button
            if (win.infogrid.m_res >= (50 * (win.buildgrid.m_mine_level + 1)) && win.infogrid.c_res >= (20 * (win.buildgrid.m_mine_level + 1)) && win.buildgrid.m_mine_level < win.buildgrid.m_total_mine) {
                win.buildgrid.button_m.sensitive = true;
            } else {
                win.buildgrid.button_m.sensitive = false;
            }
            
            // Crystal Mine button
            if (win.infogrid.m_res >= (20 * (win.buildgrid.c_mine_level + 1)) && win.infogrid.c_res >= (50 * (win.buildgrid.c_mine_level + 1)) && win.buildgrid.c_mine_level < win.buildgrid.c_total_mine) {
                win.buildgrid.button_c.sensitive = true;
            } else {
                win.buildgrid.button_c.sensitive = false;
            }
            
            // Hydrogen Mine button
            if (win.infogrid.m_res >= (50 * (win.buildgrid.c_mine_level + 1)) && win.infogrid.c_res >= (50 * (win.buildgrid.c_mine_level + 1)) && win.buildgrid.h_mine_level < win.buildgrid.h_total_mine) {
                win.buildgrid.button_h.sensitive = true;
            } else {
                win.buildgrid.button_h.sensitive = false;
            }
            
            // Mineral Storage button
            if (win.infogrid.m_res >= (100 * (win.buildgrid.stm_level + 1)) && win.buildgrid.stm_level < win.buildgrid.stm_total) {
                win.buildgrid.button_stm.sensitive = true;
            } else {
                win.buildgrid.button_stm.sensitive = false;
            }
            
            // Crystal Storage button
            if (win.infogrid.c_res >= (100 * (win.buildgrid.stc_level + 1)) && win.buildgrid.stc_level < win.buildgrid.stc_total) {
                win.buildgrid.button_stc.sensitive = true;
            } else {
                win.buildgrid.button_stc.sensitive = false;
            }
            
            // Hydrogen Storage button
            if (win.infogrid.h_res >= (100 * (win.buildgrid.sth_level + 1)) && win.buildgrid.sth_level < win.buildgrid.sth_total) {
                win.buildgrid.button_sth.sensitive = true;
            } else {
                win.buildgrid.button_sth.sensitive = false;
            }
            
            // Population Housing button
            if (win.infogrid.c_res >= (10 * (win.buildgrid.ph_level + 1)) && win.infogrid.m_res >= (10 * (win.buildgrid.ph_level + 1)) && win.buildgrid.ph_level < win.buildgrid.ph_total) {
                win.buildgrid.button_ph.sensitive = true;
            } else {
                win.buildgrid.button_ph.sensitive = false;
            }
            
            // Lab button
            if (win.infogrid.m_res >= (200 * (win.resgrid.l_level + 1)) && win.infogrid.c_res >= (200 * (win.resgrid.l_level + 1)) && win.infogrid.h_res >= (100 * (win.resgrid.l_level + 1)) && win.resgrid.l_level < win.resgrid.l_total) {
                win.resgrid.button_l.sensitive = true;
            } else {
                win.resgrid.button_l.sensitive = false;
            }
            
            // Mineral Synthesizer button
            if (win.infogrid.c_res >= (200 * (win.resgrid.sym_level + 1)) && win.infogrid.h_res >= (200 * (win.resgrid.sym_level + 1)) && win.resgrid.l_level >= 1 && win.resgrid.sym_level < win.resgrid.sym_total) {
                win.resgrid.button_sym.sensitive = true;
            } else {
                win.resgrid.button_sym.sensitive = false;
            }
            
            // Crystal Synthesizer button
            if (win.infogrid.c_res >= (200 * (win.resgrid.syc_level + 1)) && win.infogrid.h_res >= (200 * (win.resgrid.syc_level + 1)) && win.resgrid.l_level >= 2 && win.resgrid.syc_level < win.resgrid.syc_total) {
                win.resgrid.button_syc.sensitive = true;
            } else {
                win.resgrid.button_syc.sensitive = false;
            }
            
            // Hydrogen Synthesizer button
            if (win.infogrid.c_res >= (200 * (win.resgrid.syh_level + 1)) && win.infogrid.h_res >= (200 * (win.resgrid.syc_level + 1)) && win.resgrid.l_level >= 3 && win.resgrid.syh_level < win.resgrid.syh_total) {
                win.resgrid.button_syh.sensitive = true;
            } else {
                win.resgrid.button_syh.sensitive = false;
            }
            
            // Population Housing Upgrade button
            if (win.infogrid.c_res >= (100 * (win.resgrid.phs_level + 1)) && win.infogrid.h_res >= (100 * (win.resgrid.phs_level + 1)) && win.resgrid.l_level >= 1 && win.resgrid.phs_level < win.resgrid.phs_total) {
                win.resgrid.button_phs.sensitive = true;
            } else {
                win.resgrid.button_phs.sensitive = false;
            }
        }

        public void update_pb_values () {
            win.infogrid.population_desc.set_label ("%0.f".printf(win.infogrid.ph_res));
            win.infogrid.mpb.set_fraction(win.infogrid.m_res/win.infogrid.m_total);
            win.infogrid.mpb.set_text ("""%.2f/%.2f""".printf(win.infogrid.m_res, win.infogrid.m_total));
            win.infogrid.cpb.set_fraction(win.infogrid.c_res/win.infogrid.c_total);
            win.infogrid.cpb.set_text ("""%.2f/%.2f""".printf(win.infogrid.c_res, win.infogrid.c_total));
            win.infogrid.hpb.set_fraction(win.infogrid.h_res/win.infogrid.h_total);
            win.infogrid.hpb.set_text ("""%.2f/%.2f""".printf(win.infogrid.h_res, win.infogrid.h_total));
            
            win.buildgrid.mpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.m_mine_level, win.buildgrid.m_total_mine));
            win.buildgrid.mpm.set_fraction (win.buildgrid.m_mine_level/win.buildgrid.m_total_mine);
            win.buildgrid.cpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.c_mine_level, win.buildgrid.c_total_mine));
            win.buildgrid.cpm.set_fraction (win.buildgrid.c_mine_level/win.buildgrid.c_total_mine);
            win.buildgrid.hpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.h_mine_level, win.buildgrid.h_total_mine));
            win.buildgrid.hpm.set_fraction (win.buildgrid.h_mine_level/win.buildgrid.h_total_mine);
            win.buildgrid.stmpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.stm_level, win.buildgrid.stm_total));
            win.buildgrid.stmpm.set_fraction (win.buildgrid.stm_level/win.buildgrid.stm_total);
            win.buildgrid.stcpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.stc_level, win.buildgrid.stc_total));
            win.buildgrid.stcpm.set_fraction (win.buildgrid.stc_level/win.buildgrid.stc_total);
            win.buildgrid.sthpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.sth_level, win.buildgrid.sth_total));
            win.buildgrid.sthpm.set_fraction (win.buildgrid.sth_level/win.buildgrid.sth_total);
            win.buildgrid.phpm.set_text ("""%.0f/%.0f""".printf(win.buildgrid.ph_level, win.buildgrid.ph_total));
            win.buildgrid.phpm.set_fraction (win.buildgrid.ph_level/win.buildgrid.ph_total);
            
            win.resgrid.lpm.set_text ("""%.0f/%.0f""".printf(win.resgrid.l_level, win.resgrid.l_total));
            win.resgrid.lpm.set_fraction (win.resgrid.l_level/win.resgrid.l_total);
            win.resgrid.sympm.set_text ("""%.0f/%.0f""".printf(win.resgrid.sym_level, win.resgrid.sym_total));
            win.resgrid.sympm.set_fraction (win.resgrid.sym_level/win.resgrid.sym_total);
            win.resgrid.sycpm.set_text ("""%.0f/%.0f""".printf(win.resgrid.syc_level, win.resgrid.syc_total));
            win.resgrid.sycpm.set_fraction (win.resgrid.syc_level/win.resgrid.syc_total);
            win.resgrid.syhpm.set_text ("""%.0f/%.0f""".printf(win.resgrid.syh_level, win.resgrid.syh_total));
            win.resgrid.syhpm.set_fraction (win.resgrid.syh_level/win.resgrid.syh_total);
            win.resgrid.phspm.set_text ("""%.0f/%.0f""".printf(win.resgrid.phs_level, win.resgrid.phs_total));
            win.resgrid.phspm.set_fraction (win.resgrid.phs_level/win.resgrid.phs_total);
        }

        public void reset_all () {
            win.infogrid.m_res = 100.0;
            win.infogrid.c_res = 100.0;
            win.infogrid.h_res = 0.0;
            win.infogrid.ph_res = 1000.0;
            win.infogrid.m_total = 1000.0;
            win.infogrid.c_total = 1000.0;
            win.infogrid.h_total = 1000.0;
            win.buildgrid.m_mine_level = 1.0;
            win.buildgrid.c_mine_level = 1.0;
            win.buildgrid.h_mine_level = 0.0;
            win.buildgrid.stm_level = 0.0;
            win.buildgrid.stc_level = 0.0;
            win.buildgrid.sth_level = 0.0;
            win.buildgrid.ph_level = 1.0;
            win.resgrid.l_level = 0.0;
            win.resgrid.phs_level = 0.0;
            win.resgrid.sym_level = 0.0;
            win.resgrid.syc_level = 0.0;
            win.resgrid.syh_level = 0.0;
            win.infogrid.planet_name = win.infogrid.planet_name_gen ();
            win.infogrid.header.set_label (win.infogrid.planet_name);
            win.infogrid.planet_diameter = win.infogrid.planet_diameter_gen ();
            win.infogrid.size_diameter_desc.set_label (win.infogrid.planet_diameter);
            win.infogrid.planet_type = win.infogrid.planet_type_gen ();
            win.infogrid.type_of_planet_desc.set_label (win.infogrid.planet_type);
            win.infogrid.planet_atm = win.infogrid.planet_atm_gen ();
            win.infogrid.type_of_atm_desc.set_label (win.infogrid.planet_atm);
            win.infogrid.population_desc.set_label ("%0.f".printf(win.infogrid.ph_res));
            win.infogrid.mpb.set_fraction (win.infogrid.m_res/win.infogrid.m_total);
            win.infogrid.cpb.set_fraction (win.infogrid.c_res/win.infogrid.c_total);
            win.infogrid.hpb.set_fraction (win.infogrid.h_res/win.infogrid.h_total);
            
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

        public ExplodyDialog (MainWindow win) {
            Object (
                image_icon: new ThemedIcon ("dialog-warning"),
                primary_text: (_("Reset Your Game?")),
                secondary_text: (_("If you reset, the planet will be issued a Planet Buster™ and you'll move to another planet, newly colonized. Proceed?"))
            );
            
            this.win = win;
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
                        win.base_utils.reset_all ();
                        win.base_utils.update_pb_values ();
                        win.base_utils.update_help_tooltips ();
                        win.base_utils.update_buttons ();
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
