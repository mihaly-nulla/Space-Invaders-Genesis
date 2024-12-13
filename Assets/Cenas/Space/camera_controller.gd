extends Camera3D

@export var player : Node3D

var player_movement_controller
# Called when the node enters the scene tree for the first time.

func _ready():
	player_movement_controller = player.get_node("MovementController")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player_movement_controller) :
		print("boosted")
	
	
