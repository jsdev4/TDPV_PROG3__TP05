extends Area2D
signal collected
var is_collected

func _ready():
	is_collected=connect("collected",get_node("../../Player"),"add_lifes")
	pass

func _on_LifeUp_body_entered(body):
	if body.name=="Player":
		emit_signal("collected")
		queue_free()
