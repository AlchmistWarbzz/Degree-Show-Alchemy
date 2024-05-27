extends Control

var save
var miss
# Called when the node enters the scene tree for the first time.
func _ready():
	save = $GlitcheTickBySoulDraws
	miss = $GlitchedCrossBySoulDraws # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.GK_save == true:
		save.visible = true
		await get_tree().create_timer(0.3).timeout
		Global.GK_save = false
		save.visible = false
	if Global.GK_miss == true:
		miss.visible = true
		await get_tree().create_timer(0.3).timeout
		Global.GK_miss = false
		miss.visible = false
		
