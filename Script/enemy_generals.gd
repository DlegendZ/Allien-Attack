extends Area2D
signal PlayerLifeCrit
signal Player2Kills
var GeneralsLife = 2
var Speed = 400
func _ready():
	pass

func _process(delta):
	global_position.y += Speed * delta
	if global_position.y > get_viewport_rect().size.y + get_viewport_rect().size.y * 0.3 :
		queue_free()

func _on_area_entered(area):
	if area.name == "Player" :
		emit_signal("PlayerLifeCrit")
		queue_free()
	else :
		pass
		
func EnemyGeneralsKilled() :
	GeneralsLife -= 1
	$AudioStreamPlayer.play()
	$Shield.visible = false
	if GeneralsLife == 0 :
		emit_signal("Player2Kills")
		queue_free()
	
