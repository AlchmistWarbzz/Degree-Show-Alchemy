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
	if Global.normal_ball == true:
		NormalBall()
	if Global.speed_ball == true:
		SpeedBall()
	if Global.glide_ball == true:
		GlideBall()
	if Global.rebound_ball == true:
		ReboundBall()

func _on_play_ball_sound():
	$Saves.play()
	Global.ball_sound = false
	
func _on_play_sound():
	$Cheers.play()
	Global.save_sound = false
	Global.crowd_cheer.emit()
	
func Game_Over():
	$Boos.play()

func SpeedBall():
	$"Speed Ball".play()
	Global.speed_ball = false
	
func NormalBall():
	$"Normal Ball".play()
	Global.normal_ball = false
	
func GlideBall():
	$"Glide Ball".play()
	Global.glide_ball = false
	
func ReboundBall():
	$"Rebound Ball".play()
	Global.rebound_ball = false
