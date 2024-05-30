extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.on_gameover.connect(_on_gameover)
	self.text = str("1st: ", Global.highest_saved)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gameover():
	# You can handle additional game over logic here if needed
	if Global.saves > Global.highest_saved:
		Global.highest_saved = Global.saves
		Global.save_game.emit()
	#print("Signal activated saves!!")
	self.text = "1st: " + str(Global.highest_saved)

