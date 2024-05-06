extends Area3D

var ball

func _on_body_entered(body):
	print("has worked")
	if body is RigidBody3D:
		ball = body as RigidBody3D
		# Stop the ball's movement
		ball.set_linear_velocity(Vector3.ZERO)
		ball.set_angular_velocity(Vector3.ZERO)
		# Disable gravity
		ball.gravity_scale = 0
		
