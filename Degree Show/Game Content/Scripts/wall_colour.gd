extends Node3D

# PackedScenes for different ball scenes
var normal_scene: PackedScene
var gravity_scene: PackedScene
var curve_scene: PackedScene
var speed_scene: PackedScene

# Colors for different scenes
var normal_color: Color = Color(0, 0, 1)  # Blue
var curve_color: Color = Color(0, 1, 0)   # Green
var speed_color: Color = Color(1, 0.5, 0) # Orange
var gravity_color: Color = Color(0.5, 0, 0.5) # Purple

# References to the wall materials (if multiple)
var wall_material: StandardMaterial3D

func _ready():
	# Preload scenes
	normal_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	gravity_scene = preload("res://Game Content/Scripts/SubScenes/gravity.tscn")
	curve_scene = preload("res://Game Content/Scripts/SubScenes/curve.tscn")
	speed_scene = preload("res://Game Content/Scripts/SubScenes/speed.tscn")

	# Get the wall materials
	wall_material = load("res://Game Content/Materials/Window_Emissive.tres")
		# Add more materials if needed
   

	# Ensure all wall materials are StandardMaterial3D and update initial colors
	if wall_material is StandardMaterial3D:
	# Initial update of wall emissive color
		update_wall_colors(wall_material)
	else:
		print("The wall material is not a StandardMaterial3D.")


# Function to update the emissive and albedo colors of a given material
func update_wall_colors(material: StandardMaterial3D):
	var color: Color = Color(1, 1, 1)  # Default color
	
	# Determine the colors based on the active scene
	if Global.next_ball == normal_scene:
		color = normal_color
	elif Global.next_ball == curve_scene:
		color = curve_color
	elif Global.next_ball == speed_scene:
		color = speed_color
	elif Global.next_ball == gravity_scene:
		color = gravity_color
	
	# Set the emissive and albedo colors in the material
	material.emission = color
	material.emission_enabled = true
	material.albedo_color = color
	print("Updated colors to ", color)

# Check for changes in Global.next_ball
var previous_ball = null

func _process(delta):
	if previous_ball != Global.next_ball:
		update_wall_colors(wall_material)
		previous_ball = Global.next_ball

