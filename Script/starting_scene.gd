extends Node2D
@onready var GameScene = preload("res://Scene/Game.tscn")

func _ready():
	$"Main Menu".play()

func _process(delta):
	get_node("Spawner/Enemy/EnemySpawner/Timer").wait_time = 0.05
	var ScrollSpeed = 100
	$Graphic/CanvasLayer/ParallaxBackground.scroll_offset.y += delta * ScrollSpeed

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scene/Game.tscn")


func _on_enemy_spawner_enemy(EnemyId):
	get_node("Spawner/Enemy/EnemySpawner/EnemyContainer").add_child(EnemyId)
