extends Node

var option
var navigation
var timer
var timer_
var change
func _ready():
	option=0
	navigation=true
	timer=0
	timer_=0
	NodePlayMusic.get_node("AudioStreamPlayer").play()
func _process(delta):
	timer+=delta
	if navigation==true:
		if option==0:
			get_node("Play").add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm")&&option==0:
				change=get_tree().change_scene("res://Mainmenu_to_level.tscn")
			if Input.is_action_pressed("menuDown"):
				pass
			if Input.is_action_just_released("menuDown"):
				option=1
				timer=0
				get_node("Play").add_color_override("font_color", Color(0.85,0.11,0.56,1))
		if option==1:
			get_node("Options").add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				navigation=false
			if Input.is_action_pressed("menuUP"):
				pass
			if Input.is_action_just_released("menuUP"):
				option=0
				get_node("Options").add_color_override("font_color", Color(0.85,0.11,0.56,1))
			if Input.is_action_pressed("menuDown"):
				pass
			if Input.is_action_just_released("menuDown")&&timer>0.1:
				option=2
				timer=0
				get_node("Options").add_color_override("font_color", Color(0.85,0.11,0.56,1))
		if option==2:
			get_node("Quit").add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				get_tree().quit()
			if Input.is_action_pressed("menuUP"):
				pass
			if Input.is_action_just_released("menuUP"):
				option=1
				get_node("Quit").add_color_override("font_color", Color(0.85,0.11,0.56,1))
			if Input.is_action_pressed("menuDown"):
				pass
			if Input.is_action_just_released("menuDown")&&timer>0.1:
				option=3
				timer=0
				get_node("Quit").add_color_override("font_color", Color(0.85,0.11,0.56,1))
		if option==3:
			get_node("Credits").add_color_override("font_color",Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				navigation=false
			if Input.is_action_pressed("menuUP"):
				pass
			if Input.is_action_just_released("menuUP"):
				option=2
				get_node("Credits").add_color_override("font_color", Color(0.85,0.11,0.56,1))

	if navigation==false&&option==1:
		get_node("Back").visible=true
		get_node("Options").visible=false
		get_node("Play").visible=false
		get_node("Quit").visible=false
		get_node("DisplayTextOptions").visible=true
		get_node("Credits").visible=false
		get_node("Back").add_color_override("font_color",Color(0.11,0.47,0.85,1))
		timer_+=delta
		if Input.is_action_pressed("Escape_to_main_menu")&&timer_>0.1:
			navigation=true
			get_node("Back").visible=false
			get_node("Options").visible=true
			get_node("Play").visible=true
			get_node("Quit").visible=true
			get_node("Credits").visible=true
			get_node("DisplayTextOptions").visible=false
			timer_=0
	if navigation==false&&option==3:
		get_node("Back").visible=true
		get_node("Options").visible=false
		get_node("Play").visible=false
		get_node("Quit").visible=false
		get_node("Credits").visible=false
		get_node("DisplayCreditsDescription").visible=true
		get_node("Back").add_color_override("font_color",Color(0.11,0.47,0.85,1))
		timer_+=delta
		if Input.is_action_pressed("Escape_to_main_menu")&&timer_>0.1:
			navigation=true
			get_node("Options").visible=true
			get_node("Play").visible=true
			get_node("Quit").visible=true
			get_node("Back").visible=false
			get_node("Credits").visible=true
			get_node("DisplayCreditsDescription").visible=false
			get_node("Back").add_color_override("font_color",Color(0.85,0.11,0.56,1))
			timer_=0