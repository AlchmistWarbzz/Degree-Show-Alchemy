extends Node3D

@export var min_jump_duration := 0.2
@export var max_jump_duration := 0.3
@export var idle_jump_height := 0.1
@export var cheer_jump_height := 0.8
var idle_tweens : Array[Tween]
var cheer_tweens : Array[Tween]

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ball_saved.connect(_on_ball_saved)
	
	create_idle_tweens()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Enter")):
		_on_ball_saved()
	
	var is_tween_active := false
	if (cheer_tweens.size() > 0):
		for tween : Tween in cheer_tweens:
			if (tween.is_running()):
				is_tween_active = true
		if (not is_tween_active):
			kill_cheer_tweens()
			create_idle_tweens()

func _on_ball_saved():
	kill_idle_tweens()
	create_cheer_tweens()


func create_idle_tweens():
	for mesh : Node3D in get_children():
		var tween = mesh.create_tween()
		tween.set_loops()# infinite
		idle_tweens.append(tween)
		
		var ypos := mesh.position.y
		var duration := randf_range(min_jump_duration, max_jump_duration)
		tween.tween_property(mesh, "position:y", ypos + idle_jump_height, duration)
		tween.tween_property(mesh, "position:y", ypos, duration)


func kill_idle_tweens():
	for tween : Tween in idle_tweens:
		tween.custom_step(30)
		tween.kill()
	idle_tweens.clear()


func create_cheer_tweens():
	for mesh : Node3D in get_children():
		var tween = mesh.create_tween()
		tween.set_loops(4)
		cheer_tweens.append(tween)
		
		var ypos := mesh.position.y
		var duration := randf_range(min_jump_duration, max_jump_duration)
		tween.tween_property(mesh, "position:y", ypos + cheer_jump_height, duration)
		tween.tween_property(mesh, "position:y", ypos, duration)


func kill_cheer_tweens():
	for tween : Tween in cheer_tweens:
		tween.custom_step(30)
		tween.kill()
	cheer_tweens.clear()

