extends RigidBody3D
var velocity
var spawner 


func _on_timer_timeout():
	#print("KILL")
	queue_free()
