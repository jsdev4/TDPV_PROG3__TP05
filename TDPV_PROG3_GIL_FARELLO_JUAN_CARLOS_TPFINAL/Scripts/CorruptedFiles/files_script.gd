extends PathFollow2D

signal touching_the_player
signal is_not_touching_the_player
signal increase_score1

export var direction=false
export var velocity=0
export var kind_of_file=0
var times_touched_aac=0
var times_touched_mp3=0
var times_touched_wav=0

var is_touching
var is_not_touching
var score
func _ready():
	is_touching=connect("touching_the_player",get_node("../../../Player"),"_set_flashing_when_hitted") 
	is_not_touching=connect("is_not_touching_the_player",get_node("../../../Player"),"quit_life")
	score=connect("increase_score1",get_node("../../../GUI/Score"),"increase_score")

func _physics_process(delta):
	if(velocity<150):
		set_offset(get_offset() + (150*delta))
	if( velocity>150):
		set_offset(get_offset()+(velocity*delta))
	if direction==false:
		$KinematicBody2D/Sprite.set_flip_h(false)
	if direction==true:
		$KinematicBody2D/Sprite.set_flip_h(true)
		
func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("touching_the_player")

	if body.name=="FileConverters"&&kind_of_file==0:
		times_touched_aac+=1
		delete_if_touched()
	if body.name=="FileConverters"&&kind_of_file==1:
		times_touched_mp3+=1
		delete_if_touched()
	if body.name=="FileConverters"&&kind_of_file==2:
		times_touched_wav+=1
		delete_if_touched()
	

func _on_Area2D_body_exited(body):
	if body.name=="Player":
		emit_signal("is_not_touching_the_player")

func delete_if_touched():
	if kind_of_file==0&&times_touched_aac==1:
		emit_signal("increase_score1")
		queue_free()
	if kind_of_file==1&&times_touched_mp3==2:
		emit_signal("increase_score1")
		queue_free()
	if kind_of_file==2&&times_touched_wav==3:
		emit_signal("increase_score1")
		queue_free()
