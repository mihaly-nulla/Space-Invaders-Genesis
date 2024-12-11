extends Node


@export var player : CharacterBody3D
var camera : Camera3D

const CURRENT_SPEED = 30.0
const MAX_SPEED = 30.0
const ACCELERATION = 1.25 # Constante de aceleração
const THROTTLE_MAXIMUM_ACCEL = 1.0
const JUMP_VELOCITY = 4.5
const MAXIMUM_BOOST_DISTANCE = -10.0
const MINIMUM_BOOST_DISTANCE = 5.0
var direction_vector : Vector3
var velocity_vector : Vector3
var THROTTLE_VALUE = 0.0
var LIMIT_REACHED = false

func throttle():
	direction_vector.z = Input.get_action_strength("throttle_down") - Input.get_action_strength("throttle_up")
	THROTTLE_VALUE = THROTTLE_MAXIMUM_ACCEL
	LIMIT_REACHED = false
func move_player(delta):
	velocity_vector.x = move_toward(velocity_vector.x, direction_vector.x * CURRENT_SPEED, ACCELERATION)
	velocity_vector.y = move_toward(velocity_vector.y, direction_vector.y * CURRENT_SPEED, ACCELERATION)
	velocity_vector.z = move_toward(velocity_vector.z, direction_vector.z * CURRENT_SPEED, THROTTLE_VALUE)
	
	player.rotation_degrees.z = velocity_vector.x * (-2) #rotaciona em um eixo central, dada uma velocidade x. Rotação para a direita é negativa em z e para a esquerda é positiva
	player.rotation_degrees.x = velocity_vector.y * 1.25 #rotaciona verticalmente, a partir da velocidade y
	player.rotation_degrees.y = -velocity_vector.x / 2
	player.velocity = player.velocity.lerp(velocity_vector, ACCELERATION * delta)
	# Limitar a posição do jogador
	var viewport_rect = get_viewport().get_visible_rect()
	var new_position = player.global_transform.origin
	#new_position.x = clamp(new_position.x, screen_left_limit, screen_right_limit)
	#new_position.y = clamp(new_position.y, screen_bottom_limit, screen_top_limit)
	new_position.x = clamp(new_position.x, viewport_rect.position.x - (viewport_rect.size.x/2.0/100.0), viewport_rect.position.x + (viewport_rect.size.x/2.0/100.0))
	new_position.y = clamp(new_position.y, viewport_rect.position.y - (viewport_rect.size.y/2.0/100.0), viewport_rect.position.y + (viewport_rect.size.y/2.0/100.0))
	player.global_transform.origin = new_position

func _physics_process(delta):
	move_player(delta)
	player.move_and_slide()

func _input(event):
	var travelled_distance = player.global_transform.origin.z
	print("PLAYER Z: ", travelled_distance)
	if event.is_action("movement_event"):
		direction_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
		if event.is_action("throttle_up") or event.is_action("throttle_down"):
			if travelled_distance > -10.0 or travelled_distance <= 0.0:
				throttle()
		else:
			THROTTLE_VALUE = 0.0
			velocity_vector.z = move_toward(velocity_vector.z, 0.0, ACCELERATION * 50.0)
		direction_vector = direction_vector.normalized()
