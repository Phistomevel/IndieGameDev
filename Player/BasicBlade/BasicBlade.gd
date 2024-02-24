extends Node2D
@onready var KnifeArea = $"KnifeArea"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onUse():
	$"AnimationPlayer".play("knife_basic")
	pass##TODO: make the collisionshape rotate to follow the attack animation, and hide the area again

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
