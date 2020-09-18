extends Area2D

signal hit

export var speed = 200;#(pixel/sec)
var screen_size #size of the window.

#the start state of the player 
func start(pos):
	position = pos;
	self.show();
	$CollisionShape2D.disabled = false;

func _ready() -> void:
	screen_size = get_viewport_rect().size;
	self.hide();

# Called every frame. 'delta' is the elapsed time since the previous frame.

# 1. Check for input 
# 2. Move in the given direction.
# 3. Play the animation (enum p_animation)
func _process(delta: float) -> void:
	var current_velocity : Vector2 = get_current_velocity(delta);
	position += current_velocity;
	animate(current_velocity);
	pos_clamp();


func pos_clamp() :
	self.position.x = clamp(position.x,50,screen_size.x - 50);
	self.position.y = clamp(position.y,50,screen_size.y - 50 );

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
	

# 3. Play the animation (enum p_animation)
func animate(velocity : Vector2) :
	if velocity.x != 0 : 
		$AnimatedSprite.animation = "walk";
		$AnimatedSprite.flip_v = false;
		$AnimatedSprite.flip_h = velocity.x < 0 ;
	if velocity.y != 0 :
		$AnimatedSprite.animation = "up";
		$AnimatedSprite.flip_h = false;
		$AnimatedSprite.flip_v = velocity.y > 0 ;

#hide then send the signale when the palayer get hit
func _on_Player_body_entered(body: Node) -> void:
	self.hide();
	emit_signal("hit");
	$CollisionShape2D.set_deferred("disabled" , true);

