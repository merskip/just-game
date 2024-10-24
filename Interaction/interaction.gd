class_name Interaction
extends Node2D

@export var action_name: String = "Interact"

func is_interactable(_unit: Unit) -> bool:
	return true

func interact(_unit: Unit):
	pass
