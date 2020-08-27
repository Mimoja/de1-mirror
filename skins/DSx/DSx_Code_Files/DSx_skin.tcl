package provide DSx_skin 1.0

#### Skin by Damian Brakel ####

package ifneeded DSx_functions 1.0 [list source [file join "./skins/DSx/DSx_Code_Files/" DSx_functions.tcl]]
package require DSx_functions 1.0
DSx_startup
package ifneeded DSx_admin 1.0 [list source [file join "./skins/DSx/DSx_Code_Files/" DSx_admin.tcl]]
package require DSx_admin 1.0


set ::DSx_settings(version) {2.98}
#set ::LRv2_presets 1

### Heading
set ::DSx_heading [add_de1_variable "$::DSx_home_pages" 1280 100 -font [DSx_font font 30] -fill $::DSx_settings(heading_colour) -anchor "center" -textvariable {$::DSx_settings(heading)}]

#Clock
set ::DSx_clock_font_var_1 [add_de1_variable "$::DSx_home_pages" 2420 80 -font [DSx_font "$::DSx_settings(clock_font)" 14.5] -fill $::DSx_settings(font_colour) -justify right -anchor "e" -textvariable {[DSx_clock]}]
set ::DSx_clock_font_var_2 [add_de1_variable "$::DSx_home_pages" 2450 130 -font [DSx_font "$::DSx_settings(clock_font)" 6.4] -fill #efbf63 -justify center -anchor "e" -textvariable {[DSx_date]}]
set ::DSx_clock_font_var_3 [add_de1_variable "$::DSx_home_pages" 2420 92 -font [DSx_font "$::DSx_settings(clock_font)" 8] -fill $::DSx_settings(font_colour) -justify left -anchor "w" -textvariable { [DSx_clock_s]}]
set ::DSx_clock_font_var_4 [add_de1_variable "$::DSx_home_pages" 2426 60 -font [DSx_font "$::DSx_settings(clock_font)" 6] -fill #efbf63 -justify left -anchor "w" -textvariable { [DSx_clock_ap]}]

set listbox_font "Helv_8"
profile_has_changed_set_colors

### Right side
# Data


add_de1_variable "$::DSx_standby_pages steam preheat_2 water" 1840 325 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 720] -textvariable {$::DSx_settings(live_graph_profile)}
add_de1_variable "$::DSx_standby_pages steam preheat_2 water" 1840 375 -justify right -anchor "nw" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 720] -textvariable {[last_shot_date]}

add_de1_variable "$::DSx_standby_pages" 2140 736 -justify center -anchor "n" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {$::DSx_settings(live_graph_pi_time)+$::DSx_settings(live_graph_pour_time) = $::DSx_settings(live_graph_shot_time)s   $::DSx_settings(live_graph_pi_water)+$::DSx_settings(live_graph_pour_water) = $::DSx_settings(live_graph_water)mL   $::DSx_settings(live_graph_weight)g}
add_de1_variable "espresso" 2140 736 -justify center -anchor "n" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {[espresso_preinfusion_timer]+[espresso_pour_timer] = [espresso_elapsed_timer]s   [DSx_water_data]mL  [round_to_one_digits $::de1(scale_sensor_weight)]g}

add_de1_variable "espresso" 1810 370 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 520] -textvariable {[pressure_text]}
add_de1_variable "espresso" 2120 370 -justify center -anchor "n" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 520] -textvariable {[waterflow_text]}
add_de1_variable "espresso" 2440 370 -justify left -anchor "ne" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 520] -textvariable {[waterweight_text]}

add_de1_variable "steam" 1830 1060 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 520] -textvariable {[pressure_text]}
add_de1_variable "steam" 2440 1060 -justify left -anchor "ne" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -width [rescale_x_skin 520] -textvariable {[waterflow_text]}
add_de1_image "$::DSx_home_pages" 1820 1280 "[skin_directory_graphics]/icons/setup.png"
add_de1_image "$::DSx_home_pages" 2040 1280 "[skin_directory_graphics]/icons/settings.png"
add_de1_image "$::DSx_home_pages" 2260 1280 "[skin_directory_graphics]/icons/power.png"
add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); set ::current_espresso_page "off"; load_test; set_next_page off DSx_workflow; start_idle; page_show DSx_workflow} 1810 1250 2030 1500

if {$::DSx_settings(admin) == 1} {
    add_de1_button "$::DSx_standby_pages" {say [translate {}] $::settings(sound_button_in); set ::current_espresso_page "off"; load_test; set_next_page off DSx_admin; start_idle; page_show DSx_admin}  2030 1250 2250 1500
    } else {
    add_de1_button "$::DSx_standby_pages" { say [translate {settings}] $::settings(sound_button_in); set ::current_espresso_page "off"; show_settings;} 2030 1250 2250 1500
}
add_de1_button "$::DSx_standby_pages" {say [translate {sleep}] $::settings(sound_button_in); set ::current_espresso_page "off"; off_timer;} 2250 1250 2470 1500

### Left Side
add_de1_image "$::DSx_home_pages" 140 350 "[skin_directory_graphics]/icons/history.png"
add_de1_image "$::DSx_home_pages" 100 770 "[skin_directory_graphics]/icons/jug.png"
add_de1_image "$::DSx_home_pages" 100 1270 "[skin_directory_graphics]/icons/bluecup.png"
add_de1_image "$::DSx_home_pages" 320 1270 "[skin_directory_graphics]/icons/pinkcup.png"
add_de1_image "$::DSx_home_pages" 540 1270 "[skin_directory_graphics]/icons/orangecup.png"
add_de1_variable "$::DSx_home_pages" 360 350 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Group [group_head_heater_temperature_text]}
add_de1_variable "$::DSx_home_pages" 360 400 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Steam [steamtemp_text]}
add_de1_variable "$::DSx_home_pages" 360 450 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Tank [DSx_low_water]}
add_de1_variable "$::DSx_home_pages" 580 490 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(red) -textvariable {[DSx_preheat_status]}

set ::DSx_profile_name [add_de1_variable "$::DSx_home_pages" 410 640 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -width [rescale_x_skin 600] -textvariable {$::settings(profile_title)}]
set ::DSx_bean_name [add_de1_variable "$::DSx_home_pages" 320 724 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]
set ::DSx_saw_name [add_de1_variable "$::DSx_home_pages" 320 774 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]
set ::DSx_sav_name [add_de1_variable "$::DSx_home_pages" 320 824 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]

set ::DSx_flush_name [add_de1_variable "$::DSx_home_pages" 320 874 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]
set ::DSx_steam_name [add_de1_variable "$::DSx_home_pages" 320 924 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]
set ::DSx_water_name [add_de1_variable "$::DSx_home_pages" 320 974 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {*}]
set ::DSx_wsaw_name [add_de1_variable "$::DSx_home_pages" 320 1024 -justify right -anchor "nw" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[wsaw_fav_indicator]}]
set ::DSx_jug_name [add_de1_variable "$::DSx_home_pages" 190 850 -justify center -anchor "n" -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {$::DSx_settings(jug_size)}]

add_de1_variable "$::DSx_home_pages" 350 720 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Beans - [round_to_one_digits $::settings(DSx_bean_weight)]g}
add_de1_variable "$::DSx_home_pages" 350 770 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Shot - (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(saw))/$::settings(DSx_bean_weight)]])  $::DSx_settings(saw)g}
add_de1_variable "$::DSx_home_pages" 350 820 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[DSx_profile_type] [DSx_sav]}

add_de1_variable "$::DSx_home_pages" 350 870 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Flush - [round_to_integer $::DSx_settings(flush_time)][translate "s"]}
add_de1_variable "$::DSx_home_pages" 350 920 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Steam - [DSx_steam_time_text]}
add_de1_variable "$::DSx_home_pages" 350 970 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Water - [return_liquid_measurement $::settings(water_volume)] [return_temperature_measurement $::settings(water_temperature)]}
add_de1_variable "$::DSx_home_pages" 350 1020 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[wsaw_text]}

add_de1_variable "$::DSx_home_pages" 200 1450 -justify center -anchor "s" -text "" -font [DSx_font notosansuiregular 24] -fill $::DSx_settings(blue) -textvariable {$::DSx_settings(blue_cup_indicator)}
add_de1_variable "$::DSx_home_pages" 420 1450 -justify center -anchor "s" -text "" -font [DSx_font notosansuiregular 24] -fill $::DSx_settings(pink) -textvariable {$::DSx_settings(pink_cup_indicator)}
add_de1_variable "$::DSx_home_pages" 640 1450 -justify center -anchor "s" -text "" -font [DSx_font notosansuiregular 24] -fill $::DSx_settings(orange) -textvariable {$::DSx_settings(orange_cup_indicator)}

add_de1_button "$::DSx_standby_pages" {say [translate {}] $::settings(sound_button_in); history_prep;}  100 320 360 540
add_de1_button "$::DSx_standby_pages" {say [translate {}] $::settings(sound_button_in); show_settings; after 500 update_de1_explanation_chart; say [translate {settings}] $::settings(sound_button_in); set_next_page off settings_1; page_show off; set ::settings(active_settings_tab) settings_1; set_profiles_scrollbar_dimensions}  100 550 700 720
add_de1_button "$::DSx_standby_pages" {say [translate {}] $::settings(sound_button_in); load_test; set_next_page off DSx_workflow; start_idle} 320 730 700 1040
add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); jug_toggle;} 100 750 320 980
add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); load_bluecup; DSx_set_on; after 1200 DSx_set_off;} 90 1250 310 1500
add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); load_pinkcup; DSx_set_on; after 1200 DSx_set_off;} 310 1250 530 1500
add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); load_orangecup; DSx_set_on; after 1200 DSx_set_off;} 530 1250 750 1500

### Start button

if {$::DSx_settings(bezel) == 1} {
    if {$::DSx_settings(dial) == 2} {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/SbuttonE.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/SbuttonF.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/SbuttonS.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/SbuttonW.png"
        } elseif {$::DSx_settings(dial) == 3} {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/SbuttonF.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/SbuttonS.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/SbuttonW.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/SbuttonE.png"
        } else {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/SbuttonE.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/SbuttonS.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/SbuttonF.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/SbuttonW.png"
    }
    } elseif {$::DSx_settings(bezel) == 2} {
    add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/2SbuttonA.png"
    add_de1_image "espresso" 830 250 "[skin_directory_graphics]/2SbuttonE.png"
    add_de1_image "steam" 830 250 "[skin_directory_graphics]/2SbuttonE.png"
    add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/2SbuttonE.png"
    add_de1_image "water" 830 250 "[skin_directory_graphics]/2SbuttonE.png"
    } else {
        if {$::DSx_settings(dial) == 2} {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/3SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/3SbuttonE.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/3SbuttonF.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/3SbuttonS.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/3SbuttonW.png"
        } elseif {$::DSx_settings(dial) == 3} {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/3SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/3SbuttonF.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/3SbuttonS.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/3SbuttonW.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/3SbuttonE.png"
        } else {
        add_de1_image "$::DSx_standby_pages" 830 250 "[skin_directory_graphics]/3SbuttonA.png"
        add_de1_image "espresso" 830 250 "[skin_directory_graphics]/3SbuttonE.png"
        add_de1_image "steam" 830 250 "[skin_directory_graphics]/3SbuttonS.png"
        add_de1_image "preheat_2" 830 250 "[skin_directory_graphics]/3SbuttonF.png"
        add_de1_image "water" 830 250 "[skin_directory_graphics]/3SbuttonW.png"
    }
}
add_de1_image "$::DSx_active_pages" 1200 570 "[skin_directory_graphics]/icons/stop.png"

if {$::DSx_settings(icons) == 2} {
    if {$::DSx_settings(dial) == 2} {
        add_de1_image "$::DSx_standby_pages espresso" 1214 310 "[skin_directory_graphics]/icons/DEespresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1200 900 "[skin_directory_graphics]/icons/DEsteam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 1490 610 "[skin_directory_graphics]/icons/DEflush.png"
        add_de1_image "$::DSx_standby_pages water" 900 610 "[skin_directory_graphics]/icons/DEwater.png"
        add_de1_variable "preheat_2" 1570 590 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
        } elseif {$::DSx_settings(dial) == 3} {
        add_de1_image "$::DSx_standby_pages espresso" 1204 900 "[skin_directory_graphics]/icons/DEespresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1490 610 "[skin_directory_graphics]/icons/DEsteam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 900 610 "[skin_directory_graphics]/icons/DEflush.png"
        add_de1_image "$::DSx_standby_pages water" 1200 310 "[skin_directory_graphics]/icons/DEwater.png"
        add_de1_variable "preheat_2" 980 590 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
        } else {
        add_de1_image "$::DSx_standby_pages espresso" 1214 310 "[skin_directory_graphics]/icons/DEespresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1490 610 "[skin_directory_graphics]/icons/DEsteam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 1200 900 "[skin_directory_graphics]/icons/DEflush.png"
        add_de1_image "$::DSx_standby_pages water" 900 610 "[skin_directory_graphics]/icons/DEwater.png"
        add_de1_variable "preheat_2" 1280 890 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
        }
    } else {
    if {$::DSx_settings(dial) == 2} {
        add_de1_image "$::DSx_standby_pages espresso" 1180 320 "[skin_directory_graphics]/icons/espresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1180 900 "[skin_directory_graphics]/icons/steam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 1470 600 "[skin_directory_graphics]/icons/flush.png"
        add_de1_image "$::DSx_standby_pages water" 910 610 "[skin_directory_graphics]/icons/water.png"
        add_de1_variable "preheat_2" 1570 680 -text "" -font [DSx_font font 8] -fill #8efba2 -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
        } elseif {$::DSx_settings(dial) == 3} {
        add_de1_image "$::DSx_standby_pages espresso" 1180 900 "[skin_directory_graphics]/icons/espresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1470 600 "[skin_directory_graphics]/icons/steam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 890 600 "[skin_directory_graphics]/icons/flush.png"
        add_de1_image "$::DSx_standby_pages water" 1200 310 "[skin_directory_graphics]/icons/water.png"
        add_de1_variable "preheat_2" 990 680 -text "" -font [DSx_font font 8] -fill #8efba2 -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
        } else {
        add_de1_image "$::DSx_standby_pages espresso" 1180 320 "[skin_directory_graphics]/icons/espresso.png"
        add_de1_image "$::DSx_standby_pages steam" 1470 600 "[skin_directory_graphics]/icons/steam.png"
        add_de1_image "$::DSx_standby_pages preheat_2" 1180 870 "[skin_directory_graphics]/icons/flush.png"
        add_de1_image "$::DSx_standby_pages water" 910 610 "[skin_directory_graphics]/icons/water.png"
        add_de1_variable "preheat_2" 1280 950 -text "" -font [DSx_font font 8] -fill #8efba2 -anchor "center" -justify "center" -textvariable {[DSx_add_flush_time_extend_text]}
    }
}

add_de1_variable "$::DSx_standby_pages" 1280 680 -text [translate "START"] -font [DSx_font font 14] -fill $::DSx_settings(green) -anchor "center" -textvariable {[start_button_ready]}
add_de1_variable "$::DSx_standby_pages" 1280 1180 -text [translate ""] -font [DSx_font font 20] -fill $::DSx_settings(blue) -anchor "center"  -textvariable {$::DSx_saved_2}
# Count down timer
add_de1_variable "steam" 1280 480 -text "" -font [DSx_font font 20] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {[DSx_steam_time]}
add_de1_variable "preheat_2" 1280 480 -text "" -font [DSx_font font 20] -fill $::DSx_settings(font_colour) -anchor "center" -justify center -textvariable {[DSx_flush_time_display]}
# DE1 connection and substate info
add_de1_variable "$::DSx_standby_pages" 1280 600 -justify center -anchor "center" -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {[de1_connected_state_DSx]}
add_de1_variable "$::DSx_standby_pages" 1280 560 -justify center -anchor "center" -text "" -font [DSx_font font 8] -fill $::DSx_settings(red) -textvariable {$::steam_off_message}

if {$::DSx_settings(bezel) == 1} {
    if {$::DSx_settings(dial) == 2} {

        add_de1_variable "preheat_2" 1280 940 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {flushing HOT water}
        add_de1_variable "steam" 1280 786 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_steam_info]}
        add_de1_variable "water" 1280 940 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {pouring HOT water}
        add_de1_variable "espresso" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::settings(current_frame_description)}
        } elseif {$::DSx_settings(dial) == 3} {
        add_de1_variable "preheat_2" 1280 940 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {flushing HOT water}
        add_de1_variable "steam" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_steam_info]}
        add_de1_variable "water" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {pouring HOT water}
        add_de1_variable "espresso" 1280 486 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::settings(current_frame_description)}
        } else {
        add_de1_variable "preheat_2" 1280 786 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {flushing HOT water}
        add_de1_variable "steam" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_steam_info]}
        add_de1_variable "water" 1280 940 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {pouring HOT water}
        add_de1_variable "espresso" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::settings(current_frame_description)}
        }
    } else {
    add_de1_variable "preheat_2" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {flushing HOT water}
    add_de1_variable "steam" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_steam_info]}
    add_de1_variable "water" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {pouring HOT water}
    add_de1_variable "espresso" 1280 840 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::settings(current_frame_description)}
}

add_de1_button "espresso" {say [translate {stop}] $::settings(sound_button_in); DSx_stop} 880 340 1660 1060
#add_de1_button "preheat_2" {after cancel {set_next_page off off; start_idle}; DSx_stop}  880 340 1660 1060
add_de1_button "preheat_2" {say [translate {stop}] $::settings(sound_button_in); DSx_stop}  880 340 1660 1060

add_de1_button "steam" {say [translate {stop}] $::settings(sound_button_in); DSx_steam_state_off; DSx_stop; check_if_steam_clogged} 880 340 1660 1060
add_de1_button "water" {say [translate {stop}] $::settings(sound_button_in); DSx_stop} 880 340 1660 1060

if {$::DSx_settings(dial) == 2} {
    add_de1_button "off" {say [translate {espresso}] $::settings(sound_button_in); DSx_reset_graphs; DSx_espresso;} 1100 260 1460 540
    add_de1_button "preheat_2" {say [translate {flush2}] $::settings(sound_button_in); DSx_flush_extend} 1440 540 1730 860
    add_de1_button "off" {say [translate {flush}] $::settings(sound_button_in); DSx_flush} 1440 540 1730 860
    add_de1_button "off" {say [translate {steam}] $::settings(sound_button_in); DSx_steam} 1100 860 1460 1140
    add_de1_button "off" {say [translate {Hot water}] $::settings(sound_button_in); DSx_water;} 830 540 1120 860
    } elseif {$::DSx_settings(dial) == 3} {
    add_de1_button "off" {say [translate {espresso}] $::settings(sound_button_in); DSx_reset_graphs; DSx_espresso;} 1100 860 1460 1140
    add_de1_button "preheat_2" {say [translate {flush2}] $::settings(sound_button_in); DSx_flush_extend} 830 540 1120 860
    add_de1_button "off" {say [translate {flush}] $::settings(sound_button_in); DSx_flush} 830 540 1120 860
    add_de1_button "off" {say [translate {steam}] $::settings(sound_button_in); DSx_steam} 1440 540 1730 860
    add_de1_button "off" {say [translate {Hot water}] $::settings(sound_button_in); DSx_water;} 1100 260 1460 540
    } else {
    add_de1_button "off" {say [translate {espresso}] $::settings(sound_button_in); DSx_reset_graphs; DSx_espresso;} 1100 260 1460 540
    add_de1_button "preheat_2" {say [translate {flush2}] $::settings(sound_button_in); DSx_flush_extend} 1100 860 1460 1140
    add_de1_button "off" {say [translate {flush}] $::settings(sound_button_in); DSx_flush} 1100 860 1460 1140
    add_de1_button "off" {say [translate {steam}] $::settings(sound_button_in); DSx_steam} 1440 540 1730 860
    add_de1_button "off" {say [translate {Hot water}] $::settings(sound_button_in); DSx_water;} 830 540 1120 860
}

## scale
if {$::DSx_settings(no_scale) == 1} {
    add_de1_image "$::DSx_home_pages" 880 1200 "[skin_directory_graphics]/big_scale1.png"
    if {$::android != 1} {
        set ::de1(scale_sensor_weight) 400
        } else {
        set ::de1(scale_weight_rate) -1
    }
    set ::show_net_weight " "
    if {$::de1(scale_sensor_weight) <= $::show_net_weight || $::DSx_settings(jug_g) < 50} {
        set ::show_net_weight " "
        } else {
        set ::show_net_weight [round_to_milk [expr ($::de1(scale_sensor_weight) - $::DSx_settings(jug_g))]]g
    }
    set ::show_net_bean_weight " "
    if {$::de1(scale_sensor_weight) <= $::show_net_bean_weight || $::DSx_settings(bean_offset) < 50} {
        set ::show_net_bean_weight " "
        } else {
        set ::show_net_bean_weight [round_to_beans [expr ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset))]]g
    }
    add_de1_variable "$::DSx_home_pages" 980 1270 -justify right -anchor "nw" -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[round_to_bean [expr ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset))]]}
    add_de1_variable "$::DSx_home_pages" 1280 1320 -justify center -anchor "n" -text "" -font [DSx_font font 13] -fill $::DSx_settings(font_colour) -textvariable {[round_to_one_digits $::de1(scale_sensor_weight)]g}
    add_de1_variable "$::DSx_home_pages" 1580 1270 -justify left -anchor "ne" -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[round_to_milk [expr ($::de1(scale_sensor_weight) - $::DSx_settings(jug_g))]]}
    add_de1_variable "$::DSx_home_pages" 1280 1270 -justify center -anchor "n" -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {+}
    add_de1_variable "$::DSx_home_pages" 1280 1400 -justify center -anchor "n" -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {-}
    add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); clear_steam_font; steam_time_calc; DSx_set_on; after 1200 DSx_set_off;} 1400 1250 1620 1500
    add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); clear_bean_font; DSx_set_dose; DSx_bean_set_on; after 1500 DSx_set_off;} 930 1250 1150 1500
    add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); vertical_clicker 5 5 ::de1(scale_sensor_weight) 100 750 %x %y %x0 %y0 %x1 %y1;} 1150 1200 1400 1570 ""
    } else {
    add_de1_image "$::DSx_home_pages" 880 1200 "[skin_directory_graphics]/big_scale1.png"
    if {$::android != 1} {
        set ::de1(scale_sensor_weight) 218
        } else {
        set ::de1(scale_weight_rate) -1
    }
    set ::show_net_weight " "
    if {$::de1(scale_sensor_weight) <= $::show_net_weight || $::DSx_settings(jug_g) < 20} {
        set ::show_net_weight " "
        } else {
        set ::show_net_weight [round_to_milk [expr ($::de1(scale_sensor_weight) - $::DSx_settings(jug_g))]]g
    }
    add_de1_variable "$::DSx_home_pages" 980 1270 -justify right -anchor "nw" -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[round_to_bean [expr ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset))]]}
    add_de1_variable "$::DSx_home_pages" 1290 1320 -justify center -anchor "n" -text "" -font [DSx_font font 13] -fill $::DSx_settings(font_colour) -textvariable {[round_to_one_digits $::de1(scale_sensor_weight)]g}
    add_de1_variable "$::DSx_home_pages" 1580 1270 -justify left -anchor "ne" -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {[round_to_milk [expr ($::de1(scale_sensor_weight) - $::DSx_settings(jug_g))]]}
    # skale ble reconnection button
    add_de1_button "$::DSx_home_pages" {say [translate {connect}] $::settings(sound_button_in); skale_tare; catch {ble_connect_to_scale}} 1150 1200 1400 1500
    add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); clear_bean_font; DSx_set_dose; DSx_bean_set_on; after 1500 DSx_set_off;} 930 1250 1150 1500
    add_de1_button "$::DSx_standby_pages" {say "" $::settings(sound_button_in); clear_steam_font; steam_time_calc; DSx_set_on; after 1200 DSx_set_off;} 1400 1250 1620 1500
}
add_de1_variable "$::DSx_home_pages" 1280 1410 -justify center -anchor "n" -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour)  -textvariable {[DSx_scale_disconnected]}


proc clearshit {} {
    set cnt 0
    set debugcnt 0
    set ::debuglog {}
}


# Sleep pages
add_de1_text "sleep" 2500 1440 -justify right -anchor "ne" -text [translate "Going to sleep"] -font [DSx_font font 20] -fill $::DSx_settings(font_colour)
add_de1_text "DSx_power" 1370 760 -justify left -anchor "ne" -text [translate "Power off  >>> "] -font [DSx_font font 16] -fill $::DSx_settings(font_colour)
add_de1_text "DSx_power" 1600 1400 -justify center -anchor center -text [translate "...or wait for sleep"] -font [DSx_font font 16] -fill $::DSx_settings(font_colour)
add_de1_button "DSx_power" {say [translate {sleep}] $::settings(sound_button_in); set ::current_espresso_page "off"; power_off} 1400 700 1600 900
add_de1_button "saver descaling cleaning" {say [translate {awake}] $::settings(sound_button_in); set_next_page off off; start_idle; clearshit} 600 0 2560 1600


### Graphs home stanby page
# Steam graph
add_de1_widget "$::DSx_standby_pages" graph 1810 830 {
	set ::DSx_home_steam_graph_1 $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page off off_steam_zoomed;
		set_next_page steam steam_steam_zoomed;
		page_show $::de1(current_context);
	}
	$widget element create line_steam_pressure -xdata steam_elapsed -ydata steam_pressure -symbol none -label "" -linewidth [rescale_x_skin 4] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_flow -xdata steam_elapsed -ydata steam_flow -symbol none -label "" -linewidth [rescale_x_skin 4] -color #4e85f4  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_temperature -xdata steam_elapsed -ydata steam_temperature -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e73249  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -linewidth [rescale_x_skin 2]
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max [expr {$::settings(max_steam_pressure) + 0.01}] -subdivisions 5 -majorticks {1 2 3}
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 240] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat


# espresso graph
add_de1_widget "$::DSx_standby_pages" graph 1800 440 {
	set ::DSx_home_espresso_graph_1 $widget

	bind $widget [platform_button_press] {
        say [translate {zoom}] $::settings(sound_button_in);
        DSx_reset_graphs;
        set_next_page off off_zoomed;
        set_next_page espresso espresso_zoomed;
		page_show $::de1(current_context);
	}
	$widget element create line_espresso_pressure_goal -xdata espresso_elapsed -ydata espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 4] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {2 2};
	$widget element create line2_espresso_pressure -xdata espresso_elapsed -ydata espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 6] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_goal_2x  -xdata espresso_elapsed -ydata espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
	$widget element create line_espresso_flow_2x  -xdata espresso_elapsed -ydata espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 6] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_weight_2x  -xdata espresso_elapsed -ydata espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_state_change_1 -xdata espresso_elapsed -ydata espresso_state_change -label "" -linewidth [rescale_x_skin 3] -color #AAAAAA  -pixels 0 ;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0;
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max $::de1(max_pressure) -subdivisions 5 -majorticks {0  2  4  6  8  10  12}  -hide 0;
	$widget axis configure y2 -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max 6 -subdivisions 2 -majorticks {0  1  2  3  4  5  6} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
# show the shot configuration
#	$widget element create line_espresso_de1_explanation_chart_flow -xdata espresso_de1_explanation_chart_elapsed_flow -ydata espresso_de1_explanation_chart_flow -label "" -linewidth [rescale_x_skin 6] -color #98c5ff  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0;
#   $widget element create line_espresso_de1_explanation_chart_pressure -xdata espresso_de1_explanation_chart_elapsed -ydata espresso_de1_explanation_chart_pressure  -label "" -linewidth [rescale_x_skin 6] -color #47e098  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0;
#	$widget element create line_espresso_de1_explanation_chart_temp -xdata espresso_de1_explanation_chart_elapsed -ydata espresso_de1_explanation_chart_temperature_10  -label "" -linewidth [rescale_x_skin 6] -color #ff888c  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0;
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 300] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat



### Graphs action page
# Steam graph
add_de1_widget "steam" graph 1810 830 {
	set ::DSx_home_steam_graph_2 $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page off off;
		set_next_page steam steam_steam_zoomed;
		page_show $::de1(current_context);
	}
	$widget element create line_steam_pressure -xdata steam_elapsed -ydata steam_pressure -symbol none -label "" -linewidth [rescale_x_skin 4] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_flow -xdata steam_elapsed -ydata steam_flow -symbol none -label "" -linewidth [rescale_x_skin 4] -color #4e85f4  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_temperature -xdata steam_elapsed -ydata steam_temperature -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e73249  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -linewidth [rescale_x_skin 2]
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max [expr {$::settings(max_steam_pressure) + 0.01}] -subdivisions 5 -majorticks {1 2 3}
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 240] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

# Espresso action graph
add_de1_widget "espresso" graph 1800 440 {
	set ::DSx_home_espresso_graph_2 $widget
	bind $widget [platform_button_press] {
        say [translate {zoom}] $::settings(sound_button_in);
        DSx_reset_graphs;
        set_next_page off off;
        set_next_page espresso espresso_zoomed;
		page_show $::de1(current_context);
	}
	$widget element create line_espresso_pressure_goal -xdata espresso_elapsed -ydata espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 4] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {2 2};
	$widget element create line2_espresso_pressure -xdata espresso_elapsed -ydata espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 4] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_goal_2x  -xdata espresso_elapsed -ydata espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
	$widget element create line_espresso_flow_2x  -xdata espresso_elapsed -ydata espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_weight_2x  -xdata espresso_elapsed -ydata espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_state_change_1 -xdata espresso_elapsed -ydata espresso_state_change -label "" -linewidth [rescale_x_skin 3] -color #AAAAAA  -pixels 0 ;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0;
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max $::de1(max_pressure) -subdivisions 5 -majorticks {0  2  4  6  8  10  12}  -hide 0;
	$widget axis configure y2 -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max 6 -subdivisions 2 -majorticks {0  1  2  3  4  5  6} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 300] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

### Graphs non active action page
# Steam graph
add_de1_widget "espresso preheat_2 water" graph 1810 830 {
	set ::DSx_home_steam_graph_3 $widget
	bind $widget [platform_button_press] {

	}
	$widget element create line_steam_pressure -xdata steam_elapsed -ydata steam_pressure -symbol none -label "" -linewidth [rescale_x_skin 4] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_flow -xdata steam_elapsed -ydata steam_flow -symbol none -label "" -linewidth [rescale_x_skin 4] -color #4e85f4  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_temperature -xdata steam_elapsed -ydata steam_temperature -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e73249  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -linewidth [rescale_x_skin 2]
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max [expr {$::settings(max_steam_pressure) + 0.01}] -subdivisions 5 -majorticks {1 2 3}
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 240] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

# Espresso action graph
add_de1_widget "preheat_2 steam water" graph 1800 440 {
	set ::DSx_home_espresso_graph_3 $widget
	bind $widget [platform_button_press] {

	}
	$widget element create line_espresso_pressure_goal -xdata espresso_elapsed -ydata espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 4] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {2 2};
	$widget element create line2_espresso_pressure -xdata espresso_elapsed -ydata espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 6] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_goal_2x  -xdata espresso_elapsed -ydata espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
	$widget element create line_espresso_flow_2x  -xdata espresso_elapsed -ydata espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 6] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_flow_weight_2x  -xdata espresso_elapsed -ydata espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 4] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_state_change_1 -xdata espresso_elapsed -ydata espresso_state_change -label "" -linewidth [rescale_x_skin 3] -color #AAAAAA  -pixels 0 ;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0;
	$widget axis configure y -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max $::de1(max_pressure) -subdivisions 5 -majorticks {0  2  4  6  8  10  12}  -hide 0;
	$widget axis configure y2 -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 5] -min 0.0 -max 6 -subdivisions 2 -majorticks {0  1  2  3  4  5  6} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 650] -height [rescale_y_skin 300] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

### Graph (zoom) Pages
#### to make the graph work for sim
add_de1_variable "$::DSx_zoomed_pages $::DSx_steam_zoomed_pages" 0 2000 -font [DSx_font font 6] -fill #000 -textvariable {
    [pressure_text]
    [waterflow_text]
    [waterweight_text]
    [waterweightflow_text]
    [watervolume_text]
    [watertemp_text]
    [mixtemp_text]
    [steamtemp_text]
    [group_head_heater_temperature_text]
    [espresso_goal_temp_text]
    [pour_volume]
    [preinfusion_volume]
    [profile_type_text]
}


# zoomed espresso
add_de1_widget "$::DSx_zoomed_pages" graph 40 70 {
	set ::DSx_espresso_zoomed_graph $widget
	bind $widget [platform_button_press] {
        set x [translate_coordinates_finger_down_x %x]
	    set y [translate_coordinates_finger_down_y %y]
        if {$x < [rescale_y_skin 500]} {
			# left column clicked on chart, indicates zoom

			if {$y > [rescale_y_skin 610]} {
				DSx_scroll_down
			} else {
				DSx_scroll_up
			}
		} else {
		set_next_page off off;
        set_next_page espresso_zoomed espresso;
        set_next_page espresso espresso;
        set_next_page off_zoomed off;
		page_show $::de1(current_context);
	    }
    }
	$widget element create line2_espresso_pressure -xdata espresso_elapsed -ydata espresso_pressure -symbol none -label "" -linewidth $::glt1 -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_temperature_basket -xdata espresso_elapsed -ydata DSx_espresso_temperature_basket -symbol none -label ""  -linewidth $::glt2 -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_temperature_mix -xdata espresso_elapsed -ydata DSx_espresso_temperature_mix -symbol none -label ""  -linewidth $::glb2 -color #ff9900 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create line_espresso_flow_weight_2x  -xdata espresso_elapsed -ydata espresso_flow_weight_2x -symbol none -label "" -linewidth $::glt4 -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_espresso_weight_2x  -xdata espresso_elapsed -ydata espresso_weight_chartable -symbol none -label "" -linewidth $::glb4 -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes $::settings(chart_dashes_espresso_weight);
    $widget element create line_espresso_flow_2x  -xdata espresso_elapsed -ydata espresso_flow_2x -symbol none -label "" -linewidth $::glt5 -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create line_espresso_resistance  -xdata espresso_elapsed -ydata espresso_resistance -symbol none -label "" -linewidth $::glb1 -color #e5e500 -smooth $::settings(live_graph_smoothing_technique) -pixels 0

    $widget element create line_espresso_flow_delta_1  -xdata espresso_elapsed -ydata espresso_flow_delta -symbol none -label "" -linewidth $::glb5 -color #98c5ff -pixels 0 -smooth $::settings(live_graph_smoothing_technique)
	$widget element create line_espresso_state_change_1 -xdata espresso_elapsed -ydata espresso_state_change -label "" -linewidth $::glt3 -color #AAAAAA  -pixels 0 ;
	$widget element create line_espresso_temperature_goal -xdata espresso_elapsed -ydata DSx_espresso_temperature_goal -symbol none -label "" -linewidth $::glb3 -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
	$widget element create line_espresso_pressure_goal -xdata espresso_elapsed -ydata espresso_pressure_goal -symbol none -label "" -linewidth $::glb3 -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
	$widget element create line_espresso_flow_goal_2x  -xdata espresso_elapsed -ydata espresso_flow_goal_2x -symbol none -label "" -linewidth $::glb3 -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5};
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 9] -min 0.0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 9] -min $::DSx_settings(zoomed_y_axis_min) -max $::DSx_settings(zoomed_y_axis_max) -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}  -hide 0;
    $widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 9] -min $::DSx_settings(zoomed_y2_axis_min) -max $::DSx_settings(zoomed_y2_axis_max) -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2490] -height [rescale_y_skin 1230] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

add_de1_image "$::DSx_zoomed_pages" 2200 1295 "[skin_directory_graphics]/icons/button5.png"
add_de1_image "$::DSx_zoomed_pages" 40 1400 "[skin_directory_graphics]/icons/zoomminus.png"
add_de1_image "$::DSx_zoomed_pages" 240 1400 "[skin_directory_graphics]/icons/zoomplus.png"
add_de1_image "$::DSx_zoomed_pages" 1 375 "[skin_directory_graphics]/icons/zoomshift.png"
add_de1_image "$::DSx_zoomed_pages" 480 1300 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 700 1300 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 920 1300 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 1140 1300 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 1360 1300 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 480 1444 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 700 1444 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 920 1444 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 1140 1444 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "$::DSx_zoomed_pages" 1360 1444 "[skin_directory_graphics]/icons/button4.png"
add_de1_image "espresso_zoomed steam_steam_zoomed" 2258 1340 "[skin_directory_graphics]/icons/stop.png"

# Reset
set ::DSx_graph_temp_units_text [add_de1_variable "$::DSx_zoomed_pages" 20 1314 -text "" -font [DSx_font font 7] -fill #e73249 -anchor "w"  -justify "center" -textvariable {[DSx_graph_temp_units_text]}]
set ::DSx_graph_reset_button_text [add_de1_variable "$::DSx_zoomed_pages" 240 1350 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center"  -justify "center" -textvariable {[DSx_graph_reset_button_text]}]
add_de1_button "$::DSx_zoomed_pages" {say [translate {reset}] $::settings(sound_button_in); DSx_graph_reset_button;} 100 1200 400 1410

# top row buttons
add_de1_variable "$::DSx_zoomed_pages" 590 1370 -text "" -font [DSx_font font 8] -fill "#18c37e" -anchor "center"  -justify "center" -textvariable {[round_to_one_digits [expr $::de1(pressure)]]bar}
add_de1_variable "$::DSx_zoomed_pages" 810 1370 -text "" -font [DSx_font font 8] -fill "#e73249" -anchor "center"  -justify "center" -textvariable {[group_head_heater_temperature_text]}
add_de1_variable "$::DSx_zoomed_pages" 1030 1370 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center"  -justify "center" -textvariable {steps}
add_de1_variable "$::DSx_zoomed_pages" 1250 1370 -text "" -font [DSx_font font 8] -fill "#a2693d" -anchor "center"  -justify "center" -textvariable {[round_to_one_digits [expr $::de1(scale_weight_rate)]]g/s}
add_de1_variable "$::DSx_zoomed_pages" 1470 1370 -text "" -font [DSx_font font 8] -fill "#4e85f4" -anchor "center"  -justify "center" -textvariable {[round_to_one_digits [expr $::de1(flow)]]mL/s}
# bottom row buttons
add_de1_variable "$::DSx_zoomed_pages" 590 1515 -text "" -font [DSx_font font 8] -fill #e5e500 -anchor "center"  -justify "center" -textvariable {[DSx_R]}
add_de1_variable "$::DSx_zoomed_pages" 810 1515 -text "" -font [DSx_font font 8] -fill "#ff9900" -anchor "center"  -justify "center" -textvariable {[mixtemp_text]}
add_de1_variable "$::DSx_zoomed_pages" 1030 1515 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center"  -justify "center" -textvariable {goal}
add_de1_variable "$::DSx_zoomed_pages" 1250 1515 -text "" -font [DSx_font font 8] -fill "#a2693d" -anchor "center"  -justify "center" -textvariable {[round_to_one_digits [expr $::de1(scale_weight)]]g }
add_de1_variable "$::DSx_zoomed_pages" 1470 1515 -text "" -font [DSx_font font 8] -fill "#4e85f4" -anchor "center"  -justify "center" -textvariable {delta}

add_de1_variable "off_zoomed" 1280 0 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor n -textvariable {$::DSx_settings(live_graph_profile)   -   [last_shot_date]}
add_de1_variable "off_zoomed" 1650 1340 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Beans   [round_to_one_digits $::DSx_settings(live_graph_beans)]g}
add_de1_variable "off_zoomed" 1650 1400 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Shot   $::DSx_settings(live_graph_weight)g  ([live_extraction_ratio])}
add_de1_variable "off_zoomed" 1650 1460 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Water  $::DSx_settings(live_graph_pi_water) + $::DSx_settings(live_graph_pour_water) = $::DSx_settings(live_graph_water)mL}
add_de1_variable "off_zoomed" 1650 1520 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Time   $::DSx_settings(live_graph_pi_time) + $::DSx_settings(live_graph_pour_time) = $::DSx_settings(live_graph_shot_time)s}
add_de1_variable "espresso_zoomed" 1650 1400 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Shot   [round_to_one_digits $::de1(scale_sensor_weight)]g  ([live_extraction_ratio])}
add_de1_variable "espresso_zoomed" 1650 1460 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Water  [DSx_water_data]mL}
add_de1_variable "espresso_zoomed" 1650 1520 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Time   [espresso_preinfusion_timer] + [espresso_pour_timer] = [espresso_elapsed_timer]s}

add_de1_variable "espresso_zoomed" 1650 1340 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Beans   [round_to_one_digits [expr $::settings(DSx_bean_weight)]]g}
add_de1_variable "off_zoomed" 2342 1430 -text [translate "START"] -font [DSx_font font 13] -fill $::DSx_settings(green) -anchor "center" -justify "center" -textvariable {[start_text_if_espresso_ready]}
add_de1_text "off_zoomed" 2342 1486 -text [translate "ESPRESSO"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center"
add_de1_button "off_zoomed" {say [translate {espresso}] $::settings(sound_button_in); set ::DSxv 0; DSx_espresso;} 2200 1280 2560 1600
add_de1_button "espresso_zoomed" {say [translate {stop}] $::settings(sound_button_in); set_next_page off off; start_idle} 2200 1280 2560 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); DSx_zoom_out;} 0 1420 230 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); DSx_zoom_in;} 230 1420 460 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_t1;} 480 1300 700 1440
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_t2;} 700 1300 920 1440
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_t3;} 920 1300 1140 1440
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_t4;} 1140 1300 1360 1440
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_t5;} 1360 1300 1580 1440

add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_b1;} 480 1440 700 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_b2;} 700 1440 920 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_b3;} 920 1440 1140 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_b4;} 1140 1440 1360 1600
add_de1_button "$::DSx_zoomed_pages" {say [translate {zoom}] $::settings(sound_button_in); push_b5;} 1360 1440 1580 1600

# Steam zoomed
add_de1_widget "$::DSx_steam_zoomed_pages" graph 40 0 {
	set ::DSx_home_steam_zoomed_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
        set_next_page off off;
        set_next_page steam_steam_zoomed steam;
        set_next_page steam steam;
        set_next_page off_steam_zoomed off;
		page_show $::de1(current_context);
	}
	$widget element create line_steam_pressure -xdata steam_elapsed -ydata steam_pressure -symbol none -label "" -linewidth [rescale_x_skin 10] -color #18c37e  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create line_steam_flow -xdata steam_elapsed -ydata steam_flow -symbol none -label "" -linewidth [rescale_x_skin 10] -color #4e85f4  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 6] -linewidth [rescale_x_skin 2]
	#$widget axis configure y -color #008c4c -tickfont [DSx_font font 6] -min 0.0 -max [expr {$::settings(max_steam_pressure) + 0.01}] -subdivisions 5 -majorticks {0.25 0.5 0.75 1 1.25 1.5 1.75 2 2.25 2.5 2.75 3}
    $widget axis configure y -color #008c4c -tickfont [DSx_font font 6] -min 0.0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2490] -height [rescale_y_skin 800] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

add_de1_widget "$::DSx_steam_zoomed_pages" graph 40 800 {
	set ::DSx_home_steam_zoomed_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
        set_next_page off off;
        set_next_page steam_steam_zoomed steam;
        set_next_page steam steam;
        set_next_page off_steam_zoomed off;
		page_show $::de1(current_context);
	}
	$widget element create line_steam_temperature -xdata steam_elapsed -ydata steam_temperature -symbol none -label ""  -linewidth [rescale_x_skin 10] -color #e73249  -pixels 0 -dashes $::settings(chart_dashes_temperature);
	if {$::settings(enable_fahrenheit) == 1} {
		$widget axis configure y -color #e73249 -tickfont [DSx_font font 6] -min 250 -max 350;
	} else {
		$widget axis configure y -color #e73249 -tickfont [DSx_font font 6] -min 130 -max 180;
	}
	$widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 6] -linewidth [rescale_x_skin 2]
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2490] -height [rescale_y_skin 500] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

add_de1_variable "steam_steam_zoomed" 1960 1400 -text "" -font [DSx_font font 20] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {[DSx_steam_time]}
add_de1_variable "$::DSx_steam_zoomed_pages" 300 1300 -justify right -anchor "nw" -font [DSx_font font 8] -fill #18c37e -textvariable {Pressure - [pressure_text]}
add_de1_variable "$::DSx_steam_zoomed_pages" 300 1360 -justify right -anchor "nw" -font [DSx_font font 8] -fill #4e85f4 -textvariable {Flow - [waterflow_text]}
add_de1_variable "$::DSx_steam_zoomed_pages" 300 1420 -justify right -anchor "nw" -font [DSx_font font 8] -fill #e73249 -textvariable {Temperature - [steamtemp_text]}
add_de1_variable "$::DSx_steam_zoomed_pages" 1800 1430 -justify center -anchor "center" -text "" -font [DSx_font font 8] -fill $::DSx_settings(red) -textvariable {$::steam_off_message}
add_de1_variable "$::DSx_steam_zoomed_pages" 300 1480 -justify right -anchor "nw" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Steam Timer - [DSx_steam_time_text]}
add_de1_variable "steam_steam_zoomed" 1960 1460 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {[DSx_steam_info]}

add_de1_text "$::DSx_steam_zoomed_pages" 50 24 -text [translate "Pressure (bar)"] -font [DSx_font font 9] -fill "#008c4c" -justify "left" -anchor "nw"
add_de1_text "$::DSx_steam_zoomed_pages" 2460 24 -text [translate "Flow (mL/s)"] -font [DSx_font font 9] -fill "#206ad4" -justify "left" -anchor "ne"
add_de1_text "$::DSx_steam_zoomed_pages" 1600 24 -text [translate "Temperature ([return_html_temperature_units])"] -font [DSx_font font 9] -fill "#e73249" -justify "left" -anchor "nw"
add_de1_image "$::DSx_steam_zoomed_pages" 2200 1295 "[skin_directory_graphics]/icons/button5.png"
add_de1_variable "off_steam_zoomed" 2342 1430 -text [translate "START"] -font [DSx_font font 13] -fill $::DSx_settings(green) -anchor "center" -justify "center" -textvariable {[start_text_if_espresso_ready]}
add_de1_text "off_steam_zoomed" 2342 1486 -text [translate "STEAM"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center"
add_de1_button "off_steam_zoomed" {say [translate {steam}] $::settings(sound_button_in); DSx_steam} 2200 1280 2560 1600
add_de1_button "steam_steam_zoomed" {say [translate {stop}] $::settings(sound_button_in); DSx_steam_state_off; set_next_page off off; start_idle; check_if_steam_clogged} 2200 1280 2560 1600

# end graphs #
#################################### end home page

##### Setup Pages #####
### Common
add_de1_variable "$::DSx_other_pages" 2150 1560 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify center -anchor center -textvariable {[translate "DSx Version $::DSx_settings(version) - by Damian"] }

# left arrow
add_de1_image "$::DSx_other_pages" 1820 1280 "[skin_directory_graphics]/icons/arrow_left.png"
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); page_show DSx_cal; check_backup} 1810 1250 2030 1500
add_de1_button "DSx_cal" {say "" $::settings(sound_button_in); page_show DSx_backup;} 1810 1250 2030 1500
add_de1_button "DSx_backup" {say "" $::settings(sound_button_in); page_show DSx_theme;} 1810 1250 2030 1500
add_de1_button "DSx_theme" {say "" $::settings(sound_button_in); page_show DSx_admin;} 1810 1250 2030 1500
add_de1_button "DSx_admin" {say "" $::settings(sound_button_in); page_show DSx_workflow;} 1810 1250 2030 1500

# right arrow
add_de1_image "$::DSx_other_pages" 2260 1280 "[skin_directory_graphics]/icons/arrow_right.png"
add_de1_button "DSx_theme" {say "" $::settings(sound_button_in); page_show DSx_backup;} 2250 1250 2470 1500
add_de1_button "DSx_backup" {say "" $::settings(sound_button_in); page_show DSx_cal; check_backup} 2250 1250 2470 1500
add_de1_button "DSx_cal" {say "" $::settings(sound_button_in); page_show DSx_workflow;} 2250 1250 2470 1500
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); page_show DSx_admin;} 2250 1250 2470 1500
add_de1_button "DSx_admin" {say "" $::settings(sound_button_in); page_show DSx_theme;} 2250 1250 2470 1500

# save
add_de1_image "$::DSx_other_pages" 2040 1280 "[skin_directory_graphics]/icons/home.png"
add_de1_button "$::DSx_other_pages" {say "" $::settings(sound_button_in); restore_DSx_live_graph; save_DSx_settings; save_settings;
    if {[array_item_difference ::settings ::settings_backup "steam_temperature water_refill_point"] == 1} {
        # resend the calibration settings if they were changed
        de1_send_steam_hotwater_settings
        de1_send_waterlevel_settings
    }
    if {[array_item_difference ::settings ::settings_backup "enable_fahrenheit scale_bluetooth_address language skin waterlevel_indicator_on waterlevel_indicator_blink display_rate_espresso display_espresso_water_delta_number display_group_head_delta_number display_pressure_delta_line display_flow_delta_line display_weight_delta_line allow_unheated_water"] == 1  || [ifexists ::app_has_updated] == 1} {
        # changes that effect the skin require an app restart
        .can itemconfigure $::message_label -text [translate "Please quit and restart to load changes."] -fill $::DSx_settings(font_colour)
        set_next_page off message; page_show message
        after 2000 app_exit
    } else {
        if {$::DSx_settings(graph_weight_total_b) != $::DSx_settings(graph_weight_total) \
            || $::DSx_settings(tare_off_b) != $::settings(tare_only_on_espresso_start) \
            || $::DSx_settings(black_saver_b) != $::settings(black_screen_saver) \
            || $::DSx_settings(font_size_b) != $::settings(default_font_calibration) \
            || $::DSx_settings(admin_b) != $::DSx_settings(admin) \
            || $::restart == 1
            } {
            .can itemconfigure $::message_label -text [translate "Please quit and restart to load changes."] -fill $::DSx_settings(font_colour)
            set_next_page off message; page_show message
        } else {
            set_next_page off off; start_idle; page_show off;
        }
    }
} 2030 1250 2250 1500

### Theme page
add_de1_widget "DSx_theme" entry 280 0 {
        set ::DSx_heading_entry $widget
        bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); save_DSx_settings;}
    }  -width 21 -font [DSx_font font 30] -borderwidth 2 -bg $::DSx_settings(bg_colour) -textvariable ::DSx_settings(heading) -relief sunken -highlightthickness 0 -highlightcolor #000000 -justify center -foreground $::DSx_settings(heading_colour)

# Heading colour
add_de1_image "DSx_theme" 100 350 "[skin_directory_graphics]/icons/button7.png"
set ::DSx_theme_var_10_3 [add_de1_text "DSx_theme" 300 450 -font [DSx_font font 10] -justify center -anchor center -text [translate "Heading\rColor"] -fill $::DSx_settings(font_colour)]
set ::DSx_theme_var_7_1 [add_de1_text "DSx_theme" 300 570 -font [DSx_font font 7] -justify center -anchor center -text [translate "Default $::DSx_settings(font_colour)"] -fill $::DSx_settings(font_colour)]
add_de1_button "DSx_theme" {say "" $::settings(sound_button_in); heading_colour_picker;} 100 350 500 550

set ::dial [add_de1_image "DSx_theme" 860 730 ""]

set ::DSx_theme_var_10_1 [add_de1_variable "DSx_theme" 1280 256 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Theme Setup Page}]
set ::DSx_theme_var_10_2 [add_de1_variable "DSx_theme" 1160 390 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Dial Design}]
set ::DSx_theme_var_8_1 [add_de1_variable "DSx_theme" 800 480 -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Bezel}]
set ::DSx_theme_var_8_2 [add_de1_variable "DSx_theme" 1100 480 -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Icons}]
set ::DSx_theme_var_8_3 [add_de1_variable "DSx_theme" 1400 480 -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor w -textvariable {Layout}]
add_de1_widget "DSx_theme" radiobutton 100 940 {set ::DSx_theme_radiobutton1 $widget} -text [translate "background 1"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(bg_name) -value bg1.jpg -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command theme_change
add_de1_widget "DSx_theme" radiobutton 100 1040 {set ::DSx_theme_radiobutton2 $widget} -text [translate "background 2"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(bg_name) -value bg2.jpg -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command theme_change
add_de1_widget "DSx_theme" radiobutton 100 1140 {set ::DSx_theme_radiobutton3 $widget} -text [translate "background 3"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(bg_name) -value bg3.jpg -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command theme_change
add_de1_widget "DSx_theme" radiobutton 100 1240 {set ::DSx_theme_radiobutton4 $widget} -text [translate "background 4"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(bg_name) -value bg4.jpg -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command theme_change
add_de1_widget "DSx_theme" radiobutton 100 1340 {set ::DSx_theme_radiobutton5 $widget} -text [translate "background 5"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(bg_name) -value bg5.jpg -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command theme_change
add_de1_widget "DSx_theme" radiobutton 760 520 {set ::DSx_theme_bezel_radiobutton1 $widget} -text [translate "Orig"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(bezel) -value 1 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 760 620 {set ::DSx_theme_bezel_radiobutton2 $widget} -text [translate "Clock"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(bezel) -value 2 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 760 720 {set ::DSx_theme_bezel_radiobutton3 $widget} -text [translate "Ring"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(bezel) -value 3 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 1060 520 {set ::DSx_theme_icons_radiobutton1 $widget} -text [translate "DSx"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(icons) -value 1 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 1060 620 {set ::DSx_theme_icons_radiobutton2 $widget} -text [translate "DE1.3"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(icons) -value 2 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 1360 520 {set ::DSx_theme_dial_radiobutton1 $widget} -text [translate "DSx"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(dial) -value 1 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 1360 620 {set ::DSx_theme_dial_radiobutton2 $widget} -text [translate "CLB"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(dial) -value 2 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
add_de1_widget "DSx_theme" radiobutton 1360 720 {set ::DSx_theme_dial_radiobutton3 $widget} -text [translate "DE1.3"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(dial) -value 3 -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command dial_config
dial_config_start

# Font
add_de1_image "DSx_theme" 100 650 "[skin_directory_graphics]/icons/button7.png"
set ::DSx_theme_var_12_1 [add_de1_variable "DSx_theme" 300 730 -font [DSx_font font 12] -fill $::DSx_settings(orange) -anchor center -textvariable {Font}]
set ::DSx_theme_var_7_3 [add_de1_variable "DSx_theme" 300 800 -font [DSx_font font 7] -width [rescale_x_skin 340] -fill $::DSx_settings(font_colour) -anchor center -textvariable {$::DSx_settings(font_name)}]
add_de1_button "DSx_theme" {say "" $::settings(sound_button_in); DSx_font_selection;} 100 650 500 850

#graph axis
add_de1_image "DSx_theme" 1880 420 "[skin_directory_graphics]/icons/click1.png"
set ::DSx_theme_var_18_1 [add_de1_variable "DSx_theme" 2124 520 -text "" -font [DSx_font font 18] -fill $::DSx_settings(font_colour) -anchor "center"  -textvariable {[round_to_integer $::DSx_settings(zoomed_y_axis_scale_default)]}]
set ::DSx_theme_var_7_2 [add_de1_variable "DSx_theme" 2124 670 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify center -anchor "center"  -textvariable {[translate "Set zoomed graph default\r y axis hight. (6 to 15)"]}]
add_de1_button "DSx_theme" {say "" $::settings(sound_button_in); horizontal_clicker_int 1 1 ::DSx_settings(zoomed_y_axis_scale_default) 6 15 %x %y %x0 %y0 %x1 %y1; DSx_reset_graphs; save_DSx_settings;} 1880 420 2360 620 ""

add_de1_widget "DSx_theme" checkbutton 1920 880 {set ::DSx_theme_checkbutton_1 $widget} -text [translate "Scale not used"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(orange) -variable ::DSx_settings(no_scale) -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa -relief flat -command restart_set;
add_de1_widget "DSx_theme" checkbutton 1920 960 {set ::DSx_theme_checkbutton_3 $widget} -text [translate "Hide Clock"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(clock_hide) -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa -relief flat;
add_de1_widget "DSx_theme" checkbutton 1920 1040 {set ::DSx_theme_checkbutton_4 $widget} -text [translate "Original Clock font"] -indicatoron true  -font "[DSx_font "$::DSx_settings(clock_font)" 8]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(original_clock_font) -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa -relief flat -command DSx_clock_font;
set ::DSx_theme_var_9_1 [add_de1_variable "DSx_theme" 1000 1540 -text "" -font [DSx_font font 9] -fill $::DSx_settings(orange) -justify center -anchor "center"  -textvariable {[translate "Note: options in Orange require an app restart"]}]

### Workflow page
add_de1_variable "DSx_workflow" 1280 60 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Workflow Setup Page}

# bean
add_de1_image "DSx_workflow" 120 134 "[skin_directory_graphics]/icons/bean.png"
add_de1_image "DSx_workflow" 400 140 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_workflow" 800 240 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_one_digits $::DSx_settings(bean_weight)]g}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 1 0.1 ::DSx_settings(bean_weight) 1 40 %x %y %x0 %y0 %x1 %y1; save_dose; clear_bean_font;} 400 140 1200 340 ""
# saw
add_de1_image "DSx_workflow" 120 404 "[skin_directory_graphics]/icons/espresso.png"
add_de1_image "DSx_workflow" 400 410 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_workflow" 800 510 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_integer $::DSx_settings(saw)]g}
add_de1_variable "DSx_workflow" 800 370 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {extraction ratio (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(saw))/$::settings(DSx_bean_weight)]])}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::DSx_settings(saw) 1 1000 %x %y %x0 %y0 %x1 %y1; DSx_update_saw; clear_saw_font;} 400 410 1200 610 ""
# flush
add_de1_image "DSx_workflow" 120 644 "[skin_directory_graphics]/icons/flush.png"
add_de1_image "DSx_workflow" 400 650 "[skin_directory_graphics]/icons/click.png"
add_de1_image "DSx_workflow" 1250 650 "[skin_directory_graphics]/icons/click1.png"
add_de1_variable "DSx_workflow" 800 750 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_integer $::DSx_settings(flush_time)]s}
add_de1_variable "DSx_workflow" 1512 750 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[DSx_flush_time_extend_text]}
add_de1_variable "DSx_workflow" 1500 820 -justify center -anchor center -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {2nd tap extra time}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 10 1 ::DSx_settings(flush_time) 1 250 %x %y %x0 %y0 %x1 %y1; save_DSx_flush_time_to_settings; clear_flush_font;} 400 650 1200 850 ""
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 1 1 ::DSx_settings(flush_time2) 0 20 %x %y %x0 %y0 %x1 %y1; save_DSx_settings;} 1250 650 1720 850 ""

# steam
add_de1_image "DSx_workflow" 120 884 "[skin_directory_graphics]/icons/steam.png"
add_de1_image "DSx_workflow" 400 890 "[skin_directory_graphics]/icons/click.png"
#add_de1_variable "DSx_workflow" 800 990 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_integer $::settings(steam_timeout)][translate "s"]}

add_de1_variable "DSx_workflow" 800 990 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[DSx_steam_time_text]}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::settings(steam_timeout) 0 250 %x %y %x0 %y0 %x1 %y1; check_steam_on;} 400 890 1200 1090 ""

# water
add_de1_image "DSx_workflow" 140 1124 "[skin_directory_graphics]/icons/water.png"
add_de1_image "DSx_workflow" 400 1130 "[skin_directory_graphics]/icons/click.png"
add_de1_image "DSx_workflow" 1250 1130 "[skin_directory_graphics]/icons/click1.png"
add_de1_variable "DSx_workflow" 800 1280 -justify center -anchor center -font [DSx_font font 8] -fill $::DSx_settings(blue) -textvariable {[wsaw_warning]}
add_de1_variable "DSx_workflow" 800 1230 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[return_liquid_measurement $::settings(water_volume)]}
add_de1_variable "DSx_workflow" 1512 1230 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[return_temperature_measurement $::settings(water_temperature)]}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 10 1 ::settings(water_volume) 10 400 %x %y %x0 %y0 %x1 %y1; save_settings; de1_send_steam_hotwater_settings; clear_water_font;} 400 1130 1200 1330 ""
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 1 1 ::settings(water_temperature) 60 100 %x %y %x0 %y0 %x1 %y1; save_settings; de1_send_steam_hotwater_settings; clear_water_font;} 1250 1130 1720 1330 ""

# wsaw
add_de1_image "DSx_workflow" 400 1340 "[skin_directory_graphics]/icons/click.png"
add_de1_image "DSx_workflow" 1250 1340 "[skin_directory_graphics]/icons/click1.png"
add_de1_variable "DSx_workflow" 800 1440 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[wsaw_value]}
add_de1_variable "DSx_workflow" 1500 1440 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[wsaw_cal_value]}
add_de1_variable "DSx_workflow" 800 1510 -justify center -anchor center -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {Water stop at weight}
add_de1_variable "DSx_workflow" 1500 1510 -justify center -anchor center -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {off-set}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::DSx_settings(wsaw) 0 300 %x %y %x0 %y0 %x1 %y1; save_DSx_settings; save_wsaw_to_settings; clear_wsaw_font;} 400 1340 1200 1540 ""
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); horizontal_clicker 0.1 0.1 ::DSx_settings(wsaw_cal) 0 3 %x %y %x0 %y0 %x1 %y1; save_DSx_settings;} 1250 1340 1720 1540 ""

# favourite
add_de1_image "DSx_workflow" 1830 900 "[skin_directory_graphics]/icons/bluecup.png"
add_de1_image "DSx_workflow" 2050 900 "[skin_directory_graphics]/icons/pinkcup.png"
add_de1_image "DSx_workflow" 2270 900 "[skin_directory_graphics]/icons/orangecup.png"
add_de1_variable "DSx_workflow" 2150 849 -text "" -font [DSx_font font 8] -fill $::DSx_settings(green) -anchor "center" -justify "center" -textvariable {$::fave_saved}
add_de1_variable "DSx_workflow" 2140 1130 -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {tap to save}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); save_bluecup; fav_saved_on; after 1000 fav_saved_off;} 1820 890 2040 1110
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); save_pinkcup; fav_saved_on; after 1000 fav_saved_off;} 2040 890 2260 1110
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); save_orangecup; fav_saved_on; after 1000 fav_saved_off;} 2260 890 2480 1110

# Profile
add_de1_variable "DSx_workflow" 2140 580 -anchor "center" -justify "center" -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -textvariable {[profile_type_text]}
add_de1_variable "DSx_workflow" 2140 660 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -width [rescale_x_skin 510] -textvariable {$::settings(profile_title)}
add_de1_button "DSx_workflow" {say [translate {}] $::settings(sound_button_in); set ::DSx_workflow_to_settings_1 1; show_settings; after 500 update_de1_explanation_chart; say [translate {settings}] $::settings(sound_button_in); set_next_page off settings_1; page_show off; set ::settings(active_settings_tab) settings_1; set_profiles_scrollbar_dimensions} 1900 540 2370 740

add_de1_widget "DSx_workflow" checkbutton 1920 750 {set ::DSx_workflow_checkbutton_1 $widget} -text [translate "LRv2/3 fast fill"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground #26a -variable ::DSx_settings(LRv2_presets) -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #26a -relief flat;

# Jug
add_de1_image "DSx_workflow" 1400 884 "[skin_directory_graphics]/icons/jug.png"
add_de1_variable "DSx_workflow" 1490 960 -justify center -anchor "n" -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {$::DSx_settings(jug_size)}
add_de1_button "DSx_workflow" {say "" $::settings(sound_button_in); jug_toggle;} 1390 890 1610 1090


### Calibrate ###
set ::cal_instructions "Tare the scale with your empty jug, add some milk and record its weight, steam to your desired temperature and record the time. \rSet the weight for your empty jug/s and your set to go! "

add_de1_variable "DSx_cal" 1920 840 -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -width [rescale_x_skin 1100] -textvariable {$::cal_instructions}
add_de1_variable "DSx_cal" 1280 60 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Steam by Weight Setup Page}
add_de1_variable "DSx_cal" 600 304 -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Empty jug weight}
add_de1_variable "DSx_cal" 600 604 -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Empty jug weight}
add_de1_variable "DSx_cal" 600 904 -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Empty jug weight}
add_de1_variable "DSx_cal" 2000 304 -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Milk net weight}
add_de1_variable "DSx_cal" 2000 604 -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Calibration time}

# jug 1
add_de1_image "DSx_cal" 180 134 "[skin_directory_graphics]/icons/jug.png"
add_de1_image "DSx_cal" 400 140 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_cal" 270 240 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {S}
add_de1_variable "DSx_cal" 760 180 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {X}
add_de1_variable "DSx_cal" 600 240 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[jug_s_cal_text]}
add_de1_button "DSx_cal" {say [translate {set jug}] $::settings(sound_button_in); set_jug_s} 180 140 800 340 ""
add_de1_button "DSx_cal" {say [translate {clear}] $::settings(sound_button_in); clear_jug_s} 720 120 850 220
# jug 2
add_de1_image "DSx_cal" 180 434 "[skin_directory_graphics]/icons/jug.png"
add_de1_image "DSx_cal" 400 440 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_cal" 270 540 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {M}
add_de1_variable "DSx_cal" 760 480 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {X}
add_de1_variable "DSx_cal" 600 540 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[jug_m_cal_text]}
add_de1_button "DSx_cal" {say [translate {set jug}] $::settings(sound_button_in); set_jug_m} 180 440 800 640 ""
add_de1_button "DSx_cal" {say [translate {clear}] $::settings(sound_button_in); clear_jug_m} 720 420 850 520
# jug 3
add_de1_image "DSx_cal" 180 734 "[skin_directory_graphics]/icons/jug.png"
add_de1_image "DSx_cal" 400 740 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_cal" 270 840 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {L}
add_de1_variable "DSx_cal" 760 780 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {X}
add_de1_variable "DSx_cal" 600 840 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[jug_l_cal_text]}
add_de1_button "DSx_cal" {say [translate {set jug}] $::settings(sound_button_in); set_jug_l} 180 740 800 940 ""
add_de1_button "DSx_cal" {say [translate {clear}] $::settings(sound_button_in); clear_jug_l} 720 720 850 820

# bean
add_de1_image "DSx_cal" 180 1034 "[skin_directory_graphics]/icons/bean.png"
add_de1_image "DSx_cal" 400 1040 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_cal" 600 1210 -justify center -anchor center -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -textvariable {Bean offset}
add_de1_variable "DSx_cal" 760 1080 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {X}
add_de1_variable "DSx_cal" 600 1140 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[bean_offset_text]}
add_de1_button "DSx_cal" {say [translate {set bean}] $::settings(sound_button_in); set_bean_offset} 180 1040 800 1240
add_de1_button "DSx_cal" {say [translate {clear}] $::settings(sound_button_in); clear_bean_offset} 720 1020 850 1120

add_de1_variable "DSx_cal" 500 1350 -justify center -anchor center -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -textvariable {Tap to set from scale.\rTap X to clear}


# jug full
add_de1_image "DSx_cal" 1380 134 "[skin_directory_graphics]/icons/jug_full.png"
add_de1_image "DSx_cal" 1600 140 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_cal" 2000 240 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_integer $::DSx_settings(milk_g)]g}
add_de1_button "DSx_cal" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::DSx_settings(milk_g) 1 600 %x %y %x0 %y0 %x1 %y1; set_jug} 1600 140 2400 340 ""
# time
add_de1_image "DSx_cal" 1380 434 "[skin_directory_graphics]/icons/steam_timer.png"
add_de1_image "DSx_cal" 1600 440 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_cal" 2000 540 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[round_to_integer $::DSx_settings(milk_s)]s}
add_de1_button "DSx_cal" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::DSx_settings(milk_s) 1 90 %x %y %x0 %y0 %x1 %y1; set_jug} 1600 440 2400 640 ""

add_de1_widget "DSx_skale" radiobutton 100 240 {set ::DSx_jug_radiobutton_1 $widget} -text [translate "S"] -indicatoron true  -font "[DSx_font font 16]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(jug_size) -value S -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command set_jug
add_de1_widget "DSx_skale" radiobutton 100 540 {set ::DSx_jug_radiobutton_2 $widget} -text [translate "M"] -indicatoron true  -font "[DSx_font font 16]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(jug_size) -value M -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command set_jug
add_de1_widget "DSx_skale" radiobutton 100 840 {set ::DSx_jug_radiobutton_3 $widget} -text [translate "L"] -indicatoron true  -font "[DSx_font font 16]" -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(jug_size) -value L -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command set_jug

# scale
add_de1_image "DSx_cal" 870 1200 "[skin_directory_graphics]/big_scale.png"
add_de1_variable "DSx_cal" 1280 1320 -justify center -anchor "n" -text "" -font [DSx_font font 13] -fill $::DSx_settings(font_colour) -textvariable {[round_to_one_digits $::de1(scale_sensor_weight)]g}
# skale ble reconnection button
add_de1_button "DSx_cal" {say [translate {tare}] $::settings(sound_button_in); skale_tare;} 1150 1200 1400 1500




##### Backup #####
set ::done ""
set ::no_backup ""
set backup_instructions " The Backup button will copy the de1plus folder and its content to de1plusBackUpCopy \r any previous deplusBackUpCopy will be removed. "
set backup_recommend "Dont forget to backup before running updates, adding skins, or make other file changes"
add_de1_variable "DSx_backup" 1280 60 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Backup & Restore Page}
add_de1_image "DSx_backup" 880 1030 "[skin_directory_graphics]/icons/button7.png"
add_de1_image "DSx_backup" 1330 1030 "[skin_directory_graphics]/icons/button7.png"

add_de1_text "DSx_backup" 1280 400 -text [translate "$backup_instructions"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -width [rescale_x_skin  2000]
add_de1_text "DSx_backup" 1280 580 -text [translate "$backup_recommend"] -font [DSx_font font 8] -fill "#5A9" -anchor "center" -width [rescale_x_skin  2000]
add_de1_text "DSx_backup" 1530 1130 -text [translate "Backup"] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center"
add_de1_variable "DSx_backup" 1280 750 -text "" -font [DSx_font font 12] -fill "#f00" -anchor "center" -justify "center" -textvariable {[translate "$::no_backup"]}
add_de1_variable "DSx_backup" 1280 850 -text "" -font [DSx_font font 12] -fill "#39C" -anchor "center" -justify "center" -textvariable {[translate "$::done"]}
add_de1_variable "DSx_backup" 1080 1130 -text "" -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -width [rescale_x_skin 500] -textvariable {[translate $::skin_backup_button]}
add_de1_button "DSx_backup" {say [translate {restore}] $::settings(sound_button_in); skin_wait_message; restore_DSx_User_set } 890 1040 1260 1210
add_de1_button "DSx_backup" {say [translate {backup}] $::settings(sound_button_in); wait-message; after 500 {DSx_backup}} 1340 1040 1710 1210

##### History Page #####
set DSx_past_shots_listbox_height 10
set DSx_past2_shots_listbox_height 10
set ::DSx_message2 ""

add_de1_widget "DSx_past" listbox 40 930 {
	set ::globals(DSx_past_shots_widget) $widget
	fill_DSx_past_shots_listbox
	bind $widget <<ListboxSelect>> ::load_DSx_past_shot; set ::time_line $::DSx_settings(DSx_past_espresso_elapsed); save_DSx_settings;
} -background $::DSx_settings(bg_colour) -yscrollcommand {scale_scroll ::DSx_past_slider} -font [DSx_font font 8] -bd 0 -height $DSx_past_shots_listbox_height -width 16 -foreground $::DSx_settings(font_colour) -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single  -selectbackground $::DSx_settings(font_colour)
add_de1_widget "DSx_past" listbox 1940 930 {
	set ::globals(DSx_past2_shots_widget) $widget
	fill_DSx_past2_shots_listbox
	bind $widget <<ListboxSelect>> ::load_DSx_past2_shot;
} -background $::DSx_settings(bg_colour) -yscrollcommand {scale_scroll ::DSx_past2_slider} -font [DSx_font font 8] -bd 0 -height $DSx_past2_shots_listbox_height -width 16 -foreground $::DSx_settings(font_colour) -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single  -selectbackground $::DSx_settings(font_colour)
set ::DSx_past_slider 0
set ::DSx_past2_slider 0
# draw the scrollbar off screen so that it gets resized and moved to the right place on the first draw
set ::DSx_past_shots_scrollbar [add_de1_widget "DSx_past" scale 1000 1000 {} -from 0 -to .50 -bigincrement 0.2 -background $::DSx_settings(font_colour) -borderwidth 1 -showvalue 0 -resolution .01 -length [rescale_x_skin 400] -width [rescale_y_skin 150] -variable ::advsteps -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -command {listbox_moveto $::globals(DSx_past_shots_widget) $::DSx_past_slider}  -foreground #FFFFFF -troughcolor $::DSx_settings(bg_colour) -borderwidth 0  -highlightthickness 0]
set ::DSx_past2_shots_scrollbar [add_de1_widget "DSx_past" scale 1000 1000 {} -from 0 -to .50 -bigincrement 0.2 -background $::DSx_settings(font_colour) -borderwidth 1 -showvalue 0 -resolution .01 -length [rescale_x_skin 400] -width [rescale_y_skin 150] -variable ::advsteps2 -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -command {listbox_moveto $::globals(DSx_past2_shots_widget) $::DSx_past2_slider}  -foreground #FFFFFF -troughcolor $::DSx_settings(bg_colour) -borderwidth 0  -highlightthickness 0]
proc set_DSx_past_shot_scrollbar_dimensions {} {
	# set the height of the scrollbar to be the same as the listbox
	$::DSx_past_shots_scrollbar configure -length [winfo height $::globals(DSx_past_shots_widget)]
	set coords [.can coords $::globals(DSx_past_shots_widget) ]
	set newx [expr {[winfo width $::globals(DSx_past_shots_widget)] + [lindex $coords 0]}]
	.can coords $::DSx_past_shots_scrollbar "$newx [lindex $coords 1]"
	if {$::DSx_settings(DSx_past_espresso_name) == "" || $::DSx_settings(DSx_past_espresso_name) == [translate "None"]} {
		set ::DSx_settings(DSx_past_espresso_name) $::settings(profile_title)
	}
}
proc set_DSx_past2_shot_scrollbar_dimensions {} {
	# set the height of the scrollbar to be the same as the listbox
	$::DSx_past2_shots_scrollbar configure -length [winfo height $::globals(DSx_past2_shots_widget)]
	set coords [.can coords $::globals(DSx_past2_shots_widget) ]
	set newx [expr {[winfo width $::globals(DSx_past2_shots_widget)] + [lindex $coords 0]}]
	.can coords $::DSx_past2_shots_scrollbar "$newx [lindex $coords 1]"
	if {$::DSx_settings(DSx_past2_espresso_name) == "" || $::DSx_settings(DSx_past2_espresso_name) == [translate "None"]} {
		set ::DSx_settings(DSx_past2_espresso_name) $::settings(profile_title)
	}
}

#### Graphs
## Left graph
add_de1_widget "DSx_past" graph 40 80 {
	set ::DSx_history_left_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		reset_messages;
		set_next_page DSx_past DSx_past_zoomed;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past_line_espresso_flow_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line_espresso_flow_weight_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line2_espresso_pressure -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #008c4c  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past_line_espresso_pressure_goal -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past_line_espresso_flow_goal_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5};
    $widget element create DSx_past_line_espresso_temperature_goal_01 -xdata espresso_elapsed1 -ydata DSx_past_espresso_temperature_goal_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #ffa5a6 -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past_line_espresso_temperature_basket_01 -xdata espresso_elapsed1 -ydata DSx_past_espresso_temperature_basket_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past_line_espresso_resistance  -xdata espresso_elapsed1 -ydata DSx_past_espresso_resistance -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e5e500 -smooth $::settings(live_graph_smoothing_technique) -pixels 0
    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 7] -min 0.0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 7] -min 0.0 -max $::DSx_settings(zoomed_y_axis_max) -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12}  -hide 0;
	$widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 7] -min 0.0 -max $::DSx_settings(zoomed_y2_axis_max) -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 1220] -height [rescale_y_skin 745] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

## Right graph
add_de1_widget "DSx_past" graph 1300 80 {
	set ::DSx_history_right_graph $widget
	bind $widget [platform_button_press] {
	    reset_messages;
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page DSx_past DSx_past2_zoomed;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past2_line_espresso_flow_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past2_line_espresso_flow_weight_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past2_line2_espresso_pressure -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #008c4c  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_pressure_goal -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past2_line_espresso_flow_goal_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5};
    $widget element create DSx_past2_line_espresso_temperature_goal_01 -xdata espresso_elapsed2 -ydata DSx_past2_espresso_temperature_goal_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #ffa5a6 -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past2_line_espresso_temperature_basket_01 -xdata espresso_elapsed2 -ydata DSx_past2_espresso_temperature_basket_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_resistance  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_resistance -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e5e500 -smooth $::settings(live_graph_smoothing_technique) -pixels 0

    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 7] -min 0.0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 7] -min 0.0 -max $::DSx_settings(zoomed_y_axis_max) -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12}  -hide 0;
	$widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 7] -min 0.0 -max $::DSx_settings(zoomed_y2_axis_max) -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 1220] -height [rescale_y_skin 745] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

# Icon overlay graph
add_de1_widget "DSx_past" graph 1105 938 {
	set ::DSx_history_icon_graph $widget
	bind $widget [platform_button_press] {
	    reset_messages;
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page DSx_past DSx_past;
		set_next_page DSx_past DSx_past3_zoomed;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past_line_espresso_flow_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 5] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line_espresso_flow_weight_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 5] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line2_espresso_pressure -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 5] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_flow_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 5] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget element create DSx_past2_line_espresso_flow_weight_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 5] -color #edd4c1 -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget element create DSx_past2_line2_espresso_pressure -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 5] -color #c5ffe7  -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 4] -min 0.0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 4] ;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 352] -height [rescale_y_skin 158] -background $::DSx_settings(bg_colour) -plotrelief flat

## History zoomed 1
add_de1_widget "DSx_past_zoomed" graph 30 80 {
	set ::DSx_history_left_zoomed_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page DSx_past DSx_past;
		set_next_page DSx_past_zoomed DSx_past;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past_line_espresso_flow_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line_espresso_flow_weight_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line2_espresso_pressure -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #008c4c  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;

    $widget element create DSx_past_line_espresso_pressure_goal -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past_line_espresso_flow_goal_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5};
    $widget element create DSx_past_line_espresso_temperature_goal_01 -xdata espresso_elapsed1 -ydata DSx_past_espresso_temperature_goal_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #ffa5a6 -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past_line_espresso_temperature_basket_01 -xdata espresso_elapsed1 -ydata DSx_past_espresso_temperature_basket_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past_line_espresso_resistance  -xdata espresso_elapsed1 -ydata DSx_past_espresso_resistance -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e5e500 -smooth $::settings(live_graph_smoothing_technique) -pixels 0
    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 9] -min 0.0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 9] -min 0.0 -max 17 -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16}  -hide 0;
	$widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 9] -min 0.0 -max 8.5 -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2500] -height [rescale_y_skin 1440] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

## History zoomed 2
add_de1_widget "DSx_past2_zoomed" graph 30 80 {
	set ::DSx_history_right_zoomed_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page DSx_past DSx_past;
		set_next_page DSx_past2_zoomed DSx_past;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past2_line_espresso_flow_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past2_line_espresso_flow_weight_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past2_line2_espresso_pressure -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_pressure_goal -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past2_line_espresso_flow_goal_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_goal_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5};
    $widget element create DSx_past2_line_espresso_temperature_goal_01 -xdata espresso_elapsed2 -ydata DSx_past2_espresso_temperature_goal_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #ffa5a6 -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5};
    $widget element create DSx_past2_line_espresso_temperature_basket_01 -xdata espresso_elapsed2 -ydata DSx_past2_espresso_temperature_basket_01 -symbol none -label ""  -linewidth [rescale_x_skin 5] -color #e73249 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_resistance  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_resistance -symbol none -label "" -linewidth [rescale_x_skin 5] -color #e5e500 -smooth $::settings(live_graph_smoothing_technique) -pixels 0

    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 9] -majorticks {0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 130 140 150 160 170}  -hide 0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 9] -min 0.0 -max 17 -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18}  -hide 0;
	$widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 9] -min 0.0 -max 8.5 -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2500] -height [rescale_y_skin 1440] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

## History zoomed 3
add_de1_widget "DSx_past3_zoomed" graph 30 80 {
	set ::DSx_history_icon_zoomed_graph $widget
	bind $widget [platform_button_press] {
		say [translate {zoom}] $::settings(sound_button_in);
		set_next_page DSx_past DSx_past;
		set_next_page DSx_past3_zoomed DSx_past;
		page_show $::de1(current_context)
	}
	$widget element create DSx_past_line_espresso_flow_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line_espresso_flow_weight_2x  -xdata espresso_elapsed1 -ydata DSx_past_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
	$widget element create DSx_past_line2_espresso_pressure -xdata espresso_elapsed1 -ydata DSx_past_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #69fdb3  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $widget element create DSx_past2_line_espresso_flow_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #7aaaff -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget element create DSx_past2_line_espresso_flow_weight_2x  -xdata espresso_elapsed2 -ydata DSx_past2_espresso_flow_weight_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #edd4c1 -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget element create DSx_past2_line2_espresso_pressure -xdata espresso_elapsed2 -ydata DSx_past2_espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 8] -color #c5ffe7  -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {2 2};
    $widget axis configure x -color $::DSx_settings(x_axis_colour) -tickfont [DSx_font font 9] -majorticks {0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 130 140 150 160 170}  -hide 0;
	$widget axis configure y -color #008c4c -tickfont [DSx_font font 9] -min 0.0 -max $::de1(max_pressure) -subdivisions 5 -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12}  -hide 0;
	$widget axis configure y2 -color #206ad4 -tickfont [DSx_font font 9] -min 0.0 -max 6 -subdivisions 2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8} -hide 0;
    $widget grid configure -color $::DSx_settings(grid_colour)
} -plotbackground $::DSx_settings(bg_colour) -width [rescale_x_skin 2500] -height [rescale_y_skin 1490] -borderwidth 1 -background $::DSx_settings(bg_colour) -plotrelief flat

add_de1_text "DSx_past_zoomed DSx_past2_zoomed DSx_past3_zoomed" 2460 20 -text [translate "Flow (mL/s)"] -font [DSx_font font 8] -fill "#206ad4" -justify "left" -anchor "ne"
add_de1_text "DSx_past_zoomed DSx_past2_zoomed DSx_past3_zoomed" 50 20 -text [translate "Pressure (bar)"] -font [DSx_font font 8] -fill "#008c4c" -justify "left" -anchor "nw"
add_de1_text "DSx_past_zoomed DSx_past2_zoomed DSx_past3_zoomed" 1900 20 -text [translate "Weight (g/s)"] -font [DSx_font font 8] -fill "#a2693d" -justify "left" -anchor "ne"
add_de1_variable "DSx_past_zoomed DSx_past2_zoomed" 450 20 -text "" -font [DSx_font font 8] -fill #da5050 -anchor "nw" -justify left -textvariable {$::DSx_settings(hist_temp_key)}

## Page
add_de1_image "DSx_past" 690 920 "[skin_directory_graphics]/icons/button8.png"
add_de1_image "DSx_past" 1090 920 "[skin_directory_graphics]/icons/button8.png"
add_de1_image "DSx_past" 1490 920 "[skin_directory_graphics]/icons/button8.png"
add_de1_image "DSx_past" 690 1130 "[skin_directory_graphics]/icons/button8.png"
add_de1_image "DSx_past" 1090 1130 "[skin_directory_graphics]/icons/button8.png"
add_de1_image "DSx_past" 1490 1130 "[skin_directory_graphics]/icons/button8.png"

add_de1_image "DSx_past" 1690 1370 "[skin_directory_graphics]/icons/heart2.png"
add_de1_image "DSx_past" 1180 1360 "[skin_directory_graphics]/icons/home.png"
add_de1_image "DSx_past" 680 1360 "[skin_directory_graphics]/icons/store.png"
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); DSx_archive} 670 1360 890 1600
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); set_next_page off off; start_idle; page_show off;} 1170 1360 1390 1600
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); unset -nocomplain ::settings_backup; array set ::settings_backup [array get ::settings]; set_next_page off describe_espresso0; page_show off; set_god_shot_scrollbar_dimensions} 1680 1360 1900 1600
source "[homedir]/skins/Insight/scentone.tcl"

##### DAMIAN Flow Correction
#add_de1_variable "DSx_past" 1550 1444 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {DSxFlow}
#add_de1_variable "DSx_past" 1550 1494 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_settings(flow_correction)}
#add_de1_button "DSx_past" {say "" $::settings(sound_button_in); history_flow_correction;} 1440 1360 1660 1600
set ::DSx_settings(flow_correction)  off
#####

add_de1_text "DSx_past DSx_past_zoomed DSx_past2_zoomed DSx_past3_zoomed" 1280 30 -text [translate "History Viewer"] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_text "DSx_past" 2500 30 -text [translate "Flow (mL/s)"] -font [DSx_font font 7] -fill "#206ad4" -justify "left" -anchor "ne"
add_de1_text "DSx_past" 50 30 -text [translate "Pressure (bar)"] -font [DSx_font font 7] -fill "#008c4c" -justify "left" -anchor "nw"
add_de1_text "DSx_past" 2500 1 -text [translate "Weight (g/s)"] -font [DSx_font font 7] -fill "#a2693d" -justify "left" -anchor "ne"

add_de1_variable "DSx_past" 50 1 -text "" -font [DSx_font font 7] -fill #da5050 -anchor "nw" -justify left -textvariable {$::DSx_settings(hist_temp_key)}
add_de1_variable "DSx_past" 500 1 -text "" -font [DSx_font font 7] -fill #e5e500 -anchor "nw" -justify left -textvariable {$::DSx_settings(hist_resistance_key)}

add_de1_text "DSx_past" 1690 970 -text [translate "showing"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_text "DSx_past" 880 986 -text [translate "Save to"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_text "DSx_past" 880 1034 -text [translate "godshots"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_variable "DSx_past" 1694 1014 -text "" -font [DSx_font font 12] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_settings(history_godshots)}
add_de1_variable "DSx_past" 1260 1350 -text "" -font [DSx_font font 16] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_message2}

add_de1_text "DSx_past" 870 1170 -text [translate "Temperature"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_text "DSx_past" 1280 1170 -text [translate "Goals"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_text "DSx_past" 1680 1170 -text [translate "Resistance"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"
add_de1_variable "DSx_past" 870 1224 -text "" -font [DSx_font font 12] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_settings(show_history_temperature)}
add_de1_variable "DSx_past" 1280 1224 -text "" -font [DSx_font font 12] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_settings(show_history_goal)}
add_de1_variable "DSx_past" 1680 1224 -text "" -font [DSx_font font 12] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_settings(show_history_resistance)}
add_de1_text "DSx_past" 780 1494 -text [translate "remove"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center"

add_de1_button "DSx_past" {say "" $::settings(sound_button_in); set_next_page off off; history_godshots_switch; after 200; fill_DSx_past2_shots_listbox; reset_messages} 1506 930 1870 1100
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); unset -nocomplain ::settings_backup; array set ::settings_backup [array get ::settings]; set_next_page off off; page_show DSx_h2g; reset_messages} 696 930 1060 1100
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); set_next_page off off; history_graph_temperature; after 200; reset_messages} 696 1130 1060 1300
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); set_next_page off off; history_graph_goal; after 200; reset_messages} 1101 1130 1465 1300
add_de1_button "DSx_past" {say "" $::settings(sound_button_in); set_next_page off off; history_graph_resistance; after 200; reset_messages} 1501 1130 1865 1300

## shot data
add_de1_variable "DSx_past" 640 56 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor center -justify center -textvariable {$::DSx_settings(shot_date_time)}
add_de1_variable "DSx_past" 40 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -justify left -width [rescale_x_skin  500] -textvariable {$::DSx_settings(past_profile_title)}
add_de1_variable "DSx_past" 1260 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "ne" -justify right -textvariable {$::DSx_settings(DSx_left_shot_time)    $::DSx_settings(past_bean_weight)g : $::DSx_settings(drink_weight)g (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(drink_weight))/$::DSx_settings(past_bean_weight)]])}
add_de1_variable "DSx_past" 1260 870 -text "" -font [DSx_font font 7] -fill "#206ad4" -anchor "ne" -justify right -textvariable {[round_to_integer $::DSx_settings(past_volume1)]mL}
#add_de1_variable "DSx_past" 880 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "ne" -justify right -textvariable {$::DSx_settings(DSx_left_shot_time)}
add_de1_variable "DSx_past" 1900 56 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor center -justify center -textvariable {$::DSx_settings(shot_date_time2)}
add_de1_variable "DSx_past" 1300 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -justify left -width [rescale_x_skin  500] -textvariable {$::DSx_settings(past_profile_title2)}
add_de1_variable "DSx_past" 2520 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "ne" -justify right -textvariable {$::DSx_settings(DSx_right_shot_time)    $::DSx_settings(past_bean_weight2)g : $::DSx_settings(drink_weight2)g (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(drink_weight2))/$::DSx_settings(past_bean_weight2)]])}
add_de1_variable "DSx_past" 2520 870 -text "" -font [DSx_font font 7] -fill "#206ad4" -anchor "ne" -justify right -textvariable {[round_to_integer $::DSx_settings(past_volume2)]mL}
#add_de1_variable "DSx_past" 2140 820 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "ne" -justify right -textvariable {$::DSx_settings(DSx_right_shot_time)}

## zoomed shot data
add_de1_variable "DSx_past_zoomed" 2510 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "e" -justify left -textvariable {$::DSx_settings(shot_date_time)}
add_de1_variable "DSx_past_zoomed" 50 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "w" -justify left -width [rescale_x_skin  500] -textvariable {$::DSx_settings(past_profile_title)}
add_de1_variable "DSx_past_zoomed" 1410 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "e" -justify right -textvariable {$::DSx_settings(DSx_left_shot_time)    $::DSx_settings(past_bean_weight)g : $::DSx_settings(drink_weight)g (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(drink_weight))/$::DSx_settings(past_bean_weight)]])}
add_de1_variable "DSx_past_zoomed" 1450 1545 -text "" -font [DSx_font font 9] -fill "#206ad4" -anchor "w" -justify right -textvariable {[round_to_integer $::DSx_settings(past_volume1)]mL}

add_de1_variable "DSx_past2_zoomed" 2510 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "e" -justify left -textvariable {$::DSx_settings(shot_date_time2)}
add_de1_variable "DSx_past2_zoomed" 50 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "w" -justify left -width [rescale_x_skin  500] -textvariable {$::DSx_settings(past_profile_title2)}
add_de1_variable "DSx_past2_zoomed" 1410 1545 -text "" -font [DSx_font font 9] -fill $::DSx_settings(font_colour) -anchor "e" -justify right -textvariable {$::DSx_settings(DSx_right_shot_time)    $::DSx_settings(past_bean_weight2)g : $::DSx_settings(drink_weight2)g (1:[round_to_one_digits [expr (0.01 + $::DSx_settings(drink_weight2))/$::DSx_settings(past_bean_weight2)]])}
add_de1_variable "DSx_past2_zoomed" 1450 1545 -text "" -font [DSx_font font 9] -fill "#206ad4" -anchor "w" -justify right -textvariable {[round_to_integer $::DSx_settings(past_volume2)]mL}

### Page h2g

add_de1_text "DSx_h2g" 340 420 -text [translate "Save As..."] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_widget "DSx_h2g" entry 340 480  {
	set ::globals(widget_DSx_past_shot_save) $widget
	bind $widget <Return> { say [translate {save}] $::settings(sound_button_in);}
	} -width 45 -font [DSx_font font 8]  -borderwidth 1 -bg #FFFFFF  -foreground #4e85f4 -textvariable ::DSx_settings(DSx_past2_espresso_name)

add_de1_text "DSx_h2g" 1640 465 -text [translate "Cancel"] -font [DSx_font font 14] -fill "#FF0000" -anchor "center"
add_de1_text "DSx_h2g" 2040 465 -text [translate "Save"] -font [DSx_font font 14] -fill "#00FF00" -anchor "center"
add_de1_button "DSx_h2g" {say "" $::settings(sound_button_in); set_next_page off off; page_show DSx_past;} 1460 386 1825 552
add_de1_button "DSx_h2g" {say "" $::settings(sound_button_in); DSx_save_h2g;} 1860 386 2225 552
set ::DSx_message ""
add_de1_variable "DSx_h2g" 1260 230 -text "" -font [DSx_font font 14] -fill $::DSx_settings(font_colour) -anchor "center" -justify "center" -textvariable {$::DSx_message}

###########################################################################################################################################

add_de1_button "settings_1 settings_2 settings_2a settings_2b settings_2c settings_2czoom settings_2c2 settings_3 settings_4" {if {[ifexists ::profiles_hide_mode] == 1} { unset -nocomplain ::profiles_hide_mode; fill_profiles_listbox }; array unset ::settings {\*}; array set ::settings [array get ::settings_backup]; update_de1_explanation_chart; fill_skin_listbox; profile_has_changed_set_colors; say [translate {Cancel}] $::settings(sound_button_in); set_next_page off off; page_show off; fill_advanced_profile_steps_listbox; restore_espresso_chart; LRv2_preview; DSx_graph_restore; save_settings_to_de1; fill_profiles_listbox;} 1505 1430 2015 1600
add_de1_button "settings_1 settings_2 settings_2a settings_2b settings_2c settings_2c2 settings_3 settings_4" {LRv2_preview; DSx_graph_restore; save_settings_to_de1; set_alarms_for_de1_wake_sleep; say [translate {save}] $::settings(sound_button_in); save_settings; profile_has_changed_set_colors;
    if {[array_item_difference ::settings ::settings_backup "steam_temperature"] == 1 && $::settings(steam_temperature) > 130} {
        set ::DSx_settings(steam_temperature_backup) $::settings(steam_temperature);
    }
    if {[array_item_difference ::settings ::settings_backup "enable_fahrenheit language skin waterlevel_indicator_on waterlevel_indicator_blink display_rate_espresso display_espresso_water_delta_number display_group_head_delta_number display_pressure_delta_line display_flow_delta_line display_weight_delta_line allow_unheated_water"] == 1 } {
        .can itemconfigure $::message_label -text [translate "Please quit and restart to load changes."] -fill $::DSx_settings(font_colour)
        set_next_page off message; page_show message; set ::DSx_workflow_to_settings_1 0
    } else {
        if {$::DSx_workflow_to_settings_1 == 1} {
            set_next_page off off; page_show DSx_workflow; clear_profile_font; off_cup; saw_switch; set ::DSx_workflow_to_settings_1 0;
        } else {
            set_next_page off off; page_show off; clear_profile_font; off_cup; saw_switch; set ::DSx_workflow_to_settings_1 0;
        }
    }
} 2016 1430 2560 1600


add_de1_widget "settings_1" graph 1330 300 {
    set ::DSx_preview_graph_advanced $widget
    update_de1_explanation_chart;
    LRv2_preview;
    $::DSx_preview_graph_advanced element create DSx_preview_line_espresso_flow_2x  -xdata DSx_espresso_elapsed_preview -ydata DSx_espresso_flow_preview_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #4e85f4 -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $::DSx_preview_graph_advanced element create DSx_preview_line_espresso_flow_weight_2x  -xdata DSx_espresso_elapsed_preview -ydata DSx_espresso_flow_weight_preview_2x -symbol none -label "" -linewidth [rescale_x_skin 8] -color #a2693d -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $::DSx_preview_graph_advanced element create DSx_preview_line2_espresso_pressure -xdata DSx_espresso_elapsed_preview -ydata DSx_espresso_pressure_preview -symbol none -label "" -linewidth [rescale_x_skin 8] -color #008c4c  -smooth $::settings(live_graph_smoothing_technique) -pixels 0;
    $::DSx_preview_graph_advanced axis configure x -color #5a5d75 -tickfont Helv_6 ;
    $::DSx_preview_graph_advanced axis configure y -color #5a5d75 -tickfont Helv_6 -min 0.0 -max 14 -stepsize 2 -majorticks {0 2 4 6 8 10 12 14} -title [translate "pressure"] -titlefont Helv_8 -titlecolor #5a5d75;
    $::DSx_preview_graph_advanced axis configure y2 -color #5a5d75 -tickfont Helv_6 -min 0.0 -max 7 -stepsize 2 -majorticks {0 1 2 3 4 5 6 7} -title [translate "flow"] -titlefont Helv_8 -titlecolor #5a5d75  -hide 0;
    bind $::DSx_preview_graph_advanced [platform_button_press] { after 500 update_de1_explanation_chart; say [translate {settings}] $::settings(sound_button_in); set_next_page off $::settings(settings_profile_type); page_show off; set ::settings(active_settings_tab) $::settings(settings_profile_type); fill_advanced_profile_steps_listbox }
} -plotbackground #F8F8F8 -width [rescale_x_skin 1050] -height [rescale_y_skin 450] -borderwidth 1 -background #FFFFFF -plotrelief raised

add_de1_variable "settings_1" 1560 230 -text [translate "Load a preset"] -font Helv_10_bold -fill "#7f879a" -justify "left" -anchor "nw" -textvariable {[LRv2_preview_text]}

###########################################################################################################################################


proc skins_page_change_due_to_de1_state_change { textstate } {
	page_change_due_to_de1_state_change $textstate

    if {$textstate == "Idle"} {
	    set ::DSx_timer_start 0
        set ::flush_counting 0
        set ::flush_run 0
        set ::DSx_steam_purge_state 0
        set ::DSx_steam_state_text "Steaming"
	} elseif {$textstate == "Steam"} {
		set ::DSx_steam_timing_text 1111
		set_next_page off off;
	} elseif {$textstate == "Espresso"} {
		#set ::weight_record 1
		set_next_page off off;
	} elseif {$textstate == "HotWater"} {
		set_next_page off off; 
	} elseif {$textstate == "HotWaterRinse"} {
		set_next_page off off;
        set ::DSx_timer_reset 1
        set ::DSx_flush_time2 0
        set ::flush_run 1
        DSx_loop
	}
}

DSx_final_prep
