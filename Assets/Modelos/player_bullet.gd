extends Node3D

@export var bullet_velocity = Vector3()

func is_out_of_render():
	var screen_limit = 700.0
	return abs(global_transform.origin.x) > screen_limit or abs(global_transform.origin.y) > screen_limit or abs(global_transform.origin.z) > screen_limit
func _physics_process(delta):
	global_transform.origin += bullet_velocity * delta
	if is_out_of_render(): 
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		body._on_enemy_died() 
		queue_free()
