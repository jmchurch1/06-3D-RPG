extends KinematicBody

onready var Enemy_Mesh = $metarig/Skeleton/Enemy
var Enemy = load("res://Enemy/Enemy.tscn")
onready var full = preload("res://Enemy/full.tres")
onready var three_quarters = preload("res://Enemy/three_quarters.tres")
onready var half = preload("res://Enemy/half.tres")
onready var one_quarter = preload("res://Enemy/one_quarter.tres")

var health = 100
var red = Color(231, 21, 21)

var possible_position = [

]

func _ready():
	pass


func _physics_process(_delta):
	#if Global.amount > 1:
	#	for i in Global.amount:
	#		print(Global.amount)
	#		var e = Enemy.instance()
	#		e.global_transform = possible_position[i]
	#		Global.amount -= 1
	#		add_child(e)
	pass


func _on_Area_body_entered(body):
	if body.name == "axe":
		health -= body.damage
		if health == 75:
			Enemy_Mesh.material_override = three_quarters
		if health == 50:
			Enemy_Mesh.material_override = half
		if health == 25:
			Enemy_Mesh.material_override = one_quarter
		if health <= 0:
			queue_free()

