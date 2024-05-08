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
	print("has worked")
	if body is RigidBody3D:
		ball = body as RigidBody3D
		#Calculate the direction from the ball to the center of the Area3D
		var direction = global_transform.origin - ball.global_transform.origin
		# Reflect the ball's velocity around the normal of the collision surface
		var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
		# Apply the reflected velocity to the ball
		ball.set_linear_velocity(reflection * ball.linear_velocity.length()) 


