extends Camera3D

@export var player : Node3D
var player_controller : CharacterBody3D 

func _ready(): 
	player_controller = player.get_node("PlayerController") as CharacterBody3D 
	if player_controller == null: 
		print("PlayerController não foi encontrado como subnó de Player.")
func limit_player_boost_distance():
	var camera_z = self.global_transform.origin.z 
	var player_z = player_controller.global_transform.origin.z 
	if player_z > camera_z + 1: 
		player.global_transform.origin.z = camera_z + 10 
	elif player_z < camera_z + 15: 
		player.global_transform.origin.z = camera_z + 15
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	limit_player_boost_distance()
	
