extends RigidBody2D

export var min_speed = 150;
export var max_speed = 250;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_animation();


func generate_animation() : 
	var mob_type = $AnimatedSprite.frames.get_animation_names();
	$AnimatedSprite.animation = mob_type[randi() % mob_type.size()];


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free();
