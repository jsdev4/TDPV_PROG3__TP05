extends RichTextLabel

#if score in player is changed, it's neccessary to change here
var score
func _ready():
	score=0
func _process(delta):
	set_text("files converted: "+str(score))

func increase_score():
	score+=1
	#print(score)