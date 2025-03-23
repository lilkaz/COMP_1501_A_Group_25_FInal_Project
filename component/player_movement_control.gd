class_name PlayerMovementControl extends Node

@export var body: CharacterBody2D;
@export var collision: CollisionObject2D;


#Dodge variables
@export var dodge_speed = 200
@export var dodge_duration = 0.2
@export var dodge_cooldown = 1.0

var dodge_timer = 0.0
var cooldown_timer = 0.0
var is_dodging = false
var dodge_direction = Vector2.ZERO


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
	
	
	#Dodge handling (SPACE BAR)
	if is_dodging:
		perform_dodge(movement, delta)
		return

	if Input.is_key_pressed(KEY_SPACE) and cooldown_timer <= 0:
		start_dodge(direction)
		
	
	movement.move(direction);
	
	#Dodge cooldown handle
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
	
func start_dodge(direction: Vector2) -> void:
	is_dodging = true
	dodge_timer = dodge_duration
	cooldown_timer = dodge_cooldown
	dodge_direction = direction	
	
func perform_dodge(movement: Movement, delta: float) -> void:
	movement.move(dodge_direction * dodge_speed * delta)
	dodge_timer -= delta
	if dodge_timer <= 0:
		is_dodging = false
	

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
	
