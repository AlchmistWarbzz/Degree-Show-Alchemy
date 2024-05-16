extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameover == true:
		activate()
	

func _on_button_pressed():
	print("IT WORJKSDSFD NFSD HJSMMMMMMMMMMMMMMMMM")
	Global.startgame = true
	deactivate()
	
func deactivate() -> void:
	hide()
	set_process_unhandled_input(false)
	set_process_input(false)
	set_physics_process(false)
	set_process(false)
	
func activate() -> void:
	show()
	set_process_unhandled_input(true)
	set_process_input(true)
	set_physics_process(true)
	set_process(true)
