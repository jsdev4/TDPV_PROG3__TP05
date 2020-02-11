extends Area2D

signal collected
var is_collected
var is_connected_again
var respawn
var timer
var timer_movement
export var velocity=0

func _ready():
	is_collected=connect("collected",get_node("../../Player"),"reloader")
	respawn=false
	timer=0
	timer_movement=0

func _process(delta):
	timer_movement+=delta
	if timer_movement<0.5:
		global_position.y+=velocity*delta
	if timer_movement<1&&timer_movement>0.5:
		global_position.y-=velocity*delta
	if timer_movement>1:
		timer_movement=0
		
	if respawn==true:
		$CollisionShape2D.disabled=true
		$Sprite.visible=false
		timer+=delta
		if timer>20:
			connect_again()
			respawn=false
			timer=0

func _on_Reloader_body_entered(body):
	if body.name=="Player":
		$Collected.play()
		emit_signal("collected")
		respawn=true
		disconnect("collected",get_node("../../Player"),"reloader")
		

func connect_again():
	is_connected_again=connect("collected",get_node("../../Player"),"reloader")
	$CollisionShape2D.disabled=false
	$Sprite.visible=true