extends Node

var highest_saved = 0
var highest_time = 0
var highest_saves: int = 0
var saves = 0
var goals = 0
var hits = 0
var time = 100
var time_elapsed:int = 0
var player_height: float
var player_pos
var startgame = false
var gameover = false
var timereset = false
var next_ball
var GK_save = false
var GK_miss = false
var ball_sound = false
var save_sound = false
var countdown = false
var normal_ball = false
var speed_ball = false
var glide_ball = false
var rebound_ball = false


signal ball_saved
signal crowd_cheer
signal on_gameover
signal save_game
signal load_game


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time < 0:
		startgame = false
		gameover = true

