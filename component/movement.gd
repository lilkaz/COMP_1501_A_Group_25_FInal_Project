class_name Movement extends Node

@export var body: CharacterBody2D;
@export var speed: float = 200;

@export var walk_sound: AudioStreamPlayer2D;

var is_moving: bool = false;

func _enter_tree() -> void:
	assert(owner is Entity);
	owner.set_meta(&"Movement", self);

func _exit_tree() -> void:
	owner.remove_meta(&"Movement");

func move(direction: Vector2):
	var velocity = direction * speed;
	body.velocity.x = velocity.x;
	body.velocity.y = velocity.y;
	body.move_and_slide();
	
func move_to(position: Vector2):
	# used for enemies to target
	pass
	
func _physics_process(delta: float) -> void:
	walk_sound.position = body.position;
	
	var current_is_moving = body.velocity.length() > 0;
	if is_moving != current_is_moving:
		is_moving = current_is_moving;
		if is_moving && !walk_sound.playing:
			walk_sound.play();
		elif !is_moving && walk_sound.playing:
			print("stop");
			walk_sound.stop();
				
