extends Control


func _ready():
	$AnimationPlayer.play("Fade_in")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("Fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scene/starting_scene.tscn")

func _process(delta):
	pass
