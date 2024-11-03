class_name Action
extends Resource

@warning_ignore("unused_signal")
signal finished

var icon: Texture2D

func start(_unit: Unit):
	# Override in subclass 
	pass

func dismissed(_unit: Unit):
	# Override in subclass 
	pass

func physics_process(_delta: float, _unit: Unit):
	# Override in subclass 
	pass
