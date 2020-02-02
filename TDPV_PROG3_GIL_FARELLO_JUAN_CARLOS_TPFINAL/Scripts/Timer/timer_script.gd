extends RichTextLabel

var s=0
var m=1
var paused
func _ready():
	paused=false
#warning ignore: delta is never used#
func _process(delta):
	if s<0:
		m-=1
		s=59
#poner pausa
	
	set_text(str(m)+":"+str(s))
func _on_Timer_timeout():
	if m==0&&s==0:
		m=0
		s=0
	else:
		s-=1
		