extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D4.play()
	$AudioStreamPlayer3D5.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.save_sound == true:
		_on_play_save_sound()
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
		
func _on_play_save_sound():
	$AudioStreamPlayer3D.play()
	
func _on_play_sound():
	$AudioStreamPlayer3D2.play()
	Global.savesound == false
	
func Game_Over():
	$AudioStreamPlayer3D3.play()


