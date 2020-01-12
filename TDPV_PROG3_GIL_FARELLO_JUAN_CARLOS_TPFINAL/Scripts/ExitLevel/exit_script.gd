extends Node
signal has_finished

func _ready():
	connect("has_finished",get_node("../Player"),"_has_finished_the_level")


func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("has_finished")
