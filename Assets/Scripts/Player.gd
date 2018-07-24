extends KinematicBody2D

const SPEED       = 500
const GRAVITY     = 2000
const JUMP_HEIGHT = -900
const JUMP_BOOST  = 2
const UP          = Vector2(0, -1)

var motion = Vector2()

func _ready():
	Global.Player = self


func _physics_process(delta):
	update_motion(delta)


func _process(delta):
	
	if ($AnimatedSprite.get_animation() != "die"):
		update_animation(motion)


func update_motion(delta):
	fall(delta)
	run()
	jump()
	
	move_and_slide(motion, UP)


func update_animation(motion):
	$AnimatedSprite.update(motion)


func run():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED
	else:
		motion.x = 0
		
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func fall(delta):
	if motion.y > 0 and is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY * delta
		
	if position.y > 6000:
		Global.GameState.end_game()


func jump():
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		motion.y = JUMP_HEIGHT
		Global.JumpSFX.play()


func boost():
	motion.y = JUMP_HEIGHT * JUMP_BOOST
	Global.JumpSFX.play()


func take_damage():
	if motion.y < 0:
		motion.y = -JUMP_HEIGHT
	else:
		motion.y = JUMP_HEIGHT


func play_dead():
	$AnimatedSprite.play("die")
