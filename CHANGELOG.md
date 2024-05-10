# Changelog

## 0.15.0 alpha - 10th May, 2024

### New Features
- Added two new bosses, death reaper and fire beast
  - Death Reaper, first will appear at round 10
    - Moderate speed, strong, can't be dragged
  - Fire Beast, first will appear at round 20
    - Slow speed, incredibly strong, can't be dragged
- Temporarily allow for the purchase of 6 totems
  - This allows for scaling gameplay with the new bosses, in absense of other power upgrades

### Bug Fixes
- Removed logic that was meant to smart prune missed totem attacks, this broke them attacking mages.

### Improvements / Balances
- Improved a lot of logic around center positions using hitboxes now instead
- Added in a mage dying animation
- Sped up the shots fired by the attack totems
- Increased gravity effecting mages attacks
- Balances further the scaling of entity spawning rounds
  - On boss rounds, you will always have a stream of weak enemies to use to slam into bosses, if they're alive
  - On boss rounds, less "strong" enemies (currently mages and strong skeletons) spawn, in favour of more weak ones
- Made walls slightly more effective, with higher HP gain, at higher cost
- Improved idling mechanics of mage, and idling in genereal, now they idle for longer, but after waiting for longer, too
- Slightly lengthened the spawn duration of enemies into the later rounds

## 0.14.0 alpha - 9th May, 2024

### New Features
- N/A

### Bug Fixes
- N/A

### Improvements
- Added an MVP icon
- Fixed the incorrect 4th totem placement
- Improved where the totem attacks spawn from
- Removed the totem attack when they reach the target, if they missed

## 0.13.3 alpha - 6th May, 2024

### New Features
- N/A

### Bug Fixes
- Fix the tip border not correcting size between rounds
- Fix the Round text not updating between rounds

### Improvements
- N/A

## 0.13.2 alpha - 6th May, 2024

### New Features
- N/A

### Bug Fixes
- N/A

### Improvements
- Overhauled the between rounds menu
   - Now includes the context of the round, health, gold, etc
   - Includes now a random tip each round
- Small updates to the shop HUD

## 0.13.1 alpha - 5th May, 2024

### New Features
- N/A

### Bug Fixes
- Fixed the wrong bold-ing of titles in the Shop HUD
- Fixed wall health not being reset on game restart if you hadn't purchased any wall upgrades

### Improvements
- Improved the detection of entity collisions when drag distance is small
- Reduced the distance entities can go off the left/right of the screen
- Added in a "round you made it to" text on the game over screen
- Made the spawn duration each round slightly longer
- Made both mages and strong skeletons spawn one round later
   - Also made both spawn slightly less into later rounds

## 0.13.0 alpha - 5th May, 2024

### New Features
- Added in ability to purchase four totems
   - Probably will remove this in the future, as I add more upgrades

### Bug Fixes
- When an entity died in area, they now fall with gravity

### Improvements
- Completely overhauled the spawning logic
   - Now we have a more consistent spawning of difficult of enemies
   - Certain enemies won't appear until later in the game
- Added cost scaling with additional purchases (currently only effects totems as they are the only ones you can buy multiple of)
- Reduced gold output from all enemies
- Changed the font and a lot of UX small changes

## 0.12.2 alpha - 4th May, 2024

### New Features
- N/A

### Bug Fixes
- Fix attack totems incorrectly calculating velocity of moving targets

### Improvements
- More small UX improvements to the shop
- Made the attack totems attack go through the wall for now
- Made friction for horizontally thrown targets higher
- Made the trajectory for attack totem attacks more accurate
- Made the speed of totem attacks much faster

## 0.12.1 alpha - 4th May, 2024

### New Features
- N/A

### Bug Fixes
- Reset purchases on game restart

### Improvements
- Improved the web rendering layout to scale better and remove excess screen rendering of the background
   - Also aligned this now top center, opposed to center
- Improved positioning of the purchase quote
- Improved positioning of the health/gold indicator texts

## 0.12.0 alpha - 3rd May, 2024

### New Features
- Added in new `Attack Totem` purchasable, max of 2 currently
   - 120 gold each, they will auto attack incoming enemies currently for 8 damage, in theory accurate, but the physics could use improving here
- Added in a secret way to bypass to level 10 with gold, useful for debugging

### Bug Fixes
- N/A

### Improvements
- Made the base slightly wider
- Improved the UX of the gold indicator labels
- Small UX improvements to the shop UX
- Started scaffolding for a "How To Play" screen
- Increased costs of walls again
- Decreased gold on kill for strong skeletons from 12 to 10
- Increased damage of entity drag collisions from 5 to 8

## 0.11.1 alpha - 2nd May, 2024

### New Features
- N/A

### Bug Fixes
- N/A

### Improvements
- Improved the colours within the shop HUD to be more consistent with whats been purchased
- Small wording changes
- Updated the cost of both wooden wall and stone wall from 65 and 110, to 150 and 225 gold respectively

## 0.11.0 alpha - 1st May, 2024

### New Features
- New purchaseable, "Wooden wall".
   - You now start with a basic wooden barricade, and therefore, have two wall upgrades

### Bug Fixes
- Overhauled the drag initiation logic, it now takes into account clicks (without a drag) and is much more reliable

### Improvements
- Small improvements ot the shop HUD

## 0.10.0 alpha - 29th April, 2024

### New Features
- You can now drag entities into the mage to damage both, this is a far faster way to kill the mage
   - A certain velocity will need to be met however to cause damage, damage will cause the dragged entity to stop being dragged

### Bug Fixes
- N/A

### Improvements
- Improved dragging logic to be more stable across varying devices
- Reduced velocity needed for fall and drag damage to be a kill
- Made the strong skeleton easier to drag

## 0.9.1 alpha - 28th April, 2024

### New Features
- Add concept of defense to a wall, which removes damage 1:1
   - Gave the stone wall upgrade a defense of 1 (wood has 0)

### Bug Fixes
- N/A

### Improvements
- Scaled the spawning logic better to prefer mages later on, and strong skeletons more in the early rounds
- Nerfed the mage damage
- Added a better description to the stone wall upgrade

## 0.9.0 alpha - 28th April, 2024

### New Features
- Re-introduction of the mage
    - Mage attacks with a projectile from a distance at the wall
    - Can't be dragged
    - Currently, only can be damaged by clicking on the Mage
- Added a slight red tint on currently dragged entity
- You can now slam entities in the wall, though this will also damage your wall

### Bug Fixes
- Fixed wall hitbox not being active again on game restart

### Improvements
- Basic physics for making the wall solid (this is really hacky, and will be improved in the future)
- Improved basic spawning mechanics
- Slowed down the moon
- Made all entities slightly bigger
- Re-adjusted the size of various UX elements
- Made it easier to slam enemies into the ground by reducing the velocity required
- Made all current entities disappear on death
- Fixed small render issue where slimes appeared behind skeletons