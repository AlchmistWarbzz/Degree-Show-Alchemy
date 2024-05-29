extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.ball_sound == true:
		_on_play_sound()
		
func _on_play_sound():
	$AudioStreamPlayer3D.play()
	Global.ball_sound == false
		
