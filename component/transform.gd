class_name Transform extends Node

@export var reference: Node2D;

var transform: Transform2D;

func _enter_tree() -> void:
	assert(owner is Entity);
	owner.set_meta(&"Transform", self);

func _exit_tree() -> void:
	owner.remove_meta(&"Transform");
	
func _physics_process(delta: float) -> void:
	transform = reference.global_transform;

func get_transform() -> Transform2D:
	return transform;
	
func set_transform(new_transform: Transform2D) -> void:
	reference.global_transform = new_transform;
