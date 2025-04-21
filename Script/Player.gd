extends Area2D
@export var speed = 400
@onready var no_cooldown = true
func _ready():
	global_position = get_viewport_rect().size * 0.5

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		direction.x = speed
	if Input.is_action_pressed("MoveLeft"):
		direction.x = -speed
	if Input.is_action_pressed("MoveUp"):
		direction.y = -speed
	if Input.is_action_pressed("MoveDown"):
		direction.y = speed
	if direction.length() > 0:
		direction = direction.normalized()
	global_position += direction * speed  * delta
	global_position = global_position.clamp(Vector2(), get_viewport_rect().size)
	if Input.is_action_pressed("Shoot") and no_cooldown == true:
		Shoot()
		no_cooldown = false
		await get_tree().create_timer(0.2).timeout
		no_cooldown = true
	
func Shoot() :   
	var Laser = preload("res://Scene/laser.tscn")
	var LaserInstance = Laser.instantiate()
	$"Laser Container".add_child(LaserInstance)
	LaserInstance.global_position = global_position
	$AudioStreamPlayer.play()
	
