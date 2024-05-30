extends Node3D

const SAVE_GAME_PATH := "user://savegame.tres"

@export var saved = Global.highest_saved
@export var time = Global.highest_time

func _ready():
	Global.save_game.connect(_save_game)
	Global.load_game.connect(_load_game)
	Global.load_game.emit()

func _save_game():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if file:
		file.store_var(saved)
		file.store_var(time)
		file.close()
		print("Game saved")
	else:
		print("Error opening file for saving")

func _load_game():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		if file:
			saved = file.get_var()
			time = file.get_var()
			Global.highest_saved = saved 
			Global.highest_time = time
			file.close()
			print("Game loaded")
		else:
			print("Error opening file for loading")
	else:
		print("Save file does not exist")
