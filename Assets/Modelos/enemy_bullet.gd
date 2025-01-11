extends Node3D

@export var bullet_velocity = Vector3()

func _physics_process(delta):
	global_transform.origin += bullet_velocity * delta
	if global_transform.origin.z > 10:
		queue_free()
