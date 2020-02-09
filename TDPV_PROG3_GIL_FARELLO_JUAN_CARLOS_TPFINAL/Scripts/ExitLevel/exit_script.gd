extends Area2D
<<<<<<< Updated upstream
signal has_finished
var level_completed
func _ready():
	level_completed=connect("has_finished",get_node("../Player"),"_has_finished_the_level")


func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("has_finished")
=======
signal change_scene
signal no_movement_for_player
var cant_move
var can_change_level
func _ready():
	can_change_level=connect("change_scene",get_node("../MainAdmin"),"change_level_if_completed")
	cant_move=connect("no_movement_for_player",get_node("../Player"),"set_no_movement")
func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("change_scene")
		emit_signal("no_movement_for_player")
>>>>>>> Stashed changes
