extends RigidBody3D

var area3D

func _ready():
	kick(Vector3.ZERO)  # Provide the actual target vector here
	area3D = $Area3D
func kick(target: Vector3) -> void:
	set_linear_velocity(Vector3.ZERO)
	set_angular_velocity(Vector3.ZERO)
	
	# Define the desired angle range (20 degrees) in radians
	var desired_angle_range = deg_to_rad(180)  # Convert degrees to radians
	var desired_angle_range2 = deg_to_rad(0)
	# Generate a random angle within the desired angle range
	var random_angle = randf_range(desired_angle_range2, desired_angle_range)
	
	# Set the target vector to move forward along the x-axis
	target.x = 15  # Move forward along the x-axis
	
	# Apply the random angle to the y-axis rotation
	target.y = sin(random_angle)
	
	# Apply the random angle to the z-axis rotation
	target.z = cos(random_angle)
	
	# Normalize the target vector to maintain consistent speed
	target = target.normalized()
	
	# Look at the modified target vector
	look_at(target)
	
	# Apply an impulse in the direction of the modified target vector
	apply_central_impulse(get_global_transform().basis.z * -32)

func _on_timer_timeout():
	pass # Replace with function body.
