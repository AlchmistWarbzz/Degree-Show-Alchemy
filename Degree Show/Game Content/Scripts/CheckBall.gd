extends Area3D

var ball
var score = 0
var highest_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if score > highest_score:
		highest_score = score
	elif Global.score < 0:
		Global.score = 0

func _on_body_entered(body):
	if body is RigidBody3D:
		if body.name == "ball":
			if name == "missed":
				print("MISSED")
				Global.score -= 1
				Global.goals += 1
			elif name == "playerarea":
				ball = body
				print("Entered ball")
				Global.score += 1
				Global.saves += 1
				body.name = "balls"
				var direction = global_transform.origin - ball.global_transform.origin
				# Reflect the ball's velocity around the normal of the collision surface
				var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
				# Apply the reflected velocity to the ball
				ball.set_linear_velocity(reflection * ball.linear_velocity.length())
				 
		elif body.name == "junk":
			if name != "missed":
				print("Entered is junk")
				Global.score -= 1
				Global.hits += 1
				body.name = "junkD"
			

