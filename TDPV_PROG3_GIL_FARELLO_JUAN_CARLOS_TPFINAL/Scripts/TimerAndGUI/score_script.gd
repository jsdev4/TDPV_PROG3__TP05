extends RichTextLabel

var score

#warning-ignore the delta argument is not used here#
func _ready():
	score=0
func _process(delta):
	set_text("files converted: "+str(score))
	
func increase_score():
	score+=1
	#print(score)