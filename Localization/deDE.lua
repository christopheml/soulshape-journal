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

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "deDE", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "Seelengestalten"
L["COUNT_LABEL"] = "Seelengestalten"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "Diese Seelengestalt kann nicht automatisch erkannt werden."
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "Klicke hier, um %s als gesammelt zu markieren."
L["WARNING_NOT_NIGHT_FAE"] = "Du bist kein Mitglied der Nachtfae, du kannst daher\nderzeit keine weiteren Seelengestalten sammeln."
L["Available since"] = "Verfügbar seit"
L["Soulshape Journal"] = true -- Addon title, you may translate it but it's not necessary
L["BLIZZARD_MAP_PIN_TOOLTIP"] = "<Strg+Linksklick um eine Kartenmarkierung für diese Position hinzuzufügen>"
L["TOMTOM_WAYPOINT_TOOLTIP"] = "<Shift+Linksklick um einen TomTom-Wegpunkt für diese Position hinzuzufügen>"

-- Labels
L["Loot"] = "Beute"
L["Quest"] = true
L["Campaign"] = "Kampagne"
L["World Event"] = "Weltereignis"
L["World Quest"] = "Weltquest"
L["NPC"] = true
L["Region"] = "Gebiet"
L["Cost"] = "Kosten"
L["Faction"] = "Fraktion"
L["Profession"] = "Beruf"
L["Covenant Feature"] = "Paktfeature"
L["Difficulty"] = "Schwierigkeitsgrad"
L["Coordinates"] = "Koordinaten"
L["Renown"] = "Ruhmstufe"
L["Spell"] = "Zauber"
L["Vendor"] = "Händler"

-- Zone Names
L["The Adamant Vaults"] = "Das Adamantgewölbe"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "Drust und Verzweiflung"
L["Mending a Broken Hart"] = "Neu Geweiht"
L["The Power of Elune"] = "Die Macht von Elune"
L["Night Warrior's Curse"] = "Fluch der Nachtkriegerin"
L["The Power of Night"] = "Die Macht der Nacht"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "Gaben der Wächter des Hains"
L["Queen's Conservatory Cache"] = "Truhe des Konservatoriums der Königin"
L["War Chest of the Wild Hunt"] = "Kriegskasse der Wilden Jagd"
L["Wild Hunt Supplies"] = "Vorräte der Wilden Jagd"
L["Synvir Lockbox"] = "Sinvyrschließkassette"
L["Stygian Lockbox"] = "Stygische Schließkassette"
L["Riftbound Cache"] = "Rissgebundene Truhe"
L["Wildseed Root Grain"] = "Wildsamenwurzelfaser"
L["Repaired Riftkey"] = "Reparierter Rissschlüssel"
L["Spectral Feed"] = "Spektrales Futter"
L["Lost Comb"] = "Verlorene Wabe"
L["Shrouded Cypher Cache"] = "Verhüllte Chiffrentruhe"
L["Enlightened Broker Supplies"] = "Truhe des Erleuchteten Mittlers"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "Verlorene Seele"
L["Ma'oh"] = true
L["Sparkle"] = "Glitzer"
L["Aithlyn"] = true
L["Liawyn"] = true
L["The Grand Menagerie"] = "Die Große Menagerie"
L["Master Clerk Salorn"] = "Kassenmeister Salorn"
L["Lady Sylvanas Windrunner"] = "Sylvanas Windläufer"
L["Mueh'Zala"] = "Mueh'zala"
L["Mistcaller"] = "Nebelruferin"
L["Cortinarius"] = true
L["Sire Denathrius"] = "Graf Denathrius"
L["Skuld Vit"] = true
L["So'leah"] = true
L["Valfir the Unrelenting"] = "Valfir der Unerbittliche"
L["Spindlenose"] = "Spindelzinken"
L["Shopkeeper"] = "Ladenbesitzer"
L["Mystic Rainbowhorn"] = "Mystisches Regenbogenhorn"
L["Olea Manu"] = true
L["Shifting Stargorger"] = "Veränderlicher Sternfresser"
L["Prototype Pantheon"] = "Prototypenpantheon"
L["The Jailer"] = "Der Kerkermeister"
L["Taskmaster Xy'pro"] = "Zuchtmeister Xy'pro"

-- Others
L["Burning Crusade Timewalking"] = "Zeitwanderungen von Burning Crusade"
L["Wrath of the Lich King Timewalking"] = "Zeitwanderungen von Wrath of the Lich King"
L["Cataclysm Timewalking"] = "Zeitwanderungen von Cataclysm"
L["Mists of Pandaria Timewalking"] = "Zeitwanderungen von Mists of Pandaria"
L["Warlords of Draenor Timewalking"] = "Zeitwanderungen von Warlords of Draenor"
L["Legion Timewalking"] = "Zeitwanderungen von Legion"
L["Pet Battle"] = "Haustierkampf"
L["Shadowlands World Bosses"] = "Weltbosse der Schattenlande"
L["Queen's Conservatory"] = "Konservatorium der Königin"
L["Mythic+ dungeons"] = "Mythic+ Dungeons"
L["Night Fae dailies"] = "Tägliche Quests der Nachtfae"
L["Mushroom Network"] = "Der Ring (Pilznetzwerk)"
L["Marasmius"] = true
L["Paragon reward."] = "Paragon-Belohnung"
L["Soulshape"] = "Seelengestalt"
L["Crittershape"] = "Kleintiergestalt"
L["Pilgrim's Bounty"] = "Pilgerfreudenfest"
L["Covenant Callings reward chests"] = "Belohnungstruhen der Pakt-Berufungen"
L["High Value Cache"] = "Sehr wertvoller Schatz"

L["Normal"] = "normal"
L["Heroic"] = "heroisch"
L["Mythic"] = "mythisch"
L["Hardmode"] = true
L["Any"] = "beliebig"

-- Database
L["Alpaca Soul"] = "Alpakaseele"
L["Ardenmoth Soul"] = "Ardenmottenseele"

L["Boar Soul"] = "Eberseele"
L["Boar Soul Guide"] = "Kann von Endbossen beliebiger Warlords of Draenor-Zeitwanderungsdungeons erbeutet werden."

L["Bunny Soul"] = "Häschenseele"
L["Bunny Soul Guide"] = "Kann gelegentlich als Belohnung von Haustierkampf-Weltquests der Schattenlande erbeutet werden."

L["Cat Soul"] = "Katzenseele"
L["Cat Soul Guide"] = "Ganz oben auf einem der großen Traumbäume (Traumsang Fenn, Schimmerkaskadenbecken, Tirna Vaal, Winterschlafbecken, Klauenkamm) erscheint eine Verlorene Seele. Wende das Emote\n/besänftigen auf sie an, um die Katzenseele zu erhalten.\n\nDie Verlorene Seele ist nur auf jeweils einem der Bäume aktiv. Wenn eine Seele besänftigt wurde, verschwindet sie und erscheint auf einem zufälligen Baum erneut."

L["Cat Soul (Well Fed)"] = "Katzenseele (satt)"
L["Cat Soul (Well Fed) Guide"] = "Verfügbar, nachdem die Katzenseele freigeschaltet wurde.\n\nSammele Spektrales Futter in Revendreth und kehre damit ins Herz des Waldes zurück. Im unteren Bereich, neben dem Eingang zum Konservatorium der Königin, liegt die schlafende Katze Ma'oh. Wende das Emote /miau auf sie an (sie antwortet, sie sei hungrig) und gib ihr anschließend das Spektrale Futter.\n\nDie Seelengestalt wird direkt freigeschaltet, es muss keine Quest abgeschlossen werden."

L["Chicken Soul"] = "Hühnerseele"
L["Chicken Soul Guide"] = "Sammele Spektrales Futter in Revendreth. Fliege dann zur Verlorenen Seele, wende das Emote /huhn auf sie an und füttere sie anschließend mit dem Spektralen Futter."

L["Cloud Serpent Soul"] = "Wolkenschlangenseele"
L["Cloud Serpent Soul Guide"] = "Kann von Endbossen beliebiger Mists of Pandaria-Zeitwanderungsdungeons erbeutet werden."

L["Cobra Soul"] = "Kobraseele"
L["Cobra Soul Guide"] = "Gelegentliche Belohnung für einen Sieg in Arena oder gewertetem Schlachtfeld."

L["Corgi Soul"] = "Corgiseele"
L["Corgi Soul Guide"] = "Der Hund Glitzer läuft auf der Hauptebene des Herz des Waldes im Kreis herum. Wende das Emote\n/streicheln auf ihn an.\n\nDie Seelengestalt wird direkt freigeschaltet, es muss keine Quest abgeschlossen werden."

L["Crane Soul"] = "Kranichseele"
L["Cricket Soul"] = "Grillenseele"
L["Direhorn Soul"] = "Terrorhornseele"
L["Eagle Soul"] = "Adlerseele"
L["Equine Soul"] = "Pferdeseele"

L["Frog Soul"] = "Froschseele"
L["Frog Soul Guide"] = "Kann in einem beliebigen Gewässer der vier Schattenlande-Hauptgebiete ohne Skill-Anforderung geangelt werden."

L["Goat Soul"] = "Ziegenseele"
L["Goat Soul Guide"] = "Kann in jeder Belohnungstruhe enthalten sein, nicht nur in denen der Nachtfae."

L["Gryphon Soul"] = "Greifenseele"
L["Gryphon Soul Guide"] = "Gelegentliche Belohnung für einen Sieg in Arenageplänkel, in der Arena, auf zufälligem/gewertetem Schlachtfeld oder bei einer Rauferei."

L["Gulper Soul"] = "Schluckerseele"
L["Gulper Soul Guide"] = "Gelegentliche Belohnung von Ungezähmter Geist beliebiger Qualität unter Benutzung genau einer %s."

L["Hippo Soul"] = "Flusspferdseele"
L["Hippo Soul Guide"] = "Belohnung von Nachtfae-Paktagriff im Schlund."

L["Hippogryph Soul"] = "Hippogryphenseele"

L["Hyena Soul"] = "Hyänenseele"
L["Hyena Soul Guide"] = "Kann auf jeder Schlüsselstein-Stufe erbeutet werden."

L["Jormungar Soul"] = "Jormungarseele"
L["Jormungar Soul Guide"] = "Kann von Endbossen beliebiger Wrath of the Lich King-Zeitwanderungsdungeons erbeutet werden."

L["Kodo Soul"] = "Kodoseele"
L["Kodo Soul Guide"] = "Kann von Endbossen beliebiger Cataclysm-Zeitwanderungsdungeons erbeutet werden."

L["Leonine Soul"] = "Löwenseele"
L["Lupine Soul"] = "Wolfsseele"
L["Mammoth Soul"] = "Mammutseele"

L["Moose Soul"] = "Elchseele"
L["Moose Soul Guide"] = "Es müssen mindestens 5 der 7 seltenen Gegner im Sternseeamphitheater besiegt worden sein (kann im Erfolg \"Der Ardenwald ist eine Bühne\" verfolgt werden)."

L["Otter Soul"] = "Otterseele"
L["Otter Soul Guide"] = "Die Otterseele kann im Teich westlich unter der Heldenrast gefunden werden. Nach dem /umarmen erhält man den Questgegenstand und die Otterseele im Fluss verschwindet (Respawnzeit\nca. 1 Stunde)."

L["Owl Soul"] = "Eulenseele"
L["Owl Soul Guide"] = "Kann von Endbossen beliebiger Legion-Zeitwanderungsdungeons erbeutet werden."

L["Owlcat Soul"] = "Eulenkatzenseele"
L["Porcupine Soul"] = "Stachelschweinseele"
L["Prairie Dog Soul"] = "Präriehundseele"
L["Ram Soul"] = "Widderseele"
L["Raptor Soul"] = "Raptorenseele"

L["Rat Soul"] = "Rattenseele"
L["Rat Soul Guide"] = "Beim Annähern an den Händler flüstert er einem zu. Man erhält Zugang zu seinen Waren, wenn man dies mit dem Emote /ja oder /nicken beantwortet."

L["Runestag Soul"] = "Runenhirschseele"
L["Runestag Soul Guide"] = "Spawnt im Nordosten des Ardenwalds."

L["Saurid Soul"] = "Sauridenseele"
L["Saurid Soul Guide"] = "In einer Höhle. Wende das Emote /verbeugen auf den Mysteriösen Müllhaufen an."

L["Saurolisk Soul"] = "Sauroliskenseele"
L["Saurolisk Hatchling Soul"] = "Sauroliskenjungtierseele"
L["Shadowstalker Soul"] = "Schattenpirscherseele"

L["Shoveltusk Soul"] = "Schaufelhauerseele"
L["Shoveltusk Soul Guide"] = "Gelegentliche Belohnung für einen Sieg in einer PvP-Rauferei."

L["Shrieker Soul"] = "Kreischerseele"
L["Snake Soul"] = "Schlangenseele"
L["Snapper Soul"] = "Schnapperseele"

L["Spider Soul"] = "Spinnenseele"
L["Spider Soul Guide"] = "Nutze mit %s ein Rissportal, um den Riss zu betreten. Dort gibt es täglich 4 Rissgebundene Truhen an zufällig wechselnden Orten."

L["Sporebat Soul"] = "Sporenseglerseele"
L["Sporebat Soul Guide"] = "Kann von Endbossen beliebiger Burning Crusade-Zeitwanderungsdungeons erbeutet werden."

L["Squirrel Soul"] = "Eichhörnchenseele"
L["Squirrel Soul Guide"] = "Die Standard-Kleintiergestalt in deiner Sammlung."

L["Stag Soul"] = "Hirschseele"
L["Stag Soul Guide"] = "Gelegentliche Belohnung einer beliebigen täglichen Quest der Nachtfae in Korthia."

L["Tiger Soul"] = "Tigerseele"

L["Turkey Soul"] = "Truthahnseele"
L["Turkey Soul Guide"] = "Finde einen Pilgerfreudenfest-Tisch in der Nähe einer der Fraktionshauptstädte. Iss dort jede Art Speise 5 mal, um den Buff \"Teilen macht Freude\" zu erhalten. Iss nun jede Speise ein weiteres Mal, um die Quest für die Truthahnseele zu bekommen."

L["Ursine Soul"] = "Bärenseele"
L["Veilwing Soul"] = "Schleierflügelseele"

L["Vulpine Soul"] = "Vulpinseele"
L["Vulpine Soul Guide"] = "Die Standard-Seelengestalt in deiner Sammlung."

L["Wolfhawk Soul"] = "Wolfsfalkenseele"
L["Wolfhawk Soul Guide"] = "Nutze die Seelengestalt bzw. Flackern, um durch die Barriere zu gelangen."

L["Wyvern Soul"] = "Wyvernseele"
L["Yak Soul"] = "Yakseele"

-- 9.2 Soulshapes

L["Armadillo Soul"] = "Gürteltierseele"
L["Bat Soul"] = "Fledermausseele"

L["Bee Soul"] = "Bienenseele"
L["Bee Soul Guide"] = "Die blau leuchtende Wabe liegt auf einem Bienenstock oben an einer Steinsäule. Benötigt Fliegen."

L["Brutosaur Soul"] = "Brutosaurusseele"
L["Cervid Soul"] = "Cervidseele"
L["Dragonhawk Soul"] = "Drachenfalkenseele"
L["Elekk Soul"] = "Elekkseele"

L["Gromit Soul"] = "Gromitseele"
L["Gromit Soul Guide"] = "Um die verhüllten Truhen sehen zu können, aktiviere Pocopocs |T134442:0|t |cFFFFFFFFAufmerksamer Pocopoc|r-Buff, während du Chiffrenausrüstung mit |cFFFFFFFFVerbessert Pocopocs Wahrnehmungsfähigkeiten|r-Effekt trägst."

L["Penguin Soul"] = "Pinguinseele"
L["Penguin Soul Guide"] = "Oben auf der Metallkugel. Interaktion mit der Verlorenen Seele startet die Quest. Benötigt Fliegen."

L["Pig Soul"] = "Schweineseele"
L["Ray Soul"] = "Rochenseele"
L["Scorpid Soul"] = "Skorpidenseele"

L["Sheep Soul"] = "Schafseele"
L["Sheep Soul Guide"] = "Hat verschiedene Spawnpunkte. Interaktion mit der Verlorenen Seele startet die Quest."

L["Silithid Soul"] = "Silithidenseele"

L["Snail Soul"] = "Schneckenseele"
L["Snail Soul Guide"] = "Bekämpfe Zuchtmeister Xy'pro mit mindestens drei weiteren Mobs in seiner Nähe, damit er den |T465877:0|t |cFFFFFFFFSicherheitsüberbrückung|r-Buff erhält. Nach seinem Ableben hinterlässt er dann eine |T465877:0|t |cff14b200Sicherheitsüberbrückungskugel|r. Benutze sie, um Zugriff auf die Truhe zu erhalten."

L["Tallstrider Soul"] = "Weitschreiterseele"

L["Unknown Guide"] = "Die Quelle dieser Seelengestalt ist zurzeit noch unbekannt."
L["Torghast 9.2 Soulshape Guide"] = "Kann als Verlorene Seele in Torghast spawnen."

-- Tooltips on maps
L["Spectral Feed Tooltip"] = "Spektrales Futter ist ein blau leuchtender Getreidesack auf dem Boden, der alle 1–2 Stunden für 10 Minuten erscheint. Durch Anklicken erhältst du den Gegenstand, er verbleibt dann für 10 Minuten in der Tasche und wird bei Benutzung verbraucht."
L["Olea Manu Tooltip"] = "Um Olea Manu freizuschalten, muss |T4238929:0| t|cFFFFFFFFVerständnis des Altesischen|r erforscht und die|A:smallquestbang:16:16|a|cFFFFFFFFJiroische Taten|r-Questreihe abgeschlossen sein."
L["Shrouded Cypher Cache Tooltip"] = "Um die verhüllten Truhen sehen zu können, aktiviere Pocopocs |T134442:0|t |cFFFFFFFFAufmerksamer Pocopoc|r-Buff, während du Chiffrenausrüstung mit |cFFFFFFFFVerbessert Pocopocs Wahrnehmungsfähigkeiten|r-Effekt trägst."
L["High Value Cache Tooltip"] = "Die Schutzvorrichtung kann mithilfe der |T465877:0|t |cff14b200Sicherheitsüberbrückungskugel|r von Zuchtmeister Xy'pro deaktiviert werden.|n|nAlle Spieler des Raids können auf die Truhe zugreifen – unabhängig davon, wer den Schutz deaktiviert hat."
L["Taskmaster Xy'pro Tooltip"] = "Wird der Zuchtmeister mit |T465877:0|t |cFFFFFFFFSicherheitsüberbrückung|r-Buff getötet, hinterlässt er eine |T465877:0|t |cff14b200Sicherheitsüberbrückungskugel|r.|n|nFür jeden zusätzlichen Mob in seiner unmittelbaren Nähe erhält er einen Stack |T135740:0|t |cFFFFFFFFSynergie|r. Bei drei Stacks bekommt er den |T465877:0|t |cFFFFFFFFcFFFFFFFFSicherheitsüberbrückung|r-Buff."
