extends Node

const ICON_PATH = "res://Textures/Upgrades/"
const WEAPONS_PATH = "res://Textures/Weapons/"
const UPGRADES = {
	"sword1":{
		"icon": WEAPONS_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "Flying sword is thrown at nearby enemy",
		"level": "Level: 1",
		"prerequisite":[],
		"type": "weapon"
	},
	"sword2":{
		"icon": WEAPONS_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "Sword speed is increased",
		"level": "Level: 2",
		"prerequisite":["sword1"],
		"type": "weapon"
	},
	"sword3": {
		"icon": WEAPONS_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "Swords now pass through another enemy and do + 3 damage",
		"level": "Level: 3",
		"prerequisite": ["sword2"],
		"type": "weapon"
	},
	"sword4": {
		"icon": WEAPONS_PATH + "Sword.png",
		"displayname": "Sword",
		"details": "An additional 2 Swords are thrown",
		"level": "Level: 4",
		"prerequisite": ["sword3"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "Shield.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1 point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "Shield.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "Shield.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "Shield.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "Boots.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"pipe1": {
		"icon": ICON_PATH + "Flute.png",
		"displayname": "Pipe",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"pipe2": {
		"icon": ICON_PATH + "Flute.png",
		"displayname": "Pipe",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["pipe1"],
		"type": "upgrade"
	},
	"pipe3": {
		"icon": ICON_PATH + "Flute.png",
		"displayname": "Pipe",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["pipe2"],
		"type": "upgrade"
	},
	"pipe4": {
		"icon": ICON_PATH + "Flute.png",
		"displayname": "Pipe",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["pipe3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": ICON_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "Scroll.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	"bean1": {
		"icon": ICON_PATH + "Bean.png",
		"displayname": "Magical Bean",
		"details": "Your spells now spawn 1 more additional attack",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"bean2": {
		"icon": ICON_PATH + "Bean.png",
		"displayname": "Magical Bean",
		"details": "Your spells now spawn an additional attack",
		"level": "Level: 2",
		"prerequisite": ["bean1"],
		"type": "upgrade"
	},
	"pot":{
		"icon": ICON_PATH + "Pot.png",
		"displayname": "Pot",
		"details": "Heals for 30 HP",
		"level": "N/A",
		"prerequisite":[],
		"type": "item"
	}
}
 
