<<<<<<< Updated upstream
extends Node
signal has_finished

func _ready():
	connect("has_finished",get_node("../Player"),"_has_finished_the_level")


func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("has_finished")
=======
extends Area2D

signal change_scene
signal no_movement_for_player
signal timerpaused

var cant_move
var can_change_level
var set_timer_paused
func _ready():
	can_change_level=connect("change_scene",get_node("../MainAdmin"),"change_level_if_completed")
	cant_move=connect("no_movement_for_player",get_node("../Player"),"set_no_movement")
	set_timer_paused=connect("timerpaused",get_node("../GUI/Time"),"set_pause_if_completed")
func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("change_scene")
		emit_signal("no_movement_for_player")
		emit_signal("timerpaused")
>>>>>>> Stashed changes
