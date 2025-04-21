extends Node2D
var NewScore = 0
var NewLife = 5
var HighScore
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("UI/Level/Levels").text = "Level : 1"
	get_node("EnemySpawner/Timer").wait_time = 0.5
	$AudioPack/Background.play()
	OpenHS()
	get_node("UI/ScoreUI/Score").text = "Score :     " + str(NewScore).pad_zeros(6)
	get_node("UI/LifeUI/Life").text = str(NewLife)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level()
	var ScrollSpeed = 100
	$Graphic/CanvasLayer/ParallaxBackground.scroll_offset.y += ScrollSpeed * delta

func SaveHS() :
	var WriteHS = FileAccess.open("user://HighScore", FileAccess.WRITE)
	WriteHS.store_32(HighScore)
	
func OpenHS() :
	var ReadHS = FileAccess.open("user://HighScore", FileAccess.READ)
	if ReadHS != null :
		HighScore = ReadHS.get_32()
		$UI.UpdateHighScore(HighScore)
	else :
		HighScore = 0

func HighestScore() :
	if NewScore > HighScore :
		HighScore = NewScore
		$UI.UpdateHighScore(HighScore)
		SaveHS()
	else :
		$UI.UpdateHighScore(HighScore)

func WhenPlayerDie() :
	if get_node("Player/Shield").visible == true :
		NewLife -= 0
		$Player/PlayerShield.stream = preload("res://Assets/Audio/sfx_shieldDown.ogg")
		$Player/PlayerShield.play()
		$AudioPack/LifeAdd.play()
		get_node("Player/Shield").visible = false
		$UI.PlayerLife(NewLife)
	else :
		NewLife -= 1
		WhenNoHp()
		$UI.PlayerLife(NewLife)
		$AudioPack/LifeDec.play()

func WhenNoHp() :
	if NewLife == 0 :
		$Player.queue_free()
	elif NewLife < 0 :
		NewLife = 0
		$Player.queue_free()

func WhenPlayerDieCrit() :
	if get_node("Player/Shield").visible == true :
		NewLife -= 0
		$Player/PlayerShield.stream = preload("res://Assets/Audio/sfx_shieldDown.ogg")
		$Player/PlayerShield.play()
		$AudioPack/LifeAdd.play()
		get_node("Player/Shield").visible = false
		$UI.PlayerLife(NewLife)
	else :
		NewLife -= 2
		WhenNoHp()
		$UI.PlayerLife(NewLife)
		$AudioPack/LifeDec.play()

func SpawnGift() :
	var DropRate = 25
	var randomnumber = randi() % 100 + 1
	if randomnumber <= DropRate :
		$AudioPack/Effects.play()
		get_node("EffectsSpawner").Effect()
		
func level() :
	if NewScore >= 30 :
		get_node("EnemySpawner/Timer").wait_time = 0.4
		get_node("UI/Level/Levels").text = "Level : 2" 
	if NewScore >= 45 :
		get_node("EnemySpawner/Timer").wait_time = 0.3
		get_node("UI/Level/Levels").text = "Level : 3"
	if NewScore >= 60 :
		get_node("EnemySpawner/Timer").wait_time = 0.2
		get_node("UI/Level/Levels").text = "Level : 4"
	if NewScore >= 100 :
		get_node("EnemySpawner/Timer").wait_time = 0.1
		get_node("UI/Level/Levels").text = "Level : EndLess"
	if NewScore >= 500 :
		get_node("EnemySpawner/Timer").wait_time = 0.05
		get_node("UI/Level/Levels").text = "Level : GOD"
		
	

func WhenEnemyDie() :
	if not $Timer/Timer.is_stopped() :
		NewScore += 2
		$UI.UpdateScore(NewScore)
		HighestScore()
		SpawnGift()
	else :
		NewScore += 1
		$UI.UpdateScore(NewScore)
		HighestScore()
		SpawnGift()

func WhenGeneralsDie() :
	if not $Timer/Timer.is_stopped() :
		NewScore += 8
		$UI.UpdateScore(NewScore)
		HighestScore()
		SpawnGift()
	else :
		NewScore += 4
		$UI.UpdateScore(NewScore)
		HighestScore()
		SpawnGift()

func _on_enemy_spawner_enemy(EnemyId):
	get_node("EnemySpawner/EnemyContainer").add_child(EnemyId)
	if EnemyId.name.begins_with("Normal_") :
		EnemyId.connect("EnemyDie", WhenEnemyDie)
		EnemyId.connect("PlayerDie", WhenPlayerDie)
	elif EnemyId.name.begins_with("Generals_") :
		EnemyId.connect("PlayerLifeCrit", WhenPlayerDieCrit)
		EnemyId.connect("Player2Kills", WhenGeneralsDie)
	elif EnemyId.name.begins_with("Commanders_") :
		EnemyId.connect("PlayerDead", WhenPlayerDieCrit)
		EnemyId.connect("CommanderDie", WhenGeneralsDie)
	

func WhenPlayerGotLifeAdd() :
	NewLife += 1
	$UI.PlayerLife(NewLife)
	$AudioPack/LifeAdd.play()

func WhenPlayerGotShield() :
	get_node("Player/Shield").visible = true
	$Player/PlayerShield.stream = preload("res://Assets/Audio/sfx_shieldUp.ogg")
	$Player/PlayerShield.play()

func WhenPlayerGotDoubleScore() :
	$Timer/Timer.start()
	$AudioPack/Timer.stream = preload("res://Assets/Audio/Timer Start.wav")
	$AudioPack/Timer.play()
	
func _on_timer_timeout():
	$Timer/Timer.stop()
	$AudioPack/Timer.stream = preload("res://Assets/Audio/Timer Stop.wav")
	$AudioPack/Timer.play()

func _on_effects_spawner_effects_signal(EffectsId):
	get_node("EffectsSpawner/EffectsContainer").call_deferred("add_child", EffectsId)
	if EffectsId.name.begins_with("LifeAdd_") :
		EffectsId.connect("PlayerGotLifeAdd", WhenPlayerGotLifeAdd)
	elif EffectsId.name.begins_with("Shield_") :
		EffectsId.connect("PlayerGotShield", WhenPlayerGotShield)
	elif EffectsId.name.begins_with("DoubleScore_") :
		EffectsId.connect("PlayerGotDoubleScore", WhenPlayerGotDoubleScore)
