extends Camera2D

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
	}
	return save_dict

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		set(position.y, OP_ADD(position.y, 50))
	if Input.is_action_pressed("ui_down"):
		set(position.y, OP_ADD(position.y, -50))
	if Input.is_action_pressed("ui_right"):
		set(position.x, OP_ADD(position.x, 50))
	if Input.is_action_pressed("ui_left"):
		set(position.x, OP_ADD(position.x, -50))