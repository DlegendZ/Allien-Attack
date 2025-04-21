extends Area2D
signal CommanderDie
signal PlayerDead
var Speed = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y += Speed * delta
	if global_position.y > get_viewport_rect().size.y + get_viewport_rect().size.y * 0.3 :
		queue_free()
		
func CommanderKilled():
	emit_signal("CommanderDie")
	queue_free()
	
func _on_area_entered(area):
	if area.name == "Player" :
		emit_signal("PlayerDead")
		queue_free()
