extends RigidBody3D

var area3D
var isInsideArea = false

func _ready():
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

func _process(_delta):
	if isInsideArea:
		if area3D:
			set_position(area3D.global_transform.origin)

func kick(target: Vector3) -> void:
	set_linear_velocity(Vector3.ZERO)
	set_angular_velocity(Vector3.ZERO)
	
	# Define the desired angle range (radians)
	var desired_angle_range = deg_to_rad(10) # Convert degrees to radians
	# Generate a random angle within the desired angle range
	var random_angle = randf_range(-desired_angle_range, desired_angle_range)
	# Rotate the forward vector by the random angle
	var rotated_forward_vector = Basis().rotated(Vector3.UP, random_angle) * global_transform.basis.z.normalized()
	
	# Apply an impulse in the direction of the rotated forward vector
	apply_central_impulse(rotated_forward_vector * 4)

func _on_timer_timeout():
	print("KILL")
	queue_free()
