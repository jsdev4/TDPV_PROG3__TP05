extends RichTextLabel
#if fioles in player is changed, it's neccessary to change here
var files_available
func _ready():
	files_available=10

func _process(delta):
	set_text("Converters available: "+str(files_available))

func decrease_files_available():
	files_available-=1

func increase_files_available():
	files_available+=10