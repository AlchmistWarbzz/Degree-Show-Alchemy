extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body is StaticBody3D:
		var ball = body
		var collision_normal = Vector3.UP  # Default collision normal (floor)
		if body.is_in_group("Area3DGroup"):  # Check if the body is in the Area3D group
			collision_normal = global_transform.origin - ball.global_transform.origin
		# Reflect the ball's velocity around the normal of the collision surface
		var reflection = collision_normal.normalized().reflect(ball.linear_velocity.normalized())
		# Apply the reflected velocity to the ball
		ball.set_linear_velocity(reflection * ball.linear_velocity.length())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
