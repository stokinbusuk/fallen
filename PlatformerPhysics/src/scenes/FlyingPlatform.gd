extends KinematicBody2D

# Variable initialisation
var reload_position
var falling : bool = false
var ready2fall : bool = false
var velocity : Vector2 = Vector2()
var timer = 0
var wait_time = 0.5
var oledi : bool = false
var timer2 = 0
var wait_time2 = 10
var fallen : bool = false

# Initial process
func _ready():
	reload_position = global_position
	$AnimatedSprite.play("idle")


func _physics_process(delta):
	if ready2fall:
		timer+=delta
		if timer > wait_time:
			$AnimatedSprite.play("falling")
			ready2fall = false
			falling = true
			timer = 0
	if falling:
		velocity.y += 3000 * delta
	
	if fallen:
		timer2 += delta
		if timer2 > wait_time2:
			fallen = false
			global_position = reload_position
			$AnimatedSprite.play("idle")
			$AnimatedSprite.visible = true
			timer2 = 0
			oledi = false
	
	move_and_slide(velocity, Vector2.UP)
	if falling and is_on_floor():
		fallen = true
		falling = false
		velocity = Vector2()
		$AnimatedSprite.visible = false
	

func _on_PlayerDetector_body_entered(body):
	if body.name == "Demon" and !oledi:
		oledi = true
		ready2fall = true
