extends Area2D
signal collected
var is_collected
var delete_when_collected
var timer
func _ready():
	is_collected=connect("collected",get_node("../../Player"),"add_lifes")
	delete_when_collected=false
	timer=0
	pass
func _process(delta):
	if delete_when_collected==true:
		timer+=delta
		if timer>0.8:
			queue_free()
			delete_when_collected=false
			timer=0
func _on_LifeUp_body_entered(body):
	if body.name=="Player":
		$Collected.play()
		emit_signal("collected")
		delete_when_collected=true
