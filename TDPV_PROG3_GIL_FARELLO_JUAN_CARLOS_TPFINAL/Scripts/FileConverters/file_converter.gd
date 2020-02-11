extends KinematicBody2D
export(float) var potency
export(float) var gravity
var velocity=Vector2()
var timer
var is_touching_something
var rotate
var direction_for_rotation
<<<<<<< Updated upstream:TDPV_PROG3_GIL_FARELLO_JUAN_CARLOS_TPFINAL/Scripts/FileConverters/file_converter.gd
=======
var type_file_converter
>>>>>>> Stashed changes:TDPV_PROG3_GIL_FARELLO_JUAN_CARLOS_TPFINAL/Scripts/FileConvertersAndLifeItems/file_converter.gd
func _ready():
	timer=0
	is_touching_something=false
	rotate=false
	set_process(true)

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