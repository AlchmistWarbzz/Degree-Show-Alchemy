extends RigidBody3D

func kick(target: Vector3) -> void:
	set_linear_velocity(Vector3.ZERO)
	set_angular_velocity(Vector3.ZERO)
	# Add a random range to the Z component of the target vector
	var random_angle = randf_range(-PI/4, PI/4) # Adjust the range as needed
	target.z += random_angle
	look_at(target)
	print("Works")
	apply_central_impulse(get_global_transform().basis.z * -16)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
			kick(Vector3.ZERO)  # Provide the actual target vector here
