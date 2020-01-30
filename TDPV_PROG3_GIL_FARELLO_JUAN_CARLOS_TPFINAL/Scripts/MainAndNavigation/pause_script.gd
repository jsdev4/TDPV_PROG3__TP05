extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	
	if event.is_action_pressed("Pause"):
		paused=!paused
		var new_pause_state=not get_tree().paused
		get_tree().paused=new_pause_state
		visible=new_pause_state
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#poner la condicion para que no se mueva el char