extends KinematicBody

onready var Camera = $Pivot/Camera
onready var Anim = $AnimationPlayer
onready var UI = get_node("/root/Game/UI")
onready var animation = get_node("/root/Game/UI/FadeAnimation")
onready var rect = get_node("/root/Game/UI/ColorRect")

var gravity = -30
var max_speed = 5
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var speed = 0.1

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Where I am spawning enemies, later make it after you talk to npc


func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("throw"):
		throw()
	if Input.is_action_pressed("interact"):
		if Global.enemies != 0:
			var new_dialogue2 = Dialogic.start("Main")
			UI.add_child(new_dialogue2)
		else:
			var new_dialogue3 = Dialogic.start("End")
			UI.add_child(new_dialogue3)
			animation.play("fade")
			rect.show()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		


func _physics_process(delta):
	velocity.y += gravity * delta
	var falling = velocity.y
	velocity.y = 0
	
	var desired_velocity = get_input() * speed
	if desired_velocity.length():
		velocity += desired_velocity
	else:
		velocity *= 0.9
	
	var current_speed = velocity.length()
	velocity = velocity.normalized() * clamp(current_speed, 0, max_speed)
	velocity.y = falling
	
	
	$AnimationTree.set("parameters/idle_run/blend_amount", current_speed/max_speed)
	velocity = move_and_slide(velocity, Vector3.UP, true)

func throw():
	$AnimationTree.active = false
	$AnimationPlayer.play("attack")


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationTree.active = true


func _on_FadeAnimation_animation_finished(anim_name):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://UI/End.tscn")
