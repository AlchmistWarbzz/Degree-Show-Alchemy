extends Node3D

var normal_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var gravity_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var curve_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var speed_scene: PackedScene
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
var speed_offset
var ball_instance
var ball_instances: PackedScene 
var player_height 
var height_offset = 0
var impulse_magnitude = 4  # Adjust this value to control the speed
var speed
func _ready():
	
	# Load the Ball scene
	normal_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	gravity_scene = preload("res://Game Content/Scripts/SubScenes/gravity.tscn")
	curve_scene = preload("res://Game Content/Scripts/SubScenes/curve.tscn")
	speed_scene = preload("res://Game Content/Scripts/SubScenes/speed.tscn")
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
		elif random_value < 0.9:
			ball_instances = speed_scene
		else:
			ball_instances = gravity_scene
		ball_instance = ball_instances.instantiate()
	# Define parameters for circular path
		if ball_instances == normal_scene:
			setheight(0)
			launch_offset = set_angle(85, 105, 89, 101)
			aim_towrad_player()
			launch(speed)
			print("player height - ", player_height)
		elif  ball_instances == curve_scene:
			setheight(0)
			launch_offset = set_angle(45, 135, 55, 125)
			aim_towrad_player()
			launch(speed)
			print("player height - ", player_height)
		elif ball_instances == gravity_scene:
			gravity(0.1, 0.4)
			setheight(height_offset)
			launch_offset = set_angle(75, 115, 80, 110)
			aim_towrad_player()
			launch(speed * speed_offset)
			height_offset = 0
			print("player height - ", player_height)
		if ball_instances == speed_scene:
			setheight(0)
			launch_offset = set_angle(85, 105, 89, 101)
			aim_towrad_player()
			addspeed(1.2, 1.4)
			launch(speed * speed_offset)
			print("player height - ", player_height)
	
func addspeed(Smin, Smax):
	speed_offset = randf_range(Smin, Smax)
	return speed_offset
func gravity(Gmin, Gmax):
	var gravity_scale = randf_range(Gmin, Gmax)
	
	if gravity_scale <= 0.5:
		height_offset = randf_range(0.1, 0.2)
		speed_offset = randf_range(0.5, 0.7)
	#elif gravity_scale <= 0.6: 
		#height_offset = randf_range(1.8, 2.5)
		#player_height = player_height + height_offset
	ball_instance.gravity_scale = gravity_scale
	print("gravity ", gravity)
	return height_offset 
	

func aim_towrad_player():
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

func set_angle(Amin, Amax, emin, emax):
	min_angle = deg_to_rad(Amin)  # Minimum angle in radians
	max_angle = deg_to_rad(Amax)  # Maximum angle in radians
	excluded_angle_min = deg_to_rad(emin)  # Excluded angle minimum in radians
	excluded_angle_max = deg_to_rad(emax)  # Excluded angle maximum in radians
	var valid_min_angle = min_angle
	var valid_max_angle = max_angle - (excluded_angle_max - excluded_angle_min)
	# Generate a random angle within the valid range
	angle = randf_range(valid_min_angle, valid_max_angle)
	# If the random angle falls within the excluded range, adjust it
	if angle >= excluded_angle_min:
		angle += excluded_angle_max - excluded_angle_min
	launch_offset = Vector3(radius * cos(angle), player_height, radius * sin(angle))
	return launch_offset

func setheight(offset):
	player_height = 1.93 + randf_range(0.0, 0.3) + offset
	return player_height
