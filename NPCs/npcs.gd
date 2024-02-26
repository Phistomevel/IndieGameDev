extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"AnimatedSprite2D2".play()
	$"AnimatedSprite2D".play()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Talk"):
		if $"Area2D".get_overlapping_areas().map(getNodeName).has("PlayerArea"):
			print("true")

func getNodeName(node):
	return node.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
