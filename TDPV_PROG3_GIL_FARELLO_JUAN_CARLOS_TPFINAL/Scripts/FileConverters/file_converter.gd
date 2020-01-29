extends KinematicBody2D
export(float) var potency
export(float) var gravity
var velocity=Vector2()
var timer
var is_touching_something
var rotate
var direction_for_rotation
var type_file_converter
func _ready():
	timer=0
	is_touching_something=false
	rotate=false
	set_process(true)
	#type_file_converter=0
func _physics_process(delta):
	velocity.y+=gravity*delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if is_touching_something==true:
		timer+=delta
		if timer >2:
			queue_free()
			is_touching_something=false
			timer=0
	if rotate==true:
		if direction_for_rotation==false:
			rotation_degrees-=300*delta
		if direction_for_rotation==true:
			rotation_degrees+=300*delta
	if type_file_converter==1:
		$Sprite2.visible=false
		$Sprite3.visible=false
	if type_file_converter==2:
		$Sprite.visible=false
		$Sprite3.visible=false
	if type_file_converter==3:
		$Sprite.visible=false
		$Sprite2.visible=false
func _on_Area2D_body_entered(body):
	if body.name=="StaticBody2DForGround":
		is_touching_something=true
		rotate=false
	if body.name=="StaticBody2DForPlatformsAndBoxes":
		is_touching_something=true
		rotate=false
	if body.name=="Water":
		queue_free()
	if body.name=="AACFiles"||body.name=="MP3Files"|| body.name=="WavFiles"||body.name=="AIFFfiles":
		queue_free()
		
func _set_rotation():
	rotate=true
	
func _set_direction_for_rotation(dir):
	direction_for_rotation=dir
func set_tipe_of_converter():
	type_file_converter=int(rand_range(1,4))