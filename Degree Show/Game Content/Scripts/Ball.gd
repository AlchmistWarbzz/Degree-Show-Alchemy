extends RigidBody3D
var player_pos
var raycast:RayCast3D
var height_offset:float = Global.player_height + randf_range(0.4, 0.8)
func _on_timer_timeout():
	#print("KILL")
	queue_free()


func _on_body_entered(body):
	if body is StaticBody3D:  # Assuming walls are StaticBody3D
		rebound_to_player()

func rebound_to_player():
	player_pos = $"/root/GameController".player.get_position()
	var player_direction = (player_pos - global_transform.origin).normalized()
	var speed = linear_velocity.length()
	var angle = rand_angle(90, 110, 99, 100)
	apply_impulse(player_direction.rotated(Vector3.UP, angle) * speed * mass)

func rand_angle(Amin, Amax, emin, emax):
	var min_angle = deg_to_rad(Amin)  # Minimum angle in radians
	var max_angle = deg_to_rad(Amax)  # Maximum angle in radians
	var excluded_angle_min = deg_to_rad(emin)  # Excluded angle minimum in radians
	var excluded_angle_max = deg_to_rad(emax)  # Excluded angle maximum in radians
	var valid_min_angle = min_angle
	var valid_max_angle = max_angle - (excluded_angle_max - excluded_angle_min)
	# Generate a random angle within the valid range
	var angle = randf_range(valid_min_angle, valid_max_angle)
	# If the random angle falls within the excluded range, adjust it
	if angle >= excluded_angle_min:
		angle += excluded_angle_max - excluded_angle_min
	return angle
	

	
	
