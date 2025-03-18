class_name Health extends Node

@export var current_health: float = 100;
@export var max_health: float = 100;

var is_dead = false;

func _enter_tree() -> void:
	assert(owner is Entity);
	owner.set_meta(&"Health", self);

func _exit_tree() -> void:
	owner.remove_meta(&"Health");

func damage(amount: float):
	current_health = clamp(current_health, 0, max_health);
	if current_health == 0:
		is_dead = true;
