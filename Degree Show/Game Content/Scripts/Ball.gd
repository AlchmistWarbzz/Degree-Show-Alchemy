extends RigidBody3D
var player_pos
var raycast:RayCast3D
var height_offset:float = Global.player_height + randf_range(0.4, 0.8)
func _on_timer_timeout():
	#print("KILL")
	queue_free()


func _on_body_entered(body):
	if body is StaticBody3D:  # Assuming walls are StaticBody3D
		if name == "curve":
			rebound_to_player()

func rebound_to_player():
	player_pos = $"/root/GameController".player.get_position()
	var player_direction = (player_pos - global_transform.origin).normalized()
	var speed = linear_velocity.length()
	# Calculate the impulse vector
	var impulse = player_direction * speed * mass
	
	# Apply the impulse to the ball
	apply_impulse(Vector3.ZERO, impulse)

