extends Area2D
signal PlayerGotLifeAdd


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	global_position.y += 200 * delta
	if global_position.y > get_viewport_rect().size.y + get_viewport_rect().size.y * 0.3 :
		queue_free()

func _on_area_entered(area):
	if area.name == "Player" :
		emit_signal("PlayerGotLifeAdd")
		queue_free()
		
