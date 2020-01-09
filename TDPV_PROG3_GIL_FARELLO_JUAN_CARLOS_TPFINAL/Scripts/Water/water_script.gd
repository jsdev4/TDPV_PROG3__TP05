extends Node
signal wasted
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("wasted",get_node("../../Player"), "_respawn")
	set_physics_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("wasted")
		
