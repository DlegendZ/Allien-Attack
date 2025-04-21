extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y -= 550 * delta 
	if global_position.y < 0 :
		queue_free()

func _on_area_entered(area):
	if area.name == "Player" :
		pass
	elif area.name.begins_with("Generals_") :
		area.EnemyGeneralsKilled()
		queue_free()
	elif area.name.begins_with("Normal_"):
		area.EnemyKilled()
		queue_free()
	elif area.name.begins_with("Commanders_"):
		area.CommanderKilled()
		queue_free()
	else : pass
	
