extends Node2D
signal Enemy(EnemyId)
@export var RandomEnemy : Array[PackedScene] = []
var NormalCount = 0
var GeneralsCount = 0
var CommandersCount = 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func SpawnEnemy():
	var enemy = RandomEnemy.pick_random()
	var enemyinstance = enemy.instantiate()
	var spawnposition = Vector2(randf_range(40,1100), -100)
	if enemy == preload("res://Scene/enemy.tscn") :
		NormalCount += 1
		enemyinstance.name = "Normal_" + str(NormalCount)
	elif enemy == preload("res://Scene/enemy_generals.tscn") :
		GeneralsCount += 1
		enemyinstance.name = "Generals_" + str(GeneralsCount)
	elif enemy == preload("res://Scene/enemy_commanders.tscn") :
		CommandersCount += 1
		enemyinstance.name = "Commanders_" + str(CommandersCount)
	enemyinstance.global_position = spawnposition
	emit_signal("Enemy", enemyinstance)

func _on_timer_timeout():
	SpawnEnemy()
