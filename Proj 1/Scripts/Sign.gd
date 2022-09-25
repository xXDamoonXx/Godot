extends Node2D

var dialog = null
var is_quest_accepted = false
var is_quest_finished = false

func _ready():
	$Area2D/Speech.visible = false

func _on_Area2D_body_entered(body):
	if get_node_or_null('DialogNode') == null:
		if not is_quest_accepted and not is_quest_finished:
			dialog = Dialogic.start('Start')
			dialog.connect('dialogic_signal', self, 'dialog_msg')
			
		if Globals.enemies_defeated >= 5:
			dialog = Dialogic.start('Finish')
		add_child(dialog)
	$Area2D/Speech.visible = true

func dialog_msg(msg):
	if msg == 'Yes' and not is_quest_accepted:
		is_quest_accepted == true
		is_quest_finished == false
		

func _on_Area2D_body_exited(body):
	$Area2D/Speech.visible = false
