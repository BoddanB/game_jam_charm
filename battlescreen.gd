extends Node2D

var player_node = preload("res://Player/player.tscn")
var enemy_node = preload("res://enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_node.instance()
	player.position = Vector2(143, 167)
	add_child(player)
	var enemy = enemy_node.instance()
	enemy.position = Vector2(183, 167)
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
