extends Node3D

var ball_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var spawn_timer = 3  # Time interval between spawns (in seconds)
var spawn_timer_elapsed = 0  # Time elapsed since last spawn
# Adjust these parameters to control the raycast's movement
var raycast 
var forward_direction = Vector3(0, 0, 1)  # Default forward direction
var player 
var player_pos
# Define constants
var radius = 5.0  # Maximum distance between raycast and player
var speed = 1.0   # Speed of raycast movement
var min_distance = -1  # Minimum distance between raycast and player

func _ready():
	# Load the Ball scene
	ball_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	raycast = get_node("RayCast3D")
	player = $"/root/GameController".player

func _process(_delta):
	# Update the spawn timer
	spawn_timer_elapsed += _delta
	# Check if it's time to spawn a ball
	if spawn_timer_elapsed >= spawn_timer:
		spawn_ball()
		spawn_timer_elapsed = 0  # Reset the timer
	# Move the raycast around the player
	if raycast:
		print($"/root/GameController".player.get_position())
		player_pos = $"/root/GameController".player.get_position()  # Function to get player position
		var to_player = player_pos - raycast.global_transform.origin
		# Calculate the distance between raycast and player

	


func spawn_ball():

	# Instantiate the Ball scene
	var ball_instance = ball_scene.instantiate()
	# Calculate launch position around the player
	var random_Offset = randf_range(1, 2)
	var launch_offset = Vector3(0, 0, random_Offset)  # Adjust this value for desired offset
	var launch_position = player_pos + launch_offset
	# Get the collision point and normal from the raycast
	var collision_point = raycast.get_collision_point()
	# Calculate direction towards the launch position
	var direction_to_launch = (launch_position - collision_point).normalized()
	# Add the ball instance to the scene
	add_child(ball_instance)
	# Apply impulse towards the player
	var impulse_magnitude = 8  # Adjust this value to control the speed
	ball_instance.global_transform.origin = raycast.global_transform.origin
	ball_instance.apply_impulse(direction_to_launch * impulse_magnitude)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_D:
			print("Ball Spawn")
			spawn_ball()
