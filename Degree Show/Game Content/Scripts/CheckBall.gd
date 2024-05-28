extends Area3D
var raycast: RayCast3D
var ball
var score = 0
var highest_score = 0
var player_pos
# Access the controller
var input_controller = null
var scored:bool
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
		Global.GK_miss = true
	elif name == "playerarea":
		ball = body
		#print("Entered ball")
		Input.vibrate_handheld(500)
		if score == false:
			if body.name == "gravity":
				score_system(1, 1, 25)
			elif body.name == "curve":
				score_system(1, 1, 30)
			elif body.name == "speed":
				score_system(1, 1, 25)
			elif body.name == "ball":
				score_system(1, 1, 20)
		scored = true
		deflect()

	# Trigger vibration
		if input_controller:
			input_controller.triggerHapticPulse(0, 0.5) # Adjust the intensity as needed
	elif name == "Goal":
		#ball.set_physics_process(false)
		ball.queue_free()
		print("hit")
	
func score_system(score, save, time):
	Global.score += score
	Global.saves += save
	Global.time += time
	Global.GK_save = true
	Global.save_sound = true
	await get_tree().create_timer(0.02).timeout
	Global.save_sound = false

func deflect():
	var direction = global_transform.origin - ball.global_transform.origin
# Reflect the ball's velocity around the normal of the collision surface
	var reflection = direction.normalized().reflect(ball.linear_velocity.normalized())
		# Apply the reflected velocity to the ball
	ball.set_linear_velocity(reflection * ball.linear_velocity.length())
