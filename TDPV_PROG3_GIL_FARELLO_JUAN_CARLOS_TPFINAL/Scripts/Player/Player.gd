extends KinematicBody2D

export(float) var GRAVITY = 400
export(float) var WALK_FORCE =20
export(float) var WALK_MIN_SPEED = 10
export(float) var WALK_MAX_SPEED = 70
export(float) var STOP_FORCE = 800
export(float) var JUMP_SPEED = 80 setget _set_jump_speed
export(float) var JUMP_MAX_AIRBORNE_TIME = 0.4
export (PackedScene)var file_converter
export (PackedScene) var lifes_to_show
var offset_for_lifes=50
var lifes_list=[]

signal number_of_files
signal number_of_files_increase

var velocity = Vector2()
var on_air_time = 1
var jumping = false
var jump_curve = PoolVector2Array()
var flipped=Vector2()
var original_position=Vector2()
export var lifes=5
var can_fire
var timer_for_can_fire
var hitted
var restart
var files_converted#tested purposes on console
var files_availables_to_show
var files_availables_to_show_reload
export var files_availables=10
var play_jump_sound
var play_walking_sound
var can_play_walking_sound
var timer_for_emission

func _ready():
	flipped.y=0
	can_fire=true
	play_jump_sound=false
	play_walking_sound=0
	can_play_walking_sound=false
	original_position=position
	timer_for_can_fire=0
	files_converted=0
	emit_signal("draw")
	timer_for_emission=0
	files_availables_to_show=connect("number_of_files",get_node("../GUI/FilesAvailable"),"decrease_files_available")
	files_availables_to_show_reload=connect("number_of_files_increase",get_node("../GUI/FilesAvailable"),"increase_files_available")

	if Engine.editor_hint:
		jump_curve.resize(5)
		calculate_jump_curve()
		update()
	show_lifes()
func _physics_process(delta):
	if Engine.editor_hint: 
		return
	var force = Vector2(0, GRAVITY)
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	var fire=Input.is_action_just_released("fire")
	var sprite
	var animation
	var stop = true
	sprite= get_node("Sprite")
	animation=get_node("AnimationPlayer")
	if hitted==true:
		$Particles2D.emitting=true
	if hitted==false:
		$Particles2D.emitting=false
	if lifes==0:
		restart=get_tree().reload_current_scene()
	
	
	if (walk_left):
		stop = false
		flipped.x=-10
		sprite.flip_h=true	
		can_play_walking_sound=true
		if(animation.is_playing()&&stop==false):
			animation.play("Running")
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
	elif (walk_right):
		stop = false
		flipped.x=10
		sprite.flip_h=false
		can_play_walking_sound=true
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			if(animation.is_playing()&&stop==false):
				animation.play("Running")
				
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		vlen -= STOP_FORCE*delta
		if (vlen < 0):
			vlen = 0
		velocity.x = vlen*vsign
		can_play_walking_sound=false
		animation.play("Idle")

	if can_fire==true&&files_availables>0:
		if fire&&sprite.flip_h==false:
			files_availables-=1
			decrease_files_availables()
			var new_file_converter=file_converter.instance()
			new_file_converter.set_position(get_node("Position2D").global_position)
			new_file_converter.velocity.y=new_file_converter.potency*-sin(70)
			new_file_converter.velocity.x=new_file_converter.potency*cos(70)
			get_tree().get_nodes_in_group("Main")[0].add_child(new_file_converter)
			new_file_converter.set_tipe_of_converter()
			can_fire=false
			new_file_converter._set_rotation()
			new_file_converter._set_direction_for_rotation(true)
			$FireSound.play()
		elif fire&&sprite.flip_h==true:
			files_availables-=1
			decrease_files_availables()
			var new_file_converter=file_converter.instance()
			new_file_converter.set_position(get_node("Position2D2").global_position)
			new_file_converter.velocity.y=new_file_converter.potency*-sin(70)
			new_file_converter.velocity.x=(new_file_converter.potency*cos(70))*-1
			get_tree().get_nodes_in_group("Main")[0].add_child(new_file_converter)
			new_file_converter.set_tipe_of_converter()
			new_file_converter._set_rotation()
			new_file_converter._set_direction_for_rotation(false)
			can_fire=false
			$FireSound.play()
	if can_fire==false&&files_availables>0:
		timer_for_can_fire+=delta
		if timer_for_can_fire>1:
			timer_for_can_fire=0
			can_fire=true
	if files_availables==0:
		if (fire):
			$NoFireSound.play()
	get_node("Sprite").update()
	velocity += force*delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if is_on_floor()&&walk_left||is_on_floor()&&walk_right:
		animation.play("Running")
		if can_play_walking_sound==true:
			play_walking_sound+=delta
			if play_walking_sound>0.3:
				$AudioStreamPlayer.play()
				play_walking_sound=0
		if play_jump_sound==true:
			$OnGroundStep.play()
			play_jump_sound=false
		on_air_time = 0
	elif is_on_floor()&&stop:
		animation.play("Idle")
	else:
		animation.play("Jumping")
	if jumping and velocity.y > 0:
		jumping = false
		animation.play("Jumping")
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not jumping):
		velocity.y = -JUMP_SPEED
		$JumpSound.play()
		jumping = true
		play_jump_sound=true
	on_air_time += delta
func calculate_jump_curve():
	var t = 2*JUMP_SPEED/GRAVITY
	for i in range(0,jump_curve.size()):
		var current_time = t / jump_curve.size() * (i+1)
		jump_curve[i].x = WALK_MAX_SPEED/jump_curve.size() * (i+1) #aprox
		jump_curve[i].y = -(JUMP_SPEED*current_time-pow(current_time,2)*GRAVITY/2)
		
func _set_jump_speed(js):
	JUMP_SPEED = js
	calculate_jump_curve()
	update()
	
	
func _respawn():
	quit_life()
	position=get_node("../PointForRespawn").position
	
func _has_finished_the_level():
	
	pass
	
func _set_flashing_when_hitted():
	
	hitted=true
	
func quit_life():
	$Hitted.play()
	for i in 1:
		hitted=false
		lifes-=1
		lifes_list[lifes].queue_free()


func show_lifes():
	for i in lifes:
		var new_lifes=lifes_to_show.instance()
		get_tree().get_nodes_in_group("GUI")[0].add_child(new_lifes)
		new_lifes.global_position.x+=offset_for_lifes*i
		lifes_list.append(new_lifes)
		
func add_lifes():
	lifes+=1
	var new_lifes=lifes_to_show.instance()
	get_tree().get_nodes_in_group("GUI")[0].add_child(new_lifes)
	new_lifes.global_position.x+=offset_for_lifes*(lifes-1)
	lifes_list.append(new_lifes)
	
func reloader():
	files_availables+=10
	increase_files_availables()
	print (files_availables)
	
#for tested purposes#
func increase_score():
	files_converted+=1
	print(files_converted)

func decrease_files_availables():
	emit_signal("number_of_files")
func increase_files_availables():
	emit_signal("number_of_files_increase")
func set_no_movement():
	WALK_FORCE=0
	WALK_MAX_SPEED=0