extends Spatial

var damage = 25

func _ready():
	pass


func _on_Area_body_entered(body):
	print(body.name)
