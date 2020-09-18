extends Area2D

export var speed = 200;#(pixel/sec)
var screen_size #size of the window.


func _ready() -> void:
	screen_size = get_viewport_rect().size;
	


# Called every frame. 'delta' is the elapsed time since the previous frame.

# 1. Check for input 
# 2. Move in the given direction.
# 3. Play the animation (enum p_animation)
func _process(delta: float) -> void:
	position += get_current_velocity(delta);
	print(position)
	position.x = clamp(position.x,50,screen_size.x - 50);
	position.y = clamp(position.y,50,screen_size.y - 50 );


# 1. Check for input and update velocity
func get_current_velocity(delta) -> Vector2 :
	var velocity = Vector2();
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1;
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1;
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed;
		$AnimatedSprite.play();
	else :
		$AnimatedSprite.stop();
	return velocity * delta;
