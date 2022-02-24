--[[ MIT License

Copyright (c) 2021 Christophe MICHEL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local ADDON, _ = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "enUS", true)

-- UI elements
L["TAB_TITLE"] = "Soulshapes"
L["COUNT_LABEL"] = "Total"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "This soulshape can't be automatically detected"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "Click to mark %s as collected if you already have it."
L["WARNING_NOT_NIGHT_FAE"] = "You're not a member of the Night Fae,\nyou can't collect new soulshapes at this time."
L["Available since"] = true
L["Soulshape Journal"] = true -- Addon title, you may translate it but it's not necessary
L["BLIZZARD_MAP_PIN_TOOLTIP"] = "<Ctrl + click to add a map pin for this location>"
L["TOMTOM_WAYPOINT_TOOLTIP"] = "<Shift + click to add a TomTom waypoint for this location>"

-- Labels
L["Loot"] = true
L["Quest"] = true
L["Campaign"] = true
L["World Event"] = true
L["World Quest"] = true
L["NPC"] = true
L["Region"] = true
L["Cost"] = true
L["Faction"] = true
L["Profession"] = true
L["Covenant Feature"] = true
L["Difficulty"] = true
L["Coordinates"] = true
L["Renown"] = true
L["Spell"] = true
L["Vendor"] = true

-- Zone Names
L["Shadowlands"] = true
L["Ardenweald"] = true
L["Bastion"] = true
L["Revendreth"] = true
L["Maldraxxus"] = true
L["Oribos"] = true
L["The Maw"] = true
L["Torghast"] = true
L["The Adamant Vaults"] = true
L["Korthia"] = true
L["De Other Side"] = true
L["Mists of Tirna Scithe"] = true
L["Tazavesh, the Veiled Market"] = true
L["Castle Nathria"] = true
L["Sanctum of Domination"] = true

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = true
L["Mending a Broken Hart"] = true
L["The Power of Elune"] = true
L["Night Warrior's Curse"] = true
L["The Power of Night"] = true

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = true
L["Queen's Conservatory Cache"] = true
L["War Chest of the Wild Hunt"] = true
L["Wild Hunt Supplies"] = true
L["Synvir Lockbox"] = true
L["Stygian Lockbox"] = true
L["Riftbound Cache"] = true
L["Wildseed Root Grain"] = true
L["Repaired Riftkey"] = true
L["Spectral Feed"] = true
L["Lost Comb"] = true

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = true
L["Ma'oh"] = true
L["Sparkle"] = true
L["Aithlyn"] = true
L["Liawyn"] = true
L["The Grand Menagerie"] = true
L["Master Clerk Salorn"] = true
L["Lady Sylvanas Windrunner"] = true
L["Mueh'Zala"] = true
L["Mistcaller"] = true
L["Cortinarius"] = true
L["Sire Denathrius"] = true
L["Skuld Vit"] = true
L["So'leah"] = true
L["Valfir the Unrelenting"] = true
L["Spindlenose"] = true
L["Shopkeeper"] = true
L["Mystic Rainbowhorn"] = true
L["Olea Manu"] = true
L["Shifting Stargorger"] = true

-- Others
L["Burning Crusade Timewalking"] = true
L["Wrath of the Lich King Timewalking"] = true
L["Cataclysm Timewalking"] = true
L["Mists of Pandaria Timewalking"] = true
L["Warlords of Draenor Timewalking"] = true
L["Legion Timewalking"] = true
L["Pet Battle"] = true
L["Shadowlands World Bosses"] = true
L["Queen's Conservatory"] = true
L["Mythic+ dungeons"] = true
L["Night Fae dailies"] = true
L["Mushroom Network"] = true
L["Marasmius"] = true
L["Paragon reward."] = true
L["Soulshape"] = true
L["Crittershape"] = true
L["Pilgrim's Bounty"] = true
L["Covenant Callings reward chests"] = true

L["Normal"] = true
L["Heroic"] = true
L["Mythic"] = true
L["Hardmode"] = true
L["Any"] = true

-- Database
L["Alpaca Soul"] = true
L["Ardenmoth Soul"] = true

L["Boar Soul"] = true
L["Boar Soul Guide"] = "Can drop from the last boss of any Warlords Draenor Timewalking dungeon."

L["Bunny Soul"] = true
L["Bunny Soul Guide"] = "Occasional reward from pet battle world quests."

L["Cat Soul"] = true
L["Cat Soul Guide"] = "A cat soul can spawn on top of the trunk of the tallest Ardenwealed trees (Dreamsong Fenn, Glitterfall Basin, Tirna Vaal, Hibernal Hollow or Claw's Edge). Use /soothe on it to get the soulshape."

L["Cat Soul (Well Fed)"] = true
L["Cat Soul (Well Fed) Guide"] = "Available once you have unlocked the Cat soulshape. First get the Spectral Feed, then head back to Heart of the Forest, Ma'oh is a cat soul sleeping in a basket near the Queen's Conservatory entrance.\n/meow at him (he'll tell you he's hungry) then feed him the Spectral Feed. You'll receive the soulshape immediately (no quest turn-in needed)."

L["Chicken Soul"] = true
L["Chicken Soul Guide"] = "First get the Spectral Feed, then /chicken at the chicken soul and feed it the Spectral Feed."

L["Cloud Serpent Soul"] = true
L["Cloud Serpent Soul Guide"] = "Can drop from the last boss of any Mists of Pandaria Timewalking dungeon."

L["Cobra Soul"] = true
L["Cobra Soul Guide"] = "Occasional reward from a win in Arena or Rated Battleground."

L["Corgi Soul"] = true
L["Corgi Soul Guide"] = "Sparkle is a corgi soul walking around the Heart of the Forest. /pet him and you'll receive the soulshape immediately (no quest turn-in needed)"

L["Crane Soul"] = true
L["Cricket Soul"] = true
L["Direhorn Soul"] = true
L["Eagle Soul"] = true
L["Equine Soul"] = true

L["Frog Soul"] = true
L["Frog Soul Guide"] = "Available from any covenant zone."

L["Goat Soul"] = true
L["Goat Soul Guide"] = "Can drop from any Covenant Calling chest, not only from Night Fae's."

L["Gryphon Soul"] = true
L["Gryphon Soul Guide"] = "Occasional reward from a win in Skirmish, Arena, Random Battleground, Rated Battleground or Comp Stomp Brawl."

L["Gulper Soul"] = true
L["Gulper Soul Guide"] = "Obtainable with spirits of any quality, but use only one %s."

L["Hippo Soul"] = true
L["Hippo Soul Guide"] = "Reward from Night Fae Assault."

L["Hippogryph Soul"] = true

L["Hyena Soul"] = true
L["Hyena Soul Guide"] = "Can drop at any key level."

L["Jormungar Soul"] = true
L["Jormungar Soul Guide"] = "Can drop from the last boss of any Wrath of the Lich King Timewalking dungeon."

L["Kodo Soul"] = true
L["Kodo Soul Guide"] = "Can drop from the last boss of any Cataclysm Timewalking dungeon."

L["Leonine Soul"] = true
L["Lupine Soul"] = true
L["Mammoth Soul"] = true

L["Moose Soul"] = true
L["Moose Soul Guide"] = "You must have defeated 5 of the 7 different rare bosses from the amphitheater performances."

L["Otter Soul"] = true
L["Otter Soul Guide"] = "An otter soul can spawn in the lake under Hero's Rest (60 minutes respawn). /hug it to receive the soulshape quest item."

L["Owl Soul"] = true
L["Owl Soul Guide"] = "Can drop from the last boss of any Legion Timewalking dungeon."

L["Owlcat Soul"] = true
L["Porcupine Soul"] = true
L["Prairie Dog Soul"] = true
L["Ram Soul"] = true
L["Raptor Soul"] = true

L["Rat Soul"] = true
L["Rat Soul Guide"] = "When he whispers you, answer with /yes or /nod to gain access to his wares."

L["Runestag Soul"] = true
L["Runestag Soul Guide"] = "Spawns northeast of Ardenweald."

L["Saurid Soul"] = true
L["Saurid Soul Guide"] = "Inside a cave. Target the trash pile at the back of the cave and /bow it."

L["Saurolisk Soul"] = true
L["Saurolisk Hatchling Soul"] = true
L["Shadowstalker Soul"] = true

L["Shoveltusk Soul"] = true
L["Shoveltusk Soul Guide"] = "Occasional reward from a win in any PvP Brawl."

L["Shrieker Soul"] = true
L["Snake Soul"] = true
L["Snapper Soul"] = true

L["Spider Soul"] = true
L["Spider Soul Guide"] = "Go through a Rift Portal using a %s. There are 4 caches spawning every day at random locations."

L["Sporebat Soul"] = true
L["Sporebat Soul Guide"] = "Can drop from the last boss of any Burning Crusade Timewalking dungeon."

L["Squirrel Soul"] = true
L["Squirrel Soul Guide"] = "The first crittershape of your collection, courtesy of Choofa!"

L["Stag Soul"] = true
L["Stag Soul Guide"] = "Can be randomly offered as a reward from any Night Fae daily in Korthia."

L["Tiger Soul"] = true

L["Turkey Soul"] = true
L["Turkey Soul Guide"] = "Go to a faction capital, and find a Pilgrim’s Bounty table.\nEat every food until you have the 5 food buffs, then continue eating food and switching seats every time until you get the soulshape."

L["Ursine Soul"] = true
L["Veilwing Soul"] = true

L["Vulpine Soul"] = true
L["Vulpine Soul Guide"] = "The very first soulshape of your collection!"

L["Wolfhawk Soul"] = true
L["Wolfhawk Soul Guide"] = "You need to use Soulshape to cross the barrier."

L["Wyvern Soul"] = true
L["Yak Soul"] = true

-- 9.2 Soulshapes

L["Armadillo Soul"] = true
L["Bat Soul"] = true

L["Bee Soul"] = true
L["Bee Soul Guide"] = "The soulshape-colored comb is located on top of a hive. Requires flying."

L["Brutosaur Soul"] = true
L["Cervid Soul"] = true
L["Dragonhawk Soul"] = true
L["Elekk Soul"] = true
L["Gromit Soul"] = true

L["Penguin Soul"] = true
L["Penguin Soul Guide"] = "On top of the metal orb. Interact with the penguin Lost Soul to obtain the soulshape. Requires flying."

L["Pig Soul"] = true
L["Ray Soul"] = true
L["Scorpid Soul"] = true

L["Sheep Soul"] = true
L["Sheep Soul Guide"] = "Multiple spawn locations. Interact with the sheep Lost Soul to obtain the soulshape."

L["Silithid Soul"] = true
L["Snail Soul"] = true
L["Tallstrider Soul"] = true

L["Unknown Guide"] = "Source of this soulshape is currently unknown."
L["Torghast 9.2 Soulshape Guide"] = "This soul can be freed during a Torghast run in layers 12 and higher."

-- Tooltips on maps
L["Spectral Feed Tooltip"] = "Spectral Feed is a glowing blue sack of grain on the ground, respawning every 1-2 hours. Upon clicking it, you get the item in your bags, with a 10 minutes duration, that is consumed on use."
