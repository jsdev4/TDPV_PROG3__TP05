extends KinematicBody2D
tool
export(float) var GRAVITY = 400
export(float) var FLOOR_ANGLE_TOLERANCE = 40
export(float) var WALK_FORCE =20
export(float) var WALK_MIN_SPEED = 10
export(float) var WALK_MAX_SPEED = 70
export(float) var STOP_FORCE = 800
export(float) var JUMP_SPEED = 80 setget _set_jump_speed
export(float) var JUMP_MAX_AIRBORNE_TIME = 0.4
export(float) var  SLIDE_STOP_VELOCITY = 1.0 # One pixel per second
export(float) var  SLIDE_STOP_MIN_TRAVEL = 1.0
var velocity = Vector2()
var on_air_time = 1
var jumping = false
var jump_curve = PoolVector2Array()
signal im_dead
var flipped=Vector2()
#var color_to_change=Color()

func _ready():
	flipped.y=0
	emit_signal("draw")
	#color_to_change=Color(1,1,1,1)
	if Engine.editor_hint: #para que haga draw sólo en tool mode
		jump_curve.resize(5)
		calculate_jump_curve()
		update()
		
func _physics_process(delta):
	if Engine.editor_hint: 
		return
		emit_signal("move_me")
	var force = Vector2(0, GRAVITY)
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	var animation
	var sprite
	var stop = true
	var material=get_node("Sprite").get_material()
	
	
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
	get_node("Sprite").update()
		
	velocity += force*delta
	var motion = velocity*delta
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
	