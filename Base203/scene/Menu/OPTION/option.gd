extends Node2D

func _ready():
	get_tree().call_group("Auto_focus","grab_focus")

func _process(delta):
	if Input.is_joy_known(0):
		ProjectSettings.set_setting("Config/input/Controler_Mode",true)
	else:
		ProjectSettings.set_setting("Config/input/Controler_Mode",false)

func _on_FULL_SCREEN_pressed():
	if (OS.is_window_fullscreen()):
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)

func _on_To_EN_pressed():
	TranslationServer.set_locale("en")

func _on_To_FR_pressed():
	TranslationServer.set_locale("fr")
