extends Area3D
var raycast: RayCast3D
var ball
var score = 0
var highest_score = 0
var player_pos
# Access the controller
var input_controller = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the input controller
	if Engine.has_singleton("OVRInput"):
		input_controller = Engine.get_singleton("OVRInput")

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
		#print("Entered ball")
		if body.name == "curve":
			Global.score += 1
			Global.saves += 1
			Global.time += 50
			body.name = "balls"
		else:
			Global.score += 1
			Global.saves += 1
			Global.time += 20
			body.name = "balls"
		var direction = global_transform.origin - ball.global_transform.origin
		# Reflect the ball's velocity around the normal of the collision surface
		var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
		# Apply the reflected velocity to the ball
		ball.set_linear_velocity(reflection * ball.linear_velocity.length())
	# Trigger vibration
		if input_controller:
			input_controller.triggerHapticPulse(0, 0.5) # Adjust the intensity as needed
	elif name == "Goal":
		#ball.set_physics_process(false)
		ball.queue_free()
		print("hit")
	
