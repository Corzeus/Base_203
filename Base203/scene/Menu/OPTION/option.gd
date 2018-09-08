extends Node2D

const INPUT_ACTIONS = [ "UP", "DOWN", "LEFT", "RIGHT", "PAUSE", "ACCEPT", "SUB_SELECT" ]
const CONFIG_FILE = "res://Resource/SPE/input.cfg"

var action
var button

func freeze_til_input():
	get_tree().call_group("L1","Set(PAUSE_MODE_STOP)")

func unfreeze_til_input():
	get_tree().call_group("L1","Set(PAUSE_MODE_INHERIT)")

func load_config():
	pass

func joy_mode():
	if Input.is_joy_known(0):
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

func _process(delta):
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
	while not InputEventKey.pressed():
		pass

func _on_DOWN_pressed():
	freeze_til_input()
	while not InputEventKey.pressed():
		pass

func _on_LEFT_pressed():
	freeze_til_input()
	while not InputEventKey.pressed():
		pass

func _on_RIGHT_pressed():
	freeze_til_input()
	while not InputEventKey.pressed():
		pass

func _on_PAUSE_pressed():
	freeze_til_input()
	while not InputEventKey.pressed():
		pass

func _on_ACCEPT_pressed():
	freeze_til_input()
	while not InputEventKey.pressed():
		pass
