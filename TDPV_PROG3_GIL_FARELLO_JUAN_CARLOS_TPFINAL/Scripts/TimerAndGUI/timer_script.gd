extends RichTextLabel

signal outatime
var is_outatime

var s=0
var m=7
var paused

func _ready():
	is_outatime=connect("outatime",get_node("../../MainAdmin"),"outatime")
	paused=false

func _process(delta):
	if paused==false:
		if s<0:
			m-=1
			s=59
		set_text(str(m)+":"+str(s))

func _on_Timer_timeout():
	if m==0&&s==0:
		m=0
		s=0
		emit_signal("outatime")
	else:
		s-=1

func set_pause_if_completed():
	paused=true