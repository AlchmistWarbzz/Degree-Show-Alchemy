extends XRCamera3D


func set_height():
	Global.player_height = self.global_position.y
	print("height ", Global.player_height)
