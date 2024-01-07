extends Node

var player_node = preload("res://Player/player.tscn")
var enemy_node = preload("res://enemy/enemy.tscn")

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(path_to_scene):
	call_deferred("_deferred_switching_scene", path_to_scene)

func _deferred_switching_scene(path_to_scene):
	current_scene.free()

	var s = ResourceLoader.load(path_to_scene)

	current_scene = s.instantiate()

	get_tree().root.add_child(current_scene)

	get_tree().current_scene = current_scene
