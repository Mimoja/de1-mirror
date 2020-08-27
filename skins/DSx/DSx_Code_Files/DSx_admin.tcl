package provide DSx_admin 1.0

proc DSx_app_update {} {
    if {$::DSx_settings(backup_b4_update) == 1} {
        borg spinner on
        file delete -force [homedir]BackUpCopy
        file copy -force [homedir] [homedir]BackUpCopy
        borg spinner off
        borg systemui $::android_full_screen_flags
    }
    set ::de1(app_update_button_label) [translate "Updating"]
    update;
    start_app_update
}

proc DSx_done_button {} {

    if {$::settings(steam_temperature) > 130} {
                set ::DSx_settings(steam_temperature_backup) $::settings(steam_temperature)
            }
    if {$::settings(steam_temperature) < 130} {
                set ::settings(steam_timeout) 0
            }
    if {$::settings(steam_temperature) > 130 && $::settings(steam_timeout) < 1} {
                set ::settings(steam_timeout) 1
            }
    save_DSx_settings
    save_settings
    if {[ifexists ::calibration_disabled_fahrenheit] == 1} {
			set ::settings(enable_fahrenheit) 1
			unset -nocomplain ::calibration_disabled_fahrenheit
			msg "Calibration re-enabled Fahrenheit"
		}
    save_settings_to_de1
    set_alarms_for_de1_wake_sleep
    say [translate {Done}] $::settings(sound_button_in)
    save_settings
    #profile_has_changed_set_colors
    de1_send_steam_hotwater_settings
    de1_send_waterlevel_settings
    set_fan_temperature_threshold $::settings(fan_threshold)
    de1_enable_water_level_notifications
    set_next_page off DSx_admin
    page_show DSx_admin
}

add_de1_widget "DSx_admin" checkbutton 1850 1180 {} -text [translate "Backup before updating"] -indicatoron true  -font "[DSx_font font 8]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(backup_b4_update)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command save_DSx_settings

proc DSx_fill_skin_listbox {} {
	#puts "DSx_fill_skin_listbox $widget"
	set widget $::globals(DSx_tablet_styles_listbox)
	$widget delete 0 99999

	set cnt 0
	set ::current_skin_number 0
	foreach d [skin_directories] {
		if {$d == "CVS" || $d == "example"} {
			continue
		}
		$widget insert $cnt [translate $d]
		if {$::settings(skin) == $d} {
			set ::current_skin_number $cnt
		}

		#puts "d: $d"
		if {[ifexists ::de1plus_skins($d)] == 1} {
			# mark skins that require the DE1PLUS model with a different color to highlight them
			#puts "de1plus skin: $d"
			$widget itemconfigure $cnt -background #F0F0FF
		}
		incr cnt

	}

	#$widget itemconfigure $current_skin_number -foreground blue

	$widget selection set $::current_skin_number

	make_current_listbox_item_blue $widget
	#puts "current_skin_number: $::current_skin_number"

	DSx_preview_tablet_skin
	$widget yview $::current_skin_number

}

proc DSx_preview_tablet_skin {} {
	if {$::de1(current_context) != "DSx_admin_skin"} {
		return
	}
	msg "DSx_preview_tablet_skin"
	set w $::globals(DSx_tablet_styles_listbox)
	if {[$w curselection] == ""} {
		msg "no current skin selection"
		puts "::current_skin_number: $::current_skin_number"
		$w selection set $::current_skin_number
	}
	set skindir [lindex [skin_directories] [$w curselection]]
	set ::settings(skin) $skindir
	set fn "[homedir]/skins/$skindir/${::screen_size_width}x${::screen_size_height}/icon.jpg"
	if {[file exists $fn] != 1} {
    	catch {
    		file mkdir "[homedir]/skins/$skindir/${::screen_size_width}x${::screen_size_height}/"
    	}
		puts "creating $fn"
        set rescale_images_x_ratio [expr {$::screen_size_height / 1600.0}]
        set rescale_images_y_ratio [expr {$::screen_size_width / 2560.0}]

		set src "[homedir]/skins/$skindir/2560x1600/icon.jpg"
		catch {
			$::DSx_table_style_preview_image read $src
			photoscale $::DSx_table_style_preview_image $rescale_images_y_ratio $rescale_images_x_ratio
			$::DSx_table_style_preview_image write $fn  -format {jpeg -quality 90}
		}

	} else {
		set fn "[homedir]/skins/$skindir/${::screen_size_width}x${::screen_size_height}/icon.jpg"
		$::DSx_table_style_preview_image read $fn
	}
	DSx_current_listbox_item $::globals(DSx_tablet_styles_listbox)
}



proc set_DSx_skins_scrollbar_dimensions {} {
    $::DSx_skin_scrollbar configure -length [winfo height $::globals(DSx_tablet_styles_listbox)]
    set coords [.can coords $::globals(DSx_tablet_styles_listbox) ]
    set newx [expr {[winfo width $::globals(DSx_tablet_styles_listbox)] + [lindex $coords 0]}]
    .can coords $::DSx_skin_scrollbar "$newx [lindex $coords 1]"
}

proc load_DSx_language {} {
	set stepnum [$::DSx_languages_widget curselection]
	if {$stepnum == ""} {
		return
	}
	if {$stepnum == 0} {
		set ::settings(language) ""
	} else {
		set ::settings(language) [lindex [translation_langs_array] [expr {($stepnum * 2) - 2}] ]
	}
	#make_current_listbox_item_blue $::DSx_languages_widget
	DSx_current_listbox_item $::DSx_languages_widget
}
proc fill_DSx_languages_listbox {} {

	set widget $::DSx_languages_widget

	$widget delete 0 99999
	set cnt 0
	set current_profile_number 0

	# on android we can automatically detect the language from the OS setting, and this is the preferred way to go
	$widget insert $cnt [translate Automatic]
	incr cnt

	set current 0

	foreach {code desc} [translation_langs_array] {
        #puts "$code $desc"

		if {$::settings(language) == $code} {
			set current $cnt
		}
		$widget insert $cnt "$desc"
		incr cnt
	}

	$widget selection set $current;
	DSx_current_listbox_item $::DSx_languages_widget

	$::DSx_languages_widget yview $current
}

set ::DSx_language_slider 0
set ::DSx_languages_scrollbar [add_de1_widget "DSx_units" scale 1000 1000 {} -from 0 -to .50 -bigincrement 0.2 -background $::DSx_settings(font_colour) -borderwidth 1 -showvalue 0 -resolution .01 -length [rescale_x_skin 400] -width [rescale_y_skin 150] -variable ::DSx_language_slider -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -command {listbox_moveto $::DSx_languages_widget $::DSx_language_slider}  -foreground $::DSx_settings(font_colour) -troughcolor $::DSx_settings(bg_colour) -borderwidth 0  -highlightthickness 0]
set ::DSx_skin_slider 0
set ::DSx_skin_scrollbar [add_de1_widget "DSx_admin_skin" scale 10000 1 {} -from 0 -to .90 -bigincrement 0.2 -background $::DSx_settings(font_colour) -borderwidth 1 -showvalue 0 -resolution .01 -length [rescale_x_skin 400] -width [rescale_y_skin 150] -variable ::DSx_skin_slider -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -command {listbox_moveto $::globals(DSx_tablet_styles_listbox) $::DSx_skin_slider}  -foreground $::DSx_settings(font_colour) -troughcolor $::DSx_settings(bg_colour) -borderwidth 0  -highlightthickness 0]

proc set_DSx_languages_scrollbar_dimensions {} {
    # set the height of the scrollbar to be the same as the listbox
    $::DSx_languages_scrollbar configure -length [winfo height $::DSx_languages_widget]
    set coords [.can coords $::DSx_languages_widget ]
    set newx [expr {[winfo width $::DSx_languages_widget] + [lindex $coords 0]}]
    .can coords $::DSx_languages_scrollbar "$newx [lindex $coords 1]"
}

proc DSx_scheduler_feature_hide_show_refresh {} {
	if {$::de1(current_context) == "DSx_admin_saver"} {
		show_hide_from_variable $::DSx_scheduler_widgetids ::settings scheduler_enable write
	}
}

if {$::DSx_settings(admin) == 1} {
    add_de1_image "settings_1 settings_2a settings_2b settings_2c settings_2c2" 1280 0 "[skin_directory_graphics]/admin/tabover.png"
    add_de1_image "DSx_descale_prepare" 1200 1450 "[skin_directory_graphics]/admin/cleanbuttonW.png"
    add_de1_text "DSx_descale_prepare" 1490 1504 -text [translate "Clean now"] -font [DSx_font font 10] -fill "#444444" -anchor "center"
    add_de1_button "DSx_descale_prepare" {say [translate {Clean}] $::settings(sound_button_in); start_cleaning} 1160 1200 1860 1600
}

add_de1_variable "DSx_admin" 1280 60 -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "center" -textvariable {Main Settings}
set ::de1(app_update_button_label) [translate "Update"]

# language & Units
add_de1_image "DSx_admin" 1530 240 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 1730 340 -text [translate "Language Units & Options"] -width [rescale_y_skin 380] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)" -justify "center" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Language}] $::settings(sound_button_in); set_next_page off DSx_units; page_show DSx_units; set_DSx_languages_scrollbar_dimensions;} 1540 240 1910 440

# skin
add_de1_image "DSx_admin" 1530 470 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 1730 570 -text [translate "Skin"] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Styles}] $::settings(sound_button_in); set_next_page off DSx_admin_skin; page_show DSx_admin_skin; DSx_preview_tablet_skin; set_DSx_skins_scrollbar_dimensions;} 1540 470 1910 670

# screen_saver
add_de1_image "DSx_admin" 1530 700 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 1730 800 -text [translate "Screen Saver"] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Screen Saver}] $::settings(sound_button_in); set_next_page off DSx_admin_saver; page_show DSx_admin_saver; DSx_scheduler_feature_hide_show_refresh;} 1540 700 1910 900

# firmware update
add_de1_image "DSx_admin" 1530 930 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_admin" 1730 1030 -text "" -width [rescale_y_skin 380] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -justify "center" -anchor "center" -textvariable {[check_firmware_update_is_available]FW [translate $::de1(firmware_update_button_label)]}
#add_de1_button "DSx_admin" {start_firmware_update} 1540 930 1910 1130
add_de1_button "DSx_admin" {set ::de1(in_fw_update_mode) 1; page_to_show_when_off firmware_update_1} 1540 930 1910 1130

# calibrate
add_de1_image "DSx_admin" 1950 240 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 2150 340 -text [translate "Machine Calibration"] -width [rescale_y_skin 380] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)"  -justify "center" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Calibrate}] $::settings(sound_button_in); calibration_gui_init; set_next_page off calibrate; page_show calibrate; }  1960 240 2330 440

# descale
add_de1_image "DSx_admin" 1950 470 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 2150 570 -text [translate "Clean & Descale"] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Descale}] $::settings(sound_button_in); set_next_page off DSx_descale_prepare; page_show DSx_descale_prepare;} 1960 470 2330 670

# transport
add_de1_image "DSx_admin" 1950 700 "[skin_directory_graphics]/icons/button7.png"
add_de1_text "DSx_admin" 2150 800 -text [translate "Transport"] -font [DSx_font font 9] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_button "DSx_admin" {say [translate {Transport}] $::settings(sound_button_in); set_next_page off DSx_travel_prepare; page_show DSx_travel_prepare; } 1960 700 2330 900

# app update
add_de1_image "DSx_admin" 1950 930 "[skin_directory_graphics]/icons/button7.png"
add_de1_variable "DSx_admin" 2150 1030 -text [translate "Update"] -width [rescale_y_skin 360] -font [DSx_font font 9] -fill $::DSx_settings(font_colour)  -justify "center" -anchor "center" -textvariable {App $::de1(app_update_button_label)}
add_de1_button "DSx_admin" {DSx_app_update} 1960 930 2330 1130

# data
add_de1_text "DSx_admin" 200 544 -text [translate {FW Version}] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -anchor "nw" -width [rescale_y_skin 1220] -justify "left"
add_de1_variable "DSx_admin" 200 634 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "nw" -width [rescale_y_skin 920] -justify "left" -textvariable {[de1_version_string]}
add_de1_text "DSx_admin" 200 220 -text [translate "Counter"] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_text "DSx_admin" 200 310 -text [translate "Espresso"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "nw"
add_de1_text "DSx_admin" 200 370 -text [translate "Steam"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "nw"
add_de1_text "DSx_admin" 200 430 -text [translate "Hot water"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "nw"
add_de1_variable "DSx_admin" 600 310 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "ne" -textvariable {[round_to_integer $::settings(espresso_count)]}
add_de1_variable "DSx_admin" 600 370 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "ne" -textvariable {[round_to_integer $::settings(steaming_count)]}
add_de1_variable "DSx_admin" 600 430 -text "" -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "ne" -textvariable {[round_to_integer $::settings(water_count)]}

# bluetooth connect
add_de1_text "DSx_admin" 60 970 -text [translate "Bluetooth Connect"] -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_variable "DSx_admin" 980 1016 -text {} -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -anchor "center"  -textvariable {[scanning_state_text]}
add_de1_button "DSx_admin" {say [translate {Search}] $::settings(sound_button_in); scanning_restart} 650 960 1260 1070
add_de1_text "DSx_admin" 60 1100 -text [translate "Espresso machine"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_text "DSx_admin" 680 1100 -text [translate "Scale"] -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_variable "DSx_admin" 1200 1100 -text \[[translate "Remove"]\] -font [DSx_font font 7] -fill "#bec7db" -justify "right" -anchor "ne" -textvariable {[if {$::settings(scale_bluetooth_address) != ""} { return \[[translate "Remove"]\]} else {return "" } ] }
add_de1_button "DSx_admin" {say [translate {Remove}] $::settings(sound_button_in);set ::settings(scale_bluetooth_address) ""; fill_ble_scale_listbox} 940 1100 1230 1140 ""

add_de1_widget "DSx_admin settings_4" listbox 55 1150 {
    set ::ble_listbox_widget $widget
    bind $::ble_listbox_widget <<ListboxSelect>> ::change_bluetooth_device
    fill_ble_listbox
} -background #fbfaff -font [DSx_font font 8] -bd 0 -height 3 -width 19 -foreground #d3dbf3 -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single -selectbackground #c0c4e1

add_de1_widget "DSx_admin settings_4" listbox 670 1150 {
    set ::ble_scale_listbox_widget $widget
    bind $widget <<ListboxSelect>> ::change_scale_bluetooth_device
    fill_ble_scale_listbox
} -background #fbfaff -font [DSx_font font 8] -bd 0 -height 3 -width 19 -foreground #d3dbf3 -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single -selectbackground #c0c4e1

###### Sub Pages
# "done" button for all these sub-pages.
add_de1_image "DSx_admin_saver DSx_units DSx_admin_skin" 1080 1210 "[skin_directory_graphics]/icons/button7.png"

add_de1_text "DSx_admin_saver DSx_units DSx_admin_skin" 1280 1310 -text [translate "Done"] -font [DSx_font font 10] -fill "#fAfBff" -anchor "center"
add_de1_button "DSx_admin_saver DSx_units DSx_admin_skin" {DSx_done_button} 980 1210 1580 1410 ""



### Skin
add_de1_text "DSx_admin_skin" 1280 60 -text [translate "Skin"] -font [DSx_font font 10] -width 1200 -fill $::DSx_settings(font_colour) -anchor "center" -justify "center"
set ::DSx_table_style_preview_image [add_de1_image "DSx_admin_skin" 1400 450 ""]
add_de1_widget "DSx_admin_skin" listbox 260 450 {
    set ::globals(DSx_tablet_styles_listbox) $widget
    DSx_fill_skin_listbox
    bind $::globals(DSx_tablet_styles_listbox) <<ListboxSelect>> ::DSx_preview_tablet_skin
} -background $::DSx_settings(bg_colour) -yscrollcommand {scale_scroll ::DSx_skin_slider} -font [DSx_font font 10] -bd 0 -height 10 -width 30 -foreground $::DSx_settings(font_colour) -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single -selectbackground $::DSx_settings(font_colour)

### Language Units & Options
# Language
add_de1_text "DSx_units" 1280 60 -text [translate "Language, Units & Options"] -font [DSx_font font 10] -width 1200 -fill $::DSx_settings(font_colour) -anchor "center" -justify "center"
add_de1_text "DSx_units" 260 300 -text [translate "Language"] -font [DSx_font font 8] -width 1200 -fill $::DSx_settings(font_colour) -anchor "nw" -justify "left"
add_de1_widget "DSx_units" listbox 260 390 {
    set ::DSx_languages_widget $widget
    bind $widget <<ListboxSelect>> ::load_DSx_language
    fill_DSx_languages_listbox
} -background $::DSx_settings(bg_colour) -yscrollcommand {scale_scroll ::DSx_language_slider} -font [DSx_font font 10] -bd 0 -height 6 -width 20 -foreground $::DSx_settings(font_colour) -borderwidth 0 -selectborderwidth 0  -relief flat -highlightthickness 0 -selectmode single  -selectbackground $::DSx_settings(font_colour)
# Screen brightness
add_de1_image "DSx_units" 1480 340 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_units" 1880 440 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {$::settings(app_brightness)%}
add_de1_variable "DSx_units" 1880 560 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[translate "Screen brightness"]}
add_de1_button "DSx_units" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::settings(app_brightness) 0 100 %x %y %x0 %y0 %x1 %y1; save_settings;} 1480 340 2280 540 ""
#font size
add_de1_image "DSx_units" 1880 660 "[skin_directory_graphics]/icons/click1.png"
add_de1_variable "DSx_units" 2124 760 -text "" -font [DSx_font font 14] -fill $::DSx_settings(font_colour) -anchor "center"  -textvariable {$::settings(default_font_calibration)}
add_de1_variable "DSx_units" 2124 890 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -justify center -anchor "center"  -textvariable {[translate "Font size editor. Default = 0.5"]}
add_de1_button "DSx_units" {say "" $::settings(sound_button_in); horizontal_clicker 1 1 ::DSx_settings(font_size) 1 100 %x %y %x0 %y0 %x1 %y1; save_DSx_settings; DSx_font_cal;} 1880 660 2360 860 ""
# Options
add_de1_widget "DSx_units" checkbutton 1400 740 {} -text [translate "Fahrenheit"] -indicatoron true  -font [DSx_font font 10] -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(enable_fahrenheit)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa
add_de1_widget "DSx_units" checkbutton 1400 820 {} -text [translate "AM/PM"] -indicatoron true  -font [DSx_font font 10] -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(enable_ampm)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa
add_de1_widget "DSx_units" checkbutton 1400 900 {} -text [translate "1.234,56"] -indicatoron true  -font [DSx_font font 10] -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(enable_commanumbers)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa
add_de1_widget "DSx_units" checkbutton 1400 980 {set ::DSx_theme_checkbutton_2 $widget} -text [translate "Tare only on espresso start"] -indicatoron true  -font "[DSx_font font 10]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(tare_only_on_espresso_start)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command save_settings
add_de1_widget "DSx_units" checkbutton 1400 1060 {} -text [translate "Use DSx style App settings pages"] -indicatoron true  -font "[DSx_font font 10]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::DSx_settings(admin)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command save_DSx_settings

# Water level
add_de1_text "DSx_units" 260 910  -text [translate "Refill level"] -font [DSx_font font 8] -fill $::DSx_settings(font_colour) -justify "left" -anchor "nw"
add_de1_widget "DSx_units" scale 260 970 {} -from 3 -to 70 -background $::DSx_settings(bg_colour) -borderwidth 1 -bigincrement 1 -showvalue 0 -resolution 1 -length [rescale_x_skin 610] -width [rescale_y_skin 115] -variable ::settings(water_refill_point) -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -orient horizontal -foreground $::DSx_settings(font_colour) -troughcolor $::DSx_settings(bg_colour) -borderwidth 1  -highlightthickness 0
add_de1_variable "DSx_units" 260 1100 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -width 800 -justify "left" -textvariable {[translate "Refill at:"] [water_tank_level_to_milliliters $::settings(water_refill_point)] [translate mL] ($::settings(water_refill_point)[translate mm])}
add_de1_variable "DSx_units" 890 914 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "ne" -width [rescale_y_skin 1000] -justify "right" -textvariable {[translate "Now:"] [water_tank_level_to_milliliters $::de1(water_level)] [translate mL] ([round_to_integer $::de1(water_level)][translate mm])}

### Screen Saver Page
add_de1_text "DSx_admin_saver" 1280 60 -text [translate "Screen Saver"] -font [DSx_font font 10] -width 1200 -fill $::DSx_settings(font_colour) -anchor "center" -justify "center"
# Sleep timer
add_de1_image "DSx_admin_saver" 400 310 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_admin_saver" 800 410 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {$::settings(screen_saver_delay)min}
add_de1_variable "DSx_admin_saver" 800 530 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[translate "Sleep timer"]}
add_de1_button "DSx_admin_saver" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::settings(screen_saver_delay) 0 120 %x %y %x0 %y0 %x1 %y1; save_settings;} 400 310 1200 510 ""
# brightness
add_de1_image "DSx_admin_saver" 1400 310 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_admin_saver" 1800 410 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {$::settings(saver_brightness)%}
add_de1_variable "DSx_admin_saver" 1800 530 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[translate "Brightness"]}
add_de1_button "DSx_admin_saver" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::settings(saver_brightness) 0 100 %x %y %x0 %y0 %x1 %y1; save_settings;} 1400 310 2200 510 ""
# interval
add_de1_image "DSx_admin_saver" 1400 650 "[skin_directory_graphics]/icons/click.png"
add_de1_variable "DSx_admin_saver" 1800 750 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {$::settings(screen_saver_change_interval)min}
add_de1_variable "DSx_admin_saver" 1800 870 -justify center -anchor center -font [DSx_font font 10] -fill $::DSx_settings(font_colour) -textvariable {[translate "Rotation speed (minutes)"]}
add_de1_button "DSx_admin_saver" {say "" $::settings(sound_button_in); horizontal_clicker_int 10 1 ::settings(screen_saver_change_interval) 1 120 %x %y %x0 %y0 %x1 %y1; save_settings;} 1400 650 2200 850 ""

# Clock
add_de1_widget "DSx_admin_saver" checkbutton 1480 970 {} -text [translate "Show screen saver clock"] -indicatoron true  -font "[DSx_font font 10]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(display_time_in_screen_saver)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command save_DSx_settings

# Black Screensaver
add_de1_widget "DSx_admin_saver" checkbutton 1480 1060 {} -text [translate "Black Screensaver"] -indicatoron true  -font "[DSx_font font 10]" -bg $::DSx_settings(bg_colour) -justify left -anchor nw -foreground $::DSx_settings(font_colour) -variable ::settings(black_screen_saver)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa  -relief flat -command save_settings

# scheduled power up/down
add_de1_widget "DSx_admin_saver" checkbutton 400 700 {} -text [translate "Scheduler"] -padx 0 -pady 0 -indicatoron true  -font [DSx_font font 8] -bg $::DSx_settings(bg_colour) -anchor nw -foreground $::DSx_settings(font_colour) -activeforeground #7f879a -variable ::settings(scheduler_enable)  -borderwidth 0 -selectcolor $::DSx_settings(bg_colour) -highlightthickness 0 -activebackground $::DSx_settings(bg_colour) -bd 0 -activeforeground #aaa -command DSx_scheduler_feature_hide_show_refresh -relief flat
set scheduler_widget_id1d [add_de1_widget "DSx_admin_saver" scale 400 750 {} -from 0 -to 85800 -background $::DSx_settings(bg_colour) -borderwidth 1 -bigincrement 3600 -showvalue 0 -resolution 600 -length [rescale_x_skin 800] -width [rescale_y_skin 120] -variable ::settings(scheduler_wake) -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -orient horizontal -foreground $::DSx_settings(font_colour) -troughcolor $::DSx_settings(bg_colour) -borderwidth 1  -highlightthickness 0 ]
set scheduler_widget_id2d [add_de1_variable "DSx_admin_saver" 400 870 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -textvariable {[translate "Heat up:"] [format_alarm_time $::settings(scheduler_wake)]}]
set scheduler_widget_id3d [add_de1_widget "DSx_admin_saver" scale 400 950 {} -from 0 -to 85800 -background $::DSx_settings(bg_colour) -borderwidth 1 -bigincrement 3600 -showvalue 0 -resolution 600 -length [rescale_x_skin 800] -width [rescale_y_skin 120] -variable ::settings(scheduler_sleep) -font [DSx_font font 10] -sliderlength [rescale_x_skin 125] -relief flat -orient horizontal -foreground $::DSx_settings(font_colour) -troughcolor $::DSx_settings(bg_colour) -borderwidth 1  -highlightthickness 0 ]
set scheduler_widget_id4d [add_de1_variable "DSx_admin_saver" 400 1070 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -textvariable {[translate "Cool down:"] [format_alarm_time $::settings(scheduler_sleep)]}]
set scheduler_widget_id5d [add_de1_variable "DSx_admin_saver" 850 700 -text "" -font [DSx_font font 7] -fill $::DSx_settings(font_colour) -anchor "nw" -width [rescale_y_skin 1000] -justify "left" -textvariable {It is [time_format [clock seconds]]}]
set ::DSx_scheduler_widgetids [list $scheduler_widget_id1d $scheduler_widget_id2d $scheduler_widget_id3d $scheduler_widget_id4d $scheduler_widget_id5d]
set_alarms_for_de1_wake_sleep

### Transport
add_de1_text "DSx_travel_prepare" 1280 120 -text [translate "Prepare your espresso machine for transport"] -font [DSx_font font 15] -fill "#a77171" -anchor "center" -width 1000
add_de1_text "DSx_travel_prepare" 1520 1000 -text [translate "After you press Ok, pull the water tank forward as shown in this photograph."] -font [DSx_font font 10] -fill "#a77171" -anchor "nw" -width 500
add_de1_text "DSx_travel_prepare" 280 1504 -text [translate "Cancel"] -font [DSx_font font 10] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_text "DSx_travel_prepare" 2300 1504 -text [translate "Ok"] -font [DSx_font font 10] -fill "$::DSx_settings(font_colour)" -anchor "center"
add_de1_button "DSx_travel_prepare" {say [translate {Cancel}] $::settings(sound_button_in);set_next_page off DSx_admin; page_show DSx_admin;} 0 1200 600 1600 ""
add_de1_button "DSx_travel_prepare" {say [translate {Ok}] $::settings(sound_button_in); set_next_page off off; start_air_purge} 1960 1200 2560 1600 ""

### Clean
add_de1_text "DSx_descale_prepare" 70 50 -text [translate "Prepare to descale"] -font [DSx_font font 20] -fill "#a77171" -anchor "nw" -width 1000
add_de1_text "DSx_descale_prepare" 1050 280 -text [translate "1) Remove the drip tray and its cover."] -font [DSx_font font 8] -fill "#a77171" -anchor "sw" -justify left -width 400
add_de1_text "DSx_descale_prepare" 1050 670 -text [translate "2) In the water tank, mix 1.5 liter hot water with 300g citric acid powder."] -font [DSx_font font 8] -fill "#a77171" -anchor "sw" -justify left -width 400
add_de1_text "DSx_descale_prepare" 1050 970 -text [translate "3) Put a blind basket in the portafilter."] -font [DSx_font font 8] -fill "#a77171" -anchor "sw" -justify left -width 400
add_de1_text "DSx_descale_prepare" 1050 1350 -text [translate "4) Push back the water tank.  Place the drip tray back without its cover."] -font [DSx_font font 8] -fill "#a77171" -anchor "sw" -justify left -width 400
add_de1_text "DSx_descale_prepare" 340 1504 -text [translate "Cancel"] -font [DSx_font font 10] -fill "#444444" -anchor "center"
add_de1_text "DSx_descale_prepare" 2233 1504 -text [translate "Descale now"] -font [DSx_font font 10] -fill "#444444" -anchor "center"
add_de1_button "DSx_descale_prepare" {say [translate {Cancel}] $::settings(sound_button_in);set_next_page off DSx_admin; page_show DSx_admin;} 0 1200 700 1600 ""
add_de1_button "DSx_descale_prepare" {say [translate {Ok}] $::settings(sound_button_in); start_decaling} 1860 1200 2560 1600 ""

### Calibrate
add_de1_text "calibrate calibrate2" 1280 1310 -text [translate "Done"] -font Helv_10_bold -fill "#fAfBff" -anchor "center"
add_de1_button "calibrate calibrate2" {say [translate {Done}] $::settings(sound_button_in);
    if {[ifexists ::calibration_disabled_fahrenheit] == 1} {
        set ::settings(enable_fahrenheit) 1
        unset -nocomplain ::calibration_disabled_fahrenheit
        msg "Calibration re-enabled Fahrenheit"
    }

    save_settings; set_next_page off DSx_admin;
    set_heater_tweaks;
    set ::DSx_settings(backup_phase_2_flow_rate) $::settings(phase_2_flow_rate)
    set ::DSx_settings(backup_espresso_warmup_timeout) $::settings(espresso_warmup_timeout)
    page_show DSx_admin;} 980 1210 1580 1410 ""
