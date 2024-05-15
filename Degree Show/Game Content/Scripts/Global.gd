extends Node

var score = 5
var saves = 0
var goals = 0
var hits = 0
var time = 100
var hithand = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time < 0:
		get_tree().paused = true

