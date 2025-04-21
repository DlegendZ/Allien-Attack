extends Control
var OldLife = 5
var AudioEnemy = preload("res://Assets/Audio/Touched.wav")
var AudioLife = preload("res://Assets/Audio/sfx_twoTone.ogg")

func _ready():
	pass

func UpdateScore(Score) :
	$ScoreUI/Score.text = "Score :     " + str(Score).pad_zeros(6)
	get_node("CanvasLayer/Game Over UI/Panel/ScoreNumber").text = str(Score).pad_zeros(6)
	$GainScore.play()

func UpdateHighScore(NewHighScore) :
	get_node("CanvasLayer/Game Over UI/Panel/HighScoreNumber").text = str(NewHighScore).pad_zeros(6)
	
func PlayerLife(Life) :
	$LifeUI/Life.text = str(Life)
	if Life == 0 :
		$GameOver.play()
		get_node("CanvasLayer/Game Over UI").visible = true
