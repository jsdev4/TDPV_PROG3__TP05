extends Node
signal wasted
var under_water
func _ready():
	under_water=connect("wasted",get_node("../../Player"), "_respawn")
	set_physics_process(true)

func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("wasted")
		
