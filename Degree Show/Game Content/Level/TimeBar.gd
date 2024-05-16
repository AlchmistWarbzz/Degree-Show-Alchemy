extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	set_value(Global.time) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Time: ", Global.time)



func _on_timer_timeout():
	if Global.startgame == true:
		$".".value = Global.time
		Global.time -= 1
		
		

	# Replace with function body.
