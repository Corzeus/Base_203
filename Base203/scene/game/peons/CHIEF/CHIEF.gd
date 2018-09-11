extends Node2D

var draged = false
var zone = 0
var z_pos = 0
var mouse = false

func _ready():
	pass

func _process(delta):
	if mouse and Input.is_mouse_button_pressed(0):
		pass

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"zone" : zone,
		"z_pos" : z_pos
	}
	return save_dict

func _on_Area2D_mouse_entered():
	mouse = true

func _on_Area2D_mouse_exited():
	mouse = false
