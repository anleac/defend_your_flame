# Changelog

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