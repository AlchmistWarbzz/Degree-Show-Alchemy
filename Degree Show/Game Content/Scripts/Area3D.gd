extends Area3D

var ball

#func _on_body_entered(body):
	#print("has worked")
	#if body is RigidBody3D:
		#ball = body as RigidBody3D
		## Stop the ball's movement
		#var min_angle = deg_to_rad(85)  # Minimum angle in radians
		#var max_angle = deg_to_rad(105)  # Maximum angle in radians
		#var angle = randf_range(min_angle, max_angle)
		#ball.set_linear_velocity(-ball.get_linear_velocity() + angle)
func _on_body_entered(body):
	#print("has worked")
	if body is RigidBody3D:
		ball = body as RigidBody3D
		#Calculate the direction from the ball to the center of the Area3D



