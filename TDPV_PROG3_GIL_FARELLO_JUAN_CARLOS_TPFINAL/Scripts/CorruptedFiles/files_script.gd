extends PathFollow2D
signal wasted
<<<<<<< Updated upstream
export var kind_of_file=0
var touched
var number_of_touched
export var direction=false
func _ready():
	number_of_touched=0
	touched=false
	connect("wasted",get_node("../../../CorruptedFiles/Files"),"_set_file")# reemplazar esta parte con golpe de enemigo, considerar un flickering
	
	pass
#acomodar las variables
func _physics_process(delta):
	
	set_offset(get_offset() + (150*delta))
	if unit_offset<1.0&&direction==true:
		$KinematicBody2D/Sprite.set_flip_h(false)
		
	if unit_offset<1.0&&direction==false:
		$KinematicBody2D/Sprite.set_flip_h(true)
	
func _on_Area2D_body_entered(body):
	if body.name=="Player"&&kind_of_file==0:
		emit_signal("wasted")
		queue_free()
	if body.name=="Player"&&kind_of_file==1:
		emit_signal("wasted")
		number_of_touched+=1
		delete_if_touched()
func delete_if_touched():
	if number_of_touched==2:
		queue_free()
=======
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("wasted",get_node("../../../Player"),"_respawn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name=="Player":
		emit_signal("wasted")
>>>>>>> Stashed changes
