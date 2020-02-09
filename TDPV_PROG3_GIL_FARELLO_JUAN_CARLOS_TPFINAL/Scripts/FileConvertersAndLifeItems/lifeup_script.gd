extends Area2D
signal collected
var is_collected

func _ready():
	is_collected=connect("collected",get_node("../../Player"),"add_lifes")
	pass
<<<<<<< Updated upstream

=======
func _process(delta):
	if delete_when_collected==true:
		timer+=delta
		if timer>0.2:
			queue_free()
			delete_when_collected=false
			timer=0
>>>>>>> Stashed changes
func _on_LifeUp_body_entered(body):
	if body.name=="Player":
		emit_signal("collected")
		queue_free()
