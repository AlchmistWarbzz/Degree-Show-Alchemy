extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.on_gameover.connect(_on_gameover)
	self.text = str("1st: ", Global.highest_time)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gameover():
	# You can handle additional game over logic here if needed
	if Global.time_elapsed > Global.highest_time:
		Global.highest_time = Global.time_elapsed
		Global.save_game.emit()
	#print("Signal activated time!!")
	self.text = "1st: " + str(Global.highest_time)
