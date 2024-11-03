class_name Action
extends Resource

@warning_ignore("unused_signal")
signal finished

func start(_unit: Unit):
	# Override in subclass 
	pass

func dismissed(_unit: Unit):
	# Override in subclass 
	pass

func physics_process(_delta: float, _unit: Unit):
	# Override in subclass 
	pass
