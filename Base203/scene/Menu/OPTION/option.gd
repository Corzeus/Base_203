extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func _on_FULL_SCREEN_pressed():
	if (OS.is_window_fullscreen()):
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)

func _on_To_EN_pressed():
	TranslationServer.set_locale("en")

func _on_To_ES_pressed():
	TranslationServer.set_locale("es")

func _on_To_FR_pressed():
	TranslationServer.set_locale("fr")
