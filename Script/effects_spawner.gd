extends Node2D
signal EffectsSignal(EffectsId)
var LifeCount = 0
var ShieldCount = 0
var DoubleScoreCount = 0
@export var Effects : Array[PackedScene] = []

func Effect() :
	var getEffect = Effects.pick_random()
	var EffectInstance = getEffect.instantiate()
	if getEffect == preload("res://Scene/life_add.tscn") :
		LifeCount += 1
		EffectInstance.name = "LifeAdd_" + str(LifeCount)
	elif getEffect == preload("res://Scene/shield.tscn") :
		ShieldCount += 1
		EffectInstance.name = "Shield_" + str(ShieldCount)
	elif getEffect == preload("res://Scene/double_score.tscn") :
		DoubleScoreCount += 1
		EffectInstance.name = "DoubleScore_" + str(DoubleScoreCount)
	EffectInstance.global_position = Vector2(randf_range(40,1100), -100)
	emit_signal("EffectsSignal", EffectInstance)
