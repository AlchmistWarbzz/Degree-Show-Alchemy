extends Resource
class_name SaveGame

@export var highscores: Dictionary

var gameSave = SaveGame.new()
var save_path = "user://scoresave.tres"

func save_game():
	ResourceSaver.save(gameSave, save_path)

func load_save():
	if FileAccess.file_exists(save_path):
		gameSave = ResourceLoader.load(save_path + save_name).duplicate(true)
		high_scores = gameSave.high_scores
	else:
		printerr('No save file found at path')
