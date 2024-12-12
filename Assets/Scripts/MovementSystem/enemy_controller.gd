extends Node3D

var enemy_speed = randf_range(20,50)
var enemy_accel = randf_range(0.25,0.6)

var enemy : CharacterBody3D 
var velocity_vector : Vector3

func _ready(): # Recupere o subnó chamado "PlayerController" do tipo CharacterBody3D 
	enemy = get_node("EnemyController") as CharacterBody3D 
	if enemy == null: 
		print("CharacterBody3D não foi encontrado como subnó de Enemy.")
func _physics_process(delta):
	if enemy:
		var direction_vector = (Vector3.ZERO - enemy.global_transform.origin)
		#velocity_vector.x = move_toward(velocity_vector.x, direction_vector.x * enemy_speed, enemy_accel/2.0)
		#velocity_vector.y = move_toward(velocity_vector.y, direction_vector.y * enemy_speed, enemy_accel/2.0)
		velocity_vector.z = move_toward(velocity_vector.z, direction_vector.z * enemy_speed, enemy_accel)
		
		enemy.velocity = enemy.velocity.lerp(velocity_vector, enemy_accel * delta)
		
		enemy.move_and_slide()
		if enemy.global_transform.origin.z > 10:
			queue_free()
