extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _on_host_pressed() -> void:
	peer.create_server(9990)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)

func _on_join_pressed() -> void:
	peer.create_client("localhost",9990)
	multiplayer.multiplayer_peer = peer


func _on_disconnect_pressed() -> void:
	print("Disconnecting...")

	# Optional: Remove your player node
	var peer_id = multiplayer.get_unique_id()
	if has_node(str(peer_id)):
		get_node(str(peer_id)).queue_free()

	# Disconnect from the server or stop hosting
	if multiplayer.is_server():
		multiplayer.multiplayer_peer.close()
	else:
		multiplayer.multiplayer_peer.disconnect_from_host()

	# Reset the peer to null (fully disconnects)
	multiplayer.multiplayer_peer = null

	# Optional: Go back to a main menu scene
	# get_tree().change_scene_to_file("res://main_menu.tscn")
