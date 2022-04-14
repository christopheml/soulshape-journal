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

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "frFR", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "Formes d’âme"
L["COUNT_LABEL"] = "Total"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "Cette forme d’âme ne peut pas être détectée automatiquement"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "Cliquez pour marquer %s comme débloquée si vous l'avez déjà."
L["WARNING_NOT_NIGHT_FAE"] = "Vous n'êtes pas membre des Faë nocturnes, vous ne pouvez pas\ncollecter de nouvelle forme d’âme actuellement."
L["Available since"] = "Disponible depuis la"
L["BLIZZARD_MAP_PIN_TOOLTIP"] = "<Ctrl + clic pour ajouter un repère cartographique pour cet emplacement>"
L["TOMTOM_WAYPOINT_TOOLTIP"] = "<Shift + clic pour ajouter un point de passage TomTom pour cet emplacement>"


-- Labels
L["Loot"] = "Butin"
L["Quest"] = "Quête"
L["Campaign"] = "Campagne"
L["World Event"] = "Événement mondial"
L["World Quest"] = "Expédition"
L["NPC"] = "PNJ"
L["Region"] = "Région"
L["Cost"] = "Coût"
L["Faction"] = true
L["Profession"] = "Métier"
L["Covenant Feature"] = "Fonctionnalité de la congrégation"
L["Difficulty"] = "Difficulté"
L["Coordinates"] = "Coordonnées"
L["Renown"] = "Renom"
L["Spell"] = "Sort"
L["Vendor"] = "Vendeur"

-- Zone Names
L["The Adamant Vaults"] = "Caveaux Impitoyables"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "De Drust et de cendres"
L["Mending a Broken Hart"] = "Soulager un cœur brisé"
L["The Power of Elune"] = "Le pouvoir d’Élune"
L["Night Warrior's Curse"] = "La malédiction de la guerrière de la Nuit"
L["The Power of Night"] = "Le pouvoir de la nuit"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "Butin des gardiens du Bosquet"
L["Queen's Conservatory Cache"] = "Cache du jardin d’hiver de la Reine"
L["War Chest of the Wild Hunt"] = "Trésor de guerre de l’Hallali"
L["Wild Hunt Supplies"] = "Fournitures de l’Hallali"
L["Synvir Lockbox"] = "Coffret en vicevyr"
L["Stygian Lockbox"] = "Coffret stygien"
L["Riftbound Cache"] = "Cache liée à la faille"
L["Wildseed Root Grain"] = "Grain de racine sauvage"
L["Repaired Riftkey"] = "Clé de faille réparée"
L["Spectral Feed"] = "Céréales spectrales"
L["Lost Comb"] = "Rayon de miel égaré"
L["Shrouded Cypher Cache"] = "Cache cryptique dissimulée"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "Âme égarée"
L["Ma'oh"] = "Ma’oh"
L["Sparkle"] = "Sparkel"
L["Aithlyn"] = true
L["Liawyn"] = true
L["The Grand Menagerie"] = "Grandiose Ménagerie"
L["Master Clerk Salorn"] = "Ouvreur en chef Salorn"
L["Lady Sylvanas Windrunner"] = "Dame Sylvanas Coursevent"
L["Mueh'Zala"] = true
L["Mistcaller"] = "Mandebrume"
L["Cortinarius"] = true
L["Sire Denathrius"] = true
L["Skuld Vit"] = true
L["So'leah"] = true
L["Valfir the Unrelenting"] = "Valfir le Tenace"
L["Spindlenose"] = "Fusenez"
L["Shopkeeper"] = "Commerçant"
L["Mystic Rainbowhorn"] = "Mystique Arc-en-Corne"
L["Olea Manu"] = "Oléa Manu"
L["Shifting Stargorger"] = "Dévoreur d'étoile changeant"
L["Prototype Pantheon"] = "Panthéon des prototypes"
L["The Jailer"] = "Le Geôlier"
L["Taskmaster Xy'pro"] = "Sous-chef Xy’pro"

-- Others
L["Burning Crusade Timewalking"] = "Marcheurs du temps de Burning Crusade"
L["Wrath of the Lich King Timewalking"] = "Marcheurs du temps de Wrath of the Lich King"
L["Cataclysm Timewalking"] = "Marcheurs du temps de Cataclysm"
L["Mists of Pandaria Timewalking"] = "Marcheurs du temps de Mists of Pandaria"
L["Warlords of Draenor Timewalking"] = "Marcheurs du temps de Warlords of Draenor"
L["Legion Timewalking"] = "Marcheurs du temps de Legion"
L["Pet Battle"] = "Combat de mascottes"
L["Shadowlands World Bosses"] = "Boss hors instance de l'Ombreterre"
L["Queen's Conservatory"] = "Jardin d’hiver de la Reine"
L["Mythic+ dungeons"] = "Donjons mythiques +"
L["Night Fae dailies"] = "Quêtes quotidiennes des Faë nocturnes"
L["Mushroom Network"] = "Réseau de champignons"
L["Marasmius"] = true
L["Paragon reward."] = "Récompense de parangon."
L["Soulshape"] = "Forme d’âme"
L["Crittershape"] = "Forme de bestiole"
L["Pilgrim's Bounty"] = "Les Bienfaits du pèlerin"
L["Covenant Callings reward chests"] = "Coffres de récompense d'appels de congrégation"
L["High Value Cache"] = "Cache précieuse"

L["Normal"] = true
L["Heroic"] = "Héroïque"
L["Mythic"] = "Mythique"
L["Hardmode"] = true
L["Any"] = "Toutes"

-- Database
L["Alpaca Soul"] = "Âme d’alpaga"
L["Ardenmoth Soul"] = "Âme de phalarden"

L["Boar Soul"] = "Âme de sanglier"
L["Boar Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Warlords of Draenor."

L["Bunny Soul"] = "Âme de lapin"
L["Bunny Soul Guide"] = "Récompense occasionnelle des expéditions de combat de mascottes."

L["Cat Soul"] = "Âme de chat"
L["Cat Soul Guide"] = "Une âme de chat peut apparaître au sommet d'un des plus hauts arbres de Sylvarden (Palun Chanterêve, Bassin Tombe-Lueur, Tirna Vaal, Creux Hibernal ou Bord-de-Griffe). Utilisez /apaise sur lui pour obtenir la forme d'âme."

L["Cat Soul (Well Fed)"] = "Âme de chat (bien nourri)"
L["Cat Soul (Well Fed) Guide"] = "Disponible après avoir débloqué l'âme de chat. Récupérez d'abord les Céréales spectrales, puis revenez au Cœur de la forêt, Ma'oh est une âme de chat qui dort dans un panier près de l'entrée du Jardin d'hiver de la Reine." .. "|n" .. "Faites-lui /miaou (il vous dira qu'il a faim) puis donnez-lui les Céréales spectrales. Vous recevez directement la forme d'âme (pas de quête à rendre)."

L["Chicken Soul"] = "Âme de poulet"
L["Chicken Soul Guide"] = "Récupérez d'abord les Céréales spectrales, puis faites \n/poulet à l'âme de poulet et donnez-lui les Céréales spectrales."

L["Cloud Serpent Soul"] = "Âme de serpent-nuage"
L["Cloud Serpent Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Mists of Pandaria."

L["Cobra Soul"] = "Âme de cobra"
L["Cobra Soul Guide"] = "Récompense occasionnelle après une victoire en Arène ou Champ de bataille coté."

L["Corgi Soul"] = "Âme de corgi"
L["Corgi Soul Guide"] = "Sparkel est une âme de corgi qui tourne dans le Cœur de la forêt. Faites-lui /cajoler et vous recevez directement la forme d'âme (pas de quête à rendre)."

L["Crane Soul"] = "Âme de grue"
L["Cricket Soul"] = "Âme de criquet"
L["Direhorn Soul"] = "Âme de navrecorne"
L["Eagle Soul"] = "Âme d’aigle"
L["Equine Soul"] = "Âme d’étalon"

L["Frog Soul"] = "Âme de grenouille"
L["Frog Soul Guide"] = "Disponible dans n'importe quelle zone de congrégation."

L["Goat Soul"] = "Âme de chèvre"
L["Goat Soul Guide"] = "Obtenable dans les coffres de n'importe quel Appel de congrégation, pas uniquement des Faë nocturnes."

L["Gryphon Soul"] = "Âme de griffon"
L["Gryphon Soul Guide"] = "Récompense occasionnelle après une victoire en Escarmouche, Arène, Champ de bataille aléatoire, Champ de bataille coté ou Choc JcJ : contre l’IA."

L["Gulper Soul"] = "Âme de gobeur"
L["Gulper Soul Guide"] = "Obtenable avec des esprits de n'importe quelle qualité, mais n'utilisez qu'un seul %s."

L["Hippo Soul"] = "Âme de potamodonte"
L["Hippo Soul Guide"] = "Récompense de l'assaut des Faë nocturnes."

L["Hippogryph Soul"] = "Âme d’hippogriffe"

L["Hyena Soul"] = "Âme de hyène"
L["Hyena Soul Guide"] = "Peut s'obtenir à n'importe quel niveau de clé."

L["Jormungar Soul"] = "Âme de jormungar"
L["Jormungar Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Wrath of the Lich King."

L["Kodo Soul"] = "Âme de kodo"
L["Kodo Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Cataclysm."

L["Leonine Soul"] = "Âme de lion"
L["Lupine Soul"] = "Âme de loup"
L["Mammoth Soul"] = "Âme de mammouth"

L["Moose Soul"] = "Âme d’élan"
L["Moose Soul Guide"] = "Vous devez avoir battu 5 des 7 différents boss rares des représentations de l'amphitéatre."

L["Otter Soul"] = "Âme de loutre"
L["Otter Soul Guide"] = "Une âme de loutre peut apparaître dans le lac sous le Repos du Héros (60 minutes de respawn).\nFaites-lui /serrer pour recevoir l'objet de quête de la forme d'âme."

L["Owl Soul"] = "Âme de chouette"
L["Owl Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Legion."

L["Owlcat Soul"] = "Âme de fauve-huant"
L["Porcupine Soul"] = "Âme de porc-épic"
L["Prairie Dog Soul"] = "Âme de chien de prairie"
L["Ram Soul"] = "Âme de bélier"
L["Raptor Soul"] = "Âme de raptor"

L["Rat Soul"] = "Âme de rat"
L["Rat Soul Guide"] = "Quand il vous aborde, répondez avec /oui ou /hoche pour accéder à ses marchandises."

L["Runestag Soul"] = "Âme de cerf runique"
L["Runestag Soul Guide"] = "Apparaît au nord-est de Sylvarden."

L["Saurid Soul"] = "Âme de sauride"
L["Saurid Soul Guide"] = "A l'intérieur d'une grotte. Ciblez la pile de débris et faites /incliner."

L["Saurolisk Soul"] = "Âme de saurolisque"
L["Saurolisk Hatchling Soul"] = "Âme de bébé saurolisque"
L["Shadowstalker Soul"] = "Âme de traqueur des ombres"

L["Shoveltusk Soul"] = "Âme de brochepelle"
L["Shoveltusk Soul Guide"] = "Récompense occasionnelle après une victoire dans n'importe quel Choc JcJ."

L["Shrieker Soul"] = "Âme de hurleur"
L["Snake Soul"] = "Âme de serpent"
L["Snapper Soul"] = "Âme de mordeuse"

L["Spider Soul"] = "Âme d’araignée"
L["Spider Soul Guide"] = "Entrez dans un portail de faille avec une %s. Il y a 4 caches qui apparaissent chaque jour à des emplacements aléatoires."

L["Sporebat Soul"] = "Âme de sporoptère"
L["Sporebat Soul Guide"] = "Peut-être obtenu sur le dernier boss de n’importe quel donjon des Marcheurs du temps de Burning Crusade."

L["Squirrel Soul"] = "Âme d’écureuil"
L["Squirrel Soul Guide"] = "La première forme de bestiole de votre collection, offerte par Choufa !"

L["Stag Soul"] = "Âme de cerf"
L["Stag Soul Guide"] = "Peut-être aléatoirement offert en récompense de n'importe quelle quête journalière des Faë nocturnes à Korthia."

L["Tiger Soul"] = "Âme de tigre"

L["Turkey Soul"] = "Âme de dinde"
L["Turkey Soul Guide"] = "Allez dans une capitale et trouvez une table des Bienfaits du pèlerin.\nMangez de chaque nourriture jusqu'à avoir les 5 buffs différents, puis continuer à manger et changer de siège à chaque fois. jusqu'à obtenir la forme d'âme."

L["Ursine Soul"] = "Âme d’ours"
L["Veilwing Soul"] = "Âme d’aile-voilée"

L["Vulpine Soul"] = "Âme de vulpin"
L["Vulpine Soul Guide"] = "La toute première forme d'âme de votre collection !"

L["Wolfhawk Soul"] = "Âme de loup-faucon"
L["Wolfhawk Soul Guide"] = "Vous devez utiliser votre forme d'âme pour traverser la barrière."

L["Wyvern Soul"] = "Âme de wyverne"
L["Yak Soul"] = "Âme de yack"

-- 9.2 Soulshapes

L["Armadillo Soul"] = "Âme de tatou"
L["Bat Soul"] = "Âme de chauve-souris"

L["Bee Soul"] = "Âme d’abeille"
L["Bee Soul Guide"] = "Les alvéoles bleues brillantes sont situées au sommet d'une ruche. Nécessite le vol."

L["Brutosaur Soul"] = "Âme de brutosaure"
L["Cervid Soul"] = "Âme de cervidé"
L["Dragonhawk Soul"] = "Âme de faucon-dragon"
L["Elekk Soul"] = "Âme d’elekk"

L["Gromit Soul"] = "Âme de gronil"
L["Gromit Soul Guide"] = "Pour voir les caches, vous devez porter une pièce d'équipement cryptique avec |cFFFFFFFFDénicheur de trésors|r et demander à Pocopoc de \"chercher des objets intéressants\" pour avoir le buff |T134442:0|t |cFFFFFFFFPocopoc perspicace|r."

L["Penguin Soul"] = "Âme de pingouin"
L["Penguin Soul Guide"] = "Au sommet de l'orbe métallique. Interagissez avec l'âme égarée de pingouin pour obtenir la forme d'âme. Requiert le vol."

L["Pig Soul"] = "Âme de cochon"
L["Ray Soul"] = "Âme de raie"
L["Scorpid Soul"] = "Âme de scorpide"

L["Sheep Soul"] = "Âme de mouton"
L["Sheep Soul Guide"] = "Plusieurs emplacements de spawn possibles. Interagissez avec l'âme égarée de mouton pour obtenir la forme d'âme."

L["Silithid Soul"] = "Âme de silithide"

L["Snail Soul"] = "Âme d’escargot"
L["Snail Soul Guide"] = "Tankez le Sous-chef Xy’pro avec au moins 3 autres mobs jusqu'à ce qu'il obtienne le buff |T465877:0|t |cFFFFFFFFContrôle de la sécurité|r, tuez-le, puis utilisez |T465877:0|t |cff14b200Orbe de prise de contrôle de la sécurité|r pour accéder à la cache."

L["Tallstrider Soul"] = "Âme de haut-trotteur"

L["Unknown Guide"] = "La source de cette forme d'âme est inconnue pour le moment."
L["Torghast 9.2 Soulshape Guide"] = "Cette âme peut être libérée pendant une exploration de Tourment de niveau 12 ou plus."

-- Tooltips on maps
L["Spectral Feed Tooltip"] = "Les cérales spectrales sont un sac de grain luisant bleu posé sur le sol, qui réapparaît toutes les 1 à 2 heures. En le cliquant, vous obtenez l'objet dans vos sacs, qui dure 10 minutes et est consommé à l'utilisation."
L["Olea Manu Tooltip"] = "Pour accéder à Oléa Manu, vous devez débloquer |T4238929:0|t |cFFFFFFFFCompréhension altonienne|r et terminer la série de quêtes |A:smallquestbang:16:16|a|cFFFFFFFFDe Jiro à héros|r."
L["Shrouded Cypher Cache Tooltip"] = "Activez |T134442:0|t |cFFFFFFFFPocopoc perspicace|r tout en portant une pièce d'équipement cryptique avec |cFFFFFFFFDénicheur de trésors|r pour voir les caches."
L["High Value Cache Tooltip"] = "La cache peut être déverrouillée par un jour avec une |T465877:0|t |cff14b200Orbe de prise de contrôle de la sécurité|r, obtenue sur le Sous-chef Xy’pro.|n|nTous les joueurs du raid peuvent loot la cache indépendamment de qui l'a ouverte."
L["Taskmaster Xy'pro Tooltip"] = "Donne une |T465877:0|t |cff14b200Orbe de prise de contrôle de la sécurité|r losqu'il est tué avec le buff |T465877:0|t |cFFFFFFFFContrôle de la sécurité|r buff.|n|nPour chaque mob additionnel autour de lui, Xy'pro gagne une charge de |T135740:0|t |cFFFFFFFFSynergie|r. A 3 charges, il gagne |T465877:0|t |cFFFFFFFFContrôle de la sécurité|r."
