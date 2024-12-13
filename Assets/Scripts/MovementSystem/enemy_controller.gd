extends CharacterBody3D

var enemy_speed = randf_range(20,50)
var enemy_accel = randf_range(0.25,0.6)

var velocity_vector : Vector3
@onready var main = get_tree().current_scene 
var Bullet = preload("res://Assets/Modelos/EnemyBullet.tscn")
@onready var guns = [$Gun1]
var enemy_ready_to_shoot = true

func shoot_bullet(direction): 
	for gun in guns:
		var bullet = Bullet.instantiate()
		main.add_child(bullet)
		bullet.global_transform = gun.global_transform
		enemy_ready_to_shoot = false # Reiniciar a variável can_shoot após um tempo 
		await get_tree().create_timer(1.0).timeout
		enemy_ready_to_shoot = true
		
func _on_enemy_died():
	queue_free()
func _physics_process(delta):
	var direction_vector = (Vector3.ZERO - global_transform.origin)
	#velocity_vector.x = move_toward(velocity_vector.x, direction_vector.x * enemy_speed, enemy_accel/2.0)
	#velocity_vector.y = move_toward(velocity_vector.y, direction_vector.y * enemy_speed, enemy_accel/2.0)
	velocity_vector.z = move_toward(velocity_vector.z, direction_vector.z * enemy_speed, enemy_accel)
	
	velocity = velocity.lerp(velocity_vector, enemy_accel * delta)
	
	move_and_slide()
	
	if global_transform.origin.z > -200 and enemy_ready_to_shoot:
		shoot_bullet(direction_vector)
	if global_transform.origin.z > 10:
		queue_free()
