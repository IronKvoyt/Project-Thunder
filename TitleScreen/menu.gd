extends Control

var level= "res://node_2d.tscn"

func _on_button_play_click_end():
	var _level = get_tree().change_scene_to_file(level)
	



func _on_button_exit_click_end():
	get_tree().quit()
