extends Area2D

signal collected
var is_collected
var delete_when_collected
var timer
var timer_movement
export var velocity1=0

func _ready():
	is_collected=connect("collected",get_node("../../Player"),"add_lifes")
	delete_when_collected=false
	timer=0
	timer_movement=0

func _process(delta):
	timer_movement+=delta
	if timer_movement<0.5:
		global_position.y+=velocity1*delta
	if timer_movement<1&&timer_movement>0.5:
		global_position.y-=velocity1*delta
	if timer_movement>1:
		timer_movement=0
	if delete_when_collected==true:
		timer+=delta
		if timer>0.2:
			queue_free()
			delete_when_collected=false
			timer=0

func _on_LifeUp_body_entered(body):
	if body.name=="Player":
		$Collected.play()
		emit_signal("collected")
		delete_when_collected=true