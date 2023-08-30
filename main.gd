extends Node
@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
	
	
func new_game():
	score = 0
	$Music.play()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	
	


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	#choose a random location on Path2D
	var mob_spawn_location = get_node(("MobPath/MobSpawnLocation"))
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation+PI/2
	mob.position = mob_spawn_location.position
	#add some randomness to the direction
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	#choose the velolcity for the mob
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#Spawn the mob by adding it to the main scene
	add_child(mob)
