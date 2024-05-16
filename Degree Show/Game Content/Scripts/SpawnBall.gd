extends Node3D

var normal_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var gravity_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var curve_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var spawn_timer = 2  # Time interval between spawns (in seconds)
var spawn_timer_elapsed = 0  # Time elapsed since last spawn
# Adjust these parameters to control the raycast's movement
var raycast 
var player 
var player_pos
var radius = 2.0  # Maximum distance between raycast and player
var ball_scene = []
var min_angle = deg_to_rad(85)  # Minimum angle in radians
var max_angle = deg_to_rad(105)  # Maximum angle in radians
var excluded_angle_min = deg_to_rad(89)  # Excluded angle minimum in radians
var excluded_angle_max = deg_to_rad(101)  # Excluded angle maximum in radians
var chance_to_spawn = 50
var launch_offset
var angle
var speed
var ball_instance
var ball_instances: PackedScene 
var height = 1.93 + randf_range(0, 0.3)
var impulse_magnitude = 4  # Adjust this value to control the speed
func _ready():
	# Load the Ball scene
	normal_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	gravity_scene = preload("res://Game Content/Scripts/SubScenes/gravity.tscn")
	curve_scene = preload("res://Game Content/Scripts/SubScenes/curve.tscn")
	raycast = get_node("RayCast3D")
	player = $"/root/GameController".player
	ball_scene = [
		normal_scene,
		gravity_scene,
		curve_scene
	]
func _process(_delta):
	# Update the spawn timer
	
	spawn_timer_elapsed += _delta
	# Check if it's time to spawn a ball
	
	if spawn_timer_elapsed >= spawn_timer :
		spawn_ball()
		spawn_timer_elapsed = 0  # Reset the timer
		
		#var spawm_range = randf_range(1, 100)
		#if spawm_range < chance_to_spawn:
			#spawn_timer_elapsed = 0  # Reset the timer
	# Move the raycast around the player
		

	if raycast:
		#print($"/root/GameController".player.get_position())
		player_pos = $"/root/GameController".player.get_position()  # Function to get player position

	

func spawn_ball():
	# Instantiate the Ball scene
	if Global.startgame == true:
		var random_value = randf()
		if random_value < 0.6:
			ball_instances = normal_scene
		elif random_value < 0.8:
			ball_instances = curve_scene
		else:
			ball_instances = gravity_scene
		ball_instance = ball_instances.instantiate()
	# Define parameters for circular path
		if ball_instances == normal_scene:
			launch_offset = set_angle(85, 105, 89, 101)
			aim_towrad_player(player_pos, launch_offset, ball_instance, impulse_magnitude)
			launch(speed)
		elif  ball_instances == curve_scene:
			launch_offset = set_angle(50, 130, 60, 120)
			aim_towrad_player(player_pos, launch_offset, ball_instance, impulse_magnitude)
			launch(speed)
		elif ball_instances == gravity_scene:
			launch_offset = set_angle(85, 105, 89, 101)
			gravity(ball_instance, gravity)
			aim_towrad_player(player_pos, launch_offset, ball_instance, impulse_magnitude)
			launch(speed * 0.8)
	# Launch the ball
	
	
func gravity(ball_instance, gravity):
	ball_instance.gravity_scale = gravity
	
func aim_towrad_player(player_pos, launch_offset, ball_instance, impulse_magnitude):
	
	var launch_position = player_pos + launch_offset
	# Get the collision point and normal from the raycast
	var collision_point = raycast.get_collision_point()
	
	# Calculate direction towards the launch position
	var direction_to_launch = (launch_position - collision_point).normalized()
	# Add the ball instance to the scene
	speed = direction_to_launch * impulse_magnitude
	return speed
	
func launch(speed):
	add_child(ball_instance)
	ball_instance.global_transform.origin = raycast.global_transform.origin
	ball_instance.apply_impulse(speed)

func set_angle(min, max, emin, emax):
	min_angle = deg_to_rad(min)  # Minimum angle in radians
	max_angle = deg_to_rad(max)  # Maximum angle in radians
	excluded_angle_min = deg_to_rad(emin)  # Excluded angle minimum in radians
	excluded_angle_max = deg_to_rad(emax)  # Excluded angle maximum in radians
	var valid_min_angle = min_angle
	var valid_max_angle = max_angle - (excluded_angle_max - excluded_angle_min)
	# Generate a random angle within the valid range
	angle = randf_range(valid_min_angle, valid_max_angle)
	# If the random angle falls within the excluded range, adjust it
	if angle >= excluded_angle_min:
		angle += excluded_angle_max - excluded_angle_min
	print("angle" , angle)
	launch_offset = Vector3(radius * cos(angle), height, radius * sin(angle))
	return launch_offset
