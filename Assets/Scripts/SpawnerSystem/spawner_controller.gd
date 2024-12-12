extends Node3D

@onready var main = get_tree().current_scene
var Enemy = preload("res://Assets/Modelos/Enemy.tscn")
func spawn():
	var spawned_enemy = Enemy.instantiate()
	main.add_child(spawned_enemy)
	spawned_enemy.global_transform.origin = self.global_transform.origin + Vector3(randf_range(-15,15), randf_range(-10,10), randf_range(-1, 1))



func _on_timer_timeout():
	spawn()
