extends PathFollow2D
signal touching_the_player
signal is_not_touching_the_player
export var kind_of_file=0

var number_of_touched_mp3
var number_of_touched_wav
var number_of_touched_aiff
export var direction=false
export var velocity=0
func _ready():
	number_of_touched_mp3=0
	number_of_touched_wav=0
	number_of_touched_aiff=0
	connect("touching_the_player",get_node("../../../Player"),"_set_flashing_when_hitted")# 
	connect("is_not_touching_the_player",get_node("../../../Player"),"_set_not_flashing_when_leave_it")##reemplazar esta parte con golpe de enemigo, considerar un flickering
	pass
func _physics_process(delta):
	if(velocity<150):
		set_offset(get_offset() + (150*delta))
	if( velocity>150):
		set_offset(get_offset()+(velocity*delta))
	if unit_offset<1.0&&direction==true:
		$KinematicBody2D/Sprite.set_flip_h(false)
	if unit_offset<1.0&&direction==false:
		$KinematicBody2D/Sprite.set_flip_h(true)
		
func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("touching_the_player")
	if body.name=="FileConverters"&&kind_of_file==1:
		number_of_touched_mp3+=1
		delete_if_touched()
	if body.name=="FileConverters"&&kind_of_file==2:
		number_of_touched_wav+=1
		delete_if_touched()
	if body.name=="FileConverters"&&kind_of_file==3:
		number_of_touched_aiff+=1
		delete_if_touched()
	if body.name=="FileConverters"&&kind_of_file==0:
		queue_free()
		
func delete_if_touched():
	if number_of_touched_mp3==2:
		queue_free()
	if number_of_touched_wav==3:
		queue_free()
	if number_of_touched_aiff==4:
		queue_free()


func _on_Area2D_body_exited(body):
	if body.name=="Player":
		emit_signal("is_not_touching_the_player")
