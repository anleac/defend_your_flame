# Changelog

## 0.12.1 alpha - 4th May, 2024

### New Features
- N/A

### Bug Fixes
- Reset purchases on game restart

### Improvements
- Improved the web rendering layout to scale better and remove excess screen rendering of the background
   - Also aligned this now top center, opposed to center
- Improved positioning of the purchase quote

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