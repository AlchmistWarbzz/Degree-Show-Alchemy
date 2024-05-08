extends Area3D

var ball

func _on_body_entered(body):
	print("has worked")
	if body is RigidBody3D:
		ball = body as RigidBody3D
		# Stop the ball's movement
		ball.set_linear_velocity(-ball.get_linear_velocity())

