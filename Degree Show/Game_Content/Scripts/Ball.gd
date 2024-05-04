extends RigidBody3D


func kick(target: Vector3) -> void:
	set_linear_velocity(Vector3.ZERO)
	set_angular_velocity(Vector3.ZERO)
	look_at(target)
	print("Works")
	apply_central_impulse(get_global_transform().basis.z * -6)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
			kick(Vector3.ZERO)  # Provide the actual target vector here
