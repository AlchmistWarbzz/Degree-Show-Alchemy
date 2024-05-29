extends Node

var highscores: Dictionary
var player_high_score
var high_scores
var lowestvalue
@export var leaderboard_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_highscores(player_name): 
	var name = player_name
	var score = player_high_score
	highscores[name] = score
	while highscores.size() > 10:
		var lowest_value: int = 100
		for entry in high_scores:
			if highscores[entry] < lowest_value:
				lowestvalue = highscores[entry]

		for logged in highscores:
			if highscores[logged] == lowest_value:
				highscores.erase(logged)

func order_highscores(score: Dictionary) -> Dictionary:
	var original_dict: Dictionary = highscores.duplicate()
	var ordered_dict: Dictionary
	for i in original_dict.size():
		var highest_score: int = 0
		for entry in original_dict:
			if original_dict[entry] > highest_score:
				highest_score = original_dict[entry]
		ordered_dict[original_dict.find_key(highest_score)] = highest_score
		original_dict.erase(original_dict.find_key(highest_score))
	return ordered_dict

func draw_highscores_to_ui(highscores):
	for i in $VBoxContainer.get_child_count():
		if get_child(i) != null:
			$VBoxContainer.get_child(i).queue_free()
#//Code that clears VBoContainer goes here//

	for entry in highscores:
		var score_panel = score_panel_scene.instantiate()
		score_panel.get_child(0).text = entry
		score_panel.get_child(1).text = str(highscores[entry]).pad_zeros(3)
		$VBoxContainer.add_child(score_panel)
