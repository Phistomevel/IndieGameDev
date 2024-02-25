extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal OnUse
signal OnDoubleJump
signal OnAttack


##[CUSTOM VARIABLES]
var doubleJumpUnlocked = false
var hasDoubleJump = false
var facingLeft : bool = false 

func _ready():
	$"AnimatedSprite2D".animation = "idle"
	$"AnimatedSprite2D".play()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		hasDoubleJump = doubleJumpUnlocked

	# Handle jump.[CUSTOMIZED]
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif doubleJumpUnlocked && hasDoubleJump:
			velocity.y = JUMP_VELOCITY
			hasDoubleJump= false
			OnDoubleJump.emit()
		
	if Input.is_action_just_pressed("ui_select") && $"BasicBlade":
		##attack
		$"AnimatedSprite2D".animation = "attack"
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction< 0 && !facingLeft:
			scale.x = -1
			facingLeft = true
		elif direction > 0 && facingLeft:
			scale.x = -1
			facingLeft = false
	else:
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
	$"AnimatedSprite2D".animation = "idle"
	$"AnimatedSprite2D".play()
	print("hidden")
	pass # Replace with function body.
