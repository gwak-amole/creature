extends Node

signal entered_light
signal game_done

var hp = 3
var points = 0
var last_max_speed = 0
var last_min_speed = 0

var jam_chance = 0
var still_jam = false
var still_jam_2 = false
var took_tutorial = false
