extends Node
signal has_finished
func _ready():
	connect("has_finished",get_node("../Player"),"_has_finished_the_level")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitLevel_body_entered(body):
	if body.name=="Player":
		emit_signal("has_finished")
