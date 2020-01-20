extends Node
var type
var type1
var type2
var converted
var emited
var emited1
var emited2
export var number_of_path=0
func _ready():
	randomize()
	converted=false
	emited=false
	emited1=false
	emited2=false

func _process(delta):
	_rand_for_the_file_generation()
	
func _rand_for_the_file_generation():
	if number_of_path==0:
		if (emited==false):
			type=int(rand_range(0,2))
			emited=true
		if emited==true:
			if type==1:
				remove_child($MP3Files)
				emited=false
			if type==2:
				remove_child($AACFiles)
				emited=false

	if number_of_path==1:
		if (emited1==false):
			type1=int(rand_range(0,2))
			emited1=true
		if emited1==true:
			if type1==1:
				remove_child($MP3Files)
				emited1=false
			if type1==2:
				remove_child($AACFiles)
				emited1=false
	if number_of_path==2:
		if (emited2==false):
			type2=int(rand_range(0,2))
			emited2=true
		if emited2==true:
			if type2==1:
				remove_child($MP3Files)
				emited2=false
			if type2==2:
				remove_child($AACFiles)
				emited2=false
	if converted==true&&type==0:
		converted=false
	if converted==true&&type==1:
		converted=false
func _set_file():
	converted=true
			# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
