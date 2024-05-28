extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.gameover = true
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameover == true:
		self.visible = true
		Global.time = 100
	if Global.gameover == false:
		self.visible = false 
		Global.timereset = false
		

func _on_button_pressed():
	Global.gameover = false
	Global.countdown = true
	await get_tree().create_timer(3).timeout
	Global.countdown = false
	Global.startgame = true
	Global.goals = 0
	Global.saves = 0
	Global.timereset = true
	GetHeight.set_height()

