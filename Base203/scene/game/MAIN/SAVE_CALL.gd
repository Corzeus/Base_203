extends Node2D

var save_path = "res://save/savegame.save"

func _ready():
	load_game()

func _process(delta):
	if Input.is_action_pressed("SAVE"):
		save_game()

func save_game():
	var save_game = File.new()
	save_game.open(save_path, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(save_path):
		return
	var save_node = get_tree().get_nodes_in_group("Persist")
	for i in save_node:
		i.queue_free()
	save_game.open(save_path, File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		var new_object = load(current_line["filename"]).instance()
		get_node(current_line["parent"]).add_child(new_object)
		new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		for i in current_line.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, current_line[i])
	save_game.close()
