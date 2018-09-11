extends Node

var gamepad = ProjectSettings.get_setting("Config/Input/Controller_mode")
var CN = get_tree().get_nodes_in_group("cheat_node")
var CL = get_tree().get_nodes_in_group("cheat_line")

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cheat") and not get("visible"):
		for i in CN:
			i.call(set("visible",true))
	if Input.is_action_pressed("ui_cheat") and get("visible"):
		for i in CN:
			i.call(set("visible",false))
	for i in CN:
		i.call(set("position.y",(OS.get_window_safe_area().size.y)/2))
	for i in CL:
		i.call(set("position.x",((OS.get_window_safe_area().size.x)/2)*-1))
		i.call(set("size.x",OS.get_window_safe_area().size.x))