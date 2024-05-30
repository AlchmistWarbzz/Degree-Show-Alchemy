extends XRCamera3D


func set_height():
	Global.player_height = self.global_position.y
	Global.player_pos = self.global_position
	print("height ", Global.player_height)
