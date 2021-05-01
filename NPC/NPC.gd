extends KinematicBody

onready var UI = get_node("/root/Game/UI") 

func _ready():
	pass
	


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("metarigAction")


func _on_Area_body_entered(body):
	if body.name == "axe":
		var new_dialoge = Dialogic.start("Attacked")
		UI.add_child(new_dialoge)
