extends RigidBody3D
var velocity
#var area3D
#var isInsideArea = false
#var GameController
#
func _ready():
	velocity = velocity.length()
	#area3D = null
	#GameController = get_node("GameController") 
#func _on_body_entered(area):
	#if area is Area3D:
		#area3D = area  # Assign the entered Area3D to area3D
		#isInsideArea = true
		## Remove the RigidBody3D component
		#if has_node("RigidBody3D"):
			#var rigidbody = get_node("RigidBody3D")
			#remove_child(rigidbody)
			#rigidbody.queue_free()
#
#func _process(_delta):
	#if isInsideArea:
		#if area3D:
			#set_position(area3D.global_transform.origin)
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		velocity.x *= 2
		velocity.y *= 2
		velocity.z *= 2
func _on_timer_timeout():
	print("KILL")
	queue_free()
