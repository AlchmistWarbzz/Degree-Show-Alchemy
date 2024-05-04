extends Label3D

@onready var label_3d_4 = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".text = "1"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
