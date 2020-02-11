extends Node
var is_outatime
var finished
var paused
var option
var option2
var reload
var change
func _ready():
	is_outatime=false
	finished=false
	option=0
	option2=0
func _process(delta):
	if is_outatime==true:
		get_tree().get_nodes_in_group("TimeIsOut")[0].visible=true
		get_tree().get_nodes_in_group("BackgroundForPause")[0].visible=true
		get_tree().get_nodes_in_group("GameTitle")[0].visible=true
		get_tree().get_nodes_in_group("GameTitle")[1].visible=true
		get_tree().get_nodes_in_group("MenuLabel")[0].visible=true
		get_tree().get_nodes_in_group("MenuLabel")[1].visible=true
		get_tree().paused=true
		if option==0:
			get_tree().get_nodes_in_group("MenuLabel")[0].add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				reload=get_tree().reload_current_scene()
				get_tree().paused=false
			if Input.is_action_pressed("menuDown"):
				option=1
				get_tree().get_nodes_in_group("MenuLabel")[0].add_color_override("font_color", Color(0.85,0.11,0.56,1))
				
		if option==1:
			get_tree().get_nodes_in_group("MenuLabel")[1].add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				change=get_tree().change_scene("res://Mainmenu.tscn")
				get_tree().paused=false
			if Input.is_action_pressed("menuUP"):
				option=0
				get_tree().get_nodes_in_group("MenuLabel")[1].add_color_override("font_color", Color(0.85,0.11,0.56,1))
	if  finished==true:
		get_tree().get_nodes_in_group("LevelFinished")[0].visible=true

		if Input.is_action_pressed("ConfirmChangeScene"):
				change=get_tree().change_scene("res://Mainmenu.tscn")
				#from here connects another scene
	if is_outatime==false&&finished==false:
		
		if Input.is_action_just_pressed("Escape_to_main_menu"):
			paused=!paused

			var new_pause_state=not get_tree().paused
			get_tree().get_nodes_in_group("BackgroundForPause")[0].visible=new_pause_state
			get_tree().get_nodes_in_group("GameTitle")[0].visible=new_pause_state
			get_tree().get_nodes_in_group("GameTitle")[1].visible=new_pause_state
			get_tree().get_nodes_in_group("MenuLabel")[0].visible=new_pause_state
			get_tree().get_nodes_in_group("MenuLabel")[1].visible=new_pause_state
			get_tree().get_nodes_in_group("MenuLabel")[2].visible=new_pause_state
		
			get_tree().paused=new_pause_state

		if paused==true:
			
			if option2==0:
				get_tree().get_nodes_in_group("MenuLabel")[0].add_color_override("font_color", Color(0.11,0.47,0.85,1))
			if Input.is_action_pressed("Confirm"):
				reload=get_tree().reload_current_scene()
				get_tree().paused=false
			if Input.is_action_pressed("menuDown"):
				option2=1
				get_tree().get_nodes_in_group("MenuLabel")[0].add_color_override("font_color", Color(0.85,0.11,0.56,1))
			if option2==1:
				get_tree().get_nodes_in_group("MenuLabel")[1].add_color_override("font_color", Color(0.11,0.47,0.85,1))
				if Input.is_action_pressed("Confirm"):
					change=get_tree().change_scene("res://Mainmenu.tscn")
				#from here back to main menu#
				if Input.is_action_pressed("menuUP"):
					option2=0
					get_tree().get_nodes_in_group("MenuLabel")[1].add_color_override("font_color", Color(0.85,0.11,0.56,1))
func change_level_if_completed():
	finished=true
		
func outatime():
	is_outatime=true