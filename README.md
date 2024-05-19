# defend_your_flame

Inspired by a classic game I grew up with as a kid.

### What is this game?
It is a simple, side on, round based game where you are trying to defend your flame from an ever increasing onslaught of enemies.

Defend it, by using throwing the enemies into the air, and upgrade your bases defenses.

See how long you can last!

### Why are you re-making this?
I'd like to do a small project that uses Flame, as an experiment, and then host it on my GitHub for free.

### Want to contribute?
Feel free to open a code change, or open an issue, I'll respond to it!

I'm tracking the current work [here](https://github.com/users/anleac/projects/9/views/1)

### Git tips

Delete all merged branches:
> git branch --merged | grep -Ev "(^\*|master|main|dev)" | xargs git branch -d

### Useful AI tools for graphic generation.
- Image generation
    - Generic free tool: https://bing.com/create
    - Fremium tool that appears to be higher quality: https://app.leonardo.ai
    - Free tool: https://beta.pixelvibe.com/ (aimed at pixel art, but fairly limited in types)
- Removing backgrounds: https://www.remove.bg/upload
- Edit manipulation/extension: https://app.runwayml.com/
- Removing objects: https://snapedit.app/
- Pixelifying objects: https://pixelartify.com
- Another pixelify tool: https://pixelied.com/features/pixel-art-generator

### Useful general tools for graphic manipulation / generation
- You can use ImageMagick to flip images locally:
    - `mogrify -flop *.png` (this will be in place manipulation), otherwise you can use a new directory:
    - `mkdir flipped && mogrify -path flipped -flop *.png`
- Splitting spritesheets: https://ezgif.com/sprite-cutter

### Readings for perf
- [Web Performance](https://medium.com/flutter/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c)