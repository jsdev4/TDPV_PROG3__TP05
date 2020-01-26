extends Node
var type_in_path
var type_in_path1
var type_in_path2
var type_in_path3
var type_in_path4
var type_in_path5
var type_in_path6
var type_in_path7
var converted
var emited_in_path
var emited_in_path1
var emited_in_path2
var emitted_in_path3
var emitted_in_path4
var emitted_in_path5
var emitted_in_path6
var emitted_in_path7
export var number_of_path=0
func _ready():
	randomize()
	converted=false
	emited_in_path=false
	emited_in_path1=false
	emited_in_path2=false
	emitted_in_path3=false
	emitted_in_path4=false
	emitted_in_path5=false
	emitted_in_path6=false
func _process(delta):
	_rand_for_the_file_generation()
	
func _rand_for_the_file_generation():
	if number_of_path==0:
		if (emited_in_path==false):
			type_in_path=int(rand_range(0,2))
			emited_in_path=true
		if emited_in_path==true:
			if type_in_path==1:
				$MP3Files/KinematicBody2D.set_process(false)
				$MP3Files/KinematicBody2D/Sprite.visible=false
				emited_in_path=false
			if type_in_path==2:
				$AACFiles/KinematicBody2D.set_process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emited_in_path=false

	if number_of_path==1:
		if (emited_in_path1==false):
			type_in_path1=int(rand_range(0,2))
			emited_in_path1=true
		if emited_in_path1==true:
			if type_in_path1==1:
				$MP3Files/KinematicBody2D.set_process(false)
				$MP3Files/KinematicBody2D/Sprite.visible=false
				emited_in_path1=false
			if type_in_path1==2:
				$AACFiles/KinematicBody2D.set_process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emited_in_path1=false
	if number_of_path==2:
		if emited_in_path2==false:
			type_in_path2=int(rand_range(0,2))
			emited_in_path2=true
		if emited_in_path2==true:
			if type_in_path2==1:
				$MP3Files/KinematicBody2D.set_process(false)
				$MP3Files/KinematicBody2D/Sprite.visible=false
				emited_in_path2=false
			if type_in_path2==2:
				$AACFiles/KinematicBody2D.set_process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emited_in_path2=false
	if number_of_path==3:
		if emitted_in_path3==false:
			type_in_path3=int(rand_range(0,2))
			emitted_in_path3=true
		if emitted_in_path3==true:
			if type_in_path3==1:
				$WavFiles/KinematicBody2D.set_process(false)
				$WavFiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path3=false
			if type_in_path3==2:
				$AIFFfiles/KinematicBody2D.set__process(false)
				$AIFFfiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path3=false
	if number_of_path==4:
		if emitted_in_path4==false:
			type_in_path4=int(rand_range(0,2))
			emitted_in_path4=true
		if emitted_in_path4==true:
			if type_in_path4==1:
				$WavFiles/KinematicBody2D.set_process(false)
				$WavFiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path4=false
			if type_in_path4==2:
				$AIFFfiles/KinematicBody2D.set__process(false)
				$AIFFfiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path4=false
	if number_of_path==5:
		if emitted_in_path5==false:
			type_in_path5=int(rand_range(0,2))
			emitted_in_path5=true
		if emitted_in_path5==true:
			if type_in_path5==1:
				$AACFiles/KinematicBody2D.set_process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path5=false
			if type_in_path5==2:
				$AIFFfiles/KinematicBody2D.set__process(false)
				$AIFFfiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path5=false
	if number_of_path==6:
		if emitted_in_path6==false:
			type_in_path6=int(rand_range(1,2))
			emitted_in_path6=true
		if emitted_in_path6==true:
			if type_in_path6==1:
				$AIFFfiles/KinematicBody2D.set_process(false)
				$AIFFfiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path6=false
			if type_in_path6==2:
				$AACfiles/KinematicBody2D.set__process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path6=false
	if number_of_path==7:
		if emitted_in_path7==false:
			type_in_path7=int(rand_range(1,2))
			emitted_in_path7=true
		if emitted_in_path7==true:
			if type_in_path7==1:
				$AIFFfiles/KinematicBody2D.set_process(false)
				$AIFFfiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path7=false
			if type_in_path7==2:
				$AACFiles/KinematicBody2D.set_process(false)
				$AACFiles/KinematicBody2D/Sprite.visible=false
				emitted_in_path7=false
	if converted==true&&type_in_path==0:
		converted=false
	if converted==true&&type_in_path==1:
		converted=false
func _set_file():
	converted=true
			# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
