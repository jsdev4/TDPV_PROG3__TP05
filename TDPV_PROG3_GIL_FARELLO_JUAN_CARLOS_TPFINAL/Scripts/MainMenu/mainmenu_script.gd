extends Node

var option
var timer
func _ready():
	option=0
	timer=0

func _process(delta):
	timer+=delta
	if option==0:
		get_node("Play").add_color_override("font_color", Color(0.11,0.47,0.85,1))
		if Input.is_action_pressed("menuDown"):
			pass
		if Input.is_action_just_released("menuDown"):
			option=1
			timer=0
			get_node("Play").add_color_override("font_color", Color(0.85,0.11,0.56,1))
	if option==1:
		get_node("Options").add_color_override("font_color", Color(0.11,0.47,0.85,1))
		if Input.is_action_pressed("menuUP"):
			pass
		if Input.is_action_just_released("menuUP"):
			option=0
			get_node("Options").add_color_override("font_color", Color(0.85,0.11,0.56,1))
		if Input.is_action_pressed("menuDown"):
			pass
		if Input.is_action_just_released("menuDown")&&timer>0.2:
			option=2
			timer+=delta
			get_node("Options").add_color_override("font_color", Color(0.85,0.11,0.56,1))

	if option==2:
		get_node("Quit").add_color_override("font_color", Color(0.11,0.47,0.85,1))
		if Input.is_action_pressed("menuUP"):
			pass
		if Input.is_action_just_released("menuUP"):
			option=1
			get_node("Quit").add_color_override("font_color", Color(0.85,0.11,0.56,1))
func _input(event):
	if option==0:
		if event.is_action_pressed("Confirm"):
			get_tree().change_scene("res://level0_demo.tscn")
	if option==1:
		pass
	if option==2:
		if event.is_action_pressed("Confirm"):
			get_tree().quit()
