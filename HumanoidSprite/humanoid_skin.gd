class_name HumanoidSkin
extends Resource

@export var state: State
@export var body: Body
@export var torso: Torso
@export var weapon: Weapon
@export var feet: Feet
@export var head: Head
@export var behind: Behind
@export var belt: Belt
@export var hands: Hands
@export var legs: Legs

enum State {
	WALKCYCLE
}

enum Direction {
	UP,
	LEFT,
	DOWN,
	RIGHT
}

enum Body {
	MALE,
	SKELETON
}

enum Torso {
	NONE,
	ROBE_SHIRT_BROWN,
	CHAIN_ARMOR_JACKET_PURPLE,
	CHAIN_ARMOR_TORSO,
	LEATHER_ARMOR_BRACERS,
	LEATHER_ARMOR_SHIRT_WHITE,
	LEATHER_ARMOR_SHOULDERS,
	LEATHER_ARMOR_TORSO,
	PLATE_ARMOR_ARMS_SHOULDERS,
	PLATE_ARMOR_TORSO
}

enum Weapon {
	NONE,
	SHIELD_CUTOUT_BODY,
	SHIELD_CUTOUT_CHAIN_ARMOR_HELMET
}

enum Feet {
	NONE,
	PLATE_ARMOR_SHOES,
	SHOES_BROWN
}

enum Head {
	NONE,
	HAIR_BLONDE,
	CHAIN_ARMOR_HELMET,
	CHAIN_ARMOR_HOOD,
	LEATHER_ARMOR_HAT,
	PLATE_ARMOR_HELMET,
	ROBE_HOOD
}

enum Behind {
	NONE,
	QUIVER
}

enum Belt {
	NONE,
	LEATHER,
	ROPE
}

enum Hands {
	NONE,
	PLATE_ARMOR_GLOVES
}

enum Legs {
	NONE,
	PANTS_GREENISH,
	PLATE_ARMOR_PANTS,
	ROBE_SKIRT
}

func _get_region_rect(direction: Direction) -> Rect2:
	match direction:
		Direction.UP:
			return Rect2(0, 0 * 64, 9 * 64, 64)
		Direction.LEFT:
			return Rect2(0, 1 * 64, 9 * 64, 64)
		Direction.DOWN:
			return Rect2(0, 2 * 64, 9 * 64, 64)
		Direction.RIGHT:
			return Rect2(0, 3 * 64, 9 * 64, 64)
	return Rect2()

func _body_texture() -> Texture2D:
	var state_dir = _state_dir()
	match body:
		Body.MALE:
			return load_texture(state_dir, "BODY_male.png")
		Body.SKELETON:
			return load_texture(state_dir, "BODY_skeleton.png")
	return null

func _weapon_texture() -> Texture2D:
	var state_dir = _state_dir()
	match weapon:
		Weapon.SHIELD_CUTOUT_BODY:
			return load_texture(state_dir, "WEAPON_shield_cutout_body.png")
		Weapon.SHIELD_CUTOUT_CHAIN_ARMOR_HELMET:
			return load_texture(state_dir, "WEAPON_shield_cutout_chain_armor_helmet.png")
	return null

func _feet_texture() -> Texture2D:
	var state_dir = _state_dir()
	match feet:
		Feet.PLATE_ARMOR_SHOES:
			return load_texture(state_dir, "FEET_plate_armor_shoes.png")
		Feet.SHOES_BROWN:
			return load_texture(state_dir, "FEET_shoes_brown.png")
	return null

func _head_texture() -> Texture2D:
	var state_dir = _state_dir()
	match head:
		Head.HAIR_BLONDE:
			return load_texture(state_dir, "HEAD_hair_blonde.png")
		Head.CHAIN_ARMOR_HELMET:
			return load_texture(state_dir, "HEAD_chain_armor_helmet.png")
		Head.CHAIN_ARMOR_HOOD:
			return load_texture(state_dir, "HEAD_chain_armor_hood.png")
		Head.LEATHER_ARMOR_HAT:
			return load_texture(state_dir, "HEAD_leather_armor_hat.png")
		Head.PLATE_ARMOR_HELMET:
			return load_texture(state_dir, "HEAD_plate_armor_helmet.png")
		Head.ROBE_HOOD:
			return load_texture(state_dir, "HEAD_robe_hood.png")
	return null

func _behind_texture() -> Texture2D:
	var state_dir = _state_dir()
	match behind:
		Behind.QUIVER:
			return load_texture(state_dir, "BEHIND_quiver.png")
	return null

func _belt_texture() -> Texture2D:
	var state_dir = _state_dir()
	match belt:
		Belt.LEATHER:
			return load_texture(state_dir, "BELT_leather.png")
		Belt.ROPE:
			return load_texture(state_dir, "BELT_rope.png")
	return null

func _hands_texture() -> Texture2D:
	var state_dir = _state_dir()
	match hands:
		Hands.PLATE_ARMOR_GLOVES:
			return load_texture(state_dir, "HANDS_plate_armor_gloves.png")
	return null

func _legs_texture() -> Texture2D:
	var state_dir = _state_dir()
	match legs:
		Legs.PANTS_GREENISH:
			return load_texture(state_dir, "LEGS_pants_greenish.png")
		Legs.PLATE_ARMOR_PANTS:
			return load_texture(state_dir, "LEGS_plate_armor_pants.png")
		Legs.ROBE_SKIRT:
			return load_texture(state_dir, "LEGS_robe_skirt.png")
	return null

func _torso_texture() -> Texture2D:
	var state_dir = _state_dir()
	match torso:
		Torso.ROBE_SHIRT_BROWN:
			return load_texture(state_dir, "TORSO_robe_shirt_brown.png")
		Torso.CHAIN_ARMOR_JACKET_PURPLE:
			return load_texture(state_dir, "TORSO_chain_armor_jacket_purple.png")
		Torso.CHAIN_ARMOR_TORSO:
			return load_texture(state_dir, "TORSO_chain_armor_torso.png")
		Torso.LEATHER_ARMOR_BRACERS:
			return load_texture(state_dir, "TORSO_leather_armor_bracers.png")
		Torso.LEATHER_ARMOR_SHIRT_WHITE:
			return load_texture(state_dir, "TORSO_leather_armor_shirt_white.png")
		Torso.LEATHER_ARMOR_SHOULDERS:
			return load_texture(state_dir, "TORSO_leather_armor_shoulders.png")
		Torso.LEATHER_ARMOR_TORSO:
			return load_texture(state_dir, "TORSO_leather_armor_torso.png")
		Torso.PLATE_ARMOR_ARMS_SHOULDERS:
			return load_texture(state_dir, "TORSO_plate_armor_arms_shoulders.png")
		Torso.PLATE_ARMOR_TORSO:
			return load_texture(state_dir, "TORSO_plate_armor_torso.png")
	return null

func load_texture(state_dir: String, filename: String) -> Texture2D:
	return load("res://3rd party/lpc_entry/%s/%s" % [state_dir, filename])

func _state_dir() -> String:
	match state:
		State.WALKCYCLE: return "walkcycle"
	return ""
