extends AnimatedSprite

#Character Stats
export (int) var atk = 2
export (int) var def = 1
export (int) var spd = 4
export (int) var mp = 3
export (int) var hp = 20

#Leveling System
export (int) var level = 1
var experience = 0
var experience_all = 0
var experience_required = get_required_xp(level+1)

func get_required_xp (level):
	return round(pow(level,1.8)+ level*4 +8)
	
func gain_xp (amount):
	experience_all += amount
	experience += amount
	while experience >= experience_required:
		experience -= experience_required
		levelup()
		
func levelup ():
	level += 1
	atk += round(int(1+ (level*0.2)))
	def += round(int(1+(level*0.08)))
	print("ATK: ",atk)
	print("DEF: ",def)
	experience_required = get_required_xp(level+1)