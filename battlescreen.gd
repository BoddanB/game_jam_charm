extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var player = Global.player_node.instantiate()
	player.position = Vector2(166, 167)
	add_child(player)
	var enemy = Global.enemy_node.instantiate()
	enemy.position = Vector2(184, 167)
	call_deferred("add_child", enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
