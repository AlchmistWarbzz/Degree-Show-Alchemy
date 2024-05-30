extends RigidBody3D

var player_pos
var raycast:RayCast3D
var height_offset:float = Global.player_height + randf_range(0.4, 0.8)


func _on_timer_timeout():
	#print("KILL")
	queue_free()

func rebound_to_player():
	player_pos = Global.player_pos
	var player_direction = (player_pos - global_transform.origin).normalized()
	var speed = linear_velocity.length()
	# Calculate the impulse vector
	var impulse = player_direction * speed * mass
	gravity_scale = randf_range(0.8, 1.2)
	# Apply the impulse to the ball
	apply_impulse(Vector3.ZERO, impulse)
	

