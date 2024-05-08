extends RigidBody3D
var velocity
var spawner 
#var area3D
#var isInsideArea = false
#var GameController
#
#func _ready():
	##area3D = null
	##GameController = get_node("GameController") 
#func _on_body_entered(area):
	##if area is Area3D:
		##area3D = area  # Assign the entered Area3D to area3D
		##isInsideArea = true
		### Remove the RigidBody3D component
		#if has_node("RigidBody3D"):
			#var rigidbody = get_node("RigidBody3D")
			#spawner.apply_impulse(ballspeed)
			#remove_child(rigidbody)
			#rigidbody.queue_free()
#
#func _process(_delta):
	#if isInsideArea:
		#if area3D:
			#set_position(area3D.global_transform.origin)

func _on_timer_timeout():
	print("KILL")
	queue_free()
