# Changelog

## 0.18.0 - 17th May, 2024

### New Features
- N/A

### Bug Fixes
- Dragging gets stopped if killed mid-drag
- Fixed weird velocity bug when only dragging for a short duration that would cause a sharp reverse velocity
- Fixed the bosses not showing their damage when attacking the wall

### Improvements / Balances
- Updated the totems to have a chance to miss the ice wolf (deemed a fast enemy)
- Updated the grass texture
- Updated entities to do different collision damage
  - Slimes do 80% of damage
  - Strong skeletons do 150% of damage
  - Rock golems do 200% of damage
- Made attack totems slightly weaker, they now attack ~15% slower on average

## 0.17.4 - 17th May, 2024

### New Features
- Updated the mouse cursor to be responsive to what you're currently hovering over and the related action

### Bug Fixes
- N/A

### Improvements / Balances
- N/A

## 0.17.3 - 16th May, 2024

### New Features
- N/A

### Bug Fixes
- N/A

### Improvements / Balances
- Shifted the collision detection damage for the wall to be the segment of the wall the entity corresponds with, rather than the entire bounding polygon
- Adjusted gravity (increased by approx 10%), and increased air friction by 10% also
- Slowed down slightly the first boss
- Entities that are attacking the wall on top now fall after it's destroyed

## 0.17.2 - 15th May, 2024

### New Features
- Overhauled collision logic with the walls
  - They can no longer be dragged into them at all, and can also land on top
  - If they land on top, they will start to attack

### Bug Fixes
- N/A

### Improvements / Balances
- Small scale fixes

## 0.17.1 - 14th May, 2024

### New Features
- N/A

### Bug Fixes
- Fixed ice wolf attack being incredibly slow

### Improvements / Balances
- N/A

## 0.17.0 alpha - 14th May, 2024

### New Features
- Added in another new enemy, ice wolf
  - Ice wolf, key features:
    - Fast speed, low health, dies on one throw
    - Intention was to replace the rat sprite
    - This enemy is even faster
- New purchaseable item, "blacksmith"
  - Costs 250
  - Repairs up to 20% of your wall health each round

### Bug Fixes
- N/A

### Improvements / Balances
- Made all entities attack slightly slower
- Small UX tweaks, made most effect text larger

## 0.16.0 alpha - 14th May, 2024

### New Features
- Added two new enemies
  - Rock golem, key features:
    - Strong, takes four throws to kill
    - Immune to magical attacks, totems attacks won't be able to hit them
    - Starts spawning currently at wave 14
    - Heavy, and therefore hard to drag
  - Rat, key features:
    - Very fast, this will be the fastest current enemy in the game so far
    - Standard health, therefore die on one throw
    - Starts spawning currently at wave 12

### Bug Fixes
- Small fix to incorrect positioning of damage text when clicking on a mage

### Improvements / Balances
- To scale difficulty into the later game, speed of most mobs (all currently except the mage, and bosses) will increase at a rate of sqrt(currentround * 3) / 100, as a percentage, this is a minor change but should help to subtly increase difficulty
- Give most mobs a general variance now of speed, being +/- 5% of the default speed
- Added two new tips in regards to the new enemies
- Sharpened some of the ingame textures
- The attacks from the attack totem fire 5% faster now

## 0.15.2 alpha - 13th May, 2024

### New Features
- N/A

### Bug Fixes
- N/A

### Improvements / Balances
- Reduced gold per moon click to 50
- Overhauled the tip system, now allowing for certain tips to always appear at certain rounds
- Slightly improved the collision box of the strong skeleton

## 0.15.1 alpha - 13th May, 2024

### New Features
- N/A

### Bug Fixes
- Fixed gold starting at 10,000 - this is now correctly back at 0

### Improvements / Balances
- Overhauled the game start menu
  - There is now an additional screen for selecting a game
  - You can now fast track to round 10 or 15 with additional gold
- Removed the "moon-click" fast track in favour of the new game start menu
- Clicking the moon between rounds now gives gold, this is temporary for debugging purposes while testing in alpha
- Improved the visual effects of damage and gold
- Scaled the totem cost now to get progressively more expensive by 30% each time
- Small improvements to the positioning of the wall
- Small improvements to where damage text is positioned on mage and strong skeletons

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
- Added in more tips to reference the new boss rounds
- Slightly lengthened the spawn duration of enemies into the later rounds

### Debug only
- Updated the moon fast track to have 600 gold now to compensate for harder boss rounds

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