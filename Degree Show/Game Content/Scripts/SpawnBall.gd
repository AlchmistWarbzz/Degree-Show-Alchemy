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
		var distance = to_player.length()
		# If the distance is greater than the maximum allowed distance, move the raycast towards the player
		if distance > radius:
			var move_amount = min(speed * _delta, distance - radius)
			raycast.global_translate(-to_player.normalized() * move_amount)
		elif distance < min_distance:
			var move_amount = min(speed * _delta, min_distance - distance)
			raycast.global_translate(to_player.normalized() * move_amount)


func spawn_ball():
	# Instantiate the Ball scene
	var ball_instance = ball_scene.instantiate()
	# Calculate the direction towards the player
	var ball_position = raycast.global_transform.origin
	var forward_direction = (player_pos - ball_position).normalized()
	# Add the ball instance to the scene
	add_child(ball_instance)
	# Apply impulse in the forward direction
	var impulse_magnitude = 8  # Adjust this value to control the speed
	ball_instance.apply_impulse(forward_direction * impulse_magnitude)
	# Set the initial position of the ball
	#ball_instance.apply_impulse(forward_direction * 4)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_D:
			print("Ball Spawn")
			spawn_ball()
