# Changelog

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