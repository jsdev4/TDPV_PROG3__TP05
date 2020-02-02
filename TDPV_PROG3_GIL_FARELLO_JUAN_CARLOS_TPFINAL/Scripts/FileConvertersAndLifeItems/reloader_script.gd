extends Area2D

signal collected
var is_collected
func _ready():
	is_collected=connect("collected",get_node("../../Player"),"reloader")
	pass

func _on_Reloader_body_entered(body):
	if body.name=="Player":
		emit_signal("collected")
		queue_free()

