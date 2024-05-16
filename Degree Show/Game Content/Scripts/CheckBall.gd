extends Area3D
var raycast: RayCast3D
var ball
var score = 0
var highest_score = 0
var player_pos
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
			#if Global.hithand == false:
			checkball(body)
		elif body.name == "curve":
				checkball(body)
				 
			

func checkball(body):
	if name == "missed":
		print("MISSED")
		Global.score -= 1
		Global.goals += 1
		body.name = "balls"
	elif name == "playerarea":
		ball = body
		print("Entered ball")
		Global.score += 1
		Global.saves += 1
		Global.time += 20
		body.name = "balls"
		var direction = global_transform.origin - ball.global_transform.origin
		# Reflect the ball's velocity around the normal of the collision surface
		var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
		# Apply the reflected velocity to the ball
		ball.set_linear_velocity(reflection * ball.linear_velocity.length())
	elif name == "Goal":
		#ball.set_physics_process(false)
		ball.queue_free()
		print("hit")
func rebound_to_player(body):
	ball = body
	if raycast:
		#print($"/root/GameController".player.get_position())
		player_pos = $"/root/GameController".player.get_position()
		var player_direction = (player_pos - ball.global_transform.origin).normalized()
		# Set a fixed speed or keep the current speed of the ball
		var speed = ball.linear_velocity.length() * 0.8
		ball.set_linear_velocity(player_direction * speed)
