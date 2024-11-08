@tool
class_name HumanoidSprite
extends Node2D

@export var direction: Direction = Direction.DOWN:
	set(new_value):
		if new_value != direction:
			direction = new_value
			_update_direction()

@export_range(0, 8) var frame: int:
	set(new_value):
		frame = new_value
		_update_frame()

@export var state: State:
	set(new_value):
		state = new_value
		_update_sprites()

@export var body: Body:
	set(new_value):
		body = new_value
		_update_sprites()

@export var torso: Torso:
	set(new_value):
		torso = new_value
		_update_sprites()

@export var weapon: Weapon:
	set(new_value):
		weapon = new_value
		_update_sprites()

@export var feet: Feet:
	set(new_value):
		feet = new_value
		_update_sprites()

@export var head: Head:
	set(new_value):
		head = new_value
		_update_sprites()

@export var behind: Behind:
	set(new_value):
		behind = new_value
		_update_sprites()

@export var belt: Belt:
	set(new_value):
		belt = new_value
		_update_sprites()

@export var hands: Hands:
	set(new_value):
		hands = new_value
		_update_sprites()

@export var legs: Legs:
	set(new_value):
		legs = new_value
		_update_sprites()

@onready var _body_sprite := %Body
@onready var _torso_sprite := %Torso
@onready var _weapon_sprite := %Weapon
@onready var _feet_sprite := %Feet
@onready var _head_sprite := %Head
@onready var _behind_sprite := %Behind
@onready var _belt_sprite := %Belt
@onready var _hands_sprite := %Hands
@onready var _legs_sprite := %Legs
@onready var _animation_player := $AnimationPlayer

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

enum Anim {
	IDLE,
	WALK,
}

func _ready() -> void:
	_update_sprites()
	_update_frame()
	_update_direction()

func set_anim(anim: Anim):
	match anim:
		Anim.IDLE:
			_animation_player.play("idle")
		Anim.WALK:
			_animation_player.play("walk")

func _update_sprites():
	if _body_sprite == null:
		return
	var state_dir := _state_dir()
	_body_sprite.texture = _body_texture(state_dir)
	_torso_sprite.texture = _torso_texture(state_dir)
	_weapon_sprite.texture = _weapon_texture(state_dir)
	_feet_sprite.texture = _feet_texture(state_dir)
	_head_sprite.texture = _head_texture(state_dir)
	_behind_sprite.texture = _behind_texture(state_dir)
	_belt_sprite.texture = _belt_texture(state_dir)
	_hands_sprite.texture = _hands_texture(state_dir)
	_legs_sprite.texture = _legs_texture(state_dir)

func _update_direction():
	if _body_sprite == null:
		return
	var region = _get_region_rect()
	_body_sprite.region_rect = region
	_torso_sprite.region_rect = region
	_weapon_sprite.region_rect = region
	_feet_sprite.region_rect = region
	_head_sprite.region_rect = region
	_behind_sprite.region_rect = region
	_belt_sprite.region_rect = region
	_hands_sprite.region_rect = region
	_legs_sprite.region_rect = region


func _get_region_rect() -> Rect2:
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

func _update_frame():
	if _body_sprite == null:
		return
	_body_sprite.frame = frame
	_torso_sprite.frame = frame
	_weapon_sprite.frame = frame
	_feet_sprite.frame = frame
	_head_sprite.frame = frame
	_behind_sprite.frame = frame
	_belt_sprite.frame = frame
	_hands_sprite.frame = frame
	_legs_sprite.frame = frame

func _body_texture(state_dir: String) -> Texture2D:
	match body:
		Body.MALE:
			return load_texture(state_dir, "BODY_male.png")
		Body.SKELETON:
			return load_texture(state_dir, "BODY_skeleton.png")
	return null

func _weapon_texture(state_dir: String) -> Texture2D:
	match weapon:
		Weapon.SHIELD_CUTOUT_BODY:
			return load_texture(state_dir, "WEAPON_shield_cutout_body.png")
		Weapon.SHIELD_CUTOUT_CHAIN_ARMOR_HELMET:
			return load_texture(state_dir, "WEAPON_shield_cutout_chain_armor_helmet.png")
	return null

func _feet_texture(state_dir: String) -> Texture2D:
	match feet:
		Feet.PLATE_ARMOR_SHOES:
			return load_texture(state_dir, "FEET_plate_armor_shoes.png")
		Feet.SHOES_BROWN:
			return load_texture(state_dir, "FEET_shoes_brown.png")
	return null

func _head_texture(state_dir: String) -> Texture2D:
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

func _behind_texture(state_dir: String) -> Texture2D:
	match behind:
		Behind.QUIVER:
			return load_texture(state_dir, "BEHIND_quiver.png")
	return null

func _belt_texture(state_dir: String) -> Texture2D:
	match belt:
		Belt.LEATHER:
			return load_texture(state_dir, "BELT_leather.png")
		Belt.ROPE:
			return load_texture(state_dir, "BELT_rope.png")
	return null

func _hands_texture(state_dir: String) -> Texture2D:
	match hands:
		Hands.PLATE_ARMOR_GLOVES:
			return load_texture(state_dir, "HANDS_plate_armor_gloves.png")
	return null

func _legs_texture(state_dir: String) -> Texture2D:
	match legs:
		Legs.PANTS_GREENISH:
			return load_texture(state_dir, "LEGS_pants_greenish.png")
		Legs.PLATE_ARMOR_PANTS:
			return load_texture(state_dir, "LEGS_plate_armor_pants.png")
		Legs.ROBE_SKIRT:
			return load_texture(state_dir, "LEGS_robe_skirt.png")
	return null

func _torso_texture(state_dir: String) -> Texture2D:
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
