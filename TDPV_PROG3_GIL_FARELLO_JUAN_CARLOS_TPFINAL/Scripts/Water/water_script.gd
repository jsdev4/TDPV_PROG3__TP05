extends Node
signal wasted

func _ready():
	connect("wasted",get_node("../../Player"), "_respawn")
	set_physics_process(true)


func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("wasted")
		
