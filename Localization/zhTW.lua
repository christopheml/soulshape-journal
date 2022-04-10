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
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "zhTW", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "靈魂幻體"
L["COUNT_LABEL"] = "總數"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "此靈魂幻體無法經由插件自動偵測"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "如你已經擁有，點擊圖標 %s 來手動標記為已收藏。"
L["WARNING_NOT_NIGHT_FAE"] = "你現在並非暗夜妖精的成員，不能收集新的靈魂幻體。"
L["Available since"] = "新增於"
L["Soulshape Journal"] = "靈魂幻體手冊" -- Addon title, you may translate it but it's not necessary
L["BLIZZARD_MAP_PIN_TOOLTIP"] = "<按下Ctrl + 滑鼠左鍵可新增一個指向此座標的地圖標記>"
L["TOMTOM_WAYPOINT_TOOLTIP"] = "<按下Shift + 滑鼠左鍵可新增一個指向此座標的 TomTom 路徑點>"

-- Labels
L["Loot"] = "掉落"
L["Quest"] = "任務"
L["Campaign"] = "戰役"
L["World Event"] = "世界事件"
L["World Quest"] = "世界任務"
L["NPC"] = "目標"
L["Region"] = "區域"
L["Cost"] = "費用"
L["Faction"] = "陣營"
L["Profession"] = "專業技能"
L["Covenant Feature"] = "誓盟特色"
L["Difficulty"] = "難度"
L["Coordinates"] = "坐標"
L["Renown"] = "名望"
L["Spell"] = "法術"
L["Vendor"] = "商人"

-- Zone Names
L["The Adamant Vaults"] = "不滅寶庫"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "佐司特的惡意"
L["Mending a Broken Hart"] = "治療詛咒"
L["The Power of Elune"] = "伊露恩之力"
L["Night Warrior's Curse"] = "黑夜戰士的詛咒"
L["The Power of Night"] = "黑夜之力"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "林地看守者的獎賞"
L["Queen's Conservatory Cache"] = "女王栽培園的寶箱"
L["War Chest of the Wild Hunt"] = "曠野獵者戰爭寶箱"
L["Wild Hunt Supplies"] = "曠野獵者補給品"
L["Synvir Lockbox"] = "鋅維爾帶鎖箱"
L["Stygian Lockbox"] = "冥魄帶鎖箱"
L["Riftbound Cache"] = "隙縛寶箱"
L["Wildseed Root Grain"] = "野性種子根粒"
L["Repaired Riftkey"] = "修復的裂隙鑰匙"
L["Spectral Feed"] = "幽靈雞飼料"
L["Lost Comb"] = "失落的蜂巢"
L["Shrouded Cypher Cache"] = "隱蔽的暗語寶箱"
L["Enlightened Broker Supplies"] = "受啟迪的仲介者物資"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "失落的靈魂"
L["Ma'oh"] = "茂歐"
L["Sparkle"] = "火花"
L["Aithlyn"] = "艾瑟琳"
L["Liawyn"] = "莉亞溫"
L["The Grand Menagerie"] = "大展示廳"
L["Master Clerk Salorn"] = "首席營業員沙洛恩"
L["Lady Sylvanas Windrunner"] = "希瓦娜斯‧風行者女士"
L["Mueh'Zala"] = "繆薩拉"
L["Mistcaller"] = "喚霧者"
L["Cortinarius"] = "寇提納留斯"
L["Sire Denathrius"] = "戴納瑟斯王"
L["Skuld Vit"] = "斯寇德‧維特"
L["So'leah"] = "索利亞"
L["Valfir the Unrelenting"] = "『冷酷』瓦菲爾"
L["Spindlenose"] = "軸鼻"
L["Shopkeeper"] = "店員"
L["Mystic Rainbowhorn"] = "神秘虹角"
L["Olea Manu"] = "歐利亞瑪努"
L["Shifting Stargorger"] = "變異吞星者"
L["Prototype Pantheon"] = "原型萬神殿"
L["The Jailer"] = "閻獄之主"
L["Taskmaster Xy'pro"] = "監工希普羅"

-- Others
L["Burning Crusade Timewalking"] = "燃燒的遠征時光漫遊"
L["Wrath of the Lich King Timewalking"] = "巫妖王之怒時光漫遊"
L["Cataclysm Timewalking"] = "浩劫與重生時光漫遊"
L["Mists of Pandaria Timewalking"] = "潘達利亞之謎時光漫遊"
L["Warlords of Draenor Timewalking"] = "德拉諾之霸時光漫遊"
L["Legion Timewalking"] = "軍臨天下時光漫遊"
L["Pet Battle"] = "寵物對戰"
L["Shadowlands World Bosses"] = "暗影之境世界首領"
L["Queen's Conservatory"] = "女王的栽培園"
L["Mythic+ dungeons"] = "傳奇鑰石地城"
L["Night Fae dailies"] = "暗夜妖精每日任務"
L["Mushroom Network"] = "蘑菇網路"
L["Marasmius"] = "瑪拉茲莫斯"
L["Paragon reward."] = "聲望巔峰獎勵。"
L["Soulshape"] = "靈魂幻體"
L["Crittershape"] = "小動物型態"
L["Pilgrim's Bounty"] = "旅人豐年祭"
L["Covenant Callings reward chests"] = "誓盟使命任務獎勵寶箱"
L["High Value Cache"] = "高價值儲物箱"

L["Normal"] = "普通"
L["Heroic"] = "英雄"
L["Mythic"] = "傳奇"
L["Hardmode"] = "困難模式"
L["Any"] = "任意"

-- Database
L["Alpaca Soul"] = "羊駝靈魂"
L["Ardenmoth Soul"] = "亞登蛾靈魂"

L["Boar Soul"] = "野豬靈魂"
L["Boar Soul Guide"] = "任何德拉諾之霸時光漫遊地城的尾王掉落。"

L["Bunny Soul"] = "兔子靈魂"
L["Bunny Soul Guide"] = "戰寵世界任務可能出現的獎勵之一。"

L["Cat Soul"] = "貓靈魂"
L["Cat Soul Guide"] = "出生點在亞登曠野的參天巨木頂端（夢歌沼地、爍瀑盆地、特納瓦勒、冬日窪地、利爪之緣)。對其輸入/soothe 來獲取。"

L["Cat Soul (Well Fed)"] = "貓靈魂（阿嬤餵的）"
L["Cat Soul (Well Fed) Guide"] = "解鎖貓靈魂後始可取得。首先取得幽靈雞飼料，接著前往森林之心，有隻叫茂歐的靈魂貓睡在通往女王栽培園的傳送點附近的籃子裡。\n對其輸入/meow （牠會告訴你他餓了），然後餵牠靈魂雞飼料。你將立即解鎖外觀選項而無須繳回任務道具。"

L["Chicken Soul"] = "雞靈魂"
L["Chicken Soul Guide"] = "首先取得靈魂雞飼料，接著對靈魂雞輸入/chicken，之後餵牠靈魂雞飼料。"

L["Cloud Serpent Soul"] = "雲蛟靈魂"
L["Cloud Serpent Soul Guide"] = "任何潘達利亞之謎時光漫遊地城的尾王掉落。"

L["Cobra Soul"] = "眼鏡蛇靈魂"
L["Cobra Soul Guide"] = "競技場或積分戰場勝利時機率獲取。"

L["Corgi Soul"] = "柯基犬靈魂"
L["Corgi Soul Guide"] = "有隻叫火花的靈魂柯基犬在森林之心走動。對其輸入/pet，你將立刻解鎖外觀選項而無須繳回任務道具。"

L["Crane Soul"] = "羽鶴靈魂"
L["Cricket Soul"] = "蟋蟀靈魂"
L["Direhorn Soul"] = "恐角龍靈魂"
L["Eagle Soul"] = "飛鷹靈魂"
L["Equine Soul"] = "駿馬靈魂"

L["Frog Soul"] = "青蛙靈魂"
L["Frog Soul Guide"] = "可於任何誓盟所在地圖的水域取得。"

L["Goat Soul"] = "山羊靈魂"
L["Goat Soul Guide"] = "從任何地區的使命任務獎勵寶箱掉落，不限於亞登曠野。"

L["Gryphon Soul"] = "獅鷲獸靈魂"
L["Gryphon Soul Guide"] = "亂鬥、競技場、隨機戰場、積分戰場獲勝時機率取得。"

L["Gulper Soul"] = "大嘴蟾靈魂"
L["Gulper Soul Guide"] = "不羈魂靈 + 一個%s"

L["Hippo Soul"] = "河馬靈魂"
L["Hippo Soul Guide"] = "暗夜妖精進攻戰的獎勵。"

L["Hippogryph Soul"] = "角鷹獸靈魂"

L["Hyena Soul"] = "土狼靈魂"
L["Hyena Soul Guide"] = "完成任何層數的鑰匙後機率掉落。"

L["Jormungar Soul"] = "蟄猛巨蟲靈魂"
L["Jormungar Soul Guide"] = "任何巫妖王之怒時光漫遊地城的尾王掉落。"

L["Kodo Soul"] = "科多獸靈魂"
L["Kodo Soul Guide"] = "任何浩劫與重生時光漫遊地城的尾王掉落。"

L["Leonine Soul"] = "雄獅靈魂"
L["Lupine Soul"] = "孤狼靈魂"
L["Mammoth Soul"] = "長毛象靈魂"

L["Moose Soul"] = "麋鹿靈魂"
L["Moose Soul Guide"] = "你必須擊敗過星湖露天劇場七種稀有當中的五種。"

L["Otter Soul"] = "水獺靈魂"
L["Otter Soul Guide"] = "出生點在英雄之陵底下的湖（重生時間一小時）。對其輸入/hug 來獲得任務道具。"

L["Owl Soul"] = "貓頭鷹靈魂"
L["Owl Soul Guide"] = "任何軍臨天下時光漫遊地城的尾王掉落。"

L["Owlcat Soul"] = "梟羽獸靈魂"
L["Porcupine Soul"] = "豪豬靈魂"
L["Prairie Dog Soul"] = "草原土撥鼠靈魂"
L["Ram Soul"] = "大角羊靈魂"
L["Raptor Soul"] = "迅猛龍靈魂"

L["Rat Soul"] = "老鼠靈魂"
L["Rat Soul Guide"] = "當他發送悄悄話時，以表情指令/yes或/nod回應他以獲取查看與購買商品的權利。"

L["Runestag Soul"] = "符文雄鹿靈魂"
L["Runestag Soul Guide"] = "出生點在亞登曠野的東北方。"

L["Saurid Soul"] = "羽冠龍靈魂"
L["Saurid Soul Guide"] = "洞穴裡面，點選洞穴深處的垃圾堆並輸入/bow。"

L["Saurolisk Soul"] = "尖角蜥靈魂"
L["Saurolisk Hatchling Soul"] = "尖角幼蜥靈魂"
L["Shadowstalker Soul"] = "巡影者靈魂"

L["Shoveltusk Soul"] = "鍬牙靈魂"
L["Shoveltusk Soul Guide"] = "任何PvP亂鬥獲勝時機率取得。"

L["Shrieker Soul"] = "尖嘯者靈魂"
L["Snake Soul"] = "蛇靈魂"
L["Snapper Soul"] = "鉗嘴龜靈魂"

L["Spider Soul"] = "蜘蛛靈魂"
L["Spider Soul Guide"] = "用%s進入裂隙傳送門，裡面每天都有四個寶箱分布於隨機地點。"

L["Sporebat Soul"] = "孢子蝙蝠靈魂"
L["Sporebat Soul Guide"] = "任何燃燒的遠征時光漫遊地城的尾王掉落。"

L["Squirrel Soul"] = "松鼠之魂"
L["Squirrel Soul Guide"] = "你的第一個小動物型態，鳴謝丘發的慷慨餽贈！"

L["Stag Soul"] = "雄鹿靈魂"
L["Stag Soul Guide"] = "科西亞由暗夜妖精陣營發布的每日任務可能的獎勵之一。"

L["Tiger Soul"] = "猛虎靈魂"

L["Turkey Soul"] = "火雞靈魂"
L["Turkey Soul Guide"] = "前往陣營主城，找到旅人豐年祭餐桌。\n吃下食物直到你獲得五層食物增益，接著換位置繼續吃直到你獲得靈魂幻體為止。"

L["Ursine Soul"] = "巨熊靈魂"
L["Veilwing Soul"] = "幕翼靈魂"

L["Vulpine Soul"] = "狐狸靈魂"
L["Vulpine Soul Guide"] = "你最初獲得的靈魂！"

L["Wolfhawk Soul"] = "狼鷹靈魂"
L["Wolfhawk Soul Guide"] = "使用靈魂幻體來穿過屏障。"

L["Wyvern Soul"] = "雙足飛龍靈魂"
L["Yak Soul"] = "氂牛靈魂"

-- 9.2 Soulshapes

L["Armadillo Soul"] = "犰狳靈魂"
L["Bat Soul"] = "蝙蝠靈魂"

L["Bee Soul"] = "蜜蜂靈魂"
L["Bee Soul Guide"] = "靈魂型態的小蜂巢坐落於大蜂巢的頂端。需要解鎖飛行。"

L["Brutosaur Soul"] = "雷龍靈魂"
L["Cervid Soul"] = "原鹿靈魂"
L["Dragonhawk Soul"] = "龍鷹靈魂"
L["Elekk Soul"] = "伊萊克靈魂"

L["Gromit Soul"] = "哥羅米靈魂"
L["Gromit Soul Guide"] = "要想看到寶箱，你得穿上帶有|cFFFFFFFF尋寶者|r效果的暗語裝備，接著點擊波克波可要求它「留意值得注意的物體」，以獲得|T134442:0|t |cFFFFFFFF感知型波克波可|r的增益效果。"

L["Penguin Soul"] = "企鵝靈魂"
L["Penguin Soul Guide"] = "金屬巨球頂端。點擊企鵝樣貌的失落靈魂以獲取之。需要解鎖飛行。"

L["Pig Soul"] = "豬靈魂"
L["Ray Soul"] = "魟魚靈魂"
L["Scorpid Soul"] = "毒蠍靈魂"

L["Sheep Soul"] = "綿羊靈魂"
L["Sheep Soul Guide"] = "多個重生點。點擊綿羊外貌的失落靈魂以獲取之。"

L["Silithid Soul"] = "異種蠍靈魂"

L["Snail Soul"] = "蝸牛靈魂"
L["Snail Soul Guide"] = "同時拉住監工希莫斯與至少三隻其它小怪，直到監工身上出現|T465877:0|t |cFFFFFFFF防護撤銷|r的增益效果，將之擊殺，然後使用撿到的|T465877:0|t |cff14b200防護撤銷球體|r來解鎖寶箱。"

L["Tallstrider Soul"] = "陸行鳥靈魂"

L["Unknown Guide"] = "獲取管道目前未知。"
L["Torghast 9.2 Soulshape Guide"] = "托迦司難度 12 或更高的區域，樓層內機率出現，援救後取得。"

-- Tooltips on maps
L["Spectral Feed Tooltip"] = "幽靈雞飼料是地上一袋散發藍光的穀物，每一到兩小時重生。點擊後會出現在背包裡，且持續十分鐘，使用後消耗。"
L["Olea Manu Tooltip"] = "為了與歐利亞瑪努交易，你得研究完 |T4238929:0|t |cFFFFFFFF低音語理解|r 且完成|A:smallquestbang:16:16|a|cFFFFFFFF機諾化身英雄|r 的任務線。"
L["Shrouded Cypher Cache Tooltip"] = "啟動波克波可的 |T134442:0|t |cFFFFFFFF感知型波克波可|r 功能並穿著帶有 |cFFFFFFFF尋寶者|r 效果的暗語裝備來看見隱藏的寶箱。"
L["High Value Cache Tooltip"] = "儲物箱可經由拾獲了 |T465877:0|t |cff14b200防護撤銷球體|r 的玩家來解鎖，掉落自監工希普羅。|n|n 所有身處團隊副本的玩家，在儲物箱解鎖之後，均能拾取寶箱。"
L["Taskmaster Xy'pro Tooltip"] = "於身上存在 |T465877:0|t |cFFFFFFFF防護撤銷|r 的增益效果時將掉落 |T465877:0|t |cff14b200防護撤銷球體|r 。|n|n 每有一隻小怪靠近他，希普羅便會獲得一層 |T135740:0|t |cFFFFFFFF協力|r 的增益效果。堆疊至少三層後他會追加 |T465877:0|t |cFFFFFFFF防護撤銷|r 的增益效果。"
