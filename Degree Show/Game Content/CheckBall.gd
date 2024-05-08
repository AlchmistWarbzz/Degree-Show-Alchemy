extends Area3D

var ball
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if area.name == "missed" 
		print("is worked")
	if body is RigidBody3D:
		if body.name == "ball":
			ball = body
			print("Entered is the ball")
			var direction = global_transform.origin - ball.global_transform.origin
			# Reflect the ball's velocity around the normal of the collision surface
			var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
			# Apply the reflected velocity to the ball
			ball.set_linear_velocity(reflection * ball.linear_velocity.length()) 
		elif body.name == "junk":
			print("Entered is junk")


func _on_missed_body_entered(body):
	print("Missed")
