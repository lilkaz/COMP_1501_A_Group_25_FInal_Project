class_name PlayerMovementControl extends Node

@export var body: CharacterBody2D;
@export var collision: CollisionObject2D;
	
func _enter_tree() -> void:
	assert(owner is Entity);
	owner.set_meta(&"PlayerMovementControl", self);

func _exit_tree() -> void:
	owner.remove_meta(&"PlayerMovementControl");

func _physics_process(delta: float) -> void:
	var direction = getInputDirection();
	if (!(owner as Entity).has_component("Movement")):
		return;
	var movement = (owner as Entity).get_component("Movement") as Movement;
	movement.move(direction);
		
func getInputDirection() -> Vector2:
	var direction = Vector2.ZERO;
	if Input.is_key_pressed(KEY_W):
		direction += Vector2(0, -1);
	if Input.is_key_pressed(KEY_A):
		direction += Vector2(-1, 0);
	if Input.is_key_pressed(KEY_S):
		direction += Vector2(0, 1);
	if Input.is_key_pressed(KEY_D):
		direction += Vector2(1, 0);
		
	if direction.length() > 0:
		return direction.normalized();
	else:
		return Vector2.ZERO;
