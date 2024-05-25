extends Label

var time_elapsed := 0.0
var counter = 1
var is_stopped := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_stopped:
		if Global.startgame == true:
			if Global.timereset == false:
				time_elapsed += delta
				self.text = str("Time :",time_elapsed).pad_decimals(0)
			if Global.timereset == true:
				time_elapsed = 0.0
				Global.timereset = false
	if Global.startgame == false:
		time_elapsed = 0.0
		
func reset() -> void:
	time_elapsed = 0.0
	is_stopped = false
	
func stop() -> void:
	is_stopped = true
