extends Node2D

@export_enum(	"empty",
				"Geigenbogen", 
				"Korkenzieher", 
				"Zahnstocher", 
				"Flaschenöffner", 
				"Xray-Lupe", 
				"Standardmesser",
				"Flammenwerfer",
				"Windrad",
				"Pipette",
				"Butterfly-Messer",
				"Kompass"
) var type : String = "empty"

#Maps the type of the collectable to the scene of the collectable
#TODO: when a collectable is added, modify the path to match the path of the collectable
const NameMap = {
				"Geigenbogen" : "res://Player/BasicBlade/basic_blade.tscn", 
				"Korkenzieher" : "res://Player/BasicBlade/basic_blade.tscn", 
				"Zahnstocher" : "res://Player/BasicBlade/basic_blade.tscn", 
				"Flaschenöffner" : "res://Player/BasicBlade/basic_blade.tscn", 
				"Xray-Lupe" : "res://Player/BasicBlade/basic_blade.tscn", 
				"Standardmesser" : "res://Player/BasicBlade/basic_blade.tscn",
				"Flammenwerfer" : "res://Player/BasicBlade/basic_blade.tscn",
				"Windrad" : "res://Player/BasicBlade/basic_blade.tscn",
				"Pipette" : "res://Player/BasicBlade/basic_blade.tscn",
				"Butterfly-Messer" : "res://Player/BasicBlade/basic_blade.tscn",
				"Kompass" : "res://Player/BasicBlade/basic_blade.tscn" 
} 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent().get_name() == "Player":
		var playerNode = area.get_parent() 
		var collectableRessource = load(NameMap[type])
		var collectable = collectableRessource.instantiate()
		playerNode.add_child(collectable)
		playerNode.OnUse.connect(collectable.onUse)
		#playerNode.print_tree_pretty()
		print("collected")
		self.queue_free()
	pass # Replace with function body.
