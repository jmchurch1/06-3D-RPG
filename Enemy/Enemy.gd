extends KinematicBody

onready var Enemy_Mesh = $metarig/Skeleton/Enemy
var Enemy = load("res://Enemy/Enemy.tscn")
onready var full = preload("res://Enemy/full.tres")
onready var three_quarters = preload("res://Enemy/three_quarters.tres")
onready var half = preload("res://Enemy/half.tres")
onready var one_quarter = preload("res://Enemy/one_quarter.tres")
onready var ray = $RayCast
onready var player = get_node("/root/Game/player")

var rng = RandomNumberGenerator.new()
var velocity = 10
var health = 100
var red = Color(231, 21, 21)

var points = []

func _ready():
	pass



func _on_Area_body_entered(body):
	if body.name == "axe":
		rng.randomize()
		var random = rng.randf_range(0,500)
		if random <= 100:
			$Hurt.play()
		elif random > 100 and random <= 200:
			$Hurt2.play()
		elif random > 200 and random <= 300:
			$Hurt3.play()
		elif random == 500:
			$Hurt4.play()
		elif random > 300 and random <= 400:
			$Hurt5.play()
		elif random > 400 and random <= 499:
			$Hurt6.play()
			
	
		
		health -= body.damage
		if health == 75:
			Enemy_Mesh.material_override = three_quarters
		if health == 50:
			Enemy_Mesh.material_override = half
		if health == 25:
			Enemy_Mesh.material_override = one_quarter
		if health <= 0:
			queue_free()
			Global.enemies -= 1

