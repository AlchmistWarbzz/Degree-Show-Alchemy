extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameover == true:
		self.visible = true
		 
	

func _on_button_pressed():
	Global.startgame = true
	Global.gameover = false
	self.visible = false
	Global.time = 100
	Global.goals = 0
	Global.saves = 0
	Global.timereset = true
	GetHeight.set_height()

