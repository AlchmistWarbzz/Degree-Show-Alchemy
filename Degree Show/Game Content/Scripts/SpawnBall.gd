extends Node3D

var normal_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var gravity_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var curve_scene: PackedScene  # Reference to the Ball scene (PackedScene)
var speed_scene: PackedScene
var spawn_timer = 2  # Time interval between spawns (in seconds)
var spawn_timer_elapsed = 0  # Time elapsed since last spawn
var raycast:RayCast3D 
var player 
var player_pos
var radius = 2.0  # Maximum distance between raycast and player
var min_angle:float  # Minimum angle in radians
var max_angle:float  # Maximum angle in radians
var excluded_angle_min:float # Excluded angle minimum in radians
var excluded_angle_max:float  # Excluded angle maximum in radians
var chance_to_spawn = 50
var launch_offset
var angle:float
var speed_offset
var ball_node
var ball_scene: PackedScene 
var player_height
var height_offset:float
var impulse_magnitude = 4  # Adjust this value to control the speed
var speed
var current_min_angle:float
var current_max_angle:float
var ball_array
var SaveSound

func _ready():
	# Set heigh offset to 0
	height_offset = 0
	# Trigger reset angles
	reset_angle()
	# Load the Ball scenes
	normal_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	gravity_scene = preload("res://Game Content/Scripts/SubScenes/gravity.tscn")
	curve_scene = preload("res://Game Content/Scripts/SubScenes/curve.tscn")
	speed_scene = preload("res://Game Content/Scripts/SubScenes/speed.tscn")
	SaveSound = ("res://Game Content/Sounds/GKSaveSound.gd")
	
	# Gets Raycast node
	raycast = get_node("RayCast3D")
	# Gets player node
	player = $"/root/GameController".player
		# Initialize the ball_array
	ball_array = {
		normal_scene: "Normal Ball",
		gravity_scene: "Gravity Ball",
		curve_scene: "Curve Ball",
		speed_scene: "Speed Ball"
	}

func _process(_delta):
	# Update the spawn timer
	spawn_timer_elapsed += _delta
	# Sets Global var next ball to the ball scene
	Global.next_ball = ball_scene
	
	# Print the next ball type
	#print("Next ball node: ", ball_array.get(ball_scene, "Unknown Ball"))
	# If game has not started/ is over reset angle and set the first ball
	if Global.startgame == false:
		reset_angle()
		first_ball()
	# Once game has started this will spawn the ball every 2 seconds
	if Global.startgame == true:
	# Check if it's time to spawn a ball
		if spawn_timer_elapsed >= spawn_timer:
			spawn_ball()
			spawn_timer_elapsed = 0  # Reset the timer
			timer_angle()
			Global.ball_sound = true
			await get_tree().create_timer(0.01).timeout
			Global.ball_sound = false

	# Move the raycast around the player
	if raycast:
		player_pos = $"/root/GameController".player.get_position()  # Function to get player position

# This function resets the angle of the balls
func reset_angle():
	current_min_angle = 89 
	current_max_angle = 100

# This function increases the angle over time when it is triggered
func timer_angle():
	current_min_angle -= 0.3
	current_max_angle += 0.3

# This set the first ball of the game
func first_ball():
	ball_scene = normal_scene # Blue ball

func spawn_ball():
	ball_node = ball_scene.instantiate()
	# Long If statement to decide what to do depending on which ball the array has chosen
	if ball_scene == normal_scene:
		setheight(0) 
		launch_offset = set_angle(current_min_angle, current_max_angle, 90, 99)
		aim_towrad_player()
		launch(speed)
		Global.normal_ball = true
		#print("player height - ", player_height)
	elif ball_scene == curve_scene:
		setheight(0)
		launch_offset = set_angle(45, 140, 48, 135)
		aim_towrad_player()
		launch(speed)
		Global.rebound_ball = true
		#print("player height - ", player_height)
	elif ball_scene == gravity_scene:
		gravity(0.3, 0.4)
		setheight(height_offset)
		launch_offset = set_angle(85, 105, 88, 101)
		aim_towrad_player()
		launch(speed * speed_offset)
		height_offset = 0
		Global.glide_ball = true
		#print("player height - ", player_height)
	if ball_scene == speed_scene:
		setheight(0)
		launch_offset = set_angle(current_min_angle, current_max_angle, 89, 101)
		aim_towrad_player()
		addspeed(1.1, 1.2)
		launch(speed * speed_offset)
		Global.speed_ball = true
		#print("player height - ", player_height)
	select_next_ball()

func setheight(offset):
	player_height = Global.player_height + randf_range(0.5, 0.55) + offset
	return player_height

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

func aim_towrad_player():
	var launch_position = player_pos + launch_offset
	# Get the collision point and normal from the raycast
	var collision_point = raycast.get_collision_point()
	# Calculate direction towards the launch position
	var direction_to_launch = (launch_position - collision_point).normalized()
	# Add the ball instance to the scene
	speed = direction_to_launch * impulse_magnitude
	return speed

func addspeed(Smin, Smax):
	speed_offset = randf_range(Smin, Smax)
	return speed_offset

func gravity(Gmin, Gmax):
	var gravity_scale = randf_range(Gmin, Gmax)
	if gravity_scale <= 0.5:
		height_offset = randf_range(0.1, 0.2)
		speed_offset = randf_range(0.6, 0.7)
	ball_node.gravity_scale = gravity_scale
	#print("gravity ", gravity) 
	return height_offset


func launch(speed):
	add_child(ball_node)
	ball_node.global_transform.origin = raycast.global_transform.origin
	ball_node.apply_impulse(speed)

func select_next_ball():
		var random_value = randf()
		if random_value < 0.7:
			ball_scene = normal_scene
		elif random_value < 0.8:
			ball_scene = curve_scene
		elif random_value < 0.9:
			ball_scene = speed_scene
		else:
			ball_scene = gravity_scene
		#print("Selected ball type: ", ball_scene)
		return ball_scene


