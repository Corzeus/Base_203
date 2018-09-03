extends Node2D

var draged = false
var zone = 0
var z_pos = 0

func _ready():
	pass

func _process(delta):
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
