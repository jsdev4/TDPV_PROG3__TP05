extends Node

func _ready():
	pass

func _on_EntryMessage_body_entered(body):
	if body.name=="Player":
		$EntryMessage/Message.show()

func _on_EntryMessage_body_exited(body):
	if body.name=="Player":
		$EntryMessage/Message.hide()


func _on_Warning_body_entered(body):
	if body.name=="Player":
		$Warning/WarningMessage.show()


func _on_Warning_body_exited(body):
	if body.name=="Player":
		$Warning/WarningMessage.hide()


func _on_Items_body_entered(body):
	if body.name=="Player":
		$Items/ItemsMessage.show()


func _on_Items_body_exited(body):
	if body.name=="Player":
		$Items/ItemsMessage.hide()