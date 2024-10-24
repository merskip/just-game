class_name Abilities
extends Resource

@export var strength: int
@export var dexternity: int
@export var constitution: int
@export var intelligence: int
@export var wisdom: int
@export var charisma: int

func modifier(ability: int) -> int:
	return int(floor((ability - 10) / 2))
