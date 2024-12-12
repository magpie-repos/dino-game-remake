# Dino Game Remake
A remake of the classic chrome dino game in Godot with GDScript. This is a learning project to help familiarize myself with game dev and expand my understanding of the Godot engine.

- Created: 24-12-01
- Status: Dev
- Total Time: 15h 15m

  ##TASKS
- [x] Scope
- [x] Player Dino
	- [x] Player Jump
	- [x] Player Duck
 		- [x] Ducking Sprites
	- [x] Base Sprites
	- [x] Dino Animations
		- [x] Create Standing/Walking Animation
		- [x] Create Ducking/Walking Animation
		- [x] State Manager for Dino Animation
- [ ] Obstacles
	- [x] Large Rock
	- [x] Small Rock
	- [x] Tall Cactus
	- [~] Difficulty Scaling + Random
		- [ ] Dist scales w/ score too
	- [x] Pteradactyl
		- [x] Base Sprite
		- [x] Animations
	- [ ] (OP) Snake Enemy
	- [x] Additional Obst
- [x] Background 
  - [x] Base Background Sprite
  - [x] Parallax Effects
	- [x] Far Mountain Sprites
	- [x] Medium Mountain Sprites
	- [x] Cloud Sprites
		- [ ] ~~Medium Cloud~~
		- [x] Far Cloud
	- [x] Ground Scuffs
	- [x] Paralax Scroll Script
		- [x] Add portions for handling clouds
- [x] Sounds
	- [x] Jump SFX
	- [x] Land SFX
	- [x] 100pts SFX
	- [x] Loss SFX
- [x] Score System
	- [x] Save/Load High Score
- [x] UI
	- [x] Score Display
	- [x] Game Over UI
	- [x] Tutorial Text (Startup UI)

## Limitations - Time, Tools, and Target
- **Purpose:** Learning: Sprite animation, difficulty scaling, pixel art, animation state management
- **Time Limit:** 20h
- **Team:** Me
- **Target Platform:** Web embed, windows exe
- **Target Inputs:** kbr
- **Tools Used:** Godot, Chiptone, GIMP, Pixelorama
## Art
- **Sound:** Blips and Boops
- **Visuals:** Super simplistic pixel art with emphasis on low res and readability
## Mechanics
- Obstacles scroll across the screen
- Player can jump to clear ground obstacles and duck to avoid air obstacles
- Every 100pts the game speed increases and new obstacles start spawning and in new configurations
- The game ends if the player touches an obstacle
