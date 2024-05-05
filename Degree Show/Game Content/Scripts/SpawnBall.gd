extends Node3D

var ball_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var spawn_timer = 3  # Time interval between spawns (in seconds)
var spawn_timer_elapsed = 0  # Time elapsed since last spawn

func _ready():
	# Load the Ball scene
	ball_scene = preload("res://Game Content/Scripts/Script_Scenes/ball.tscn")

func _process(_delta):
	   # Update the spawn timer
	spawn_timer_elapsed += _delta
	
	# Check if it's time to spawn a ball
	if spawn_timer_elapsed >= spawn_timer:
		spawn_ball()
		spawn_timer_elapsed = 0  # Reset the timer


func spawn_ball():
	# Instantiate the Ball scene
	var ball_instance = ball_scene.instantiate()
	
	# Add the ball instance to the scene
	add_child(ball_instance)
	
	# Set the position of the ball (adjust as needed)
	ball_instance.global_transform.origin = Vector3(1.871, 2.152, 0)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_D:
			print("Ball Spawn")
			spawn_ball()


