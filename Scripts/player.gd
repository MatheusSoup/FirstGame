extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var animation = $AnimationPlayer
@onready var audio = $Jump
@onready var body = $Sprite2D
@onready var gamemane = %GameManeger
@onready var animacao = $AnimatedSprite2D
var can_move = false

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Pulo.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		audio.play()

	# Andar.
	if Input.is_action_pressed("ui_right") and can_move:
		velocity.x = SPEED
		$Sprite2D.flip_h = false
		animation.play("Run")
	elif Input.is_action_pressed("ui_left") and can_move:
		velocity.x = -SPEED
		$Sprite2D.flip_h = true
		animation.play("Run")
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED)

	#  Estado do personagem
	if is_on_floor():
		if velocity.x == 0:
			animation.play("Idle")
	else:
		if velocity.y < 0:
			animation.play("Jump")
		else:
			animation.play("Fall")
		
	move_and_slide()
	
func death():
	set_physics_process(false)
	body.visible = false
	animacao.visible = true
	animacao.play("Death")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animacao.animation == "Death":
		animacao.visible = false
		gamemane.lose()
	
