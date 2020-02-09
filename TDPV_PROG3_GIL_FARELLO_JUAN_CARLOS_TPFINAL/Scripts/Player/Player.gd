extends KinematicBody2D
#tool
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
signal random_file_converter
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
export var files_availables=10

func _ready():
	flipped.y=0
	can_fire=true
	original_position=position
	timer_for_can_fire=0
	
	emit_signal("draw")
	#color_to_change=Color(1,1,1,1)
	if Engine.editor_hint: #para que haga draw sólo en tool mode
		jump_curve.resize(5)
		calculate_jump_curve()
		update()
	show_lifes()
func _physics_process(delta):
	if Engine.editor_hint: 
		return
#		emit_signal("move_me")
	var force = Vector2(0, GRAVITY)
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	var fire=Input.is_action_just_released("fire")
	#var hide=Input.is_action_pressed("Hide")
#	var animation
	var sprite
	var stop = true
	var material=get_node("Sprite").get_material()
	
	if hitted==true:
		$Particles2D.emitting=true
		material.set_shader_param("glow",1.0)

	if hitted==false:
		$Particles2D.emitting=false
		material.set_shader_param("glow",0.0)
	
	if lifes==0:
		restart=get_tree().reload_current_scene()
#	animation=get_node("AnimationPlayer")
	sprite= get_node("Sprite")
	if (walk_left):
		stop = false
		flipped.x=-10
		sprite.flip_h=true	
	
		#if(animation.is_playing()&&stop==false):
		#		animation.play("Running")
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
	elif (walk_right):
		stop = false
		flipped.x=10
		sprite.flip_h=false
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			#if(animation.is_playing()&&stop==false):
			#	animation.play("Running")
				
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		vlen -= STOP_FORCE*delta
		if (vlen < 0):
			vlen = 0
		velocity.x = vlen*vsign
		#animation.play("Idle")
		#if(Input.is_action_pressed("numpad01")):
		#	color_to_change=Color(0.35,0.82,0.3,1.0)
		#if(Input.is_action_pressed("numpad02")):
		#	color_to_change=Color(0.97, 0.45, 0.32, 1.0)
		#if(Input.is_action_pressed("numpad03")):
		#	color_to_change=Color(0.18, 0.18, 0.85, 1.0)
		#if(Input.is_action_pressed("numpad0")):
		#	color_to_change=Color(1,1,1,1)
		#if(Input.is_action_pressed("megabooster")):
		#	material.set_shader_param("glow",1.0)
		#elif(Input.is_action_just_released("megabooster")):
		#	material.set_shader_param("glow",0.0)
		
			
	#material.set_shader_param("received_color",color_to_change)
	#if(hide):
	#	timer_for_hide+=delta
	#	emit_signal("is_hiding")
	if can_fire==true&&files_availables>0:
		
		if fire&&sprite.flip_h==false:
			files_availables-=1
			emit_signal("random_file_converter")
			var new_file_converter=file_converter.instance()
			new_file_converter.set_position(get_node("Position2D").global_position)
			new_file_converter.velocity.y=new_file_converter.potency*-sin(70)
			new_file_converter.velocity.x=new_file_converter.potency*cos(70)
			get_tree().get_nodes_in_group("Main")[0].add_child(new_file_converter)
			new_file_converter.set_tipe_of_converter()
			can_fire=false
			new_file_converter._set_rotation()
			new_file_converter._set_direction_for_rotation(true)
		
		elif fire&&sprite.flip_h==true:
			files_availables-=1
			var new_file_converter=file_converter.instance()
			new_file_converter.set_position(get_node("Position2D2").global_position)
			new_file_converter.velocity.y=new_file_converter.potency*-sin(70)
			new_file_converter.velocity.x=(new_file_converter.potency*cos(70))*-1
			get_tree().get_nodes_in_group("Main")[0].add_child(new_file_converter)
			new_file_converter.set_tipe_of_converter()
			new_file_converter._set_rotation()
			new_file_converter._set_direction_for_rotation(false)
			can_fire=false
	if can_fire==false&&files_availables>0:
		timer_for_can_fire+=delta
		if timer_for_can_fire>1:
			timer_for_can_fire=0
			can_fire=true
	if files_availables==0:
		can_fire=false
	get_node("Sprite").update()
	velocity += force*delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if is_on_floor():
		on_air_time = 0
	#else:
	#	animation.play("jumping")
	if jumping and velocity.y > 0:
		jumping = false
		
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not jumping):
		velocity.y = -JUMP_SPEED
		jumping = true
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
	#from here a new level instance creates another level
	pass
	
func _set_flashing_when_hitted():
	hitted=true
	
func quit_life():
	hitted=false
	for i in 1:
		lifes-=1
<<<<<<< Updated upstream
	if lifes>=0:
=======
>>>>>>> Stashed changes
		lifes_list[lifes].queue_free()
		print (lifes)

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
<<<<<<< Updated upstream
	print (files_availables)
=======
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
>>>>>>> Stashed changes
