extends Area3D

var ball
var score
var highest_score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 1
	highest_score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if score > highest_score:
		highest_score = score
	elif score < 0:
		score = 0
	print ("score", score)

func _on_body_entered(body):
	if body is RigidBody3D:
		if body.name == "ball":
			if name == "missed":
				print("MISSED")
				score = score - 1
			elif name == "playerarea":
				ball = body
				score = score + 1
				print("Entered ball")
				var direction = global_transform.origin - ball.global_transform.origin
				# Reflect the ball's velocity around the normal of the collision surface
				var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
				# Apply the reflected velocity to the ball
				ball.set_linear_velocity(reflection * ball.linear_velocity.length()) 
		elif body.name == "junk":
			print("Entered is junk")
			score = score - 1

