extends Button

var save_path = "res://save/savegame.save"

func _on_Button_pressed():
	var save_game = File.new()
	save_game.open(save_path, File.WRITE)
	var blank_data = {
		"filename" : "res://scene/game/peons/Cheif.tscn",
		"parent" : "/root/BASE",
		"pos_x" : 0,
		"pos_y" : 0,
		"zone" : 0,
		"pos_z" : 0
		}
	save_game.store_line(to_json(blank_data))
	get_tree().change_scene("res://scene/game/MAIN/BASE.tscn")