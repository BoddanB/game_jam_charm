extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var player = Global.player_node.instantiate()
	player.position = Vector2(-530, 0)
	add_child(player)
	var enemy = Global.enemy_node.instantiate()
	enemy.position = Vector2(460, 0)
	call_deferred("add_child", enemy)
	var texture: Texture2D = load("res://assets/lifebar_fill.png")
	$UIBackground/combatUI/menu/healthbar/healthtbar.set_progress_color(texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass
