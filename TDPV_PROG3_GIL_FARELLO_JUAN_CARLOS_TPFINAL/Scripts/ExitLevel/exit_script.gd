extends Area2D
signal change_scene

var can_change_level
func _ready():
	#level_completed=connect("has_finished",get_node("../GUI/PauseLabel"),"pause_for_finish")
	can_change_level=connect("change_scene",get_node("../MainAdmin"),"change_level_if_completed")

func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		#emit_signal("has_finished")
		emit_signal("change_scene")
