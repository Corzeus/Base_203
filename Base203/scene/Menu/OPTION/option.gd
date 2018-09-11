extends Node2D

const CONFIG_FILE = "user://input.save"

var InputMap setget save_config
var action
var button
var joy_num = 0
var quicktest = false
var USABLE_BUTTON = [ "KEY_ESCAPE", "KEY_BACKSPACE", "KEY_ENTER", "KEY_KP_ENTER", "KEY_HOME", "KEY_END", "KEY_LEFT", "KEY_RIGHT", "KEY_UP", "KEY_DOWN", "KEY_PAGEUP", "KEY_PAGE_DOWN", "KEY_SHIFT", "KEY_CONTROL", "KEY_ALT", "KEY_KP_0", "KEY_KP_1", "KEY_KP_2", "KEY_KP_3", "KEY_KP_4", "KEY_KP_5", "KEY_KP_6", "KEY_KP_7", "KEY_KP_8", "KEY_KP_9", "KEY_SPACE", "KEY_EXCLAM", "KEY_QUOTEDBL", "KEY_NUMBERSIGN", "KEY_DOLLAR", "KEY_PERCET", "KEY_AMPERSAND", "KEY_APOSTROPHE", "KEY_PARENLEFT", "KEY_PARENRIGHT", "KEY_ASTERISK", "KEY_PLUS", "KEY_COMMA", "KEY_MINUS", "KEY_PERIOD", "KEY_SLAHS", "KEY_0", "KEY_1", "KEY_2", "KEY_3", "KEY_4", "KEY_5", "KEY_6", "KEY_7", "KEY_8", "KEY_9", "KEY_COLON", "KEY_SEMICOLON", "KEY_LESS", "KEY_EQUAL", "KEY_GREATER", "KEY_QUESTION", "KEY_AT", "KEY_A", "KEY_B", "KEY_C", "KEY_D", "KEY_E", "KEY_F", "KEY_G", "KEY_H", "KEY_I", "KEY_J", "KEY_K", "KEY_L", "KEY_M", "KEY_N", "KEY_M", "KEY_O", "KEY_P", "KEY_Q", "KEY_R", "KEY_S", "KEY_T", "KEY_U", "KEY_V", "KEY_W", "KEY_X", "KEY_Y", "KEY_Z", "KEY_UNDERSCORE" ]
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
	save_conf.store_line(to_json(InputMap.get_actions()))
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

func _ready():
	if not ProjectSettings.get_setting("Config/input/OK"):
		ProjectSettings.set_setting("Config/input/OK",true)
		load_config()
		get_tree().change_scene("res://scene/Menu/MAIN_MENU/MAIN.tscn")
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
			if Input.is_key_pressed(OS.find_scancode_from_string(k)):
				InputMap.erase_action("ui_up")
				InputMap.add_action("ui_up")
				InputMap.action_add_event("ui_up", InputEventKey.scancode(OS.find_scancode_from_string(k)))
				InputMap.action_add_event("ui_up", InputEventJoypadButton.button_index(12))
				InputMap.action_add_event("ui_up", InputEventJoypadMotion.axis(1))
				quicktest = true
				unfreeze_til_input()
				break

func _on_DOWN_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON():
			if Input.is_key_pressed(OS.find_scancode_from_string(k)):
				InputMap.erase_action("ui_down")
				InputMap.add_action("ui_down")
				InputMap.action_add_event("ui_down", InputEventKey.scancode(OS.find_scancode_from_string(k)))
				InputMap.action_add_event("ui_up", InputEventJoypadButton.button_index(13))
				InputMap.action_add_event("ui_up", InputEventJoypadMotion.axis(1))
				quicktest = true
				unfreeze_til_input()
				break

func _on_LEFT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(OS.find_scancode_from_string(k)):
				InputMap.erase_action("ui_left")
				InputMap.add_action("ui_left")
				InputMap.action_add_event("ui_left", InputEventKey.scancode(OS.find_scancode_from_string(k)))
				InputMap.action_add_event("ui_up", InputEventJoypadButton.button_index(14))
				InputMap.action_add_event("ui_up", InputEventJoypadMotion.axis(0))
				quicktest = true
				unfreeze_til_input()
				break

func _on_RIGHT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(OS.find_scancode_from_string(k)):
				InputMap.erase_action("ui_right")
				InputMap.add_action("ui_right")
				InputMap.action_add_event("ui_right", InputEventKey.scancode(OS.find_scancode_from_string(k)))
				InputMap.action_add_event("ui_up", InputEventJoypadButton.button_index(15))
				InputMap.action_add_event("ui_up", InputEventJoypadMotion.axis(0))
				quicktest = true
				unfreeze_til_input()
				break

func _on_PAUSE_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for k in USABLE_BUTTON:
			if Input.is_key_pressed(OS.find_scancode_from_string(k)):
				InputMap.erase_action("ui_right")
				InputMap.add_action("ui_right")
				InputMap.action_add_event("ui_right", InputEventKey.scancode(OS.find_scancode_from_string(k)))
				quicktest = true
				unfreeze_til_input()
				break

func _on_ACCEPT_pressed():
	freeze_til_input()
	quicktest = false
	while not quicktest:
		for btn in range(15):
			if Input.is_joy_button_pressed(joy_num, btn):
				InputMap.erase_action("ui_menu")
				InputMap.add_action("ui_menu")
				InputMap.action_add_event("ui_menu",InputEventJoypadButton.button_index(btn))
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
				InputMap.erase_action("ui_menu")
				InputMap.add_action("ui_menu")
				InputMap.action_add_event("ui_menu",InputEventJoypadButton.button_index(btn))
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
