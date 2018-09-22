extends Node2D

const CONFIG_FILE = "user://input.save"

var InputMap #setget save_config
var action
var button
var joy_num = 0
var quicktest = false
var USABLE_BUTTON = [ OS.find_scancode_from_string("KEY_ESCAPE"), OS.find_scancode_from_string("KEY_BACKSPACE"), OS.find_scancode_from_string("KEY_ENTER"), OS.find_scancode_from_string("KEY_KP_ENTER"), OS.find_scancode_from_string("KEY_HOME"), OS.find_scancode_from_string("KEY_END"), OS.find_scancode_from_string("KEY_LEFT"), OS.find_scancode_from_string("KEY_RIGHT"), OS.find_scancode_from_string("KEY_UP"), OS.find_scancode_from_string("KEY_DOWN"), OS.find_scancode_from_string("KEY_PAGEUP"), OS.find_scancode_from_string("KEY_PAGE_DOWN"), OS.find_scancode_from_string("KEY_SHIFT"), OS.find_scancode_from_string("KEY_CONTROL"), OS.find_scancode_from_string("KEY_ALT"), OS.find_scancode_from_string("KEY_KP_0"), OS.find_scancode_from_string("KEY_KP_1"), OS.find_scancode_from_string("KEY_KP_2"), OS.find_scancode_from_string("KEY_KP_3"), OS.find_scancode_from_string("KEY_KP_4"), OS.find_scancode_from_string("KEY_KP_5"), OS.find_scancode_from_string("KEY_KP_6"), OS.find_scancode_from_string("KEY_KP_7"), OS.find_scancode_from_string("KEY_KP_8"), OS.find_scancode_from_string("KEY_KP_9"), OS.find_scancode_from_string("KEY_SPACE"), OS.find_scancode_from_string("KEY_EXCLAM"), OS.find_scancode_from_string("KEY_QUOTEDBL"), OS.find_scancode_from_string("KEY_NUMBERSIGN"), OS.find_scancode_from_string("KEY_DOLLAR"), OS.find_scancode_from_string("KEY_PERCET"), OS.find_scancode_from_string("KEY_AMPERSAND"), OS.find_scancode_from_string("KEY_APOSTROPHE"), OS.find_scancode_from_string("KEY_PARENLEFT"), OS.find_scancode_from_string("KEY_PARENRIGHT"), OS.find_scancode_from_string("KEY_ASTERISK"), OS.find_scancode_from_string("KEY_PLUS"), OS.find_scancode_from_string("KEY_COMMA"), OS.find_scancode_from_string("KEY_MINUS"), OS.find_scancode_from_string("KEY_PERIOD"), OS.find_scancode_from_string("KEY_SLAHS"), OS.find_scancode_from_string("KEY_0"), OS.find_scancode_from_string("KEY_1"), OS.find_scancode_from_string("KEY_2"), OS.find_scancode_from_string("KEY_3"), OS.find_scancode_from_string("KEY_4"), OS.find_scancode_from_string("KEY_5"), OS.find_scancode_from_string("KEY_6"), OS.find_scancode_from_string("KEY_7"), OS.find_scancode_from_string("KEY_8"), OS.find_scancode_from_string("KEY_9"), OS.find_scancode_from_string("KEY_COLON"), OS.find_scancode_from_string("KEY_SEMICOLON"), OS.find_scancode_from_string("KEY_LESS"), OS.find_scancode_from_string("KEY_EQUAL"), OS.find_scancode_from_string("KEY_GREATER"), OS.find_scancode_from_string("KEY_QUESTION"), OS.find_scancode_from_string("KEY_AT"), OS.find_scancode_from_string("KEY_A"), OS.find_scancode_from_string("KEY_B"), OS.find_scancode_from_string("KEY_C"), OS.find_scancode_from_string("KEY_D"), OS.find_scancode_from_string("KEY_E"), OS.find_scancode_from_string("KEY_F"), OS.find_scancode_from_string("KEY_G"), OS.find_scancode_from_string("KEY_H"), OS.find_scancode_from_string("KEY_I"), OS.find_scancode_from_string("KEY_J"), OS.find_scancode_from_string("KEY_K"), OS.find_scancode_from_string("KEY_L"), OS.find_scancode_from_string("KEY_M"), OS.find_scancode_from_string("KEY_N"), OS.find_scancode_from_string("KEY_M"), OS.find_scancode_from_string("KEY_O"), OS.find_scancode_from_string("KEY_P"), OS.find_scancode_from_string("KEY_Q"), OS.find_scancode_from_string("KEY_R"), OS.find_scancode_from_string("KEY_S"), OS.find_scancode_from_string("KEY_T"), OS.find_scancode_from_string("KEY_U"), OS.find_scancode_from_string("KEY_V"), OS.find_scancode_from_string("KEY_W"), OS.find_scancode_from_string("KEY_X"), OS.find_scancode_from_string("KEY_Y"), OS.find_scancode_from_string("KEY_Z"), OS.find_scancode_from_string("KEY_UNDERSCORE") ]
var total_control = [ "ui_up", "ui_down", "ui_left", "ui_right", "ui_pause", "ui_accept", "ui_select", "ui_menu", "ui_cancel" ]

func freeze_til_input():
	get_tree().call_group("L1","Set(PAUSE_MODE_STOP)")

func unfreeze_til_input():
	get_tree().call_group("L1","Set(PAUSE_MODE_INHERIT)")

func load_config():
	var save_conf = File.new()
	if not save_conf.file_exists(CONFIG_FILE):
		save_config()
	save_conf.open(CONFIG_FILE, File.READ)
	var current_line = parse_json(save_conf.get_line())
	for e in total_control:
		InputMap.erase_action(e)
		InputMap.add_action(e)
		InputMap.action_add_event(e, current_line[e])
	save_conf.close()

func save_config():
	var save_conf = File.new()
	save_conf.open(CONFIG_FILE, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	"""var input_data = {
	"ui_up" : InputMap.get_action_list("ui_up"),
	"ui_down" : InputMap.get_action_list("ui_down"),
	"ui_left" : InputMap.get_action_list("ui_left"),
	"ui_right" : InputMap.get_action_list("ui_right"),
	"ui_pause" : InputMap.get_action_list("ui_pause"),
	"ui_accept" : InputMap.get_action_list("ui_accept"),
	"ui_select" : InputMap.get_action_list("ui_select"),
	"ui_menu" : InputMap.get_action_list("ui_menu"),
	"ui_cancel" : InputMap.get_action_list("ui_cancel")
	}"""
	save_conf.store_line(to_json(0))
	save_conf.close()

func joy_mode():
	if [Input.get_connected_joypads()].has(0):
		ProjectSettings.set_setting("Config/input/Controler_Mode",true)
		get_tree().call_group("Auto_focus","grab_focus")
		get_tree().call_group("KEYBOARD","Set(visible,false)")
		get_tree().call_group("GAMEPAD","Set(visible,true)")
	else:
		ProjectSettings.set_setting("Config/input/Controler_Mode",false)
		get_tree().call_group("Auto_focus","grab_focus")
		get_tree().call_group("KEYBOARD","Set(visible,true)")
		get_tree().call_group("GAMEPAD","Set(visible,false)")

func get_joy_event(act_name):
	for i in 16:
		if InputMap.has_event_action(act_name,InputEventJoypadButton.button_index(i)):
			return i

func get_key_event(act_name):
	for i in USABLE_BUTTON:
		if InputMap.has_event_action(act_name,i):
			return i

func get_axis_event(act_name):
	for i in 5:
		if InputMap.has_event_action(act_name,InputEventJoypadMotion.axis_index(i)):
			return i

func _ready():
	if not ProjectSettings.get_setting("Config/input/OK"):
		ProjectSettings.set_setting("Config/input/OK",true)
		#load_config()
		get_tree().change_scene("res://scene/Menu/MAIN_MENU/MAIN.tscn")
		#for i in total_control:
		#	InputMap.erase_action(i)
		#	InputMap.add_action(i)
		#InputMap.erase_action("ui_focus_prev")
		#InputMap.erase_action("ui_focus_next")
		#InputMap.erase_action("ui_page_up")
		#InputMap.erase_action("ui_page_down")
		#InputMap.action_add_event("ui_down", InputEventKey.scancode(OS.find_scancode_from_string("KEY_DOWN")))
		#InputMap.action_add_event("ui_down", InputEventJoypadButton.button_index(13))
		#InputMap.action_add_event("ui_down", InputEventJoypadMotion.axis(1))
		#InputMap.action_add_event("ui_up", InputEventKey.scancode(OS.find_scancode_from_string("KEY_UP")))
		#InputMap.action_add_event("ui_up", InputEventJoypadButton.button_index(12))
		"""InputMap.action_add_event("ui_up", InputEventJoypadMotion.axis(1))
		InputMap.action_add_event("ui_left", InputEventKey.scancode(OS.find_scancode_from_string("KEY_LEFT")))
		InputMap.action_add_event("ui_left", InputEventJoypadButton.button_index(14))
		InputMap.action_add_event("ui_left", InputEventJoypadMotion.axis(0))
		InputMap.action_add_event("ui_right", InputEventKey.scancode(OS.find_scancode_from_string("KEY_RIGHT")))
		InputMap.action_add_event("ui_right", InputEventJoypadButton.button_index(15))
		InputMap.action_add_event("ui_right", InputEventJoypadMotion.axis(0))
		InputMap.action_add_event("ui_accept", InputEventKey.scancode(OS.find_scancode_from_string("KEY_ENTER")))
		InputMap.action_add_event("ui_accept", InputEventKey.scancode(OS.find_scancode_from_string("KEY_KP_ENTER")))
		InputMap.action_add_event("ui_accept", InputEventJoypadButton.button_index(0))
		InputMap.action_add_event("ui_cancel", InputEventKey.scancode(OS.find_scancode_from_string("KEY_ESCAPE")))
		InputMap.action_add_event("ui_cancel", InputEventJoypadButton.button_index(1))
		InputMap.action_add_event("ui_menu", InputEventKey.scancode(OS.find_scancode_from_string("KEY_ENTER")))
		InputMap.action_add_event("ui_menu", InputEventJoypadButton.button_index(3))
		InputMap.action_add_event("ui_select", InputEventKey.scancode(OS.find_scancode_from_string("KEY_ESCAPE")))
		InputMap.action_add_event("ui_select", InputEventJoypadButton.button_index(2))
		InputMap.action_add_event("ui_pause", InputEventKey.scancode(OS.find_scancode_from_string("KEY_ESCAPE")))
		InputMap.action_add_event("ui_pause", InputEventJoypadButton.button_index(2))"""
	get_tree().call_group("Auto_focus","grab_focus")
	get_tree().call_group("KEYBOARD","Set(visible,true)")
	get_tree().call_group("GAMEPAD","Set(visible,false)")
	save_config()

func _process(delta):
	save_config()
	joy_mode()

func _on_FULL_SCREEN_pressed():
	if (OS.is_window_fullscreen()):
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)

func _on_To_EN_pressed():
	TranslationServer.set_locale("en")

func _on_To_FR_pressed():
	TranslationServer.set_locale("fr")

func _on_UP_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON():
			if Input.is_key_pressed(k):
				var quickvar1 = InputEventJoypadButton.button_index(get_joy_event("ui_up"))
				var quickvar2 = InputEventJoypadMotion.axis(get_axis_event("ui_up"))
				InputMap.erase_action("ui_up")
				InputMap.add_action("ui_up")
				InputMap.action_add_event("ui_up", InputEventKey.scancode(k))
				InputMap.action_add_event("ui_up", quickvar1)
				InputMap.action_add_event("ui_up", quickvar2)
				quicktest = true
				unfreeze_til_input()
				break

func _on_DOWN_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON():
			if Input.is_key_pressed(k):
				InputMap.erase_action("ui_down")
				InputMap.add_action("ui_down")
				InputMap.action_add_event("ui_down", InputEventKey.scancode(k))
				InputMap.action_add_event("ui_down", InputEventJoypadButton.button_index(13))
				InputMap.action_add_event("ui_down", InputEventJoypadMotion.axis(1))
				quicktest = true
				unfreeze_til_input()
				break

func _on_LEFT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(k):
				InputMap.erase_action("ui_left")
				InputMap.add_action("ui_left")
				InputMap.action_add_event("ui_left", InputEventKey.scancode(k))
				InputMap.action_add_event("ui_left", InputEventJoypadButton.button_index(14))
				InputMap.action_add_event("ui_left", InputEventJoypadMotion.axis(0))
				quicktest = true
				unfreeze_til_input()
				break

func _on_RIGHT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(k):
				InputMap.erase_action("ui_right")
				InputMap.add_action("ui_right")
				InputMap.action_add_event("ui_right", InputEventKey.scancode(k))
				InputMap.action_add_event("ui_right", InputEventJoypadButton.button_index(15))
				InputMap.action_add_event("ui_right", InputEventJoypadMotion.axis(0))
				quicktest = true
				unfreeze_til_input()
				break

func _on_PAUSE_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(k):
				InputMap.erase_action("ui_pause")
				InputMap.add_action("ui_pause")
				InputMap.action_add_event("ui_pause", InputEventKey.scancode(k))
				quicktest = true
				unfreeze_til_input()
				break

func _on_ACCEPT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_accept")
				InputMap.add_action("ui_accept")
				InputMap.action_add_event("ui_accept",InputEventJoypadButton.button_index(btn))
				quicktest = true
				unfreeze_til_input()
				break

func _on_SUB_SELECT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_select")
				InputMap.add_action("ui_select")
				InputMap.action_add_event("ui_select",InputEventJoypadButton.button_index(btn))
				quicktest = true
				unfreeze_til_input()
				break

func _on_INVENTORY_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_inventory")
				InputMap.add_action("ui_inventory")
				InputMap.action_add_event("ui_inventory",InputEventJoypadButton.button_index(btn))
				quicktest = true
				unfreeze_til_input()
				break

func _on_BACK_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_cancel")
				InputMap.add_action("ui_cancel")
				InputMap.action_add_event("ui_cancel",InputEventJoypadButton.button_index(btn))
				quicktest = true
				unfreeze_til_input()
				break

func _on_PAUSEPAD_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_pause")
				InputMap.add_action("ui_pause")
				InputMap.action_add_event("ui_pause",InputEventJoypadButton.button_index(btn))
				quicktest = true
				unfreeze_til_input()
				break
