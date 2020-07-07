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
*/

namespace Planitis.Services {
    public class GameSaveManager {
        public MainWindow win;
        public Json.Builder builder;
        public Widgets.InfoGrid infogrid;
        public Widgets.BuildGrid buildgrid;
        public Widgets.ResGrid resgrid;
        private string app_dir = Environment.get_user_data_dir () +
                                 "/com.github.lainsce.planitis";
        private string file_name;

        public GameSaveManager (MainWindow win, Widgets.InfoGrid infogrid, Widgets.BuildGrid buildgrid, Widgets.ResGrid resgrid) {
            this.win = win;
            this.infogrid = infogrid;
            this.buildgrid = buildgrid;
            this.resgrid = resgrid;
            file_name = this.app_dir + "/save_game.json";
            debug ("%s".printf(file_name));
        }

        public void save_game() {
            string json_string = prepare_json_from_game();
            var dir = File.new_for_path(app_dir);
            var file = File.new_for_path (file_name);
            try {
                if (!dir.query_exists()) {
                    dir.make_directory();
                }
                if (file.query_exists ()) {
                    file.delete ();
                }
                var file_stream = file.create (
                                        FileCreateFlags.REPLACE_DESTINATION
                                        );
                var data_stream = new DataOutputStream (file_stream);
                data_stream.put_string(json_string);
            } catch (Error e) {
                warning ("Failed to save planitis: %s\n", e.message);
            }

        }

        private string prepare_json_from_game () {
            builder = new Json.Builder ();

            builder.begin_array ();
            save_column (builder, infogrid, buildgrid, resgrid);
            builder.end_array ();

            Json.Generator generator = new Json.Generator ();
            Json.Node root = builder.get_root ();
            generator.set_root (root);
            string str = generator.to_data (null);
            return str;
        }

        private static void save_column (Json.Builder builder, Widgets.InfoGrid infogrid, Widgets.BuildGrid buildgrid, Widgets.ResGrid resgrid) {
	        builder.begin_array ();
            builder.add_string_value (infogrid.planet_name);
            builder.add_string_value (infogrid.planet_type);
            builder.add_string_value (infogrid.planet_atm);
            builder.add_string_value (infogrid.planet_diameter);
            builder.add_double_value (infogrid.m_res);
            builder.add_double_value (infogrid.c_res);
            builder.add_double_value (infogrid.h_res);
            builder.add_double_value (infogrid.diameter);
            builder.add_double_value (infogrid.m_total);
            builder.add_double_value (infogrid.c_total);
            builder.add_double_value (infogrid.h_total);
            builder.end_array ();

            builder.begin_array ();
            builder.add_double_value (buildgrid.m_mine_level);
            builder.add_double_value (buildgrid.c_mine_level);
            builder.add_double_value (buildgrid.h_mine_level);
            builder.add_double_value (buildgrid.stm_level);
            builder.add_double_value (buildgrid.stc_level);
            builder.add_double_value (buildgrid.sth_level);
            builder.add_double_value (buildgrid.ph_level);
            builder.end_array ();

            builder.begin_array ();
            builder.add_double_value (resgrid.l_level);
            builder.add_double_value (resgrid.sym_level);
            builder.add_double_value (resgrid.syc_level);
            builder.add_double_value (resgrid.syh_level);
            builder.add_double_value (resgrid.phs_level);
            builder.end_array ();
        }

        public void load_from_file () {
            try {
                var file = File.new_for_path(file_name);
                var json_string = "";
                if (file.query_exists()) {
                    string line;
                    var dis = new DataInputStream (file.read ());
                    while ((line = dis.read_line (null)) != null) {
                        json_string += line;
                    }
                    var parser = new Json.Parser();
                    parser.load_from_data(json_string);
                    var root = parser.get_root();
                    var array = root.get_array();

                    //  string name = array.get_string_element(0);
                    //  double number = array.get_double_element(0);

                    var infogrid_arr = array.get_array_element (0);
                    string planet_name = infogrid_arr.get_string_element(0);
                    string planet_type = infogrid_arr.get_string_element(1);
                    string planet_atm = infogrid_arr.get_string_element(2);
                    string planet_diameter = infogrid_arr.get_string_element(3);
                    double m_res = infogrid_arr.get_double_element(4);
                    double c_res = infogrid_arr.get_double_element(5);
                    double h_res = infogrid_arr.get_double_element(6);
                    double diameter = infogrid_arr.get_double_element(7);
                    double m_total = infogrid_arr.get_double_element(8);
                    double c_total = infogrid_arr.get_double_element(9);
                    double h_total = infogrid_arr.get_double_element(10);
                    var buildgrid_arr = array.get_array_element (1);
                    double m_level = buildgrid_arr.get_double_element(0);
                    double c_level = buildgrid_arr.get_double_element(1);
                    double h_level = buildgrid_arr.get_double_element(2);
                    double stm_level = buildgrid_arr.get_double_element(3);
                    double stc_level = buildgrid_arr.get_double_element(4);
                    double sth_level = buildgrid_arr.get_double_element(5);
                    double ph_level = buildgrid_arr.get_double_element(5);
                    var resgrid_arr = array.get_array_element (2);
                    double l_level = resgrid_arr.get_double_element(0);
                    double sym_level = resgrid_arr.get_double_element(1);
                    double syc_level = resgrid_arr.get_double_element(2);
                    double syh_level = resgrid_arr.get_double_element(3);
                    double phs_level = resgrid_arr.get_double_element(4);

                    win.load_base_values (planet_name,
                                          planet_type,
                                          planet_atm,
                                          planet_diameter,
                                          m_res,
                                          c_res,
                                          h_res,
                                          diameter,
                                          m_total,
                                          c_total,
                                          h_total,
                                          m_level,
                                          c_level,
                                          h_level,
                                          stm_level,
                                          stc_level,
                                          sth_level,
                                          ph_level,
                                          l_level,
                                          sym_level,
                                          syc_level,
                                          syh_level,
                                          phs_level
                                        );
                }
            } catch (Error e) {
                warning ("Failed to load file: %s\n", e.message);
            }
        }
    }
}
