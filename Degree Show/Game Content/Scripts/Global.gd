extends Node

var score = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if score == 0:
		get_tree().change_scene_to_file("res://Game Content/Level/MainMenu.tscn")
