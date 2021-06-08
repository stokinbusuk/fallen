extends KinematicBody2D

const gravity = 300
var FLOOR_NORMAL = Vector2.UP
var velocity = Vector2()
export var speed : int = 300
var intensity : int = 0
var moveable : bool = true
var health : int = 5

func _ready():
	$AnimatedSprite.play("idle")

func get_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -1000
	
	if velocity.y < 0:
		$AnimatedSprite.play("jump")

	var is_jump_interrupted: bool = Input.is_action_just_released("jump") and velocity.y < 0.0
	if is_jump_interrupted:
		velocity.y = 0.0
	
	velocity.y += 3000 * get_process_delta_time()
	
	if !is_on_floor() and velocity.y > 0:
		$AnimatedSprite.play("fall")
	
	if velocity.x > 0:
		$AnimatedSprite.set_flip_h(false)
	elif velocity.x < 0:
		$AnimatedSprite.set_flip_h(true)
		
	if (velocity.x > 0 and is_on_floor()) or (velocity.x < 0 and is_on_floor()):
		$AnimatedSprite.play("run")
	
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite.play("idle")
	

func _physics_process(delta):
	if moveable:
		get_input()
	elif !moveable:
		$AnimatedSprite.play("swing")
		velocity = Vector2()
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func _on_Area2D_body_entered(body):
	if body.name == "Spikes":
		health = 0
	if body.name == "Bullet":
		health -= 1
