extends Control


func Restart() :
	get_tree().reload_current_scene()


func _on_restart_pressed():
	Restart()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/starting_scene.tscn")
