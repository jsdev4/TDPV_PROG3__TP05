extends Node

var color_to_change=Color()

func _ready():
	
	color_to_change=Color(1,1,1,1)
func _process(delta):
	color_to_change=Color(0.4,0.5,0.9,1.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
