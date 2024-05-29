extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.set_loops()
	for mesh: Node3D in get_children():
		var pos := mesh.position
		tween.tween_property(mesh, "position", Vector3(pos.x, pos.y + 0.5, pos.z), 0.5)
		tween.tween_property(mesh, "position", pos, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
