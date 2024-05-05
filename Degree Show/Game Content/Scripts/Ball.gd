extends RigidBody3D

var area3D
var isInsideArea = false

func _ready():
	kick(Vector3.ZERO)  # Provide the actual target vector here
	area3D = null
	
func _on_body_entered(area):
	if area is Area3D:
		area3D = area  # Assign the entered Area3D to area3D
		isInsideArea = true
		# Remove the RigidBody3D component
		if has_node("RigidBody3D"):
			var rigidbody = get_node("RigidBody3D")
			remove_child(rigidbody)
			rigidbody.queue_free()

func _process(delta):
	if isInsideArea:
		if area3D:
			set_position(area3D.global_transform.origin)

func kick(target: Vector3) -> void:
	set_linear_velocity(Vector3.ZERO)
	set_angular_velocity(Vector3.ZERO)
	
	# Define the desired angle range (degrees) in radians
	var desired_angle_range = deg_to_rad(60)  # Convert degrees to radians
	var desired_angle_range2 = deg_to_rad(120)
	# Generate a random angle within the desired angle range
	var random_angle = randf_range(-desired_angle_range2, -desired_angle_range)
	
	# Apply the random angle to the 2-axis rotation
	target.x = sin(random_angle)  
	
	# Apply the random angle to the y-axis rotation
	target.y = sin(random_angle)
	
	# Apply the random angle to the z-axis rotation
	target.z = cos(random_angle)
	
	# Normalize the target vector to maintain consistent speed
	target = target.normalized()
	
	# Look at the modified target vector
	look_at(target)
	
	# Apply an impulse in the direction of the modified target vector
	apply_central_impulse(get_global_transform().basis.x * -16)
	


func _on_timer_timeout():
	print("KILL")
	queue_free()
