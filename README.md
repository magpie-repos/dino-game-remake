# Dino Game Remake
A remake of the classic chrome dino game in Godot with GDScript. This is a learning project to help
familiarize myself with game dev and expand my understanding of the Godot engine.

Created: 24-12-01
Status: Dev
Total Time: 4h 00m
##TASKS
- [x] Scope
- [ ] Player Dino
	- [x] Player Jump
	- [ ] Player Duck
		-[ ] Ducking Sprites
	- [x] Base Sprites
	- [ ] Dino Animations
		- [x] Create Standing/Walking Animation
		- [ ] Create Ducking/Walking Animation
		- [ ] State Manager for Dino Animation
- [ ] Obstacles
	- [x] Large Rock
	- [x] Small Rock
	- [x] Tall Cactus
	- [ ] Pteradactyl
		- [ ] Base Sprite
		- [ ] Animations
- [ ] Background 
  - [ ] Base Background Sprite
  - [ ] Parallax Effects
	- [ ] Far Mountain Sprites
	- [ ] Medium Mountain Sprites
	- [ ] Cloud Sprites
		- [ ] Medium Cloud
		- [ ] Far Cloud
	- [ ] Ground Scuffs
	- [ ] Paralax Scroll Script
- [ ] Sounds
	- [ ] Jump SFX
	- [ ] 100pts SFX
	- [ ] Loss SFX
- [ ] Score System
- [ ] UI
	- [ ] Score Display
	- [ ] Game Over UI
	- [ ] Tutorial Text (Startup UI)

## Limitations - Time, Tools, and Target
**Purpose:** Learning: Sprite animation, difficulty scaling, pixel art, animation state management
Time Limit:**20h
**Team:** Me
**Target Platform:** Web embed, windows exe
**Target Inputs:** kbr
**Tools Used:** Godot, Chiptone, GIMP, Pixelorama
## Art
**Sound:** Blips and Boops
**Visuals:** Super simplistic pixel art with emphasis on low res and readability
## Mechanics
- Obstacles scroll across the screen
- Player can jump to clear ground obstacles and duck to avoid air obstacles
- Every 100pts the game speed increases and new obstacles start spawning and in new configurations
- The game ends if the player touches an obstacle
