package provide DSx_functions 1.0

proc DSx_startup {} {
    load_DSx_settings
    check_DSx_variables
    check_settings_for_DSx_added_variables
    set_other_variables
    DSx_pages
    load_theme
    source "[homedir]/skins/default/standard_includes.tcl"
    set ::skindebug $::DSx_skindebug
    check_MySaver_exists
    save_DSx_settings
    save_settings

}

proc DSx_final_prep {} {
    #set ::DSx_settings(version) {Beta}
    history_vars
    delete_old_variables
    startup_fav_check
    DSx_add_profiles
    fill_DSx_past_shots_listbox
    DSx_graph_restore
    focus .can
    bind Canvas <KeyPress> {handle_keypress %k}

}

proc delete_old_variables {} {
    if {[info exists ::settings(dsv4_jug_size)] == 1} {
    unset -nocomplain ::settings(dsv4_jug_size)
    unset -nocomplain ::settings(dsv4_volume)
    unset -nocomplain ::settings(dsv4_wsaw)
    unset -nocomplain ::settings(dsv4_bean_weight)
    save_settings
    }
}

proc check_DSx_variables {} {

    if {[info exists ::DSx_skindebug] == 0} {
        set ::DSx_skindebug 0
    }
    if {[info exists ::DSx_settings(backup_phase_2_flow_rate)] == 0} {
        set ::DSx_settings(backup_phase_2_flow_rate) $::settings(phase_2_flow_rate)
        set ::DSx_settings(backup_espresso_warmup_timeout) $::settings(espresso_warmup_timeout)
    }
    if {[info exists ::DSx_settings(original_clock_font)] == 0} {
        set ::DSx_settings(original_clock_font) 1
        set ::DSx_settings(clock_font) {Comic Sans MS}
    }
    if {[info exists ::DSx_settings(LRv2_presets)] == 0} {
        set ::DSx_settings(LRv2_presets) 1
    }
    if {[info exists ::DSx_settings(bean_nett_range)] == 0} {
        set ::DSx_settings(bean_nett_range) 30
    }
    if {[info exists ::DSx_settings(bean_offset)] == 0} {
        set ::DSx_settings(bean_offset) 0
    }
    if {[info exists ::DSx_settings(activated)] == 0} {
        set ::DSx_settings(activated) 1
        set ::DSx_settings(heading) {- DSx -}
        set ::DSx_settings(font_colour) #ddd
        set ::DSx_settings(bg_name) bg2.jpg
        set ::DSx_settings(bg_colour) #1e1e1e
        set ::DSx_settings(green) #00dd00
        set ::DSx_settings(pink) #f198e6
        set ::DSx_settings(blue) #73ced8
        set ::DSx_settings(orange) #ff9421
        set ::DSx_settings(grey) #eee
        set ::DSx_settings(grid_colour) #555
        set ::DSx_settings(x_axis_colour) #ddd
        set ::DSx_settings(saw) 45
        set ::DSx_settings(graph_weight_total) 0
        set ::DSx_settings(past_bean_weight) 1
        set ::DSx_settings(font_size) [expr {100 * $::settings(default_font_calibration)}]
        set ::DSx_settings(bean_weight) 0
        set ::DSx_settings(steam_calc) 1
        set ::DSx_settings(jug_g) 0
        set ::DSx_settings(jug_s) 0
        set ::DSx_settings(jug_m) 0
        set ::DSx_settings(jug_l) 0
        set ::DSx_settings(milk_g) 0
        set ::DSx_settings(milk_s) 0
        set ::DSx_settings(jug_size) { }
        set ::DSx_settings(blue_cup_indicator) { }
        set ::DSx_settings(pink_cup_indicator) { }
        set ::DSx_settings(orange_cup_indicator) { }
        set ::DSx_settings(zoomed_y_axis_scale_default) 12
        set ::DSx_settings(zoomed_y_axis_max) 12
        set ::DSx_settings(zoomed_y_axis_min) 0
        set ::DSx_settings(zoomed_y2_axis_max) 6
        set ::DSx_settings(zoomed_y2_axis_min) 0
        set ::settings(tare_only_on_espresso_start) 1
        set ::settings(DSx_bean_weight) 0
        set ::DSx_settings(bezel) 2
        set ::DSx_settings(icons) 1
        set ::DSx_settings(wsaw) 0
        set ::DSx_settings(wsaw_cal) 1.4
        set ::DSx_settings(no_scale) 0
        set ::DSx_settings(dial) 3
        if {$::settings(steam_temperature) > 129} {
            set ::DSx_settings(steam_temperature_backup) $::settings(steam_temperature)
        } else {
            set ::DSx_settings(steam_temperature_backup) 160
        }
        set ::settings(DSx_volume) 0
        set ::DSx_settings(past_volume1) 0
        set ::DSx_settings(past_volume2) 0
        set ::DSx_settings(admin) 1
        set ::DSx_settings(font_name) "Comic Sans MS"
        set ::DSx_settings(clock_hide) 0
        set ::DSx_settings(clock_hide_ss) 0
    }
    if {[info exists ::DSx_settings(heading_colour)] == 0} {
            set ::DSx_settings(heading_colour) $::DSx_settings(font_colour)
    }
    if {[info exists ::DSx_settings(font_dir)] == 0 } {
            set ::DSx_settings(font_dir) [skin_directory]/DSx_Font_Files
    }
    if {[file exists "$::DSx_settings(font_dir)/$::DSx_settings(font_name).ttf"] == 0 } {
            set ::DSx_settings(font_dir) [skin_directory]/DSx_Font_Files
            set ::DSx_settings(font_name) "Comic Sans MS"
    }
    if {$::settings(steam_temperature) > 130} {
            set ::DSx_settings(steam_temperature_backup) $::settings(steam_temperature)
    }
    if {[info exists ::DSx_settings(show_history_resistance)] == 0 } {
        set ::DSx_settings(show_history_resistance) off
    }
    if {[info exists ::DSx_settings(flow_correction)] == 0 } {
        set ::DSx_settings(flow_correction) off
    }
    if {[info exists ::DSx_settings(flush_time)] == 0 } {
        set ::DSx_settings(flush_time) $::settings(preheat_volume)
    }
    if {[info exists ::DSx_settings(flush_time2)] == 0 } {
        set ::DSx_settings(flush_time2) 0
    }
}

proc check_settings_for_DSx_added_variables {} {
        if {[info exists ::settings(DSx_bean_weight)] == 0} {
            set ::settings(DSx_bean_weight) 1
        }
        if {[info exists ::settings(DSx_jug_size)] == 0} {
            set ::settings(DSx_jug_size) { }
        }
        if {[info exists ::settings(DSx_wsaw)] == 0} {
            set ::settings(DSx_wsaw) 0
        }
        if {[info exists ::settings(DSx_flush_time)] == 0} {
            set ::settings(DSx_flush_time) $::DSx_settings(flush_time)
        }
}

proc DSx_pages {} {
    set ::DSx_admin_pages {DSx_admin DSx_admin_saver DSx_units DSx_admin_skin}
    set ::DSx_standby_pages {off steam_1 flush_1 water_1}
    set ::DSx_active_pages {espresso steam preheat_2 water}
    set ::DSx_zoomed_pages {off_zoomed steam_1_zoomed flush_1_zoomed water_1_zoomed espresso_zoomed}
    set ::DSx_steam_zoomed_pages {off_steam_zoomed steam_1_steam_zoomed flush_1_steam_zoomed water_1_steam_zoomed steam_steam_zoomed}
    set ::DSx_other_pages {DSx_theme DSx_cal DSx_backup DSx_workflow DSx_admin}
    set ::DSx_blank_pages {DSx_demo_graph message DSx_past DSx_h2g DSx_past_zoomed DSx_past2_zoomed DSx_past3_zoomed}
    set ::DSx_home_pages "$::DSx_standby_pages $::DSx_active_pages"
    set ::DSx_all_pages "$::DSx_admin_pages $::DSx_standby_pages $::DSx_active_pages $::DSx_other_pages $::DSx_blank_pages $::DSx_zoomed_pages $::DSx_steam_zoomed_pages"
    add_de1_page "DSx_power" "poweroff.png"
    add_de1_page "DSx_travel_prepare" "travel_prepare.jpg" "default"
    add_de1_page "DSx_descale_prepare" "descale_prepare.jpg" "default"
    set ::theme_bg [add_de1_image $::DSx_all_pages 0 0 ]
}
set_next_page "hotwaterrinse" "preheat_2"

proc load_theme {} {
	borg spinner on
    set fn "[skin_directory_graphics]/background/$::DSx_settings(bg_name)"
	$::theme_bg read $fn
	if {$::DSx_settings(bg_name) == "bg1.jpg"} {
        set ::DSx_settings(bg_colour) #000000
    } elseif {$::DSx_settings(bg_name) == "bg2.jpg"} {
        set ::DSx_settings(bg_colour) #1e1e1e
    } elseif {$::DSx_settings(bg_name) == "bg3.jpg"} {
        set ::DSx_settings(bg_colour) #242424
    } elseif {$::DSx_settings(bg_name) == "bg4.jpg"} {
        set ::DSx_settings(bg_colour) #333
    } else {
        set ::DSx_settings(bg_colour) #3d3c36
    }
	borg spinner off
	borg systemui $::android_full_screen_flags
}

proc set_colour {} {
    $::DSx_heading_entry configure -bg $::DSx_settings(bg_colour) -font "[DSx_font font 30]"
    $::DSx_home_espresso_graph_1 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
	$::DSx_home_espresso_graph_2 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
	$::DSx_home_espresso_graph_3 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
	$::DSx_espresso_zoomed_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
	$::DSx_home_steam_graph_1 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_home_steam_graph_2 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_home_steam_graph_3 configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_home_steam_zoomed_graph  configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_theme_radiobutton1 configure -bg $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_radiobutton2 configure -bg $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_radiobutton3 configure -bg $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_radiobutton4 configure -bg $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_radiobutton5 configure -bg $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_bezel_radiobutton1 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_bezel_radiobutton2 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_bezel_radiobutton3 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_dial_radiobutton1 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_dial_radiobutton2 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_dial_radiobutton3 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_icons_radiobutton1 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_icons_radiobutton2 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_checkbutton_1 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_checkbutton_2 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_checkbutton_3 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font font 8]"
    $::DSx_theme_checkbutton_4 configure -bg $::DSx_settings(bg_colour) -activebackground $::DSx_settings(bg_colour) -font "[DSx_font "$::DSx_settings(clock_font)" 8]"
    .can itemconfigure $::DSx_clock_font_var_1 -font "[DSx_font "$::DSx_settings(clock_font)" 14.5]"
    .can itemconfigure $::DSx_clock_font_var_2 -font "[DSx_font "$::DSx_settings(clock_font)" 6.4]"
    .can itemconfigure $::DSx_clock_font_var_3 -font "[DSx_font "$::DSx_settings(clock_font)" 8]"
    .can itemconfigure $::DSx_clock_font_var_4 -font "[DSx_font "$::DSx_settings(clock_font)" 6]"
    .can itemconfigure $::DSx_theme_var_10_1 -font "[DSx_font font 10]"
    .can itemconfigure $::DSx_theme_var_10_2 -font "[DSx_font font 10]"
    .can itemconfigure $::DSx_theme_var_10_3 -font "[DSx_font font 10]"
    .can itemconfigure $::DSx_theme_var_12_1 -font "[DSx_font font 12]"
    .can itemconfigure $::DSx_theme_var_8_1 -font "[DSx_font font 8]"
    .can itemconfigure $::DSx_theme_var_8_2 -font "[DSx_font font 8]"
    .can itemconfigure $::DSx_theme_var_8_3 -font "[DSx_font font 8]"
    .can itemconfigure $::DSx_theme_var_18_1 -font "[DSx_font font 18]"
    .can itemconfigure $::DSx_theme_var_7_1 -font "[DSx_font font 7]"
    .can itemconfigure $::DSx_theme_var_7_2 -font "[DSx_font font 7]"
    .can itemconfigure $::DSx_theme_var_7_3 -font "[DSx_font font 7]"
    .can itemconfigure $::DSx_theme_var_9_1 -font "[DSx_font font 9]"
    $::globals(DSx_past_shots_widget) configure -background $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -selectbackground $::DSx_settings(font_colour)
    $::globals(DSx_past2_shots_widget) configure -background $::DSx_settings(bg_colour) -foreground $::DSx_settings(font_colour) -selectbackground $::DSx_settings(font_colour)
    $::DSx_past_shots_scrollbar configure -troughcolor $::DSx_settings(bg_colour) -background $::DSx_settings(font_colour)
    $::DSx_past2_shots_scrollbar configure -troughcolor $::DSx_settings(bg_colour) -background $::DSx_settings(font_colour)
    $::DSx_history_left_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_history_right_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_history_icon_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_history_left_zoomed_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_history_right_zoomed_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
    $::DSx_history_icon_zoomed_graph configure -plotbackground $::DSx_settings(bg_colour) -background $::DSx_settings(bg_colour)
}

proc theme_change {} {
    load_theme
    set_colour
    dial_config_start
}

proc set_other_variables {} {
    set ::glt1 4
    set ::glt2 4
    set ::glt3 4
    set ::glt4 4
    set ::glt5 4
    set ::glb1 2
    set ::glb2 2
    set ::glb3 2
    set ::glb4 2
    set ::glb5 2
    set ::wsaw_run 0
    set ::flush_run 0
    set ::restart 0
    set ::DSx_settings(font_colour) #ddd
    set ::DSx_settings(red) #ff574a
    set ::DSx_workflow_to_settings_1 0
    set ::fave_saved { }
    set ::DSx_saved_2 {}
    set ::current_espresso_page off
    set ::DSx_steam_state 0
    set ::steam_off_message ""
    set ::de1(scale_weight) 0
    set ::DSxv 0
    set ::DSx_steam_purge_state 0
    set ::DSx_steam_state_text "Steaming"
}
proc DSx_add_profiles {} {
    set DSx_profile {Damian's LRv2.tcl}
    if {[file exists [homedir]/profiles/${DSx_profile}] != 1 && [file exists [homedir]/skins/DSx/DSx_Code_Files/${DSx_profile}] == 1} {
        file copy -force [homedir]/skins/DSx/DSx_Code_Files/${DSx_profile} [homedir]/profiles/${DSx_profile}
        fill_profiles_listbox
    }
    if {[file exists [homedir]/profiles/Damians-LRv2.tcl] == 1} {
        file delete -force [homedir]/profiles/Damians-LRv2.tcl
        fill_profiles_listbox
    }
    set DSx_profile2 {Damian's LRv3.tcl}
    if {[file exists [homedir]/profiles/${DSx_profile2}] != 1 && [file exists [homedir]/skins/DSx/DSx_Code_Files/${DSx_profile2}] == 1} {
        file copy -force [homedir]/skins/DSx/DSx_Code_Files/${DSx_profile2} [homedir]/profiles/${DSx_profile2}
        fill_profiles_listbox
    }
    if {[file exists [homedir]/profiles/Damians-LRv4.tcl] == 1} {
        file delete -force [homedir]/profiles/Damians-LRv3.tcl
        fill_profiles_listbox
    }
}

proc check_MySaver_exists {} {
    set dir "[homedir]/MySaver"
    set file_list [glob -nocomplain "$dir/*"]
    if {[llength $file_list] != 0 && $::settings(black_screen_saver) != 1} {
        #set_de1_screen_saver_directory "[homedir]/MySaver"

        set dirname "[homedir]/MySaver"
        global saver_directory
        if {$dirname != ""} {
            set saver_directory $dirname
        }

        set names "saver"
        image create photo $names

        foreach name $names {
            .can create image {0 0} -anchor nw -image $names  -tag [list saver $name] -state hidden
        }

        } else {
        #set_de1_screen_saver_directory "[homedir]/saver"
        }
}


### Saving DSx settings file
proc DSx_filename {} {
    set fn "[skin_directory]/DSx_User_Set/DSx_settings.tdb"
    return $fn
}

proc append_file {DSx_filename data} {
    set success 0
    set errcode [catch {
        set fn [open $DSx_filename a]
        puts $fn $data
        close $fn
        set success 1
    }]
    if {$errcode != 0} {
        msg "append_file $::errorInfo"
    }
    return $success
}

proc save_DSx_array_to_file {arrname fn} {
    upvar $arrname item
    set DSx_data {}
    foreach k [lsort -dictionary [array names item]] {
        set v $item($k)
        append DSx_data [subst {[list $k] [list $v]\n}]
    }
    write_file $fn $DSx_data
}

proc save_DSx_settings {} {
    if {$::settings(steam_temperature) > 130} {
           # set ::DSx_settings(steam_temperature_backup) $::settings(steam_temperature)
    }
    msg "saving DSx settings"
    save_DSx_array_to_file ::DSx_settings [DSx_filename]

}



proc load_DSx_settings {} {
    array set ::DSx_settings [encoding convertfrom utf-8 [read_binary_file [DSx_filename]]]
    blt::vector create espresso_elapsed1 espresso_elapsed2  DSx_past_espresso_resistance DSx_past_espresso_elapsed DSx_past_espresso_pressure DSx_past_espresso_flow DSx_past_espresso_flow_weight DSx_past_espresso_flow_weight_2x DSx_past_espresso_flow_2x DSx_past_espresso_temperature_basket DSx_past_espresso_temperature_mix  DSx_past_espresso_flow_goal DSx_past_espresso_flow_goal_2x DSx_past_espresso_pressure_goal DSx_past_espresso_temperature_goal DSx_past_espresso_temperature_goal_01 DSx_past_espresso_temperature_basket_01
    blt::vector create espresso_elapsed1 espresso_elapsed2  DSx_past2_espresso_resistance DSx_past2_espresso_elapsed DSx_past2_espresso_pressure DSx_past2_espresso_flow DSx_past2_espresso_flow_weight DSx_past2_espresso_flow_weight_2x DSx_past2_espresso_flow_2x DSx_past2_espresso_temperature_basket  DSx_past2_espresso_temperature_mix  DSx_past2_espresso_flow_goal DSx_past2_espresso_flow_goal_2x DSx_past2_espresso_pressure_goal DSx_past2_espresso_temperature_goal DSx_past2_espresso_temperature_goal_01 DSx_past2_espresso_temperature_basket_01
    blt::vector create espresso_elapsed1 espresso_elapsed2  DSx_last_espresso_resistance DSx_last_espresso_elapsed DSx_last_espresso_pressure DSx_last_espresso_flow DSx_last_espresso_flow_weight DSx_last_espresso_flow_weight_2x DSx_last_espresso_flow_2x DSx_last_espresso_temperature_basket DSx_last_espresso_temperature_mix  DSx_last_espresso_flow_goal DSx_last_espresso_flow_goal_2x DSx_last_espresso_pressure_goal DSx_last_espresso_temperature_goal DSx_last_espresso_temperature_goal_01 DSx_last_espresso_temperature_basket_01
    blt::vector create DSx_espresso_temperature_basket DSx_espresso_temperature_mix DSx_espresso_temperature_goal
    blt::vector create espresso_elapsed_preview espresso_pressure_preview espresso_flow_preview espresso_flow_weight_preview espresso_flow_preview_2x espresso_flow_weight_preview_2x
    blt::vector create DSx_explanation_temp DSx_espresso_elapsed_preview DSx_espresso_pressure_preview DSx_espresso_flow_preview DSx_espresso_flow_weight_preview DSx_espresso_flow_preview_2x DSx_espresso_flow_weight_preview_2x
}

proc off_timer {} {
    set_next_page off DSx_power;
    page_show DSx_power;
    after 4000 {set_next_page off off; set ::current_espresso_page "off"; start_sleep}
}

proc window_expand {} {
    set width_small [expr {$::settings(screen_size_width)}]
    set height_small [expr {$::settings(screen_size_height)}]
    wm maxsize . $width_small $height_small
    wm minsize . $width_small $height_small
    wm attributes . -fullscreen 1
}


proc power_off {} {
    after cancel {start_sleep}
    app_exit
}

proc load_test {} {
   set ::DSx_settings(graph_weight_total_b) $::DSx_settings(graph_weight_total)
   set ::DSx_settings(tare_off_b) $::settings(tare_only_on_espresso_start)
   set ::DSx_settings(black_saver_b) $::settings(black_screen_saver)
   set ::DSx_settings(font_size_b) $::settings(default_font_calibration)
   set ::DSx_settings(admin_b) $::DSx_settings(admin)
   check_skin_backup
   backup_settings
}

proc check_backup {} {
    if {[file exists [homedir]BackUpCopy] != 1} {
        set ::no_backup "You do not have a backup file"
        } else {
        set ::no_backup ""
    }
}

proc check_skin_backup {} {
    if {[file exists [homedir]BackUpCopy/skins/DSx/DSx_User_Set] != 1} {
        set ::skin_backup_button "No Backup \rAvailable"
        } else {
        set ::skin_backup_button "Restore\rDSx Setup"
    }
}

proc DSx_backup {} {
    borg spinner on
    file delete -force [homedir]BackUpCopy
    file copy -force [homedir] [homedir]BackUpCopy
    borg spinner off
    borg systemui $::android_full_screen_flags
    done_message
}

proc start_button_ready {} {
	set num $::de1(substate)
	set substate_txt $::de1_substate_types($num)
	if {$substate_txt == "ready" && $::de1(device_handle) != 0} {
		if {$::settings(steam_timeout) > 0 && [steamtemp] > [expr {$::settings(steam_temperature) - 11}]} {
		    return [translate "READY"]
		} elseif {$::settings(steam_timeout) == 0} {
		    return [translate "READY"]
		}
	}
	return [translate "WAIT"]
}

proc de1_substate_text_DSx {} {
	set num $::de1(substate)
	set substate_txt $::de1_substate_types($num)
	if {$substate_txt == "ready" || $substate_txt == "wait"} {
		return [translate " "]
	}
	return [translate $substate_txt]
}

proc DSx_steam_time_text {} {
    if {$::settings(steam_timeout) > 0} {
        return [round_to_integer $::settings(steam_timeout)][translate "s"]
    } else {
        return "off"
    }
}

proc DSx_sav {} {
    if {$::settings(scale_bluetooth_address) == "" && $::settings(final_desired_shot_volume) > 0 && ($::settings(settings_profile_type) == "settings_2a" || $::settings(settings_profile_type) == "settings_2b")} {
        return "SAV - [return_liquid_measurement [round_to_integer $::settings(final_desired_shot_volume)]]"
    } elseif {$::settings(final_desired_shot_volume_advanced) > 0 && $::settings(settings_profile_type) == "settings_2c"} {
        return "SAV Step $::settings(final_desired_shot_volume_advanced_count_start) - [return_liquid_measurement [round_to_integer $::settings(final_desired_shot_volume_advanced)]]"
    } else {
        return "SAV - off"
    }
}
proc DSx_profile_type {} {
    if {$::settings(settings_profile_type) == "settings_2a"} {
        return "Pressure"
    } elseif {$::settings(settings_profile_type) == "settings_2b"} {
        return "Flow"
    } else {
        return "Adv."
    }
}
proc DSx_preheat_status {} {
    if {$::settings(tank_desired_water_temperature) > 1} {
        return "[return_temperature_measurement $::settings(tank_desired_water_temperature)]"
    } else {
        return ""
    }
}

proc check_steam_on {} {
    if {$::settings(steam_timeout) > 0} {
        set ::settings(steam_temperature) $::DSx_settings(steam_temperature_backup)
    } else {
        set ::settings(steam_temperature) 0
    }
    save_settings
    de1_send_steam_hotwater_settings
    clear_steam_font
}

proc DSx_steam_time {} {
    if {[expr "\[round_to_integer $::settings(steam_timeout)] - \[steam_pour_timer]"] >= 0} {
        set ::DSx_steam_timing_text [expr "\[round_to_integer $::settings(steam_timeout)] - \[steam_pour_timer]"]
    } else {
        set ::DSx_steam_timing_text ""
    }
    return $::DSx_steam_timing_text
}

proc DSx_steam_state_off {} {
    set ::DSx_steam_state 0
}


proc DSx_steam_info {} {
    if {$::DSx_steam_purge_state != 1} {
        set ::DSx_steam_state_text "Steaming"
    }
    if {[expr "\[round_to_integer $::settings(steam_timeout)] - \[steam_pour_timer]"] < 0 && [expr "\[round_to_integer $::settings(steam_timeout)] - \[steam_pour_timer]" + 2] > 0} {
        set ::DSx_steam_purge_state 1
        set ::DSx_steam_state_text "Start steam purge"
    }
    return $::DSx_steam_state_text
}

proc de1_connected_state_DSx {} {
    if {[de1_connected_state] == "Wait"} {
    return ""
    }
    return [de1_connected_state]
}
set ::DSx_blink 1

proc DSx_scale_disconnected {} {
	if {$::android == 1 && [ifexists ::settings(scale_bluetooth_address)] == ""} {
		return ""
	}
	if {$::de1(scale_device_handle) == "0" && $::DSx_settings(no_scale) != 1 && $::android == 1} {
		if {$::DSx_blink == 1} {
		    after 300 {set ::DSx_blink 0}
		    return "reconnect"
		} else {
		    set ::DSx_blink 1
		    return ""
		}
	}
	return ""
}

proc done_message {} {
    set ::done "All Done!"
    after 4000 {set ::done ""}
}

proc wait-message {} {
        set ::no_backup ""
        set ::done "Please wait..."
}

proc skin_wait_message {} {
    if {[file exists [homedir]BackUpCopy/skins/DSx/DSx_User_Set] == 1} {
        set ::skin_backup_button "Please \rWait..."
    }
}

proc restore_DSx_User_set {} {
    if {[file exists [homedir]BackUpCopy/skins/DSx/DSx_User_Set] == 1} {
        file delete -force [homedir]/skins/DSx/DSx_User_Set
        file copy [homedir]BackUpCopy/skins/DSx/DSx_User_Set [homedir]/skins/DSx/DSx_User_Set
        .can itemconfigure $::message_label -text [translate "Please quit and restart this app to apply your changes."] -fill #dddddd
        after 2000 {set_next_page off message; page_show message}
        }
}

proc DSx_current_listbox_item {widget} {
	set found_one 0
	for {set x 0} {$x < [$widget index end]} {incr x} {
		if {$x == [$widget curselection]} {
				$widget itemconfigure $x -foreground $::DSx_settings(bg_colour) -selectforeground $::DSx_settings(bg_colour) -background $::DSx_settings(font_colour)
				set found_one 1
		} else {
			$widget itemconfigure $x -foreground $::DSx_settings(font_colour) -background $::DSx_settings(bg_colour)
		}
	}
	if {$found_one != 1} {
		# handle the case where nothing has been selected
		$widget selection set 0
		$widget itemconfigure 0 -foreground $::DSx_settings(font_colour) -selectforeground #000000  -background $::DSx_settings(bg_colour)
	}
}

proc DSx_font_cal {} {
    set fn [expr {$::DSx_settings(font_size)/100}]
    if {$fn <0.25} {
        set ::settings(default_font_calibration) 0.25
        set ::DSx_settings(font_size) 25
    } elseif {$fn > 1.2} {
        set ::settings(default_font_calibration) 1
        set ::DSx_settings(font_size) 100
    } else {
        set ::settings(default_font_calibration) $fn
    }
    save_settings
    save_DSx_settings
}

proc horizontal_clicker_int {bigincrement smallincrement varname minval maxval x y x0 y0 x1 y1} {

	set x [translate_coordinates_finger_down_x $x]
	set y [translate_coordinates_finger_down_y $y]
	set xrange [expr {$x1 - $x0}]
	set xoffset [expr {$x - $x0}]
	set midpoint [expr {$x0 + ($xrange / 2)}]
	set onequarterpoint [expr {$x0 + ($xrange / 5)}]
	set threequarterpoint [expr {$x1 - ($xrange / 5)}]
	if {[info exists $varname] != 1} {
		# if the variable doesn't yet exist, initialize it with a zero value
		set $varname 0
	}
	set currentval [subst \$$varname]
	set newval $currentval
	if {$x < $onequarterpoint} {
		set newval [expr "1.0 * \$$varname - $bigincrement"]
	} elseif {$x < $midpoint} {
		set newval [expr "1.0 * \$$varname - $smallincrement"]
	} elseif {$x < $threequarterpoint} {
		set newval [expr "1.0 * \$$varname + $smallincrement"]
	} else {
		set newval [expr "1.0 * \$$varname + $bigincrement"]
	}
	set newval [round_to_integer $newval]
	if {$newval > $maxval} {
		set $varname $maxval
	} elseif {$newval < $minval} {
		set $varname $minval
	} else {
		set $varname [round_to_integer $newval]
	}
	update_onscreen_variables
	return
}

proc horizontal_clicker {bigincrement smallincrement varname minval maxval x y x0 y0 x1 y1} {
	set x [translate_coordinates_finger_down_x $x]
	set y [translate_coordinates_finger_down_y $y]
	set xrange [expr {$x1 - $x0}]
	set xoffset [expr {$x - $x0}]
	set midpoint [expr {$x0 + ($xrange / 2)}]
	set onequarterpoint [expr {$x0 + ($xrange / 5)}]
	set threequarterpoint [expr {$x1 - ($xrange / 5)}]
	if {[info exists $varname] != 1} {
		# if the variable doesn't yet exist, initiialize it with a zero value
		set $varname 0
	}
	set currentval [subst \$$varname]
	set newval $currentval
	if {$x < $onequarterpoint} {
		set newval [expr "1.0 * \$$varname - $bigincrement"]
	} elseif {$x < $midpoint} {
		set newval [expr "1.0 * \$$varname - $smallincrement"]
	} elseif {$x < $threequarterpoint} {
		set newval [expr "1.0 * \$$varname + $smallincrement"]
	} else {
		set newval [expr "1.0 * \$$varname + $bigincrement"]
	}
	set newval [round_to_two_digits $newval]
	if {$newval > $maxval} {
		set $varname $maxval
	} elseif {$newval < $minval} {
		set $varname $minval
	} else {
		set $varname [round_to_two_digits $newval]
	}
	update_onscreen_variables
	return
}

proc DSx_update_saw {} {
    set ::settings(final_desired_shot_weight_advanced) $::DSx_settings(saw)
    set ::settings(final_desired_shot_weight) $::DSx_settings(saw)
    save_settings
    save_DSx_settings

}
proc DSx_volume {} {
    #set ::settings(DSx_volume) [round_to_integer [expr {$::de1(preinfusion_volume) + $::de1(pour_volume)}]]
    set ::settings(DSx_volume) [expr {[round_to_integer $::de1(preinfusion_volume)] + [round_to_integer $::de1(pour_volume)]}]]
    set a [watervolume_text]
    return $a
}

proc save_DSx_flush_time_to_settings {} {
    set ::settings(DSx_flush_time) $::DSx_settings(flush_time)
    save_settings
    save_DSx_settings
}

proc save_dose {} {
    set ::settings(DSx_bean_weight) [round_to_one_digits $::DSx_settings(bean_weight)]
    save_settings
    save_DSx_settings
}

proc DSx_set_dose {} {
    if {$::de1(scale_sensor_weight) < 0} {
        return
    }
    if {($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset)) >= 0 && $::DSx_settings(bean_offset) > 0 && ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset)) < $::DSx_settings(bean_nett_range)} {
        set ::DSx_settings(bean_weight) [expr ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset))]
    } else {
       set ::DSx_settings(bean_weight) $::de1(scale_sensor_weight)
    }
    set ::settings(DSx_bean_weight) [round_to_one_digits $::DSx_settings(bean_weight)]
    save_DSx_settings
    save_settings
    de1_send_steam_hotwater_settings
}

proc jug_toggle {} {
    if {$::DSx_settings(jug_size) == "S"} {
        if {$::DSx_settings(jug_m) > 0} {
            set ::DSx_settings(jug_size) M
            set ::DSx_settings(jug_g) $::DSx_settings(jug_m)
            clear_jug_font
            off_cup
        } elseif {$::DSx_settings(jug_l) > 0} {
            set ::DSx_settings(jug_size) L
            set ::DSx_settings(jug_g) $::DSx_settings(jug_l)
            clear_jug_font
            off_cup
        }
    } elseif {$::DSx_settings(jug_size) == "M"} {
        if {$::DSx_settings(jug_l) > 0} {
            set ::DSx_settings(jug_size) L
            set ::DSx_settings(jug_g) $::DSx_settings(jug_l)
            clear_jug_font
            off_cup
        } elseif {$::DSx_settings(jug_s) > 0} {
            set ::DSx_settings(jug_size) S
            set ::DSx_settings(jug_g) $::DSx_settings(jug_s)
            clear_jug_font
            off_cup
        }
    } elseif {$::DSx_settings(jug_size) == "L"} {
        if {$::DSx_settings(jug_s) > 0} {
            set ::DSx_settings(jug_size) S
            set ::DSx_settings(jug_g) $::DSx_settings(jug_s)
            clear_jug_font
            off_cup
        } elseif {$::DSx_settings(jug_m) > 0} {
            set ::DSx_settings(jug_size) M
            set ::DSx_settings(jug_g) $::DSx_settings(jug_m)
            clear_jug_font
            off_cup
        }
    } else {
        load_test
        page_show DSx_cal
    }
    set ::settings(DSx_jug_size) $::DSx_settings(jug_size)
    save_DSx_settings
}

proc set_jug {} {
    if {$::DSx_settings(jug_size) == { }} {
        if {$::DSx_settings(jug_s) > 20} {
            set ::DSx_settings(jug_size) S
            set ::DSx_settings(jug_g) $::DSx_settings(jug_s)
            clear_jug_font
            off_cup
        } elseif {$::DSx_settings(jug_m) > 20} {
            set ::DSx_settings(jug_size) M
            set ::DSx_settings(jug_g) $::DSx_settings(jug_m)
            clear_jug_font
            off_cup
        } elseif {$::DSx_settings(jug_l) > 20} {
            set ::DSx_settings(jug_size) L
            set ::DSx_settings(jug_g) $::DSx_settings(jug_l)
            clear_jug_font
            off_cup
        }
    }
    if {$::DSx_settings(jug_size) == "S"} {
        set ::DSx_settings(jug_g) $::DSx_settings(jug_s)
    } elseif {$::DSx_settings(jug_size) == "M"} {
        set ::DSx_settings(jug_g) $::DSx_settings(jug_m)
    } else {
        set ::DSx_settings(jug_g) $::DSx_settings(jug_l)
    }
    set ::settings(DSx_jug_size) $::DSx_settings(jug_size)
    save_DSx_settings
}

proc jug_s_cal_text {} {
    if {$::DSx_settings(jug_s) > 0} {
        return "[round_to_integer $::DSx_settings(jug_s)]g"
    } else {
        return "off"
    }
}
proc jug_m_cal_text {} {
    if {$::DSx_settings(jug_m) > 0} {
        return "[round_to_integer $::DSx_settings(jug_m)]g"
    } else {
        return "off"
    }
}
proc jug_l_cal_text {} {
    if {$::DSx_settings(jug_l) > 0} {
        return "[round_to_integer $::DSx_settings(jug_l)]g"
    } else {
        return "off"
    }
}
proc bean_offset_text {} {
    if {$::DSx_settings(bean_offset) > 0} {
        return "[round_to_one_digits $::DSx_settings(bean_offset)]g"
    } else {
        return "off"
    }
}

proc steam_time_calc {} {
    if {$::DSx_settings(jug_g) == { } || $::DSx_settings(jug_g) < 2 || $::DSx_settings(milk_g) < 2 || $::DSx_settings(milk_g) == { } || $::DSx_settings(milk_s) < 2 || $::DSx_settings(milk_s) == { }} {
        load_test
        page_show DSx_cal
    } else {
        set t [expr {$::DSx_settings(milk_s)*1000}]
        set m $::DSx_settings(milk_g)
        set j $::DSx_settings(jug_g)
        set s $::de1(scale_sensor_weight)
        set a [expr {($t/$m*($s-$j))/1000}]
        set ::DSx_settings(steam_calc) [round_to_integer $a]
        if {[expr ($::DSx_settings(steam_calc) > 0)]} {
            if {$::settings(steam_temperature) < 130} {
                set ::settings(steam_temperature) $::DSx_settings(steam_temperature_backup)
            }
            set ::settings(steam_timeout) $::DSx_settings(steam_calc)
            save_settings
            de1_send_steam_hotwater_settings
        }
    }
}
proc set_jug_s {} {
    set ::DSx_settings(jug_s) [round_to_one_digits $::de1(scale_sensor_weight)]
}
proc clear_jug_s {} {
    set ::DSx_settings(jug_s) 0
}
proc set_jug_m {} {
    set ::DSx_settings(jug_m) [round_to_one_digits $::de1(scale_sensor_weight)]
}
proc clear_jug_m {} {
    set ::DSx_settings(jug_m) 0
}
proc set_jug_l {} {
    set ::DSx_settings(jug_l) [round_to_one_digits $::de1(scale_sensor_weight)]
}
proc clear_jug_l {} {
    set ::DSx_settings(jug_l) 0
}
proc set_bean_offset {} {
    set ::DSx_settings(bean_offset) [round_to_one_digits $::de1(scale_sensor_weight)]
}
proc clear_bean_offset {} {
    set ::DSx_settings(bean_offset) 0
}

proc round_to_milk {in} {
	if {[expr ($::de1(scale_sensor_weight) > $::DSx_settings(jug_g))] && $::DSx_settings(jug_g) > 20} {
        set g g
        set x 0
        catch {
            set x [expr {round($in)}]
        }
        return $x$g
    } else {
        return ""
    }
}
proc round_to_bean {in} {


	if {[expr ($::de1(scale_sensor_weight) > ($::DSx_settings(bean_offset) - 0.1)) && $::DSx_settings(bean_offset) > 0 && ($::de1(scale_sensor_weight) - $::DSx_settings(bean_offset)) < $::DSx_settings(bean_nett_range)]} {
        set g g
        set x 0
        catch {
            set x [round_to_one_digits [expr {($in)}]]
        }
        return $x$g
    } elseif {$::DSx_settings(bean_offset) > 0} {
        return "on"
    } else {
        return ""
    }
}


##### Favourite save and load processes

proc startup_fav_check {} {
    if {$::DSx_settings(pink_cup_indicator) == "."} {
        pink_font_set
    } elseif {$::DSx_settings(blue_cup_indicator) == "."} {
        blue_font_set
    } elseif {$::DSx_settings(orange_cup_indicator) == "."} {
        orange_font_set
    }
}

proc DSx_pinkcup_file {} {
    set fn "[skin_directory]/DSx_User_set/pinkcup.fav"
    return $fn
}
proc DSx_bluecup_file {} {
    set fn "[skin_directory]/DSx_User_set/bluecup.fav"
    return $fn
}
proc DSx_orangecup_file {} {
    set fn "[skin_directory]/DSx_User_set/orangecup.fav"
    return $fn
}

proc load_pinkcup {} {
    if {[file exists [skin_directory]/DSx_User_set/pinkcup.fav] != 1} {
        load_test
        page_show DSx_workflow
        } else {
        array set ::settings [encoding convertfrom utf-8 [read_binary_file [DSx_pinkcup_file]]]
        set ::DSx_settings(wsaw) $::settings(DSx_wsaw)
        set ::DSx_settings(jug_size) $::settings(DSx_jug_size)
        set ::DSx_settings(flush_time) $::settings(DSx_flush_time)
        set_jug
        check_steam_on
        set ::DSx_settings(pink_cup_indicator) "."
        set ::DSx_settings(blue_cup_indicator) { }
        set ::DSx_settings(orange_cup_indicator) { }
        saw_switch
        save_DSx_settings
        save_settings
        save_settings_to_de1
        profile_has_changed_set_colors
        update_de1_explanation_chart
        fill_profiles_listbox
        pink_font_set
        LRv2_preview
        DSx_graph_restore
    }
}

proc load_bluecup {} {
    if {[file exists [skin_directory]/DSx_User_set/bluecup.fav] != 1} {
        load_test
        page_show DSx_workflow
        } else {
        array set ::settings [encoding convertfrom utf-8 [read_binary_file [DSx_bluecup_file]]]
        set ::DSx_settings(wsaw) $::settings(DSx_wsaw)
        set ::DSx_settings(jug_size) $::settings(DSx_jug_size)
        set ::DSx_settings(flush_time) $::settings(DSx_flush_time)
        set_jug
        check_steam_on
        set ::DSx_settings(blue_cup_indicator) "."
        set ::DSx_settings(pink_cup_indicator) { }
        set ::DSx_settings(orange_cup_indicator) { }
        saw_switch
        save_DSx_settings
        save_settings
        save_settings_to_de1
        profile_has_changed_set_colors
        update_de1_explanation_chart
        fill_profiles_listbox
        blue_font_set
        LRv2_preview
        DSx_graph_restore
    }
}
proc load_orangecup {} {
    if {[file exists [skin_directory]/DSx_User_set/orangecup.fav] != 1} {
        load_test
        page_show DSx_workflow
        } else {
        array set ::settings [encoding convertfrom utf-8 [read_binary_file [DSx_orangecup_file]]]
        set ::DSx_settings(wsaw) $::settings(DSx_wsaw)
        set ::DSx_settings(jug_size) $::settings(DSx_jug_size)
        set ::DSx_settings(flush_time) $::settings(DSx_flush_time)
        set_jug
        check_steam_on
        set ::DSx_settings(orange_cup_indicator) "."
        set ::DSx_settings(blue_cup_indicator) { }
        set ::DSx_settings(pink_cup_indicator) { }
        saw_switch
        save_DSx_settings
        save_settings
        save_settings_to_de1
        profile_has_changed_set_colors
        update_de1_explanation_chart
        fill_profiles_listbox
        orange_font_set
        LRv2_preview
        DSx_graph_restore
    }
}
proc save_pinkcup {} {
    set profile_vars {DSx_flush_time final_desired_shot_volume_advanced_count_start final_desired_shot_volume final_desired_shot_volume_advanced tank_desired_water_temperature DSx_wsaw DSx_bean_weight DSx_jug_size advanced_shot espresso_chart_over espresso_chart_under espresso_decline_time espresso_hold_time espresso_max_time espresso_notes espresso_pressure espresso_step_1 espresso_step_2 espresso_step_3 espresso_temperature espresso_typical_volume favcup_sequence final_desired_shot_weight final_desired_shot_weight_advanced flow_decline_stop_volumetric flow_hold_stop_volumetric flow_profile_decline flow_profile_decline_time flow_profile_hold flow_profile_hold_time flow_profile_minimum_pressure flow_profile_preinfusion flow_profile_preinfusion_time flow_rate_transition flow_rise_timeout flying goal_is_basket_temp minimum_water_temperature original_profile_title preheat_temperature preinfusion_enabled preinfusion_flow_rate preinfusion_flow_rate2 preinfusion_guarantee preinfusion_stop_flow_rate preinfusion_stop_pressure preinfusion_stop_timeout preinfusion_stop_volumetric preinfusion_temperature preinfusion_time pressure_decline_stop_volumetric pressure_end pressure_hold_stop_volumetric pressure_hold_time pressure_rampup_stop_volumetric pressure_rampup_timeout profile profile_filename profile_has_changed profile_notes profile_step profile_title profile_to_save settings_1_page settings_profile_type steam_timeout temperature_target water_temperature water_volume}
    set fn "[skin_directory]/DSx_User_set/pinkcup.fav"
	if {[save_settings_vars $fn $profile_vars] == 1} {
		update_de1_explanation_chart
	}
	set ::DSx_settings(pink_cup_indicator) "."
    set ::DSx_settings(blue_cup_indicator) { }
    set ::DSx_settings(orange_cup_indicator) { }
    pink_font_set
}
proc save_bluecup {} {
    set profile_vars {DSx_flush_time final_desired_shot_volume_advanced_count_start final_desired_shot_volume final_desired_shot_volume_advanced tank_desired_water_temperature DSx_wsaw DSx_bean_weight DSx_jug_size advanced_shot espresso_chart_over espresso_chart_under espresso_decline_time espresso_hold_time espresso_max_time espresso_notes espresso_pressure espresso_step_1 espresso_step_2 espresso_step_3 espresso_temperature espresso_typical_volume favcup_sequence final_desired_shot_weight final_desired_shot_weight_advanced flow_decline_stop_volumetric flow_hold_stop_volumetric flow_profile_decline flow_profile_decline_time flow_profile_hold flow_profile_hold_time flow_profile_minimum_pressure flow_profile_preinfusion flow_profile_preinfusion_time flow_rate_transition flow_rise_timeout flying goal_is_basket_temp minimum_water_temperature original_profile_title preheat_temperature preinfusion_enabled preinfusion_flow_rate preinfusion_flow_rate2 preinfusion_guarantee preinfusion_stop_flow_rate preinfusion_stop_pressure preinfusion_stop_timeout preinfusion_stop_volumetric preinfusion_temperature preinfusion_time pressure_decline_stop_volumetric pressure_end pressure_hold_stop_volumetric pressure_hold_time pressure_rampup_stop_volumetric pressure_rampup_timeout profile profile_filename profile_has_changed profile_notes profile_step profile_title profile_to_save settings_1_page settings_profile_type steam_timeout temperature_target water_temperature water_volume}
    set fn "[skin_directory]/DSx_User_set/bluecup.fav"
	if {[save_settings_vars $fn $profile_vars] == 1} {
		update_de1_explanation_chart
	}
	set ::DSx_settings(blue_cup_indicator) "."
    set ::DSx_settings(pink_cup_indicator) { }
    set ::DSx_settings(orange_cup_indicator) { }
    blue_font_set
}
proc save_orangecup {} {
    set profile_vars {DSx_flush_time final_desired_shot_volume_advanced_count_start final_desired_shot_volume final_desired_shot_volume_advanced tank_desired_water_temperature DSx_wsaw DSx_bean_weight DSx_jug_size advanced_shot espresso_chart_over espresso_chart_under espresso_decline_time espresso_hold_time espresso_max_time espresso_notes espresso_pressure espresso_step_1 espresso_step_2 espresso_step_3 espresso_temperature espresso_typical_volume favcup_sequence final_desired_shot_weight final_desired_shot_weight_advanced flow_decline_stop_volumetric flow_hold_stop_volumetric flow_profile_decline flow_profile_decline_time flow_profile_hold flow_profile_hold_time flow_profile_minimum_pressure flow_profile_preinfusion flow_profile_preinfusion_time flow_rate_transition flow_rise_timeout flying goal_is_basket_temp minimum_water_temperature original_profile_title preheat_temperature preinfusion_enabled preinfusion_flow_rate preinfusion_flow_rate2 preinfusion_guarantee preinfusion_stop_flow_rate preinfusion_stop_pressure preinfusion_stop_timeout preinfusion_stop_volumetric preinfusion_temperature preinfusion_time pressure_decline_stop_volumetric pressure_end pressure_hold_stop_volumetric pressure_hold_time pressure_rampup_stop_volumetric pressure_rampup_timeout profile profile_filename profile_has_changed profile_notes profile_step profile_title profile_to_save settings_1_page settings_profile_type steam_timeout temperature_target water_temperature water_volume}
    set fn "[skin_directory]/DSx_User_set/orangecup.fav"
	if {[save_settings_vars $fn $profile_vars] == 1} {
		update_de1_explanation_chart
	}
	set ::DSx_settings(orange_cup_indicator) "."
    set ::DSx_settings(blue_cup_indicator) { }
    set ::DSx_settings(pink_cup_indicator) { }
    orange_font_set
}
proc off_cup {} {
	set ::DSx_settings(blue_cup_indicator) { }
    set ::DSx_settings(pink_cup_indicator) { }
    set ::DSx_settings(orange_cup_indicator) { }
    save_DSx_settings
}
############################

proc saw_switch {} {
    if {$::settings(settings_profile_type) == "settings_2c"} {
        set ::DSx_settings(saw) $::settings(final_desired_shot_weight_advanced)
    } else {
        set ::DSx_settings(saw) $::settings(final_desired_shot_weight)
    }
}
############################

proc icon_bg_changer {} {
    if {$::DSx_settings(bg_name) == "bg1.jpg"} {
    set ::icon_bg bg1.png
    } elseif {$::DSx_settings(bg_name) == "bg2.jpg"} {
    set ::icon_bg bg2.png
    } elseif {$::DSx_settings(bg_name) == "bg3.jpg"} {
    set ::icon_bg bg3.png
    } elseif {$::DSx_settings(bg_name) == "bg4.jpg"} {
    set ::icon_bg bg4.png
    } else {
    set ::icon_bg bg5.png
    }
}

proc dial_config {} {
    icon_bg_changer
    $::dial read "[skin_directory_graphics]/dial/$::icon_bg"
    if {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/cdsvdsv.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/rdsvdsv.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/odedsv.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/cdedsv.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/rdedsv.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/odsvclb.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/cdsvclb.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/rdsvclb.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/odeclb.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/cdeclb.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/rdeclb.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/odsvde.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/cdsvde.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/rdsvde.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/odede.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/cdede.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/rdede.png"
    } else {
        $::dial read "[skin_directory_graphics]/dial/odsvdsv.png"
    }
    restart_set
}

proc dial_config_start {} {
    icon_bg_changer
    $::dial read "[skin_directory_graphics]/dial/$::icon_bg"
    if {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/cdsvdsv.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/rdsvdsv.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/odedsv.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/cdedsv.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 1} {
        $::dial read "[skin_directory_graphics]/dial/rdedsv.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/odsvclb.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/cdsvclb.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/rdsvclb.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/odeclb.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/cdeclb.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 2} {
        $::dial read "[skin_directory_graphics]/dial/rdeclb.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/odsvde.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/cdsvde.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 1 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/rdsvde.png"
    } elseif {$::DSx_settings(bezel) == 1 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/odede.png"
    } elseif {$::DSx_settings(bezel) == 2 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/cdede.png"
    } elseif {$::DSx_settings(bezel) == 3 && $::DSx_settings(icons) == 2 && $::DSx_settings(dial) == 3} {
        $::dial read "[skin_directory_graphics]/dial/rdede.png"
    } else {
        $::dial read "[skin_directory_graphics]/dial/odsvdsv.png"
    }
}
proc DSx_bean_set_on {} {
    if {$::DSx_settings(bean_weight) >= 0 && $::DSx_settings(bean_weight) < 34} {
        set ::DSx_saved_2 Saved
    } else {
        set ::DSx_saved_2 {WARNING - please check your settings!}
    }
}

proc DSx_set_on {} {
    set ::DSx_saved_2 Saved
}
proc DSx_set_off {} {
    set ::DSx_saved_2 {}
}
proc fav_saved_on {} {
    set ::fave_saved {Saved}
}
proc fav_saved_off {} {
    set ::fave_saved { }
}


proc clear_profile_font {} {
    if {$::settings(profile_has_changed) == 1} {
		.can itemconfigure $::DSx_profile_name -fill $::DSx_settings(red)
		} else {
        .can itemconfigure $::DSx_profile_name -fill $::DSx_settings(font_colour)
    }
    clear_sav_font
}
proc clear_bean_font {} {
    .can itemconfigure $::DSx_bean_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_saw_font {} {
    .can itemconfigure $::DSx_saw_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_sav_font {} {
    .can itemconfigure $::DSx_sav_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_flush_font {} {
    .can itemconfigure $::DSx_flush_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_steam_font {} {
    .can itemconfigure $::DSx_steam_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_water_font {} {
    .can itemconfigure $::DSx_water_name -fill $::DSx_settings(font_colour)
    off_cup
}
proc clear_wsaw_font {} {
    .can itemconfigure $::DSx_wsaw_name -fill $::DSx_settings(font_colour)
    off_cup
}

proc clear_jug_font {} {
    .can itemconfigure $::DSx_jug_name -fill $::DSx_settings(font_colour)
    off_cup
}

proc blue_font_set {} {
    .can itemconfigure $::DSx_profile_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_bean_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_saw_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_sav_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_flush_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_steam_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_water_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_wsaw_name -fill $::DSx_settings(blue)
    .can itemconfigure $::DSx_jug_name -fill $::DSx_settings(blue)
}

proc pink_font_set {} {
    .can itemconfigure $::DSx_profile_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_bean_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_saw_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_sav_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_flush_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_steam_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_water_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_wsaw_name -fill $::DSx_settings(pink)
    .can itemconfigure $::DSx_jug_name -fill $::DSx_settings(pink)
}

proc orange_font_set {} {
    .can itemconfigure $::DSx_profile_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_bean_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_saw_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_sav_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_flush_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_steam_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_water_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_wsaw_name -fill $::DSx_settings(orange)
    .can itemconfigure $::DSx_jug_name -fill $::DSx_settings(orange)
}

######################
### Graph zoom and pan
proc DSx_reset_graphs {} {
    set ::DSxv 0;
    set ::DSx_settings(zoomed_y_axis_max) $::DSx_settings(zoomed_y_axis_scale_default);
    set ::DSx_settings(zoomed_y_axis_min) 0
    set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
    set ::DSx_settings(zoomed_y2_axis_min) [expr {$::DSx_settings(zoomed_y_axis_min)*0.5}]
    $::DSx_espresso_zoomed_graph axis configure y -color #008c4c -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min) -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
    $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min) -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8}
    $::DSx_history_left_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min) -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
    $::DSx_history_left_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min) -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8}
    $::DSx_history_right_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min) -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
    $::DSx_history_right_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min) -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8}

}

proc DSx_zoom_in {} {
    if {($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min) > 1)} {
        incr ::DSx_settings(zoomed_y_axis_max) -1
        set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max)
    }
    if {($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min) < 6)} {
        $::DSx_espresso_zoomed_graph axis configure y -majorticks {0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2 4.4 4.6 4.8 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 7.2 7.4 7.6 7.8 8 8.2 8.4 8.6 8.8 9 9.2 9.4 9.6 9.8 10 10.2 10.4 10.6 10.8 11 11.2 11.4 11.6 11.8 12 12.2 12.4 12.6 12.8 13 13.2 13.4 13.6 13.8 14 14.2 14.4 14.6 14.8 15}
        $::DSx_espresso_zoomed_graph axis configure y2 -majorticks {0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 0.1 0.2 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7 7.1 7.2 7.3 7.4 7.5}

    }
}

proc DSx_zoom_out {} {
    if {($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min) < 15)} {
        # 15 is the max Y axis allowed
        if {$::DSx_settings(zoomed_y_axis_max) > 14} {
            incr ::DSx_settings(zoomed_y_axis_min) -1
            set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
            } else {
            incr ::DSx_settings(zoomed_y_axis_max)
            set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
        }
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
    if {($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min) > 5)} {
        $::DSx_espresso_zoomed_graph axis configure y -majorticks {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
        $::DSx_espresso_zoomed_graph axis configure y2 -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8}
    }
}

proc DSx_scroll_up {} {
    if {$::DSx_settings(zoomed_y_axis_min) < 14 && $::DSx_settings(zoomed_y_axis_max) < 15 && ($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min)) >= 1} {
        # 15 is the max Y axis allowed
        incr ::DSx_settings(zoomed_y_axis_min) 1
        incr ::DSx_settings(zoomed_y_axis_max) 1
        set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
        set ::DSx_settings(zoomed_y2_axis_min) [expr {$::DSx_settings(zoomed_y_axis_min)*0.5}]
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}

proc DSx_scroll_down {} {
    if {$::DSx_settings(zoomed_y_axis_min) > 0 && $::DSx_settings(zoomed_y_axis_max) > 1 && ($::DSx_settings(zoomed_y_axis_max) - $::DSx_settings(zoomed_y_axis_min)) >= 1} {
        incr ::DSx_settings(zoomed_y_axis_min) -1
        incr ::DSx_settings(zoomed_y_axis_max) -1
        set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
        set ::DSx_settings(zoomed_y2_axis_min) [expr {$::DSx_settings(zoomed_y_axis_min)*0.5}]
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}

proc DSx_R {} {
    if {$::de1(flow) == 0} {
    return 0.0LΩ
    } else {
    return [round_to_one_digits [expr ($::de1(pressure)/$::de1(flow))]]LΩ
    }
}


################
### Graph buttons
proc DSx_graph_reset_button_text {} {
    if {$::DSx_settings(zoomed_y_axis_max) == $::DSx_settings(zoomed_y_axis_scale_default) && $::DSx_settings(zoomed_y_axis_min) == 0 && $::glt2 > 0} {
        .can itemconfigure $::DSx_graph_reset_button_text -fill #e73249
        return "Zoom Temp."
    } else {
        .can itemconfigure $::DSx_graph_reset_button_text -fill $::DSx_settings(font_colour)
        return "RESET"
    }
}

proc DSx_graph_reset_button {} {
    if {$::DSx_settings(zoomed_y_axis_max) == $::DSx_settings(zoomed_y_axis_scale_default) && $::DSx_settings(zoomed_y_axis_min) == 0 && $::glt2 > 0} {
    set ::DSx_settings(zoomed_y_axis_max) 10
    set ::DSx_settings(zoomed_y_axis_min) 8
    set ::DSx_settings(zoomed_y2_axis_max) [expr {$::DSx_settings(zoomed_y_axis_max)*0.5}]
    set ::DSx_settings(zoomed_y2_axis_min) [expr {$::DSx_settings(zoomed_y_axis_min)*0.5}]
    $::DSx_espresso_zoomed_graph axis configure y -color #e73249 -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min) -majorticks {7 7.2 7.4 7.6 7.8 8 8.2 8.4 8.6 8.8 9 9.2 9.4 9.6 9.8 10}
    $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min) -majorticks {0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8}


    } else {
        DSx_reset_graphs;
    }
}

proc DSx_graph_temp_units_text {} {
    if {$::DSx_settings(zoomed_y_axis_max) == $::DSx_settings(zoomed_y_axis_scale_default) && $::DSx_settings(zoomed_y_axis_min) == 0 || $::glt2 == 0} {
        return ""
    } else {
        if {$::settings(enable_fahrenheit) == 1} {
            return "(x20)°F"
        } else {
            return "(x10)°C"
        }
    }
}


proc push_t1 {} {
    if {$::glt1 > 0} {
        set ::glt1 0
        $::DSx_espresso_zoomed_graph element configure line2_espresso_pressure -linewidth $::glt1
    } else {
        set ::glt1 4
        $::DSx_espresso_zoomed_graph element configure line2_espresso_pressure -linewidth $::glt1
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_t2 {} {
    if {$::glt2 > 0} {
        set ::glt2 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_basket -linewidth $::glt2
    } else {
        set ::glt2 4
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_basket -linewidth $::glt2
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_t3 {} {
    if {$::glt3 > 0} {
        set ::glt3 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_state_change_1 -linewidth $::glt3
    } else {
        set ::glt3 4
        $::DSx_espresso_zoomed_graph element configure line_espresso_state_change_1 -linewidth $::glt3
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_t4 {} {
    if {$::glt4 > 0} {
        set ::glt4 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_weight_2x -linewidth $::glt4
    } else {
        set ::glt4 4
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_weight_2x -linewidth $::glt4
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_t5 {} {
    if {$::glt5 > 0} {
        set ::glt5 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_2x -linewidth $::glt5
    } else {
        set ::glt5 4
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_2x -linewidth $::glt5
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}

proc push_b1 {} {
    if {$::glb1 > 0} {
        set ::glb1 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_resistance -linewidth $::glb1
    } else {
        set ::glb1 2
        $::DSx_espresso_zoomed_graph element configure line_espresso_resistance -linewidth $::glb1
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}

proc push_b2 {} {
    if {$::glb2 > 0} {
        set ::glb2 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_mix -linewidth $::glb2
    } else {
        set ::glb2 2
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_mix -linewidth $::glb2
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_b3 {} {
    if {$::glb3 > 0} {
        set ::glb3 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_goal_2x -linewidth $::glb3
        $::DSx_espresso_zoomed_graph element configure line_espresso_pressure_goal -linewidth $::glb3
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_goal -linewidth $::glb3
    } else {
        set ::glb3 2
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_goal_2x -linewidth $::glb3
        $::DSx_espresso_zoomed_graph element configure line_espresso_pressure_goal -linewidth $::glb3
        $::DSx_espresso_zoomed_graph element configure line_espresso_temperature_goal -linewidth $::glb3
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_b4 {} {
    if {$::glb4 > 0} {
        set ::glb4 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_weight_2x -linewidth $::glb4
    } else {
        set ::glb4 2
        $::DSx_espresso_zoomed_graph element configure line_espresso_weight_2x -linewidth $::glb4
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
proc push_b5 {} {
    if {$::glb5 > 0} {
        set ::glb5 0
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_delta_1 -linewidth $::glb5
    } else {
        set ::glb5 2
        $::DSx_espresso_zoomed_graph element configure line_espresso_flow_delta_1 -linewidth $::glb5
        $::DSx_espresso_zoomed_graph axis configure y -max $::DSx_settings(zoomed_y_axis_max) -min $::DSx_settings(zoomed_y_axis_min)
        $::DSx_espresso_zoomed_graph axis configure y2 -max $::DSx_settings(zoomed_y2_axis_max) -min $::DSx_settings(zoomed_y2_axis_min)
    }
}
#########

proc history_prep {} {
    borg spinner on
    fill_DSx_past_shots_listbox
    fill_DSx_past2_shots_listbox
    page_show DSx_past
    set_DSx_past_shot_scrollbar_dimensions
    set_DSx_past2_shot_scrollbar_dimensions
    DSx_reset_graphs
    borg spinner off
    borg systemui $::android_full_screen_flags
}
#set ::DSx_settings(flow_correction) {on}
proc DSx_past_shot_reference_reset {} {
	DSx_past_espresso_pressure length 0
	DSx_past_espresso_temperature_basket length 0
	DSx_past_espresso_temperature_mix length 0
	DSx_past_espresso_flow length 0
	DSx_past_espresso_flow_weight length 0
	DSx_past_espresso_flow_2x length 0
	DSx_past_espresso_flow_weight_2x length 0
    DSx_past_espresso_resistance length 0
    if {$::settings(enable_fahrenheit) == 1} {
        set ::c_f_adjust 0.05
        } else {
        set ::c_f_adjust 0.1
    }
	if {[info exists ::DSx_settings(DSx_past_espresso_elapsed)] == 1} {
		espresso_elapsed1 length 0
		espresso_elapsed1 append $::DSx_settings(DSx_past_espresso_elapsed)
	    append st [espresso_elapsed1 range end end]
		set ::DSx_settings(DSx_left_shot_time) "[round_to_one_digits [expr ($st+0.05)]] sec"

	}
	DSx_past_espresso_pressure append $::DSx_settings(DSx_past_espresso_pressure)
	if {$::DSx_settings(show_history_temperature) == on} {
	    DSx_past_espresso_temperature_basket append  $::DSx_settings(DSx_past_espresso_temperature_basket)
	}
	DSx_past_espresso_temperature_mix append  $::DSx_settings(DSx_past_espresso_temperature_mix)
	if {$::DSx_settings(DSx_past_espresso_flow) != {} } {
		DSx_past_espresso_flow append $::DSx_settings(DSx_past_espresso_flow)
		foreach flow $::DSx_settings(DSx_past_espresso_flow) pressure1 $::DSx_settings(DSx_past_espresso_pressure) {
			if {$::DSx_settings(flow_correction) != on} {
			    DSx_past_espresso_flow_2x append [expr {2.0 * $flow}]
			    } else {
			    DSx_past_espresso_flow_2x append [expr { (2.0 * $flow) - (pow(($pressure1 - 3.5),3) / (140))}]
			}
		}
	}
    if {$::DSx_settings(show_history_resistance) == on} {

        foreach a $::DSx_settings(DSx_past_espresso_pressure) b $::DSx_settings(DSx_past_espresso_weight) c $::DSx_settings(DSx_past_espresso_flow) {
            set y 0
            catch {
                #set y [expr {((($a/(($c*$c)+($a*0.9)))-2)*5)+11}]
                set y [expr {$a/($c*$c)}]
            }
            DSx_past_espresso_resistance append $y
        }
    }
	if {$::DSx_settings(DSx_past_espresso_flow_weight) != {} } {
		DSx_past_espresso_flow_weight append $::DSx_settings(DSx_past_espresso_flow_weight)
		foreach flow_weight $::DSx_settings(DSx_past_espresso_flow_weight) {
			DSx_past_espresso_flow_weight_2x append [expr {2.0 * $flow_weight}]
		}
	}
    if {[info exists ::DSx_settings(DSx_past_espresso_pressure_goal)] == 1} {
        DSx_past_espresso_pressure_goal length 0
        if {$::DSx_settings(show_history_goal) == on} {
            DSx_past_espresso_pressure_goal append $::DSx_settings(DSx_past_espresso_pressure_goal)
            }
        }
    if {[info exists ::DSx_settings(DSx_past_espresso_flow_goal)] == 1} {
        DSx_past_espresso_flow_goal length 0
        DSx_past_espresso_flow_goal_2x length 0
        if {$::DSx_settings(show_history_goal) == on} {
            DSx_past_espresso_flow_goal append $::DSx_settings(DSx_past_espresso_flow_goal)
            foreach flow_goal $::DSx_settings(DSx_past_espresso_flow_goal) {
                DSx_past_espresso_flow_goal_2x append [expr {2.0 * $flow_goal}]
                }
            }
        }
    if {[info exists ::DSx_settings(DSx_past_espresso_temperature_goal)] == 1} {
        DSx_past_espresso_temperature_goal length 0
        DSx_past_espresso_temperature_goal_01 length 0
        if {$::DSx_settings(show_history_goal) == on && $::DSx_settings(show_history_temperature) == on} {
            DSx_past_espresso_temperature_goal append $::DSx_settings(DSx_past_espresso_temperature_goal)
            foreach temperature_goal $::DSx_settings(DSx_past_espresso_temperature_goal) {
                DSx_past_espresso_temperature_goal_01 append [expr {$::c_f_adjust * $temperature_goal}]
                }
            }
        }
    if {[info exists ::DSx_settings(DSx_past_espresso_temperature_basket)] == 1} {
        DSx_past_espresso_temperature_basket length 0
        DSx_past_espresso_temperature_basket_01 length 0
            if {$::DSx_settings(show_history_temperature) == on} {
            DSx_past_espresso_temperature_basket append $::DSx_settings(DSx_past_espresso_temperature_basket)
            foreach temperature_basket $::DSx_settings(DSx_past_espresso_temperature_basket) {
                DSx_past_espresso_temperature_basket_01 append [expr {$::c_f_adjust * $temperature_basket}]
            }
        }
	}
}

proc DSx_past2_shot_reference_reset {} {
	DSx_past2_espresso_pressure length 0
	DSx_past2_espresso_temperature_basket length 0
	DSx_past2_espresso_temperature_mix length 0
	DSx_past2_espresso_flow length 0
	DSx_past2_espresso_flow_weight length 0
	DSx_past2_espresso_flow_2x length 0
	DSx_past2_espresso_flow_weight_2x length 0
    DSx_past2_espresso_resistance length 0

    if {$::settings(enable_fahrenheit) == 1} {
        set ::c_f_adjust 0.05
        } else {
        set ::c_f_adjust 0.1
    }
	if {[info exists ::DSx_settings(DSx_past2_espresso_elapsed)] == 1} {
		espresso_elapsed2 length 0
		espresso_elapsed2 append $::DSx_settings(DSx_past2_espresso_elapsed)
	    append st [espresso_elapsed2 range end end]
		set ::DSx_settings(DSx_right_shot_time) "[round_to_one_digits [expr ($st+0.05)]] sec"
	}
	DSx_past2_espresso_pressure append $::DSx_settings(DSx_past2_espresso_pressure)
	if {$::DSx_settings(show_history_temperature) == on} {
    	DSx_past2_espresso_temperature_basket append $::DSx_settings(DSx_past2_espresso_temperature_basket)
    }
	DSx_past2_espresso_temperature_mix append $::DSx_settings(DSx_past2_espresso_temperature_mix)
	if {$::DSx_settings(DSx_past2_espresso_flow) != {} } {
		DSx_past2_espresso_flow append $::DSx_settings(DSx_past2_espresso_flow)
		foreach flow $::DSx_settings(DSx_past2_espresso_flow) pressure1 $::DSx_settings(DSx_past2_espresso_pressure) {
            if {$::DSx_settings(flow_correction) != on} {
			    DSx_past2_espresso_flow_2x append [expr {2.0 * $flow}]
			    } else {
			    DSx_past2_espresso_flow_2x append [expr { (2.0 * $flow) - (pow(($pressure1 - 3.5),3) / (140))}]
			}
		}
	}

	if {$::DSx_settings(show_history_resistance) == on} {

        foreach a $::DSx_settings(DSx_past2_espresso_pressure) b $::DSx_settings(DSx_past2_espresso_weight) c $::DSx_settings(DSx_past2_espresso_flow) {
            set y 0
            catch {
                #set y [expr {((($a/(($c*$c)+($a*0.9)))-2)*5)+11}]
                set y [expr {$a/($c*$c)}]
            }
            DSx_past2_espresso_resistance append $y
        }
    }
	if {$::DSx_settings(DSx_past2_espresso_flow_weight) != {} } {
		DSx_past2_espresso_flow_weight append $::DSx_settings(DSx_past2_espresso_flow_weight)
		foreach flow_weight $::DSx_settings(DSx_past2_espresso_flow_weight) {
			DSx_past2_espresso_flow_weight_2x append [expr {2.0 * $flow_weight}]
		}
	}
    if {[info exists ::DSx_settings(DSx_past2_espresso_pressure_goal)] == 1} {
        DSx_past2_espresso_pressure_goal length 0
        if {$::DSx_settings(show_history_goal) == on} {
            DSx_past2_espresso_pressure_goal append $::DSx_settings(DSx_past2_espresso_pressure_goal)
            }
        }
    if {[info exists ::DSx_settings(DSx_past2_espresso_flow_goal)] == 1} {
        DSx_past2_espresso_flow_goal length 0
        DSx_past2_espresso_flow_goal_2x length 0
        if {$::DSx_settings(show_history_goal) == on} {
            DSx_past2_espresso_flow_goal append $::DSx_settings(DSx_past2_espresso_flow_goal)
            foreach flow_goal2 $::DSx_settings(DSx_past2_espresso_flow_goal) {
                DSx_past2_espresso_flow_goal_2x append [expr {2.0 * $flow_goal2}]
                }
            }
        }
    if {[info exists ::DSx_settings(DSx_past2_espresso_temperature_goal)] == 1} {
        DSx_past2_espresso_temperature_goal length 0
        DSx_past2_espresso_temperature_goal_01 length 0
        if {$::DSx_settings(show_history_goal) == on && $::DSx_settings(show_history_temperature) == on} {
            DSx_past2_espresso_temperature_goal append $::DSx_settings(DSx_past2_espresso_temperature_goal)
            foreach temperature_goal2 $::DSx_settings(DSx_past2_espresso_temperature_goal) {
                DSx_past2_espresso_temperature_goal_01 append [expr {$::c_f_adjust * $temperature_goal2}]
                }
            }
        }
    if {[info exists ::DSx_settings(DSx_past2_espresso_temperature_basket)] == 1} {
        DSx_past2_espresso_temperature_basket length 0
        DSx_past2_espresso_temperature_basket_01 length 0
            if {$::DSx_settings(show_history_temperature) == on} {
            DSx_past2_espresso_temperature_basket append $::DSx_settings(DSx_past2_espresso_temperature_basket)
            foreach temperature_basket2 $::DSx_settings(DSx_past2_espresso_temperature_basket) {
                DSx_past2_espresso_temperature_basket_01 append [expr {$::c_f_adjust * $temperature_basket2}]
            }
        }
	}
}

proc history_godshots_switch {} {
    if {$::DSx_settings(history_godshots) == "godshots"} {
    set ::DSx_settings(history_godshots) history
    clear_graph
    } elseif {$::DSx_settings(history_godshots) == "history"} {
    set ::DSx_settings(history_godshots) godshots
    clear_graph
    }
}

proc history_graph_temperature {} {
    if {$::DSx_settings(show_history_temperature) == "on"} {
    set ::DSx_settings(show_history_temperature)  off
    set ::DSx_settings(hist_temp_key) ""
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    } else {
    set ::DSx_settings(show_history_temperature) on
    if {$::settings(enable_fahrenheit) == 1} {
        set ::DSx_settings(hist_temp_key) {Temperature (x20)°F}
        } else {
        set ::DSx_settings(hist_temp_key) {Temperature (x10)°C}
    }
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    }
}

proc history_graph_goal {} {
    if {$::DSx_settings(show_history_goal) == "on"} {
    set ::DSx_settings(show_history_goal)  off
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    } else {
    set ::DSx_settings(show_history_goal) on
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    }
}
proc history_graph_resistance {} {
    if {$::DSx_settings(show_history_resistance) == "on"} {
    set ::DSx_settings(show_history_resistance)  off
    set ::DSx_settings(hist_resistance_key) ""
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    } else {
    set ::DSx_settings(show_history_resistance) on
    set ::DSx_settings(hist_resistance_key) "Resistance"
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    }
}

proc history_flow_correction {} {
    if {$::DSx_settings(flow_correction) == "on"} {
    set ::DSx_settings(flow_correction)  off
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    } else {
    set ::DSx_settings(flow_correction) on
    fill_DSx_past_shots_listbox;
    load_DSx_past_shot;
    fill_DSx_past2_shots_listbox;
    load_DSx_past2_shot;
    }
}

proc clear_graph {} {
    set ::DSx_settings(DSx_past2_espresso_pressure) {0.0}
    set ::DSx_settings(DSx_past2_espresso_temperature_basket) {0.0}
    set ::DSx_settings(DSx_past2_espresso_temperature_mix) {0.0}
    set ::DSx_settings(DSx_past2_espresso_flow) {0.0}
    set ::DSx_settings(DSx_past2_espresso_flow_weight) {0.0}
    set ::DSx_settings(DSx_past2_espresso_weight) {0.0}
    set ::DSx_settings(DSx_past2_espresso_elapsed) {0.0}
    set ::DSx_settings(shot_date_time2) {}
    set ::DSx_settings(drink_weight2) 0
    set ::DSx_settings(past_bean_weight2) 0
    set ::DSx_settings(past_profile_title2) {no profile data}
    set ::DSx_settings(DSx_past2_espresso_flow_goal) {0.0}
    set ::DSx_settings(DSx_past2_espresso_pressure_goal) {0.0}
    set ::DSx_settings(DSx_past2_espresso_temperature_goal) {0.0}

    set ::DSx_settings(past_sav_all) 0
    set ::DSx_settings(past_sav_drops) 0
    set ::DSx_settings(past_sav_out) 0
    save_DSx_settings
    DSx_past2_shot_reference_reset
    set DSx_pastprops2(name) ""
    set ::DSx_settings(DSx_past2_espresso_name) ""
}

proc DSx_past_shot_files {} {
	set files [lsort -dictionary [glob -nocomplain -tails -directory "[homedir]/history/" *.shot]]
	set dd {}
	foreach f $files {
	    set fn "[homedir]/history/$f"
	    array unset -nocomplain DSx_pastprops
	    array set DSx_pastprops [read_file $fn]
	    set name [ifexists DSx_pastprops(name)]
	    if {$name == "None"} {
	    	set name [translate "None"]
	    } elseif {$name == ""} {
	    	set name [file rootname $f]
	    }
		lappend dd $name $f
	}
	return $dd
}

proc DSx_past2_shot_files {} {
	set files [lsort -dictionary [glob -nocomplain -tails -directory "[homedir]/$::DSx_settings(history_godshots)/" *.shot]]
	if {$::DSx_settings(history_godshots) == "history"} {
	    set ::DSx_settings(list_order) -decreasing
	    } else {
	    set ::DSx_settings(list_order) -increasing
	}
	set dd2 {}
	foreach f2 $files {
	    set fn2 "[homedir]/$::DSx_settings(history_godshots)/$f2"
	    array unset -nocomplain DSx_pastprops2
	    array set DSx_pastprops2 [read_file $fn2]
	    set name [ifexists DSx_pastprops2(name)]
	    if {$name == "None"} {
	    	set name [translate "None"]
	    } elseif {$name == ""} {
	    	set name [file rootname $f2]
	    }
		lappend dd2 $name $f2
	}
	return $dd2
}



proc fill_DSx_past_shots_listbox {} {
	unset -nocomplain ::DSx_past_shot_filenames
	set widget $::globals(DSx_past_shots_widget)
	$widget delete 0 99999
	set cnt 0
	array set DSx_past_shot_files_array [DSx_past_shot_files]
	foreach desc [lsort -decreasing -dictionary [array names DSx_past_shot_files_array]] {
		set fn $DSx_past_shot_files_array($desc)
		$widget insert $cnt $desc
		set ::DSx_past_shot_filenames($cnt) $fn
		if {$desc == $::DSx_settings(DSx_past_espresso_name)} {
			$widget selection set $cnt
			load_DSx_past_shot 1
		}
		incr cnt
	}
}

proc fill_DSx_past2_shots_listbox {} {
	unset -nocomplain ::DSx_past2_shot_filenames
	set widget $::globals(DSx_past2_shots_widget)
	$widget delete 0 99999
	set cnt 0
	array set DSx_past2_shot_files_array [DSx_past2_shot_files]
	foreach desc [lsort $::DSx_settings(list_order) -dictionary [array names DSx_past2_shot_files_array]] {
		set fn $DSx_past2_shot_files_array($desc)
		$widget insert $cnt $desc
		set ::DSx_past2_shot_filenames($cnt) $fn
		if {$desc == $::DSx_settings(DSx_past2_espresso_name)} {
			$widget selection set $cnt
			load_DSx_past2_shot 1
		}
		incr cnt
	}
}

proc load_DSx_past_shot { {force 0} } {
	if {$::de1(current_context) != "DSx_past" && $force == 0} {
		return
	}
	set stepnum [$::globals(DSx_past_shots_widget) curselection]
	if {$stepnum == ""} {
		return
	}
	set f [ifexists ::DSx_past_shot_filenames($stepnum)]
	if {$stepnum == ""} {
		return
	}
	set fn "[homedir]/history/$f"
	array unset -nocomplain DSx_pastprops
	array set DSx_pastprops [read_file $fn]
    set ::DSx_settings(DSx_past_espresso_pressure) $DSx_pastprops(espresso_pressure)
    if {$::DSx_settings(show_history_temperature) == on} {
        set ::DSx_settings(DSx_past_espresso_temperature_basket) $DSx_pastprops(espresso_temperature_basket)
        }
    set ::DSx_settings(DSx_past_espresso_temperature_mix) $DSx_pastprops(espresso_temperature_mix)
    set ::DSx_settings(DSx_past_espresso_flow_weight) $DSx_pastprops(espresso_flow_weight)
    set ::DSx_settings(DSx_past_espresso_flow) $DSx_pastprops(espresso_flow)
    set ::DSx_settings(DSx_past_espresso_weight) $DSx_pastprops(espresso_weight)
    if {[llength [ifexists DSx_pastprops(espresso_elapsed)]] > 0} {
    	set ::DSx_settings(DSx_past_espresso_elapsed) $DSx_pastprops(espresso_elapsed)
    }
    if {[info exists DSx_pastprops(espresso_temperature_goal)] == 1} {
        if {$::DSx_settings(show_history_goal) == on} {
            set ::DSx_settings(DSx_past_espresso_pressure_goal) $DSx_pastprops(espresso_pressure_goal)
            set ::DSx_settings(DSx_past_espresso_flow_goal) $DSx_pastprops(espresso_flow_goal)
            if {$::DSx_settings(show_history_temperature) == on} {
                set ::DSx_settings(DSx_past_espresso_temperature_goal) $DSx_pastprops(espresso_temperature_goal)
            }
        }
    } else {
        set ::DSx_settings(DSx_past_espresso_pressure_goal) {0.0}
        set ::DSx_settings(DSx_past_espresso_flow_goal) {0.0}
        set ::DSx_settings(DSx_past_espresso_temperature_goal) {0.0}
    }
    array set DSx_past_sets $DSx_pastprops(settings)
    set ::DSx_settings(drink_weight) $DSx_past_sets(drink_weight)
    if {[info exists DSx_past_sets(DSx_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight) [round_to_one_digits $DSx_past_sets(DSx_bean_weight)]
        } elseif {[info exists DSx_past_sets(dsv4_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight) $DSx_past_sets(dsv4_bean_weight)
        } elseif {[info exists DSx_past_sets(dsv3_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight) $DSx_past_sets(dsv3_bean_weight)
        } elseif {[info exists DSx_past_sets(dsv2_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight) $DSx_past_sets(dsv2_bean_weight)
        } else {
            set ::DSx_settings(past_bean_weight) 0
        }
    set ::DSx_settings(past_profile_title) $DSx_past_sets(profile_title)
    set ::DSx_settings(shot_date_time) [clock format $DSx_pastprops(clock) -format {%a, %d %b %Y   %I:%M%p}]

    if {[info exists DSx_past_sets(DSx_sav_out)] == 1} {
            set ::DSx_settings(past_sav_all) $DSx_past_sets(DSx_sav_all)
            set ::DSx_settings(past_sav_drops) $DSx_past_sets(DSx_sav_drops)
            set ::DSx_settings(past_sav_out) $DSx_past_sets(DSx_sav_out)
        } else {
            set ::DSx_settings(past_sav_all) 0
            set ::DSx_settings(past_sav_drops) 0
            set ::DSx_settings(past_sav_out) 0
        }
    array set DSx_past_mach $DSx_pastprops(machine)
    if {[info exists DSx_past_mach(preinfusion_volume)] == 1} {
            set ::DSx_settings(past_volume1) [expr {$DSx_past_mach(preinfusion_volume) + $DSx_past_mach(pour_volume)}]
        } else {
            set ::DSx_settings(past_volume1) 0
    }


    save_DSx_settings
    reset_messages
    DSx_past_shot_reference_reset
	DSx_current_listbox_item $::globals(DSx_past_shots_widget)
    if {[info exists DSx_pastprops(name)] != 1} {
        set DSx_pastprops(name) [file rootname $f]
    }
    set ::DSx_settings(DSx_past_espresso_name) $DSx_pastprops(name)
}

proc load_DSx_past2_shot { {force 0} } {
	if {$::de1(current_context) != "DSx_past" && $force == 0} {
		return
	}
	set stepnum [$::globals(DSx_past2_shots_widget) curselection]
	if {$stepnum == ""} {
		return
	}
	set f2 [ifexists ::DSx_past2_shot_filenames($stepnum)]
	if {$stepnum == ""} {
		return
	}
	set fn2 "[homedir]/$::DSx_settings(history_godshots)/$f2"
	array unset -nocomplain DSx_pastprops2
	array set DSx_pastprops2 [read_file $fn2]
    set ::DSx_settings(DSx_past2_espresso_pressure) $DSx_pastprops2(espresso_pressure)
        if {$::DSx_settings(show_history_temperature) == on} {
            set ::DSx_settings(DSx_past2_espresso_temperature_basket) $DSx_pastprops2(espresso_temperature_basket)
        }
    set ::DSx_settings(DSx_past2_espresso_temperature_mix) $DSx_pastprops2(espresso_temperature_mix)
    set ::DSx_settings(DSx_past2_espresso_flow_weight) $DSx_pastprops2(espresso_flow_weight)
    set ::DSx_settings(DSx_past2_espresso_flow) $DSx_pastprops2(espresso_flow)
    set ::DSx_settings(DSx_past2_espresso_weight) $DSx_pastprops2(espresso_weight)
    if {[llength [ifexists DSx_pastprops2(espresso_elapsed)]] > 0} {
    	set ::DSx_settings(DSx_past2_espresso_elapsed) $DSx_pastprops2(espresso_elapsed)
    }
    if {[info exists DSx_pastprops2(espresso_temperature_goal)] == 1} {
        if {$::DSx_settings(show_history_goal) == on} {
            set ::DSx_settings(DSx_past2_espresso_pressure_goal) $DSx_pastprops2(espresso_pressure_goal)
            set ::DSx_settings(DSx_past2_espresso_flow_goal) $DSx_pastprops2(espresso_flow_goal)
            if {$::DSx_settings(show_history_temperature) == on} {
                set ::DSx_settings(DSx_past2_espresso_temperature_goal) $DSx_pastprops2(espresso_temperature_goal)
            }
        }
    } else {
        set ::DSx_settings(DSx_past2_espresso_pressure_goal) {0.0}
        set ::DSx_settings(DSx_past2_espresso_flow_goal) {0.0}
        set ::DSx_settings(DSx_past2_espresso_temperature_goal) {0.0}
    }

    if {[info exists DSx_pastprops2(settings)] == 1} {
        array set DSx_past_sets2 $DSx_pastprops2(settings)
        set ::DSx_settings(drink_weight2) $DSx_past_sets2(drink_weight)
        if {[info exists DSx_past_sets2(DSx_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) [round_to_one_digits $DSx_past_sets2(DSx_bean_weight)]
        } elseif {[info exists DSx_past_sets2(dsv4_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_past_sets2(dsv4_bean_weight)
        } elseif {[info exists DSx_past_sets2(dsv3_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_past_sets2(dsv3_bean_weight)
        } elseif {[info exists DSx_past_sets2(dsv2_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_past_sets2(dsv2_bean_weight)
        } else {
            set ::DSx_settings(past_bean_weight2) 0
        }
        set ::DSx_settings(past_profile_title2) $DSx_past_sets2(profile_title)

        array set DSx_past_mach2 $DSx_pastprops2(machine)
        if {[info exists DSx_past_mach2(preinfusion_volume)] == 1} {
            set ::DSx_settings(past_volume2) [expr {$DSx_past_mach2(preinfusion_volume) + $DSx_past_mach2(pour_volume)}]
        } else {
            set ::DSx_settings(past_volume2) 0
        }

    } else {
        if {[info exists DSx_pastprops2(drink_weight)] == 1} {
            set ::DSx_settings(drink_weight2) $DSx_pastprops2(drink_weight)
        } else {
            set ::DSx_settings(drink_weight2) 0
        }
        if {[info exists DSx_pastprops2(DSx_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) [round_to_one_digits $DSx_pastprops2(DSx_bean_weight)]
        } elseif {[info exists DSx_pastprops2(dsv4_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_pastprops2(dsv4_bean_weight)
        } elseif {[info exists DSx_pastprops2(dsv3_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_pastprops2(dsv3_bean_weight)
        } elseif {[info exists DSx_pastprops2(dsv2_bean_weight)] == 1} {
            set ::DSx_settings(past_bean_weight2) $DSx_pastprops2(dsv2_bean_weight)
        } else {
            set ::DSx_settings(past_bean_weight2) 0
        }
        if {[info exists DSx_pastprops2(profile_title)] == 1} {
            set ::DSx_settings(past_profile_title2) $DSx_pastprops2(profile_title)
        } else {
            set ::DSx_settings(past_profile_title2) "no profile data"
        }
    }

    set ::DSx_settings(shot_date_time2) [clock format $DSx_pastprops2(clock) -format {%a, %d %b %Y   %I:%M%p}]
    save_DSx_settings
    reset_messages
    DSx_past2_shot_reference_reset
	DSx_current_listbox_item $::globals(DSx_past2_shots_widget)
    if {[info exists DSx_pastprops2(name)] != 1} {
        set DSx_pastprops2(name) [file rootname $f2]
    }
    set ::DSx_settings(DSx_past2_espresso_name) $DSx_pastprops2(name)
}

proc DSx_save_h2g {} {
	set ::DSx_message ""
	save_DSx_settings
	set clock [clock seconds]
	set filename [subst {[clock format $clock -format "%Y%m%dT%H%M%S"].shot}]
	set files [lsort -dictionary [glob -nocomplain -tails -directory "[homedir]/godshots/" *.shot]]
	foreach fg $files {
	    set fng "[homedir]/godshots/$fg"
	    array unset -nocomplain godpropsg
	    array set godpropsg [read_file $fng]
	    if {[ifexists godpropsg(name)] == $::DSx_settings(DSx_past2_espresso_name)} {
	    	set ::DSx_message "Ooops!    That name is already taken..."
            }
        }
        if {$::DSx_settings(DSx_past2_espresso_name) == ""} {
            set ::DSx_message "Ooops!    You forgot to enter a name..."
        }
        if {$::DSx_message == ""} {
        set espresso_data {}
        append espresso_data "filename [list $filename]\n"
        append espresso_data "name [list $::DSx_settings(DSx_past2_espresso_name)]\n"
        append espresso_data "clock $clock\n"
        append espresso_data "espresso_elapsed {$::DSx_settings(DSx_past_espresso_elapsed)}\n"
        append espresso_data "espresso_pressure {$::DSx_settings(DSx_past_espresso_pressure)}\n"
        append espresso_data "espresso_weight {$::DSx_settings(DSx_past_espresso_weight)}\n"
        append espresso_data "espresso_flow {$::DSx_settings(DSx_past_espresso_flow)}\n"
        append espresso_data "espresso_flow_weight {$::DSx_settings(DSx_past_espresso_flow_weight)}\n"
        append espresso_data "espresso_temperature_basket {$::DSx_settings(DSx_past_espresso_temperature_basket)}\n"
        append espresso_data "espresso_temperature_mix {$::DSx_settings(DSx_past_espresso_temperature_mix)}\n"
        append espresso_data "espresso_temperature_goal {$::DSx_settings(DSx_past_espresso_temperature_goal)}\n"
        append espresso_data "espresso_pressure_goal {$::DSx_settings(DSx_past_espresso_pressure_goal)}\n"
        append espresso_data "espresso_flow_goal {$::DSx_settings(DSx_past_espresso_flow_goal)}\n"
	    append espresso_data "drink_weight {$::DSx_settings(drink_weight)}\n"
	    append espresso_data "DSx_bean_weight {$::DSx_settings(past_bean_weight)}\n"
	    append espresso_data "profile_title {$::DSx_settings(past_profile_title)}\n"
        set fng "[homedir]/godshots/$filename"
        write_file $fng $espresso_data
        fill_god_shots_listbox
        fill_DSx_past_shots_listbox;
        fill_DSx_past2_shots_listbox;
        set_next_page off off;
        page_show DSx_past;
        set_DSx_past_shot_scrollbar_dimensions;
        set_DSx_past2_shot_scrollbar_dimensions;
        DSx_past2_shot_files
    }
}

proc DSx_archive {} {
    if {[file exists [homedir]/history/$::DSx_settings(DSx_past_espresso_name).shot] != 1} {
        set ::DSx_message2 "file $::DSx_settings(DSx_past_espresso_name) does not exist"
        } else {
        borg spinner on
        file copy -force [homedir]/history/$::DSx_settings(DSx_past_espresso_name).shot [homedir]/history_archive/$::DSx_settings(DSx_past_espresso_name).shot
        after 1000
        file delete -force [homedir]/history/$::DSx_settings(DSx_past_espresso_name).shot
        borg spinner off
        borg systemui $::android_full_screen_flags
        fill_DSx_past_shots_listbox;
        fill_DSx_past2_shots_listbox
    }
}

proc reset_messages {} {
        set ::DSx_message ""
        set ::DSx_message2 ""
}

proc history_vars {} {
    if {[info exists ::DSx_settings(home_show_history)] != 1} {
        set ::DSx_settings(home_show_history) {1}
    }
    if {[info exists ::DSx_settings(graph_weight_total)] != 1} {
        set ::DSx_settings(graph_weight_total) {0}
    }
    if {[info exists ::DSx_settings(DSx_past2_espresso_elapsed)] != 1} {
        set ::DSx_settings(DSx_past2_espresso_elapsed) {0.0}
        set ::DSx_settings(DSx_past2_espresso_filename) {}
        set ::DSx_settings(DSx_past2_espresso_flow) {0.0}
        set ::DSx_settings(DSx_past2_espresso_flow_weight) {0.0}
        set ::DSx_settings(DSx_past2_espresso_name) none
        set ::DSx_settings(DSx_past2_espresso_pressure) {0.0}
        set ::DSx_settings(DSx_past2_espresso_temperature_basket) {0.0}
        set ::DSx_settings(DSx_past2_espresso_temperature_mix) {0.0}
        set ::DSx_settings(DSx_past2_espresso_weight) {0.0}
        set ::DSx_settings(DSx_past_espresso_elapsed) {0.0}
        set ::DSx_settings(DSx_past_espresso_filename) {}
        set ::DSx_settings(DSx_past_espresso_flow) {0.0}
        set ::DSx_settings(DSx_past_espresso_flow_weight) {0.0}
        set ::DSx_settings(DSx_past_espresso_name) none
        set ::DSx_settings(DSx_past_espresso_pressure) {0.0}
        set ::DSx_settings(DSx_past_espresso_temperature_basket) {0.0}
        set ::DSx_settings(DSx_past_espresso_weight) {0.0}
        set ::DSx_settings(DSx_past_espresso_temperature_mix) {0.0}
    }
    if {[info exists ::DSx_settings(hist_temp_key)] != 1} {
        set ::DSx_settings(history_godshots) history
        set ::DSx_settings(original_profile_title) { }
        set ::DSx_settings(past_profile_title) { }
        set ::DSx_settings(profile_title) { }
        set ::DSx_settings(hist_temp_key) {Temperature (x10)°C}
        set ::DSx_settings(past_profile_title2) { }
        set ::DSx_settings(shot_date_time) {choose a file from the list}
        set ::DSx_settings(shot_date_time2) { }
        set ::DSx_settings(show_history_temperature) off
        set ::DSx_settings(show_history_goal) off
        set ::DSx_settings(drink_weight) 0
        set ::DSx_settings(drink_weight2) 0
    }
    if {[info exists ::DSx_settings(past_bean_weight)] != 1} {
        set ::DSx_settings(past_bean_weight) 0
    }
    if {[info exists ::DSx_settings(past_bean_weight2)] != 1} {
        set ::DSx_settings(past_bean_weight2) 0
    }
    if {[info exists ::DSx_settings(list_order)] != 1} {
        set ::DSx_settings(list_order) -decreasing
    }
    if {[info exists [homedir]/history_archive] != 1} {
        set path [homedir]/history_archive
        file mkdir $path
        file attributes $path
    }
    if {[info exists ::DSx_settings(DSx_past2_espresso_pressure_goal] != 1} {
            set ::DSx_settings(DSx_past_espresso_pressure_goal) {0.0}
            set ::DSx_settings(DSx_past_espresso_flow_goal) {0.0}
            set ::DSx_settings(DSx_past_espresso_temperature_goal) {0.0}
            set ::DSx_settings(DSx_past2_espresso_pressure_goal) {0.0}
            set ::DSx_settings(DSx_past2_espresso_flow_goal) {0.0}
            set ::DSx_settings(DSx_past2_espresso_temperature_goal) {0.0}
    }

    if {$::settings(enable_fahrenheit) == 1 && $::DSx_settings(hist_temp_key) == {Temperature (x10)°C}} {
        set ::DSx_settings(hist_temp_key) {Temperature (x20)°F}
        } elseif {$::settings(enable_fahrenheit) != 1 && $::DSx_settings(hist_temp_key) == {Temperature (x20)°F}} {
        set ::DSx_settings(hist_temp_key) {Temperature (x10)°C}
    }
    if {[info exists ::DSx_settings(DSx_left_shot_time)] != 1} {
        set ::DSx_settings(DSx_left_shot_time) 0
        set ::DSx_settings(DSx_right_shot_time) 0
    }
    save_DSx_settings
    save_settings
}

proc restart_set {} {
    set ::restart 1
}

### stop hot water by weight
proc save_wsaw_to_settings {} {
    set ::settings(DSx_wsaw) $::DSx_settings(wsaw)
    save_settings
}

proc wsaw_value {} {
    if {($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > 0 } {
        return $::DSx_settings(wsaw)g
    } else {
        return "off"
    }
}
proc wsaw_fav_indicator {} {
    if {($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > 0 } {
        return "*"
    } else {
        return ""
    }
}
proc wsaw_text {} {
    if {($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > 0 } {
        return "Water SAW - $::DSx_settings(wsaw)g"
    } else {
        return ""
    }
}
proc wsaw_warning {} {
    if {($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > [expr ($::settings(water_volume) * 0.7)]} {
        return "Check water volume"
    } else {
        return ""
    }
}
proc wsaw_cal_value {} {
    if {($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > 0 } {
        return $::DSx_settings(wsaw_cal)g
    } else {
        return "off"
    }
}

proc DSx_espresso {} {
    start_LRv2_presets
    clear_temp_data
    set ::current_espresso_page off
    set_next_page off off
    start_espresso
    cancel_auto_stop
}

proc DSx_steam {} {
    if {[start_button_ready] == [translate "READY"] && $::settings(steam_timeout) > 0} {
        DSx_reset_graphs
        set_next_page steam steam
        start_steam
        cancel_auto_stop
    }
    if {$::settings(steam_timeout) == 0 || [start_button_ready] == [translate "WAIT"]} {
        steam_off_message
    }
}

proc steam_off_message {} {
    if {$::settings(steam_timeout) == 0} {
        set ::steam_off_message [translate "Steam is turned off"]
        after 2000 {set ::steam_off_message ""}
    } else {
        set ::steam_off_message [translate "Wait... still heating"]
        after 2000 {set ::steam_off_message ""}
    }
}

proc DSx_water {} {
    if {[start_button_ready] == [translate "READY"]} {
        if {$::settings(scale_bluetooth_address) != ""} {
            set ::wsaw_run 0;
            skale_tare;
            #page_show water;
            after 600 {set_next_page water water; start_water; set ::wsaw_run 1};
        } else {
            set_next_page water water
            start_water
        }
        cancel_auto_stop
    }
}

proc DSx_flush_time_display {} {
    if {[DSx_flush_time] <= 0} {
    return ""
    } else {
    return [DSx_flush_time]
    }
}

proc DSx_flush_time {} {
    set flush_timer [expr {$::DSx_settings(flush_time) - ([clock seconds] - $::DSx_timer_start) + $::DSx_flush_time2}]
    if {$flush_timer >= 0} {
        return [round_to_integer $flush_timer]
    } else {
        return 0
    }
}
set ::flush_counting 0
proc DSx_loop {} {

    if {$::DSx_timer_reset == 1 && $::flush_counting != 1} {
            set ::flush_counting 1
	        set ::DSx_timer_start [clock seconds]
	        set ::DSx_timer_reset 0

	}
    if {$::flush_run == 1 && $::de1_num_state($::de1(state)) == "HotWaterRinse"} {
        if {$::DSx_settings(flush_time) + [DSx_flush_time] <= $::DSx_settings(flush_time)} {
            #set ::flush_run 0
            DSx_stop
        }
    }
	if {[info exists ::DSx_loop_1] == 1} {
		after cancel $::DSx_loop_1
		unset ::DSx_loop_1
	}
	if {$::flush_run == 0} {
        set ::flush_counting 0
        return
    }
	set ::DSx_loop_1 [after 100 DSx_loop]
}

proc DSx_flush {} {
    set_next_page hotwaterrinse preheat_2;
    start_hot_water_rinse;
    cancel_auto_stop
}
proc DSx_flush_extend {} {
    if {$::DSx_flush_time2 == 0 && $::DSx_settings(flush_time2) > 0} {
        set ::DSx_flush_time2 $::DSx_settings(flush_time2)
    } elseif {$::de1_num_state($::de1(state)) == "HotWaterRinse"} {
        DSx_stop;
    }
}

proc DSx_flush_time_extend_text {} {
    if {$::DSx_settings(flush_time2) > 0 } {
        return [round_to_integer $::DSx_settings(flush_time2)]s
    } else {
        return "off"
    }
}

proc DSx_add_flush_time_extend_text {} {
    if {$::DSx_flush_time2 == 0 && $::DSx_settings(flush_time2) > 0} {
        return +[round_to_integer $::DSx_settings(flush_time2)]s
    } else {
        return ""
    }
}

#########
proc wsaw {} {
    if {$::wsaw_run == 1 && $::settings(scale_bluetooth_address) != "" && ($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal)) > 1} {
        if {$::de1(scale_sensor_weight) > ($::DSx_settings(wsaw) - $::DSx_settings(wsaw_cal))} {
            set ::wsaw_run 0
            #wsaw_stop_water
            DSx_stop
        }
    }
}

proc wsaw_stop_water {} {
    set_next_page off off;
    start_idle;
}
proc DSx_stop {} {
    set ::DSx_timer_start 0
    set ::flush_run 0
    set ::wsaw_run 0
    set_next_page off off
    start_idle
}

set ::DSx_blink2 1
proc DSx_low_water {} {
    if {[expr $::de1(water_level) < {$::settings(water_refill_point) + 3}]} {
        if {$::DSx_blink2 == 1} {
                after 400 {set ::DSx_blink2 0}
                return ""
            } else {
                set ::DSx_blink2 1
                return "[water_tank_level_to_milliliters $::de1(water_level)] [translate mL]"
            }
	    }
	return "[water_tank_level_to_milliliters $::de1(water_level)] [translate mL] "
}

proc heading_colour_picker {} {
    set colour [tk_chooseColor -initialcolor $::DSx_settings(heading_colour) -title "Set heading colour"]
    if {$colour != {}} {
        set ::DSx_settings(heading_colour) $colour
        save_DSx_settings
        .can itemconfigure $::DSx_heading -fill $::DSx_settings(heading_colour)
        $::DSx_heading_entry configure -foreground $::DSx_settings(heading_colour)
    }
}

proc DSx_font_selection {} {
    #{{Text Files}       {.txt}        }
    #{{TCL Scripts}      {.tcl}        }
    #{{C Source Files}   {.c}      TEXT}
    #{{GIF Files}        {.gif}        }
    #{{GIF Files}        {}        GIFF}
    #{{All Files}        *             }

    set basedir [skin_directory]/DSx_Font_Files
    set types {
        {{Font Files}       {.ttf}        }
        {{Font Files}       {.otf}        }
    }
    set filename [tk_getOpenFile -filetypes $types -initialdir $basedir]

    if {$filename != ""} {
        set tn [file tail $filename]
        set rn [file rootname $tn]
        set ::DSx_settings(font_name) $rn

        set fd [file dirname $filename]
        set ::DSx_settings(font_dir) $fd
        restart_set
        save_DSx_settings
        set_colour

    }
}

proc DSx_load_font {name fn pcsize {androidsize {}} } {
    # calculate font size # Code credit to Barney
    if {$::DSx_settings(font_name) == "GochiHand-Regular"} {
            set offset 1.24
        } elseif { $::DSx_settings(font_name) == "Bradley Hand Bold"} {
            set offset 1.14
        } else {
            set offset 1
    }
    if {$::android == 1} {
        set f 2.19
    } else {
        set f 2
    }
    if {($::android == 1 || $::undroid == 1) && $androidsize != ""} {
        set pcsize $androidsize
    }
    set platform_font_size [expr {int(1.0 * $::fontm * $pcsize * $f * $offset)}]

    if {[language] == "zh-hant" || [language] == "zh-hans"} {
        set fn ""
        set familyname $::helvetica_font
    } elseif {[language] == "th"} {
        set fn "[homedir]/fonts/sarabun.ttf"
    }
    if {[info exists ::loaded_fonts] != 1} {
        set ::loaded_fonts list
    }
    set fontindex [lsearch $::loaded_fonts $fn]
    if {$fontindex != -1} {
        set familyname [lindex $::loaded_fonts [expr $fontindex + 1]]
    } elseif {($::android == 1 || $::undroid == 1) && $fn != ""} {
        catch {
            set familyname [lindex [sdltk addfont $fn] 0]
        }
        lappend ::loaded_fonts $fn $familyname
    }
    if {[info exists familyname] != 1 || $familyname == ""} {
        msg "Font familyname not available; using name '$name'."
        set familyname $name
    }
    catch {
        font create $name -family $familyname -size $platform_font_size
    }
    msg "added font name: \"$name\" family: \"$familyname\" size: $platform_font_size filename: \"$fn\""
}

proc DSx_font {font_name size} {

    if {$font_name == "font"} {
        set font_name $::DSx_settings(font_name)
    }
    if {[info exists ::skin_fonts] != 1} {
        set ::skin_fonts list
    }
    set font_key "$font_name $size DSx"
    set font_index [lsearch $::skin_fonts $font_key]
    if {$font_index == -1} {

        # support for both OTF and TTF files


        if {[file exists "$::DSx_settings(font_dir)/$font_name.otf"] == 1} {
            DSx_load_font $font_key "$::DSx_settings(font_dir)/$font_name.otf" $size
            lappend ::skin_fonts $font_key
        } elseif {[file exists "$::DSx_settings(font_dir)/$font_name.ttf"] == 1} {
            DSx_load_font $font_key "$::DSx_settings(font_dir)/$font_name.ttf" $size
            lappend ::skin_fonts $font_key
        } elseif {[file exists "[skin_directory]/DSx_Font_Files/$font_name.otf"] == 1} {
            DSx_load_font $font_key "[skin_directory]/DSx_Font_Files/$font_name.otf" $size
            lappend ::skin_fonts $font_key
        } elseif {[file exists "[skin_directory]/DSx_Font_Files/$font_name.ttf"] == 1} {
            DSx_load_font $font_key "[skin_directory]/DSx_Font_Files/$font_name.ttf" $size
            lappend ::skin_fonts $font_key
        } else {
            msg "Unable to load font '$font_key'"
        }
    }
    return $font_key
}

proc DSx_clock_font {} {
    if {$::DSx_settings(original_clock_font) == 1} {
        set ::DSx_settings(clock_font) {Comic Sans MS}
        } else {
        set ::DSx_settings(clock_font) $::DSx_settings(font_name)
    }
    set_colour
}

proc DSx_date {} {
    if {$::DSx_settings(clock_hide) != 1} {
        set a [clock format [clock seconds] -format "%a, %d %b"]
        } else {
        set a ""
    }
    return $a
}

proc DSx_clock {} {

    if {$::DSx_settings(clock_hide) != 1} {
        if {$::settings(enable_ampm) == 0} {
            set a [clock format [clock seconds] -format "%H"]
            set b [clock format [clock seconds] -format ":%M"]
            set c $a
            } else {
            set a [clock format [clock seconds] -format "%I"]
            set b [clock format [clock seconds] -format ":%M"]
            set c $a
            regsub {^[0]} $c {\1} c
            }
        } else {
        set c ""
        set b ""
    }
    return $c$b
}

proc DSx_clock_ap {} {
    if {$::DSx_settings(clock_hide) != 1 && $::settings(enable_ampm) == 1} {
        set a [clock format [clock seconds] -format %P]
        } else {
        set a ""
    }
    return $a
}

proc DSx_clock_s {} {
    if {$::DSx_settings(clock_hide) != 1} {
        set a [clock format [clock seconds] -format %S]
    } else {
        set a ""
    }
    return $a
}

proc cancel_auto_stop {} {
    if {$::android == 0 } {
    after cancel [list update_de1_state "$::de1_state(Idle)\x5"]
    after cancel [list update_de1_state "$::de1_state(Idle)\x5"]
    after cancel [list update_de1_state "$::de1_state(Idle)\x5"]
    after cancel [list update_de1_state "$::de1_state(Idle)\x5"]
    }
}

proc DSx_return_temperature_number {in} {
	if {$::settings(enable_fahrenheit) == 1} {
		return [round_to_two_digits [expr {[celsius_to_fahrenheit $in] * 0.05}]]
	} else {
		return [round_to_two_digits [expr {$in * 0.1}]]
	}
}

proc DSx_steam_graph_list {} {
	return [list steam_elapsed steam_temperature steam_flow steam_pressure]
}

proc backup_DSx_steam_graph {} {
	foreach sg [DSx_steam_graph_list] {
	unset -nocomplain ::DSx_settings(steam_graph_$sg)
		if {[$sg length] > 0} {
			set ::DSx_settings(steam_graph_$sg) [$sg range 0 end]
		} else {
			set ::DSx_settings(steam_graph_$sg) {}
		}
	}
}

proc restore_DSx_steam_graph {} {
	set last_elapsed_time_index [expr {[espresso_elapsed length] - 1}]
	if {$last_elapsed_time_index > 1} {
	   # return
	}
	foreach sg [DSx_steam_graph_list] {
		$sg length 0
		if {[info exists ::DSx_settings(steam_graph_$sg)] == 1} {
			$sg append $::DSx_settings(steam_graph_$sg)
		}

	}
}

proc DSx_live_graph_list {} {
	return [list DSx_espresso_temperature_basket DSx_espresso_temperature_mix DSx_espresso_temperature_goal espresso_elapsed espresso_pressure espresso_weight espresso_weight_chartable espresso_flow espresso_flow_weight espresso_flow_weight_raw espresso_water_dispensed espresso_flow_weight_2x espresso_flow_2x espresso_resistance espresso_resistance_weight espresso_pressure_delta espresso_flow_delta espresso_flow_delta_negative espresso_flow_delta_negative_2x espresso_temperature_mix espresso_temperature_basket espresso_state_change espresso_pressure_goal espresso_flow_goal espresso_flow_goal_2x espresso_temperature_goal espresso_de1_explanation_chart_flow espresso_de1_explanation_chart_elapsed_flow espresso_de1_explanation_chart_flow_2x espresso_de1_explanation_chart_flow_1_2x espresso_de1_explanation_chart_flow_2_2x espresso_de1_explanation_chart_flow_3_2x espresso_de1_explanation_chart_pressure espresso_de1_explanation_chart_temperature espresso_de1_explanation_chart_temperature_10 espresso_de1_explanation_chart_pressure_1 espresso_de1_explanation_chart_pressure_2 espresso_de1_explanation_chart_pressure_3 espresso_de1_explanation_chart_elapsed_flow espresso_de1_explanation_chart_elapsed_flow_1 espresso_de1_explanation_chart_elapsed_flow_2 espresso_de1_explanation_chart_elapsed_flow_3 espresso_de1_explanation_chart_elapsed espresso_de1_explanation_chart_elapsed_1 espresso_de1_explanation_chart_elapsed_2 espresso_de1_explanation_chart_elapsed_3]
}
#Damian#
after idle {after 0 {register_state_change_handler Espresso Idle save_final_live_graph}}
proc backup_DSx_live_graph {} {
	foreach lg [DSx_live_graph_list] {
	unset -nocomplain ::DSx_settings(live_graph_$lg)
		if {[$lg length] > 0} {
			set ::DSx_settings(live_graph_$lg) [$lg range 0 end]
			set ::DSx_settings(live_graph_profile) $::settings(profile_title)
		    set ::DSx_settings(live_graph_time) $::settings(espresso_clock)
		    set ::DSx_settings(live_graph_beans) $::settings(DSx_bean_weight)
		    set ::DSx_settings(live_graph_weight) $::settings(drink_weight)
		    set ::DSx_settings(live_graph_pi_water) [round_to_integer $::de1(preinfusion_volume)]
		    set ::DSx_settings(live_graph_pour_water) [round_to_integer $::de1(pour_volume)]
		    set ::DSx_settings(live_graph_water) [expr {[round_to_integer $::de1(preinfusion_volume)] + [round_to_integer $::de1(pour_volume)]}]
		    set ::DSx_settings(live_graph_pi_time) [espresso_preinfusion_timer]
		    set ::DSx_settings(live_graph_pour_time) [espresso_pour_timer]
		    set ::DSx_settings(live_graph_shot_time) [espresso_elapsed_timer]
		} else {
			set ::DSx_settings(live_graph_$lg) {}
		}
	}
}
proc save_final_live_graph {unused_old_state unused_new_state} {
    backup_DSx_live_graph
    save_DSx_settings
    end_LRv2_presets

}
proc DSx_water_data {} {
    set piv [round_to_integer $::de1(preinfusion_volume)]
    set pv [round_to_integer $::de1(pour_volume)]
    set tv [expr {[round_to_integer $::de1(preinfusion_volume)] + [round_to_integer $::de1(pour_volume)]}]
    return "$piv+$pv = $tv"
}

proc live_extraction_ratio {} {
    catch {
        set r [round_to_one_digits [expr $::DSx_settings(live_graph_weight)/$::DSx_settings(live_graph_beans)]]
    }
    return 1:$r
}

proc last_shot_date {} {
    set date [clock format $::DSx_settings(live_graph_time) -format {%a %d %b}]
    if {$::settings(enable_ampm) == 0} {
        set a [clock format $::DSx_settings(live_graph_time) -format {%H}]
        set b [clock format $::DSx_settings(live_graph_time) -format {:%M}]
        set c $a
    } else {
        set a [clock format $::DSx_settings(live_graph_time) -format {%I}]
        set b [clock format $::DSx_settings(live_graph_time) -format {:%M}]
        set c $a
        regsub {^[0]} $c {\1} c
    }
    if {$::DSx_settings(clock_hide) != 1 && $::settings(enable_ampm) == 1} {
        set pm [clock format $::DSx_settings(live_graph_time) -format %P]
        } else {
        set pm ""
    }
    return "$date $c$b$pm"
}

proc restore_DSx_live_graph {} {
	set last_elapsed_time_index [expr {[espresso_elapsed length] - 1}]
	if {$last_elapsed_time_index > 1} {
	    return
	}
	foreach lg [DSx_live_graph_list] {
		$lg length 0
		if {[info exists ::DSx_settings(live_graph_$lg)] == 1} {
			$lg append $::DSx_settings(live_graph_$lg)
		}
	}
}

proc LRv2_preview_text {} {
        if {$::settings(profile_title) == {Damian's LRv2} || $::settings(profile_title) == {Damian's LRv3}} {
        return "of how $::settings(profile_title) should look"
        } else {
        return ""
        }
}

proc DSx_graph_restore {} {
    after 1 {restore_DSx_live_graph; restore_DSx_steam_graph}
}

proc LRv2_preview {} {

    if {$::settings(profile_title) == {Damian's LRv2}} {
        $::DSx_preview_graph_advanced configure -width [rescale_x_skin 1050] -height [rescale_y_skin 450]
        DSx_espresso_elapsed_preview length 0
        DSx_espresso_pressure_preview length 0
        DSx_espresso_flow_preview_2x length 0
        DSx_espresso_flow_weight_preview_2x length 0
        DSx_espresso_elapsed_preview append {0.0 0.03 0.251 0.477 0.747 0.971 1.244 1.469 1.737 1.962 2.234 2.503 2.729 2.997 3.222 3.493 3.717 3.987 4.211 4.483 4.751 4.975 5.248 5.517 5.747 5.965 6.237 6.463 6.732 6.957 7.227 7.452 7.721 7.992 8.217 8.485 8.712 9.029 9.208 9.477 9.702 10.015 10.196 10.468 10.692 10.962 11.233 11.46 11.728 11.97 12.22 12.447 12.717 12.987 13.212 13.437 13.705 13.977 14.203 14.472 14.698 14.968 15.19 15.482 15.685 15.958 16.184 16.449 16.678 16.951 17.218 17.441 17.715 17.936 18.206 18.43 18.738 18.925 19.195 19.423 19.693 19.96 20.187 20.46 20.681 20.952 21.176 21.458 21.669 21.941 22.165 22.437 22.708 22.929 23.201 23.424 23.696 23.92 24.191 24.42 24.684 24.909 25.179 25.449 25.685 25.992 26.169 26.441 26.709 26.936 27.161 27.455 27.656 27.925 28.202 28.419 28.689 28.959 29.186 29.409 29.708 29.911 30.178 30.408 30.671 30.894 31.209 31.436 31.659 31.929 32.156 32.426 32.656 32.921 33.144 33.417 33.642 33.909 34.179 34.405 34.677 34.91 35.169 35.394 35.664 35.903 36.159 36.389 36.655 36.88 37.151 37.419 37.645 37.924 38.141 38.409 38.635 38.907 39.133 39.402 39.625 39.916 40.164 40.391 40.662 40.884 41.163 41.404 41.651 41.874 42.158 42.372 42.641 42.919 43.136 43.409 43.651 43.9 44.126 44.418 44.621 44.937 45.114 45.4 45.655}
        DSx_espresso_pressure_preview append {0.0 0.01 0.01 0.01 0.03 0.02 0.02 0.03 0.02 0.04 0.08 0.16 0.28 0.37 0.39 0.46 0.55 0.64 0.78 0.93 1.1 1.34 1.55 1.83 2.16 2.51 2.83 3.1 3.2 3.26 3.24 3.26 3.2 3.11 3.17 3.17 3.09 2.97 3.04 3.0 3.06 3.17 3.05 2.96 3.01 3.05 2.95 3.0 3.06 2.95 2.97 3.03 2.99 3.09 3.01 2.97 3.21 3.17 3.04 2.99 2.92 3.01 3.02 2.97 3.06 2.98 2.98 3.06 2.97 3.04 3.1 3.53 4.22 4.99 5.8 6.4 6.94 7.39 7.76 8.01 8.22 8.42 8.56 8.64 8.73 8.83 8.83 8.84 8.9 8.91 8.91 8.94 8.94 8.93 8.97 8.94 8.95 8.96 8.96 8.97 8.98 8.93 8.95 8.97 8.92 8.88 8.88 8.86 8.82 8.82 8.78 8.78 8.74 8.72 8.66 8.68 8.64 8.59 8.61 8.57 8.55 8.52 8.5 8.49 8.43 8.43 8.39 8.38 8.32 8.31 8.3 8.26 8.23 8.18 8.23 8.18 8.14 8.1 8.09 8.05 8.04 7.97 8.01 7.99 7.91 7.88 7.89 7.83 7.82 7.79 7.74 7.76 7.74 7.65 7.67 7.64 7.65 7.57 7.55 7.53 7.51 7.5 7.44 7.42 7.37 7.39 7.34 7.32 7.29 7.27 7.23 7.21 7.18 7.18 7.11 7.07 7.11 7.03 7.02 7.0 6.98 6.92 6.93 6.89 6.86}
        foreach DSx_flow {0.0 2.16 3.14 4.06 4.82 5.42 5.88 6.29 6.6 6.85 7.02 7.09 7.11 7.18 7.22 7.24 7.24 7.23 7.21 7.22 7.18 7.11 7.01 6.93 6.81 6.47 5.98 5.3 4.57 3.88 3.29 2.72 2.19 1.87 1.56 1.27 1.0 0.88 0.71 0.65 0.63 0.5 0.39 0.36 0.35 0.28 0.27 0.28 0.23 0.22 0.25 0.2 0.27 0.22 0.17 0.33 0.29 0.23 0.18 0.14 0.2 0.19 0.15 0.24 0.19 0.17 0.23 0.19 0.25 0.22 0.46 0.82 1.12 1.35 1.42 1.48 1.48 1.44 1.4 1.35 1.34 1.29 1.25 1.23 1.24 1.2 1.18 1.18 1.2 1.2 1.21 1.21 1.24 1.27 1.28 1.32 1.33 1.35 1.38 1.41 1.43 1.45 1.49 1.5 1.5 1.5 1.5 1.53 1.55 1.57 1.56 1.56 1.58 1.58 1.61 1.58 1.6 1.62 1.63 1.66 1.68 1.66 1.69 1.68 1.7 1.7 1.7 1.71 1.7 1.72 1.73 1.7 1.71 1.76 1.73 1.75 1.75 1.75 1.74 1.75 1.73 1.74 1.77 1.72 1.73 1.72 1.69 1.72 1.71 1.69 1.69 1.71 1.68 1.71 1.71 1.74 1.71 1.7 1.7 1.68 1.71 1.69 1.7 1.7 1.71 1.7 1.7 1.67 1.68 1.68 1.67 1.67 1.66 1.61 1.64 1.64 1.6 1.61 1.6 1.58 1.58 1.6 1.57 1.6 1.59} {
            DSx_espresso_flow_preview_2x append [expr {1.7 * $DSx_flow}]
            }
        foreach DSx_flow_weight {0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.05 0.0 0.0 0.0 0.0 0.0 0.1 0.08 0.07 0.11 0.14 0.14 0.07 0.16 0.14 0.12 0.2 0.19 0.26 0.19 0.17 0.13 0.13 0.22 0.18 0.16 0.24 0.3 0.34 0.38 0.4 0.44 0.52 0.54 0.6 0.62 0.68 0.76 0.75 0.78 0.79 0.87 0.89 0.9 0.91 0.93 0.98 0.98 1.03 1.03 1.08 1.11 1.11 1.14 1.17 1.2 1.19 1.23 1.23 1.24 1.25 1.27 1.33 1.33 1.36 1.35 1.34 1.38 1.42 1.41 1.47 1.46 1.43 1.43 1.45 1.48 1.47 1.5 1.47 1.5 1.57 1.59 1.57 1.59 1.59 1.56 1.6 1.59 1.57 1.59 1.6 1.57 1.57 1.59 1.58 1.59 1.61 1.62 1.62 1.63 1.63 1.59 1.59 1.57 1.62 1.62 1.62 1.59 1.65 1.61 1.62 1.66 1.66 1.61 1.63 1.59 1.6 1.6 1.6 1.6 1.63 1.59 1.59 1.59 1.64 1.6 1.61 1.63 1.6 1.63 1.6 1.6 1.63 1.63 1.6 1.6} {
            DSx_espresso_flow_weight_preview_2x append [expr {2.0 * $DSx_flow_weight}]
            }
        } elseif {$::settings(profile_title) == {Damian's LRv3}} {
        $::DSx_preview_graph_advanced configure -width [rescale_x_skin 1050] -height [rescale_y_skin 450]
        DSx_espresso_elapsed_preview length 0
        DSx_espresso_pressure_preview length 0
        DSx_espresso_flow_preview_2x length 0
        DSx_espresso_flow_weight_preview_2x length 0
        DSx_espresso_elapsed_preview append {0.0 0.04 0.263 0.494 0.805 0.986 1.256 1.526 1.751 2.021 2.246 2.514 2.742 3.011 3.237 3.506 3.777 4.003 4.272 4.543 4.766 4.989 5.261 5.486 5.756 6.027 6.25 6.522 6.747 7.016 7.24 7.513 7.782 8.006 8.276 8.501 8.768 8.996 9.266 9.491 9.764 10.029 10.257 10.532 10.749 11.022 11.25 11.517 11.741 12.012 12.279 12.505 12.82 13.003 13.272 13.497 13.823 14.034 14.262 14.529 14.753 15.023 15.251 15.527 15.747 16.013 16.308 16.512 16.782 17.006 17.291 17.524 17.771 17.994 18.269 18.536 18.759 19.029 19.253 19.524 19.748 20.022 20.289 20.515 20.8 21.009 21.279 21.526 21.776 22.048 22.275 22.541 22.766 23.057 23.26 23.528 23.755 24.034 24.295 24.521 24.841 25.024 25.284 25.509 25.781 26.05 26.273 26.545 26.791 27.042 27.263 27.542 27.763 28.029 28.312 28.525 28.793 29.021 29.315 29.52 29.786 30.073 30.278 30.55 30.776 31.045 31.276 31.539 31.763 32.041 32.305 32.527 32.837 33.023 33.295 33.521 33.8 34.059 34.283 34.557 34.812 35.049 35.273 35.547 35.777 36.041 36.311 36.534 36.865 37.034 37.299 37.525 37.798 38.063 38.289 38.561 38.805 39.057 39.281 39.555 39.774 40.043 40.313 40.539 40.808}
        DSx_espresso_pressure_preview append {0.0 0.01 0.0 0.02 0.03 0.02 0.02 0.02 0.06 0.16 0.23 0.24 0.31 0.38 0.46 0.57 0.71 0.87 1.08 1.29 1.5 1.75 2.07 2.36 2.59 2.86 3.07 3.19 3.19 3.16 3.2 3.22 3.19 3.13 3.06 3.05 3.09 3.03 3.01 3.04 3.08 2.96 3.02 3.03 3.08 3.0 2.98 3.06 2.96 3.05 2.98 3.01 3.01 3.03 3.04 2.96 3.05 2.96 3.01 3.0 3.04 2.97 3.04 2.99 3.0 3.0 3.02 3.01 3.05 3.13 3.69 4.45 5.22 5.93 6.47 6.95 7.41 7.7 8.01 8.22 8.37 8.49 8.65 8.73 8.74 8.77 8.81 8.8 8.78 8.81 8.85 8.86 8.87 8.88 8.91 8.93 8.96 8.91 8.94 8.99 8.96 8.92 8.93 8.98 9.02 8.95 8.96 8.98 8.91 8.98 8.96 8.9 8.88 8.91 8.89 8.81 8.87 8.83 8.82 8.74 8.8 8.75 8.73 8.69 8.66 8.63 8.62 8.59 8.54 8.54 8.53 8.52 8.46 8.4 8.46 8.37 8.34 8.4 8.3 8.29 8.28 8.25 8.22 8.16 8.22 8.15 8.13 8.1 8.04 8.04 8.06 8.0 7.98 7.96 7.92 7.89 7.91 7.84 7.8 7.79 7.78 7.75 7.74 7.69 7.64}
        foreach DSx_flow {0.0 2.19 3.12 4.09 4.84 5.47 5.96 6.34 6.64 6.89 7.04 7.14 7.23 7.27 7.34 7.37 7.37 7.35 7.37 7.32 7.32 7.26 7.12 6.87 6.49 5.87 5.22 4.49 3.8 3.21 2.67 2.25 1.87 1.48 1.26 1.08 0.88 0.79 0.65 0.62 0.49 0.48 0.41 0.43 0.35 0.3 0.33 0.26 0.31 0.26 0.3 0.27 0.3 0.28 0.22 0.28 0.23 0.29 0.25 0.31 0.26 0.31 0.26 0.3 0.27 0.32 0.27 0.32 0.34 0.62 0.97 1.26 1.46 1.55 1.59 1.62 1.58 1.58 1.57 1.56 1.52 1.52 1.52 1.53 1.52 1.53 1.53 1.52 1.53 1.53 1.57 1.59 1.63 1.65 1.69 1.69 1.7 1.75 1.79 1.81 1.8 1.82 1.87 1.91 1.93 1.96 2.01 1.99 2.04 2.05 2.04 2.01 2.04 2.04 2.0 2.05 2.06 2.04 1.98 2.02 2.04 2.08 2.08 2.07 2.07 2.04 2.06 2.03 2.05 2.03 2.05 2.04 2.01 2.04 1.98 2.0 2.03 2.02 1.99 1.99 2.0 1.99 2.0 2.02 1.97 1.98 1.99 1.94 1.95 1.99 1.99 1.99 1.98 1.94 1.96 1.98 1.98 1.95 1.88 1.88 1.9 1.91 1.88 1.81 1.84} {
            DSx_espresso_flow_preview_2x append [expr {1.9 * $DSx_flow}]
            }
        foreach DSx_flow_weight {0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.1 0.09 0.07 0.07 0.05 0.05 0.05 0.05 0.1 0.13 0.13 0.11 0.1 0.18 0.16 0.23 0.27 0.23 0.24 0.27 0.23 0.22 0.29 0.33 0.28 0.27 0.28 0.34 0.35 0.4 0.43 0.42 0.55 0.47 0.52 0.68 0.77 0.78 0.76 0.89 0.95 0.95 1.01 1.0 1.09 1.13 1.17 1.14 1.27 1.25 1.25 1.31 1.33 1.38 1.42 1.45 1.49 1.46 1.47 1.54 1.56 1.58 1.59 1.6 1.64 1.64 1.69 1.66 1.7 1.7 1.68 1.72 1.76 1.72 1.71 1.75 1.78 1.76 1.79 1.8 1.78 1.76 1.78 1.81 1.74 1.75 1.78 1.77 1.74 1.77 1.8 1.76 1.74 1.78 1.8 1.77 1.8 1.77 1.8 1.77 1.8 1.78 1.75 1.78 1.8 1.78 1.8 1.77 1.76 1.77 1.8 1.78 1.81 1.78 1.76 1.77 1.76 1.79 1.75 1.78 1.76 1.75} {
            DSx_espresso_flow_weight_preview_2x append [expr {2.2 * $DSx_flow_weight}]
            }
        } else {
        $::DSx_preview_graph_advanced configure -width 1 -height 1
        DSx_espresso_elapsed_preview length 0
        DSx_espresso_pressure_preview length 0
        DSx_espresso_flow_preview_2x length 0
        DSx_espresso_flow_weight_preview_2x length 0
    }
}

proc clear_temp_data {} {
	DSx_espresso_temperature_basket length 0
    DSx_espresso_temperature_basket append [DSx_return_temperature_number $::settings(espresso_temperature)]
    DSx_espresso_temperature_mix length 0
    DSx_espresso_temperature_mix append [DSx_return_temperature_number $::settings(espresso_temperature)]
    DSx_espresso_temperature_goal length 0
    DSx_espresso_temperature_goal append [DSx_return_temperature_number $::settings(espresso_temperature)]
}

proc start_LRv2_presets {} {
    if {$::DSx_settings(LRv2_presets) == 1 && ($::settings(profile_title) == {Damian's LRv2} || $::settings(profile_title) == {Damian's LRv3})} {
        set ::settings(phase_2_flow_rate) 80
        set ::settings(espresso_warmup_timeout) 30
        set_heater_tweaks
    }
}
proc end_LRv2_presets {} {
    if {$::DSx_settings(LRv2_presets) == 1} {
        set ::settings(phase_2_flow_rate) $::DSx_settings(backup_phase_2_flow_rate)
        set ::settings(espresso_warmup_timeout) $::DSx_settings(backup_espresso_warmup_timeout)
        set_heater_tweaks
        save_settings
    }
}

### over write
proc profile_has_not_changed_set args {
	set ::settings(profile_has_changed) 0
    LRv2_preview
}

proc append_live_data_to_espresso_chart {} {
    wsaw
    if {$::de1_num_state($::de1(state)) == "Steam"} {
		if {$::de1(substate) == $::de1_substate_types_reversed(pouring) || $::de1(substate) == $::de1_substate_types_reversed(preinfusion)} {
			steam_pressure append [round_to_two_digits $::de1(pressure)]
			steam_flow append [round_to_two_digits $::de1(flow)]
			if {$::settings(enable_fahrenheit) == 1} {
				steam_temperature append [round_to_integer [celsius_to_fahrenheit $::de1(steam_heater_temperature)]]
			} else {
				steam_temperature append [round_to_integer $::de1(steam_heater_temperature)]
			}
			steam_elapsed append  [expr {[steam_pour_millitimer]/1000.0}]
		}
		backup_DSx_steam_graph
    	return
    } elseif {$::de1_num_state($::de1(state)) != "Espresso"} {
    	# we only store chart data during espresso
    	# we could theoretically store this data during steam as well, if we want to have charts of steaming temperature and pressure
    	return
    }
  	if {$::de1(substate) == $::de1_substate_types_reversed(pouring) || $::de1(substate) == $::de1_substate_types_reversed(preinfusion)} {
		set millitime [espresso_millitimer]
		if {$::de1(substate) == 4 || $::de1(substate) == 5} {
			set mtime [expr {$millitime/1000.0}]
			set last_elapsed_time_index [expr {[espresso_elapsed length] - 1}]
			set last_elapsed_time 0
			if {$last_elapsed_time_index >= 0} {
				set last_elapsed_time [espresso_elapsed range $last_elapsed_time_index $last_elapsed_time_index]
			}
			if {$mtime > $last_elapsed_time} {
				# this is for handling cases where a god shot has already loaded a time axis
				espresso_elapsed append $mtime
			}
			if {$::de1(scale_weight) == ""} {
				set ::de1(scale_weight) 0
			}
			espresso_weight append [round_to_two_digits $::de1(scale_weight)]
			espresso_weight_chartable append [round_to_two_digits [expr {0.10 * $::de1(scale_weight)}]]
			espresso_pressure append [round_to_two_digits $::de1(pressure)]
			espresso_flow append [round_to_two_digits $::de1(flow)]
			espresso_flow_2x append [round_to_two_digits [expr {2.0 * $::de1(flow)}]]

			set resistance 0
			catch {
				#set resistance [expr {((($::de1(pressure)/(($::de1(flow)*$::de1(flow))+($::de1(pressure)*0.9)))-2)*5)+11}]
				set resistance [round_to_two_digits [expr {$::de1(pressure) / pow($::de1(flow), 2) }]]
			}
			espresso_resistance append $resistance

			if {$::de1(scale_weight_rate) != ""} {
				# if a bluetooth scale is recording shot weight, graph it along with the flow meter
				espresso_flow_weight append [round_to_two_digits $::de1(scale_weight_rate)]
				espresso_flow_weight_raw append [round_to_two_digits $::de1(scale_weight_rate_raw)]
				espresso_flow_weight_2x append [expr {2.0 * [round_to_two_digits $::de1(scale_weight_rate)] }]

				set resistance_weight 0
				catch {
					if {$::de1(pressure) != 0 && $::de1(scale_weight_rate) != "" && $::de1(scale_weight_rate) != 0} {
						# if the scale is available, use that instead of the flowmeter calculation, to determine resistance
						set resistance_weight [round_to_two_digits [expr {$::de1(pressure) / pow($::de1(scale_weight_rate), 2) }]]
					}
				}

				espresso_resistance_weight append $resistance_weight
			}
			set flow_delta [diff_flow_rate]
			set negative_flow_delta_for_chart 0
			if {$::de1(substate) == $::de1_substate_types_reversed(preinfusion)} {
				# don't track flow rate delta during preinfusion because the puck is absorbing water, and so the numbers aren't useful (likely just pump variability)
				set flow_delta 0
			}
			if {$flow_delta > 0} {
			    if {$::settings(enable_negative_flow_charts) == 1} {
					# experimental chart from the top
					set negative_flow_delta_for_chart [expr {6.0 - (10.0 * $flow_delta)}]
					set negative_flow_delta_for_chart_2x [expr {12.0 - (10.0 * $flow_delta)}]
					espresso_flow_delta_negative append $negative_flow_delta_for_chart
					espresso_flow_delta_negative_2x append $negative_flow_delta_for_chart_2x
				}
				espresso_flow_delta append 0
				#puts "negative flow_delta: $flow_delta ($negative_flow_delta_for_chart)"
			} else {
				espresso_flow_delta append [expr {abs(10*$flow_delta)}]
			    if {$::settings(enable_negative_flow_charts) == 1} {
					espresso_flow_delta_negative append 6
					espresso_flow_delta_negative_2x append 12
					#puts "flow_delta: $flow_delta ($negative_flow_delta_for_chart)"
				}
			}
			set pressure_delta [diff_pressure]
			espresso_pressure_delta append [expr {abs ($pressure_delta) / $millitime}]
			set ::previous_espresso_flow $::de1(flow)
			set ::previous_espresso_pressure $::de1(pressure)
			espresso_temperature_mix append [return_temperature_number $::de1(mix_temperature)]
			espresso_temperature_basket append [return_temperature_number $::de1(head_temperature)]
			espresso_state_change append $::state_change_chart_value
			set ::previous_espresso_flow_time $millitime
			# don't chart goals at zero, instead take them off the chart
			if {$::de1(goal_flow) == 0} {
				espresso_flow_goal append "-1"
				espresso_flow_goal_2x append "-1"
			} else {
				espresso_flow_goal append $::de1(goal_flow)
				espresso_flow_goal_2x append [expr {2.0 * $::de1(goal_flow)}]
			}
			# don't chart goals at zero, instead take them off the chart
			if {$::de1(goal_pressure) == 0} {
				espresso_pressure_goal append "-1"
			} else {
				espresso_pressure_goal append $::de1(goal_pressure)
			}
			espresso_temperature_goal append [return_temperature_number $::de1(goal_temperature)]
			DSx_espresso_temperature_basket append [DSx_return_temperature_number $::de1(head_temperature)]
			DSx_espresso_temperature_goal append [DSx_return_temperature_number $::de1(goal_temperature)]
			DSx_espresso_temperature_mix append [DSx_return_temperature_number $::de1(mix_temperature)]

			set total_water_volume [expr {$::de1(preinfusion_volume) + $::de1(pour_volume)}]
			set total_water_volume_divided [expr {0.1 * ($::de1(preinfusion_volume) + $::de1(pour_volume))}]
			espresso_water_dispensed append $total_water_volume_divided
			# stop espresso at a desired water volume, if set to > 0, but only for advanced shots
			if {$::settings(settings_profile_type) == "settings_2c" && $::settings(final_desired_shot_volume_advanced) > 0 && $total_water_volume >= $::settings(final_desired_shot_volume_advanced)} {
				# for advanced shots, it's TOTAL WATER VOLuME that is the trigger, since Preinfusion is not necessarily part of an advanced shot
				msg "Water volume based Espresso stop was triggered at: $total_water_volume ml > $::settings(final_desired_shot_volume_advanced) ml "
			 	start_idle
			 	say [translate {Stop}] $::settings(sound_button_in)
			 	borg toast [translate "Total volume reached"]
			} elseif {$::settings(scale_bluetooth_address) == ""} {
				# if no scale connected, potentially use volumetric to stop the shot
			 	if {($::settings(settings_profile_type) == "settings_2a" || $::settings(settings_profile_type) == "settings_2b") && $::settings(final_desired_shot_volume) > 0 && $::de1(pour_volume) >= $::settings(final_desired_shot_volume)} {
			 		# for FLOW and PRESSURE shots, we normally use preinfusion, so POUR VOLUME is very close to WEIGHT
					msg "Water volume based Espresso stop was triggered at: $::de1(pour_volume) ml > $::settings(final_desired_shot_volume) ml"
				 	start_idle
				 	say [translate {Stop}] $::settings(sound_button_in)
				 	borg toast [translate "Espresso volume reached"]
			 	}
			}
		}
  	}
}

