extends Node

var score = 5
var saves = 0
var goals = 0
var hits = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if score == 0:
		await get_tree().create_timer(0.3).timeout
		get_tree().paused = true