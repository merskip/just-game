@tool
class_name HumanoidSprite
extends Node2D

@export var skin: HumanoidSkin:
	set(new_value):
		skin = new_value
		_update_sprites()

@export var direction: HumanoidSkin.Direction = HumanoidSkin.Direction.DOWN:
	set(new_value):
		direction = new_value
		_update_direction()

@export var frame: int:
	set(new_value):
		frame = new_value
		_update_frame()

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

enum Anim {
	IDLE,
	WALK,
}

func set_anim(anim: Anim):
	match anim:
		Anim.IDLE:
			_animation_player.play("idle")
		Anim.WALK:
			_animation_player.play("walk")

func _update_sprites():
	if skin == null or _body_sprite == null:
		return
	_body_sprite.texture = skin._body_texture()
	_torso_sprite.texture = skin._torso_texture()
	_weapon_sprite.texture = skin._weapon_texture()
	_feet_sprite.texture = skin._feet_texture()
	_head_sprite.texture = skin._head_texture()
	_behind_sprite.texture = skin._behind_texture()
	_belt_sprite.texture = skin._belt_texture()
	_hands_sprite.texture = skin._hands_texture()
	_legs_sprite.texture = skin._legs_texture()

func _update_direction():
	if skin == null or _body_sprite == null:
		return
	var region = skin._get_region_rect(direction)
	_body_sprite.region_rect = region
	_torso_sprite.region_rect = region
	_weapon_sprite.region_rect = region
	_feet_sprite.region_rect = region
	_head_sprite.region_rect = region
	_behind_sprite.region_rect = region
	_belt_sprite.region_rect = region
	_hands_sprite.region_rect = region
	_legs_sprite.region_rect = region


func _update_frame():
	if skin == null or _body_sprite == null:
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
