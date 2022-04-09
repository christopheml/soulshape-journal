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

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "zhCN", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "灵魂变形"
L["COUNT_LABEL"] = "总计"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "此灵魂变形不能被自动侦测"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "如果您已经拥有%s，请点击以将其标记为已收集。"
L["WARNING_NOT_NIGHT_FAE"] = "你不是法夜成员，\n现在你不能收集新的灵魂变形。"
L["Available since"] = "来自"
L["Soulshape Journal"] = "灵魂变形手册" -- Addon title, you may translate it but it's not necessary
L["BLIZZARD_MAP_PIN_TOOLTIP"] = "<Ctrl+点击添加此位置的地图别针>"
L["TOMTOM_WAYPOINT_TOOLTIP"] = "<Shift+点击添加此位置 TomTom 路径点>"

-- Labels
L["Loot"] = "拾取"
L["Quest"] = "任务"
L["Campaign"] = "战役"
L["World Event"] = "世界事件"
L["World Quest"] = "世界任务"
L["NPC"] = "NPC"
L["Region"] = "地区"
L["Cost"] = "花费"
L["Faction"] = "阵营"
L["Profession"] = "专业"
L["Covenant Feature"] = "盟约特性"
L["Difficulty"] = "难度"
L["Coordinates"] = "坐标"
L["Renown"] = "名望"
L["Spell"] = "法术"
L["Vendor"] = "商人"

-- Zone Names
L["Shadowlands"] = "暗影界"
L["Ardenweald"] = "炽蓝仙野"
L["Bastion"] = "晋升堡垒"
L["Revendreth"] = "雷文德斯"
L["Maldraxxus"] = "玛卓克萨斯"
L["Oribos"] = "奥利波斯"
L["The Maw"] = "噬渊"
L["Torghast"] = "托加斯特"
L["The Adamant Vaults"] = "坚钢宝库"
L["Korthia"] = "刻希亚"
L["De Other Side"] = "彼界"
L["Mists of Tirna Scithe"] = "塞兹仙林的迷雾"
L["Tazavesh, the Veiled Market"] = "塔扎维什，帷纱集市"
L["Castle Nathria"] = "纳斯利亚堡"
L["Sanctum of Domination"] = "统御圣所"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "德鲁“死”特"
L["Mending a Broken Hart"] = "我鹿依旧"
L["The Power of Elune"] = "艾露恩的力量"
L["Night Warrior's Curse"] = "月夜战神的诅咒"
L["The Power of Night"] = "魅夜之力"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "林地守卫者的奖赏"
L["Queen's Conservatory Cache"] = "女王的温室宝箱"
L["War Chest of the Wild Hunt"] = "荒猎团的战争宝箱"
L["Wild Hunt Supplies"] = "荒猎团补给品"
L["Synvir Lockbox"] = "罪钒保险箱"
L["Stygian Lockbox"] = "冥河保险箱"
L["Riftbound Cache"] = "隙缚宝箱"
L["Wildseed Root Grain"] = "灵种根粒"
L["Repaired Riftkey"] = "修复的裂隙钥匙"
L["Spectral Feed"] = "幽魂饲料"
L["Lost Comb"] = "失落蜂巢"
L["Shrouded Cypher Cache"] = "氤氲密文宝箱"
L["Enlightened Broker Supplies"] = "掮灵开悟者补给品"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "失落之魂"
L["Ma'oh"] = "玛欧"
L["Sparkle"] = "耀星"
L["Aithlyn"] = "艾丝琳"
L["Liawyn"] = "莉亚雯"
L["The Grand Menagerie"] = "卖品会"
L["Master Clerk Salorn"] = "文书大师萨洛恩"
L["Lady Sylvanas Windrunner"] = "希尔瓦娜斯·风行者"
L["Mueh'Zala"] = "穆厄扎拉"
L["Mistcaller"] = "唤雾者"
L["Cortinarius"] = "柯迪纳留斯"
L["Sire Denathrius"] = "德纳修斯大帝"
L["Skuld Vit"] = "斯库尔德·维特"
L["So'leah"] = "索·莉亚"
L["Valfir the Unrelenting"] = "冷酷的瓦尔菲尔"
L["Spindlenose"] = "纺鼻"
L["Shopkeeper"] = "商店老板"
L["Mystic Rainbowhorn"] = "神秘的虹角"
L["Olea Manu"] = "奥利·玛努"
L["Shifting Stargorger"] = "变换的吞星者"
L["Prototype Pantheon"] = "死亡万神殿原型体"
L["The Jailer"] = "典狱长"
L["Taskmaster Xy'pro"] = "监工赛·普洛"

-- Others
L["Burning Crusade Timewalking"] = "燃烧的远征时空漫游"
L["Wrath of the Lich King Timewalking"] = "巫妖王之怒时空漫游"
L["Cataclysm Timewalking"] = "大地的裂变时空漫游"
L["Mists of Pandaria Timewalking"] = "熊猫人之谜时空漫游"
L["Warlords of Draenor Timewalking"] = "德拉诺之王时空漫游"
L["Legion Timewalking"] = "军团再临时空漫游"
L["Pet Battle"] = "宠物对战"
L["Shadowlands World Bosses"] = "暗影界世界首领"
L["Queen's Conservatory"] = "女王的温室"
L["Mythic+ dungeons"] = "史诗钥石地下城"
L["Night Fae dailies"] = "法夜日常"
L["Mushroom Network"] = "蘑网"
L["Marasmius"] = "玛拉斯缪斯"
L["Paragon reward."] = "巅峰奖励。"
L["Soulshape"] = "灵魂变形"
L["Crittershape"] = "小动物变形"
L["Pilgrim's Bounty"] = "感恩节的馈赠"
L["Covenant Callings reward chests"] = "盟约使命奖励宝箱"
L["High Value Cache"] = "价值连城的宝箱"

L["Normal"] = "普通难度"
L["Heroic"] = "英雄难度"
L["Mythic"] = "史诗难度"
L["Hardmode"] = "困难模式"
L["Any"] = "任意"

-- Database
L["Alpaca Soul"] = "羊驼之魂"
L["Ardenmoth Soul"] = "炽蓝蛾之魂"

L["Boar Soul"] = "野猪之魂"
L["Boar Soul Guide"] = "可从德拉诺之王时空漫游地下城任意首领掉落。"

L["Bunny Soul"] = "兔子之魂"
L["Bunny Soul Guide"] = "从宠物对战世界任务中可能获得奖励。"

L["Cat Soul"] = "猫之魂"
L["Cat Soul Guide"] = "猫之魂可能在炽蓝仙野最高的巨树（梦歌沼泽、闪瀑盆地、瓦尔仙林、冬日林谷或利爪之缘）的树干顶部刷新。对它使用 /安抚 或 /soothe 来获得灵魂变形。"

L["Cat Soul (Well Fed)"] = "吃饱的猫之魂"
L["Cat Soul (Well Fed) Guide"] = "解锁猫灵魂变形后即可使用。首先从雷文德斯暗湾镇坐标 63.75, 61.69 的马厩背后拾取幽魂饲料（1-2小时左右刷新，最多可同时被三名法夜玩家拾取，物品持续10分钟），然后返回森林之心，玛欧是一个睡在女王的温室入口附近篮子里的灵魂猫。\n使用 /喵 或 /meow/ 叫它（它会告诉你它饿了）然后喂它幽魂饲料。将立即收到灵魂变形（无需交任务）。"

L["Chicken Soul"] = "鸡之魂"
L["Chicken Soul Guide"] = "首先从雷文德斯暗湾镇坐标 63.75, 61.69 的马厩背后拾取幽魂饲料（1-2小时左右刷新，最多可同时被三名法夜玩家拾取，物品持续10分钟），然后找到鸡形态的失落之魂对其使用 /小鸡 或 /chicken 表情，然后对其使用包中的幽魂饲料即可获得。"

L["Cloud Serpent Soul"] = "云端翔龙之魂"
L["Cloud Serpent Soul Guide"] = "可从熊猫人之谜时空漫游地下城任意首领掉落。"

L["Cobra Soul"] = "眼镜蛇之魂"
L["Cobra Soul Guide"] = "在竞技场或评级战场获胜后可能获得奖励。"

L["Corgi Soul"] = "柯基之魂"
L["Corgi Soul Guide"] = "耀星是一只在森林之心行走的柯基之魂。使用 /pet 表情安抚它，你会立即收到灵魂变形（无需交任务）。"

L["Crane Soul"] = "仙鹤之魂"
L["Cricket Soul"] = "蟋蟀之魂"
L["Direhorn Soul"] = "恐角龙之魂"
L["Eagle Soul"] = "老鹰之魂"
L["Equine Soul"] = "角马之魂"

L["Frog Soul"] = "青蛙之魂"
L["Frog Soul Guide"] = "任意盟约地区可用。"

L["Goat Soul"] = "山羊之魂"
L["Goat Soul Guide"] = "可以从任意盟约使命宝箱中掉落，并不只限法夜宝箱。"

L["Gryphon Soul"] = "狮鹫之魂"
L["Gryphon Soul Guide"] = "在练习赛、竞技场、随机战场，评级战场或人机对决乱斗中获胜时可能会获得奖励。"

L["Gulper Soul"] = "巨口蟾之魂"
L["Gulper Soul Guide"] = "可以从任何品质的精魂获得，但只用一个%s。"

L["Hippo Soul"] = "河马之魂"
L["Hippo Soul Guide"] = "法夜突袭奖励。"

L["Hippogryph Soul"] = "角鹰兽之魂"

L["Hyena Soul"] = "土狼之魂"
L["Hyena Soul Guide"] = "任意钥石等级掉落。"

L["Jormungar Soul"] = "冰虫之魂"
L["Jormungar Soul Guide"] = "可从巫妖王之怒时空漫游地下城任意首领掉落。"

L["Kodo Soul"] = "科多兽之魂"
L["Kodo Soul Guide"] = "可从大地的裂变时空漫游地下城任意首领掉落。"

L["Leonine Soul"] = "狮子之魂"
L["Lupine Soul"] = "狼之魂"
L["Mammoth Soul"] = "猛犸象之魂"

L["Moose Soul"] = "驼鹿之魂"
L["Moose Soul Guide"] = "必须击败泊星剧场7个之中的5个不同的稀有首领。"

L["Otter Soul"] = "水獭之魂"
L["Otter Soul Guide"] = "水獭之魂可能刷新在位于英雄之眠下面湖中（大概60分钟刷新时间）。对其使用 /拥抱 或 /hug 表情获得灵魂变形任务物品。"

L["Owl Soul"] = "猫头鹰之魂"
L["Owl Soul Guide"] = "可从军团再临时空漫游地下城任意首领掉落。"

L["Owlcat Soul"] = "鹰头猫之魂"
L["Porcupine Soul"] = "箭猪之魂"
L["Prairie Dog Soul"] = "草原土拨鼠之魂"
L["Ram Soul"] = "公羊之魂"
L["Raptor Soul"] = "迅猛龙之魂"

L["Rat Soul"] = "老鼠之魂"
L["Rat Soul Guide"] = "在其对你说悄悄话时，向他回应表情 /yes 或者 /nod 可获得购买商品的权利。"

L["Runestag Soul"] = "符文牡鹿之魂"
L["Runestag Soul Guide"] = "刷新在炽蓝仙野东北方。使用各处可能刷新的符文牡鹿的巨角召唤该稀有。"

L["Saurid Soul"] = "细颚龙之魂"
L["Saurid Soul Guide"] = "洞穴中。洞穴后面对神秘的垃圾堆目标使用 /鞠躬 或 /bow 表情。"

L["Saurolisk Soul"] = "巨蜥之魂"
L["Saurolisk Hatchling Soul"] = "巨蜥幼体之魂"
L["Shadowstalker Soul"] = "暗影追猎者之魂"

L["Shoveltusk Soul"] = "铲齿鹿之魂"
L["Shoveltusk Soul Guide"] = "任意 PvP 乱斗胜利后可能奖励。"

L["Shrieker Soul"] = "尖啸者之魂"
L["Snake Soul"] = "蛇之魂"
L["Snapper Soul"] = "龙龟之魂"

L["Spider Soul"] = "蜘蛛之魂"
L["Spider Soul Guide"] = "使用%s后穿过裂隙传送门。每天这里有4个宝箱随机位置刷新。"

L["Sporebat Soul"] = "孢子蝠之魂"
L["Sporebat Soul Guide"] = "可从燃烧的远征时空漫游地下城任意首领掉落。"

L["Squirrel Soul"] = "松鼠之魂"
L["Squirrel Soul Guide"] = "最先收藏的小动物变形，赞美丘法！"

L["Stag Soul"] = "牡鹿之魂"
L["Stag Soul Guide"] = "每天可以在刻希亚任意法夜奖励随机提供。"

L["Tiger Soul"] = "老虎之魂"

L["Turkey Soul"] = "火鸡之魂"
L["Turkey Soul Guide"] = "到阵营首都，找到感恩节的馈赠桌子。\n进食每种食物直到获得5层食物增益，然后继续进食并每次都继续吃东西和换座位，直到你得到灵魂变形。"

L["Ursine Soul"] = "熊之魂"
L["Veilwing Soul"] = "帷翼之魂"

L["Vulpine Soul"] = "狡狐之魂"
L["Vulpine Soul Guide"] = "最先收集的灵魂变形！"

L["Wolfhawk Soul"] = "狼鹰之魂"
L["Wolfhawk Soul Guide"] = "使用灵魂变形穿过屏障。"

L["Wyvern Soul"] = "双足飞龙之魂"
L["Yak Soul"] = "牦牛之魂"

-- 9.2 Soulshapes

L["Armadillo Soul"] = "犰狳之魂"
L["Bat Soul"] = "蝙蝠之魂"

L["Bee Soul"] = "蜜蜂之魂"
L["Bee Soul Guide"] = "灵魂形状的蜂巢位于顶部。需要飞行。"

L["Brutosaur Soul"] = "雷龙之魂 "
L["Cervid Soul"] = "元鹿之魂"
L["Dragonhawk Soul"] = "龙鹰之魂"
L["Elekk Soul"] = "雷象之魂"

L["Gromit Soul"] = "跃足兽之魂"
L["Gromit Soul Guide"] = "要看到宝箱，需要装备一个有 |cFFFFFFFF寻宝者|r 的密文装并要求波可波克给予 “寻找值得注意的物品” 获得 |T134442:0|t |cFFFFFFFF洞察的波可波克|r 增益。"

L["Penguin Soul"] = "企鹅之魂"
L["Penguin Soul Guide"] = "在金属球的顶部。与企鹅失落之魂互动以获得灵魂变形。需要飞行。"

L["Pig Soul"] = "猪之魂"
L["Ray Soul"] = "鳐鱼之魂"
L["Scorpid Soul"] = "蝎子之魂"

L["Sheep Soul"] = "绵羊之魂"
L["Sheep Soul Guide"] = "多个刷新位置。与绵羊失落之魂互动以获得灵魂变形。需要飞行。"

L["Silithid Soul"] = "异种蝎之魂"

L["Snail Soul"] = "蜗牛之魂"
L["Snail Soul Guide"] = "坦克监工赛·普洛和至少3个其他小怪一起直到他获得 |T465877:0|t |cFFFFFFFF安保超控|r 增益，击杀他后使用 |T465877:0|t |cff14b200安保超控宝珠|r 打开宝箱。"

L["Tallstrider Soul"] = "陆行鸟之魂"

L["Unknown Guide"] = "此灵魂变形来源当前未知。"
L["Torghast 9.2 Soulshape Guide"] = "此灵魂可以在托加斯特等级12或以上期间解救。"

-- Tooltips on maps
L["Spectral Feed Tooltip"] = "幽魂饲料是地上发光的蓝色谷物袋，每1-2小时刷新一次。点击它后，会在包中获得该物品，持续时间10分钟，在使用时消耗。"
L["Olea Manu Tooltip"] = "访问奥利·玛努，需要解锁 |T4238929:0|t |cFFFFFFFF低音语理解|r 并完成 |A:smallquestbang:16:16|a|cFFFFFFFF小机若，大英雄|r 任务线。"
L["Shrouded Cypher Cache Tooltip"] = "激活波可波克 |T134442:0|t |cFFFFFFFF洞察的波可波克|r 增益并装备一件有 |cFFFFFFFF寻宝者|r 的密文装备可以看到宝箱。"
L["High Value Cache Tooltip"] = "此宝箱可以被有 |T465877:0|t |cff14b200安保超控宝珠|r 玩家解锁，由监工赛·普洛掉落。|n|n无论是谁打开了宝箱，团队中的所有玩家都可以拾取宝箱。"
L["Taskmaster Xy'pro Tooltip"] = "掉落 |T465877:0|t |cff14b200安保超控宝珠|r 需要击杀时有 |T465877:0|t |cFFFFFFFFS安保超控|r 增益。|n|n对于他周围的每一个额外的小怪，监工赛·普洛获得一层 |T135740:0|t |cFFFFFFFF同心协力|r。3层时他获得 |T465877:0|t |cFFFFFFFF安保超控|r。"
