extends Node3D

@export var min_jump_duration := 0.2
@export var max_jump_duration := 0.4
@export var idle_jump_height := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for mesh: Node3D in get_children():
		var tween = mesh.create_tween()
		tween.set_loops()
		var pos := mesh.position
		var duration := randf_range(min_jump_duration, max_jump_duration)
		tween.tween_property(mesh, "position", Vector3(pos.x, pos.y + idle_jump_height, pos.z), duration)
		tween.tween_property(mesh, "position", pos, duration)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

