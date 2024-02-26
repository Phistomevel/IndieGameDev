extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -430.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal OnUse
signal OnDoubleJump
signal OnAttack


##[CUSTOM VARIABLES]
var doubleJumpUnlocked = false
var hasDoubleJump = false
var facingLeft : bool = false 

var isRunning = false
var isAttacking = false
var isFalling = false
var jumped = false
var isDoubleJumping = false
var justFell = false
var attackAnim = false
var doubleJumpAnim = false

func _ready():
	var animation_tree = $"AnimatedSprite2D/AnimationPlayer/AnimationTree"
	var state_machine = animation_tree["parameters/playback"]
	state_machine.start("idle")
	print(state_machine.is_playing())
	#$"AnimatedSprite2D".animation = "idle"
	#$"AnimatedSprite2D".play()

func _physics_process(delta):
	# Add the gravity.
	justFell = false
	if not is_on_floor():
		velocity.y += gravity * delta
		isFalling = true
	else:
		hasDoubleJump = doubleJumpUnlocked
		if isFalling:
			justFell = true
		isFalling = false
	# Handle jump.[CUSTOMIZED]
	jumped = false
	isDoubleJumping = false
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumped = true
		elif doubleJumpUnlocked && hasDoubleJump && !attackAnim:
			doubleJumpAnim = true
			$Timer2.start()
			isFalling = false
			velocity.y = JUMP_VELOCITY*1.1
			isDoubleJumping = true
			hasDoubleJump= false
			OnDoubleJump.emit()
	
	isAttacking = false
	
	if Input.is_action_just_pressed("ui_select") && $"BasicBlade" && !doubleJumpAnim:
		isAttacking = true
		attackAnim = true
		$Timer.start()
		#$"AnimatedSprite2D".animation = "attack"
		pass
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		isRunning = true
		velocity.x = direction * SPEED
		if direction< 0 && !facingLeft:
			scale.x = -1
			facingLeft = true
		elif direction > 0 && facingLeft:
			scale.x = -1
			facingLeft = false
	else:
		isRunning = false
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_child_order_changed():
	print_tree_pretty()
	if $"Butterflymesser":
		OnDoubleJump.connect($"Butterflymesser".runAnimation)
		doubleJumpUnlocked = true
	else:
		doubleJumpUnlocked = false
	if $"BasicBlade":
		OnAttack.connect($"BasicBlade".onUse)
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	#$"AnimatedSprite2D".animation = "idle"
	#$"AnimatedSprite2D".play()
	pass # Replace with function body.


func _on_timer_timeout():
	attackAnim = false


func _on_timer_2_timeout():
	doubleJumpAnim = false
