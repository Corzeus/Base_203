extends Node

var gamepad = ProjectSettings.get_setting("Config/Input/Controller_mode")
var Time = 0
var LNED
var ND2D

func _ready():
	var CN = get_tree().get_nodes_in_group("cheat_node")
	for i in CN:
		ND2D = i
	var CL = get_tree().get_nodes_in_group("cheat_line")
	for i in CN:
		LNED = i

func _process(delta):
	if Input.is_action_pressed("ui_cheat") and not ND2D.call(get("visible")):
		ND2D.call(set("visible",true))
	if Input.is_action_pressed("ui_cheat") and LNED.call(get("visible")):
		LNED.call(set("visible",false))
	ND2D.call(set("Position.y",(OS.get_window_safe_area().size.y)/2))
	LNED.call(set("Position.x",((OS.get_window_safe_area().size.x)/2)*-1))
	LNED.call(set("size.x",OS.get_window_safe_area().size.x))

func _on_Timer_timeout():
	Time = 1 + Time
