extends HFlowContainer

var _action_item_prefab := preload("res://Player/action_item.tscn")

func fill(actions: Array[Action]):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	for action in actions:
		var action_item = _action_item_prefab.instantiate()
		add_child(action_item)
		action_item.fill(action)
