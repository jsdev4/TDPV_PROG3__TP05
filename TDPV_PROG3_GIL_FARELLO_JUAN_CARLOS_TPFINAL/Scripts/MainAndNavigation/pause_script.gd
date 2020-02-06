extends RichTextLabel
var paused
var start_timer
var timer_for_finish_label

func _ready():
	start_timer=false
	timer_for_finish_label=0
func _process(delta):
	if start_timer==true:
		timer_for_finish_label+=delta
		if timer_for_finish_label >1:
			get_tree().get_nodes_in_group("FinishLabel")[0].show()
			get_tree().paused=true

func _input(event):
	if event.is_action_pressed("Pause"):
		paused=!paused
		var new_pause_state=not get_tree().paused
		get_tree().paused=new_pause_state
		$BackgroundForPause/Sprite.visible=new_pause_state
		get_tree().get_nodes_in_group("GameTitle")[0].hide()
		get_tree().get_nodes_in_group("GameTitle")[1].hide()
		visible=new_pause_state
		
func pause_for_finish():
	start_timer=true
	get_tree().get_nodes_in_group("Player")[0].visible=false