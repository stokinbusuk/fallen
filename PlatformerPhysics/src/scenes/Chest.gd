extends Area2D

var taken : bool = false
var takeable : bool = false
export (PackedScene) var item

func deploy() -> void:
	var i = item.instance()
	owner.add_child(i)
	i.global_position.x = $AnimatedSprite.global_position.x
	i.global_position.y = $AnimatedSprite.global_position.y - 70

func _ready():
	$AnimatedSprite.play("close")

func _physics_process(delta):
	if takeable:
		if Input.is_action_just_pressed("ui_accept"):
			$AnimatedSprite.play("open")
			if !taken:
				deploy()
				taken = true

func _on_Chest_body_entered(body):
	if body.name == "Demon":
		takeable = true


func _on_Chest_body_exited(body):
	if body.name == "Demon":
		takeable = false
