extends Button

func _ready():
	grab_focus()

func _on_PLAY_pressed():
	get_tree().change_scene("res://scene/MENU/NEWGAME/newgame.tscn")
