extends Area2D
signal has_finished
var level_completed
func _ready():
	level_completed=connect("has_finished",get_node("../Player"),"_has_finished_the_level")


func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("has_finished")
