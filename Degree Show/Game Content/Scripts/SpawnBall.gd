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
		#print($"/root/GameController".player.get_position())
		player_pos = $"/root/GameController".player.get_position()  # Function to get player position
		var to_player = player_pos - raycast.global_transform.origin
		# Calculate the distance between raycast and player

	
# Define a function to calculate the launch offset


func spawn_ball():
	# Instantiate the Ball scene
	var ball_instance = ball_scene.instantiate()
	# Define parameters for circular path
	var radius = 2.0  # Radius of the circular path
	var min_angle = deg_to_rad(85)  # Minimum angle in radians
	var max_angle = deg_to_rad(105)  # Maximum angle in radians
	var excluded_angle_min = deg_to_rad(90)  # Excluded angle minimum in radians
	var excluded_angle_max = deg_to_rad(100)  # Excluded angle maximum in radians

	# Calculate the valid range for the random angle
	var valid_min_angle = min_angle
	var valid_max_angle = max_angle - (excluded_angle_max - excluded_angle_min)

	# Generate a random angle within the valid range
	var angle = randf_range(valid_min_angle, valid_max_angle)
	# If the random angle falls within the excluded range, adjust it
	if angle >= excluded_angle_min:
		angle += excluded_angle_max - excluded_angle_min
	print("angle" , angle)
	var height = randf_range(2.3, 2.7)
	# Calculate launch offset using the adjusted angle
	var launch_offset = Vector3(radius * cos(angle), height, radius * sin(angle))

	# Calculate launch position around the player
	var launch_position = player_pos + launch_offset
	
	# Get the collision point and normal from the raycast
	var collision_point = raycast.get_collision_point()
	
	# Calculate direction towards the launch position
	var direction_to_launch = (launch_position - collision_point).normalized()
	# Add the ball instance to the scene
	add_child(ball_instance)
	# Apply impulse towards the player
	var impulse_magnitude = 3  # Adjust this value to control the speed
	ball_instance.global_transform.origin = raycast.global_transform.origin
	ball_instance.move_and_collide(direction_to_launch * impulse_magnitude)
	#ball_instance.apply_impulse(direction_to_launch * impulse_magnitude)
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_D:
			print("Ball Spawn")
			spawn_ball()
