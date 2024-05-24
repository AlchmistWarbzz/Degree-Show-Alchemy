extends Control

var normal_scene: PackedScene
var gravity_scene: PackedScene
var curve_scene: PackedScene
var speed_scene: PackedScene
var normal
var gravity
var curve
var speed
# Called when the node enters the scene tree for the first time.
func _ready():
	normal_scene = preload("res://Game Content/Scripts/SubScenes/ball.tscn")
	gravity_scene = preload("res://Game Content/Scripts/SubScenes/gravity.tscn")
	curve_scene = preload("res://Game Content/Scripts/SubScenes/curve.tscn")
	speed_scene = preload("res://Game Content/Scripts/SubScenes/speed.tscn")
	normal = $NormalBallIconBySoulDraws
	gravity = $GlideBallIconBySoulDraws
	curve = $ReboundBallIconBySoulDraws
	speed = $SpeedBallIconBySoulDraws # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.next_ball == normal_scene:
		normal.visible = true
		curve.visible = false
		speed.visible = false
		gravity.visible = false
	elif Global.next_ball == curve_scene:
		normal.visible = false
		curve.visible = true
		speed.visible = false
		gravity.visible = false
	elif Global.next_ball == speed_scene:
		normal.visible = false
		curve.visible = false
		speed.visible = true
		gravity.visible = false
	elif Global.next_ball == gravity_scene:
		normal.visible = false
		curve.visible = false
		speed.visible = false
		gravity.visible = true
