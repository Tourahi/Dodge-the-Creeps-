extends Node


export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize();
	new_game();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func game_over() -> void:
	$ScoreTimer.stop();
	$MobTimer.stop();
	$HUD.show_game_over();
	get_tree().call_group("mobs", "queue_free");

func new_game() -> void:
	score = 0;
	$Player.start($StartPosition.position);
	$StartTmer.start();
	$HUD.update_score(score);
	$HUD.show_message("Get Ready");


func _on_MobTimer_timeout() -> void:
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
func _on_ScoreTimer_timeout() -> void:
	score += 1;
	$HUD.update_score(score);


func _on_StartTmer_timeout() -> void:
	$ScoreTimer.start();
	$MobTimer.start();
