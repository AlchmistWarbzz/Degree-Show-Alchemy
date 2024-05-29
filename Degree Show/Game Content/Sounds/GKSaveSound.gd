extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	$Ambience.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.ball_sound == true:
		_on_play_ball_sound()
	if Global.saves == 9:
		_on_play_sound()
	if Global.saves == 19:
		_on_play_sound()
	if Global.saves == 29:
		_on_play_sound()
	if Global.saves == 39:
		_on_play_sound()
	if Global.saves == 49:
		_on_play_sound()
	if Global.saves == 59:
		_on_play_sound()
	if Global.saves == 69:
		_on_play_sound()
	if Global.saves == 79:
		_on_play_sound()
	if Global.saves == 89:
		_on_play_sound()
	if Global.saves == 99:
		_on_play_sound()
	if Global.gameover == false:
		Game_Over()
		
func _on_play_ball_sound():
	$Saves.play()
	Global.ball_sound == false
	
func _on_play_sound():
	$Cheers.play()
	Global.save_sound == false
	
func Game_Over():
	$Boos.play()

func SpeedBall():
	$"Speed Ball".play()
	
func NormalBall():
	$"Normal Ball".play()
	
func GravityBall():
	$"Glide Ball".play()
	
func CurveBall():
	$"Rebound Ball".play()
