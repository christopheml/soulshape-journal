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

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "ruRU", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "Облики души"
L["COUNT_LABEL"] = "Всего"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "Этот облик души не может быть обнаружен автоматически"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "Щелкните, чтобы отметить %s как собранный, если он у вас уже есть."
L["WARNING_NOT_NIGHT_FAE"] = "Ты не член Ночного народца,\nв настоящее время вы не можете собирать новые облики души."

-- Labels
L["Loot"] = "Добыча"
L["Quest"] = "Задание"
L["Campaign"] = "Кампания"
L["World Event"] = "Игровое событие"
L["World Quest"] = "Локальное задание"
L["NPC"] = "НПС"
L["Region"] = "Локация"
L["Cost"] = "Цена"
L["Faction"] = "Фракция"
L["Profession"] = "Профессия"
L["Covenant Feature"] = "Особенность ковенанта"
L["Difficulty"] = "Сложность"
L["Coordinates"] = "Координаты"
L["Renown"] = "Известность"
L["Spell"] = "Заклинание"
L["Vendor"] = "Торговец"

-- Zone Names
L["Shadowlands"] = "Темные земли"
L["Ardenweald"] = "Арденвельд"
L["Bastion"] = "Бастион"
L["Revendreth"] = "Ревендрет"
L["Maldraxxus"] = "Малдраксус"
L["Oribos"] = "Орибос"
L["The Maw"] = "Утроба"
L["Torghast"] = "Торгаст"
L["The Adamant Vaults"] = "Адамантовые хранилища"
L["Korthia"] = "Кортия"
L["De Other Side"] = "Та Сторона"
L["Mists of Tirna Scithe"] = "Туманы Тирна Скитта"
L["Tazavesh, the Veiled Market"] = "Тайный рынок Тазавеш"
L["Castle Nathria"] = "Замок Нафрия"
L["Sanctum of Domination"] = "Святилище Господства"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "Друсты и пепел"
L["Mending a Broken Hart"] = "Склеить разбитое сердце"
L["The Power of Elune"] = "Сила Элуны"
L["Night Warrior's Curse"] = "Проклятие Ночной Воительницы"
L["The Power of Night"] = "Сила ночи"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "Дар хранителей рощи"
L["Queen's Conservatory Cache"] = "Тайник королевского зимнего сада"
L["War Chest of the Wild Hunt"] = "Трофейный сундук Дикой Охоты"
L["Wild Hunt Supplies"] = "Припасы Дикой Охоты"
L["Synvir Lockbox"] = "Греховировая шкатулка"
L["Stygian Lockbox"] = "Стигийская шкатулка"
L["Riftbound Cache"] = "Тайник Разлома"
L["Wildseed Root Grain"] = "Зерно дикого корня"
L["Repaired Riftkey"] = "Восстановленный ключ Разлома"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "Заблудшая душа"
L["Ma'oh"] = "Ма'о"
L["Sparkle"] = "Искра"
L["Aithlyn"] = "Айтлин"
L["Liawyn"] = "Лиавин"
L["The Grand Menagerie"] = "Большой зверинец"
L["Master Clerk Salorn"] = "Старший служащий Салорн"
L["Lady Sylvanas Windrunner"] = "Леди Сильвана Ветрокрылая"
L["Mueh'Zala"] = "Мве'зала"
L["Mistcaller"] = "Призывательница Туманов"
L["Cortinarius"] = "Паутинник"
L["Sire Denathrius"] = "Сир Денатрий"
L["Skuld Vit"] = "Скульд Вит"
L["So'leah"] = "Со'лея"
L["Valfir the Unrelenting"] = "Валфир Непреклонный"
L["Spindlenose"] = "Веретенос"
L["Shopkeeper"] = "Лавочник"
L["Mystic Rainbowhorn"] = "Таинственный радугорог"

-- Others
L["Burning Crusade Timewalking"] = "Путешествие во времени Burning Crusade"
L["Wrath of the Lich King Timewalking"] = "Путешествие во времени Wrath of the Lich King"
L["Cataclysm Timewalking"] = "Путешествие во времени Cataclysm"
L["Mists of Pandaria Timewalking"] = "Путешествие во времени Mists of Pandaria"
L["Warlords of Draenor Timewalking"] = "Путешествие во времени Warlords of Draenor"
L["Legion Timewalking"] = "Путешествие во времени Legion"
L["Pet Battle"] = "Битва Питомцев"
L["Shadowlands World Bosses"] = "Мировые боссы Темных Земель"
L["Queen's Conservatory"] = "Королевский зимний сад"
L["Mythic+ dungeons"] = "Эпохальные подземелья с ключом"
L["Night Fae dailies"] = "Ежедневные задания Ночного народца"
L["Mushroom Network"] = "Грибная сеть"
L["Marasmius"] = "Чесночник"
L["Paragon reward."] = "Награда идеала."
L["Soulshape"] = "Облик души"
L["Pilgrim's Bounty"] = "Дары странников"

L["Normal or Heroic"] = "Обычная или Героическая"
L["Heroic"] = "Героическая"
L["Hardmode"] = "Сложный Режим"
L["Any"] = "Любая"

-- Database
L["Alpaca Soul"] = "Дух альпаки"
L["Ardenmoth Soul"] = "Дух арденвельдского мотылька"

L["Boar Soul"] = "Дух кабана"
L["Boar Soul Guide"] = "Может выпасть с последнего босса любого подземелья Warlords of Draenor в режиме путешествия во времени."

L["Bunny Soul"] = "Дух кролика"
L["Bunny Soul Guide"] = "Периодическая награда за выполнение локальных заданий по битвам питомцев в этом районе."

L["Cat Soul"] = "Дух кошки"
L["Cat Soul Guide"] = "Душа кошки может появиться на вершине стволов самых высоких деревьев Арденвельда (Роща Песни Сна, Низина Мерцающих Каскадов, Тирна Ваал, Спящая лощина или Урочище Когтя). Используйте команду /утешить, чтобы получить облик души."

L["Cat Soul (Well Fed)"] = "Дух кошки (Сытый кот)"
L["Cat Soul (Well Fed) Guide"] = "Доступно после того, как вы разблокируете облик духа кошки. Сначала получите Призрачный корм, затем возвращайтесь в Сердце леса, Ма'о - это кошачья душа, спящая в корзине возле входа в Королевский зимний сад.\nИспользуйте команду /мяу на него (он скажет, что голоден) затем скормите ему Призрачный корм. Вы получите облик души сразу же (сдача задания не требуется)."

L["Chicken Soul"] = "Дух курицы"
L["Chicken Soul Guide"] = "Сначала получите Призрачный корм, затем примените команду /цып к духу курице и скормите ей Призрачный корм."

L["Cloud Serpent Soul"] = "Дух облачного змея"
L["Cloud Serpent Soul Guide"] = "Может выпасть с последнего босса любого подземелья Mists of Pandaria в режиме путешествия во времени."

L["Cobra Soul"] = "Душа кобры"
L["Cobra Soul Guide"] = "Случайная награда за победу на Арене или Рейтинговом поле боя."

L["Corgi Soul"] = "Душа корги"
L["Corgi Soul Guide"] = "Искра - душа корги, гуляющая по Сердцу леса. Используйте команду /погладить, и вы сразу же получите облик души (сдача задания не требуется)."

L["Crane Soul"] = "Дух журавля"
L["Cricket Soul"] = "Дух сверчка"
L["Direhorn Soul"] = "Душа дикорога"
L["Eagle Soul"] = "Дух орла"
L["Equine Soul"] = "Дух лошади"

L["Frog Soul"] = "Дух лягушки"
L["Frog Soul Guide"] = "Доступно в любой локации ковенантов."

L["Goat Soul"] = "Дух козла"

L["Gryphon Soul"] = "Дух грифона"
L["Gryphon Soul Guide"] = "Случайная награда за победу в стычках, арене, случайном поле боя или рейтинговом поле боя."

L["Gulper Soul"] = "Дух мешкорота"
L["Gulper Soul Guide"] = "Можно получить за духов любого качества, но используйте только один %s."

L["Hippo Soul"] = "Душа бегемота"
L["Hippo Soul Guide"] = "Награда за Атаку Ночного Народца."

L["Hippogryph Soul"] = "Дух гиппогрифа"

L["Hyena Soul"] = "Душа гиены"
L["Hyena Soul Guide"] = "Может упасть на любом уровне."

L["Jormungar Soul"] = "Дух йормунгара"
L["Jormungar Soul Guide"] = "Может выпасть с последнего босса любого подземелья Wrath of the Lich King в режиме путешествия во времени."

L["Kodo Soul"] = "Душа кодо"
L["Kodo Soul Guide"] = "Может выпасть с последнего босса любого подземелья Cataclysm в режиме путешествия во времени."

L["Leonine Soul"] = "Дух льва"
L["Lupine Soul"] = "Дух волка"
L["Mammoth Soul"] = "Душа мамонта"

L["Moose Soul"] = "Дух лося"
L["Moose Soul Guide"] = "У вас должно быть убито как минимум 5 из 7 боссов в амфитеатре."

L["Otter Soul"] = "Дух выдры"
L["Otter Soul Guide"] = "Дух выдры может появиться в озере под Обителью Героев (возрождение 60 минут). Используйте команду /обнять, чтобы получить облик души."

L["Owl Soul"] = "Дух совы"
L["Owl Soul Guide"] = "Может выпасть с последнего босса любого подземелья Legion в режиме путешествия во времени."

L["Owlcat Soul"] = "Дух совокошки"
L["Porcupine Soul"] = "Дух дикобраза"
L["Prairie Dog Soul"] = "Дух луговой собачки"
L["Ram Soul"] = "Дух барана"
L["Raptor Soul"] = "Дух ящера"

L["Rat Soul"] = "Дух крысы"
L["Rat Soul Guide"] = "Когда он шепчет вам, ответьте командой /да или /кивнуть, чтобы получить доступ к его товарам."

L["Runestag Soul"] = "Дух рунического оленя"
L["Runestag Soul Guide"] = "Появляется в северо-восточной части Арденвельда."

L["Saurid Soul"] = "Дух саурида"
L["Saurid Soul Guide"] = "Внутри пещеры. Возьмите в цель кучу мусора в задней части пещеры и используйте команду /поклон."

L["Saurolisk Soul"] = "Душа завролиска"
L["Saurolisk Hatchling Soul"] = "Дух детеныша завролиска"
L["Shadowstalker Soul"] = "Дух тенелова"

L["Shoveltusk Soul"] = "Душа черпорога"
L["Shoveltusk Soul Guide"] = "Случайная награда за победу в PvP-потасовки."

L["Shrieker Soul"] = "Дух визгуна"
L["Snake Soul"] = "Дух змеи"
L["Snapper Soul"] = "Дух крепкохвата"

L["Spider Soul"] = "Душа паука"
L["Spider Soul Guide"] = "Пройдите через портал разлома, используя %s. Каждый день в случайных местах появляются 4 тайника."

L["Sporebat Soul"] = "Дух спороската"
L["Sporebat Soul Guide"] = "Может выпасть с последнего босса любого подземелья Burning Crusade в режиме путешествия во времени."

L["Stag Soul"] = "Дух оленя"
L["Stag Soul Guide"] = "Может быть случайным образом предложен в качестве ежедневной награды за задания Ночного Народца в Кортии."

L["Tiger Soul"] = "Дух тигра"

L["Turkey Soul"] = "Дух индейки"
L["Turkey Soul Guide"] = "Отправляйтесь в столицу фракции и найдите стол Пиршества странников.\nЕшьте каждую еду, пока не получите 5 положительных эффектов, затем продолжайте есть еду и каждый раз меняя места, пока не получите облик души."

L["Ursine Soul"] = "Дух медведя"
L["Veilwing Soul"] = "Дух туманокрыла"

L["Vulpine Soul"] = "Дух лисохвоста"
L["Vulpine Soul Guide"] = "Самый первый облик души в вашей коллекции!"

L["Wolfhawk Soul"] = "Дух звероястреба"
L["Wolfhawk Soul Guide"] = "Вам нужно использовать Облик души, чтобы пересечь барьер."

L["Wyvern Soul"] = "Дух виверны"
L["Yak Soul"] = "Душа яка"
