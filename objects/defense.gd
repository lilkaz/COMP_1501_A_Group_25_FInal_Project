class_name Defense extends Node

@export var defense_duration: float = 2.0
@export var defense_cooldown: float = 3.0
@export var defense_multiplier: float = 0.5

var defense_timer: float = 0.0
var defense_cooldown_timer: float = 0.0
var is_defending: bool = false


func start_defense() -> void:
	if defense_cooldown_timer <= 0.0:
		is_defending = true
		defense_timer = defense_duration
		print("defense activated")


func stop_defense() -> void:
	is_defending = false
	defense_cooldown_timer = defense_cooldown
	print("defense deactivated")


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SHIFT):
		if !is_defending:
			start_defense()
	else:
		if is_defending:
			stop_defense()

	
	if defense_timer > 0:
		defense_timer -= delta
		if defense_timer <= 0:
			stop_defense()
	
	if defense_cooldown_timer > 0:
		defense_cooldown_timer -= delta


func check_defending() -> bool:
	return is_defending
