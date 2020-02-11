extends Node

var timer
var stop_music
var change
func _ready():
	timer=0
	stop_music=false
func _process(delta):
	timer+=delta

	if Input.is_action_pressed("skip")&&stop_music==false:
		change=get_tree().change_scene("res://level0_demo.tscn")
		NodePlayMusic.get_node("AudioStreamPlayer").stop()
		stop_music=true