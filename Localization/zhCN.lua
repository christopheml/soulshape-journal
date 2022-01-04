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

-- UI elements
L["TAB_TITLE"] = "灵魂变形"
L["COUNT_LABEL"] = "共计"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "这种灵魂变形不能被自动检测到"
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "如果你已经拥有了%s请点击标记为已收集."
L["WARNING_NOT_NIGHT_FAE"] = "你不是法夜成员,\n你现在不能收集新的灵魂变形."

-- Labels
L["Loot"] = "拾取"
L["Quest"] = "任务"
L["Campaign"] = "战役"
L["World Event"] = "世界事件"
L["World Quest"] = "世界任务"
L["NPC"] = true
L["Region"] = "地域"
L["Cost"] = "花费"
L["Faction"] = "阵营"
L["Profession"] = "专业"
L["Covenant Feature"] = "盟约特色"
L["Difficulty"] = "难度"
L["Coordinates"] = "坐标"
L["Renown"] = "名望"
L["Spell"] = "法术"
L["Vendor"] = "商人"

-- Zone Names
L["Shadowlands"] = "暗影国度"
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

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "失落之魂"
L["Ma'oh"] = "玛欧"
L["Sparkle"] = "耀星"
L["Aithlyn"] = "艾丝琳"
L["Liawyn"] = "莉亚雯"
L["The Grand Menagerie"] = "通往卖品会的传送门"
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

-- Others
L["Burning Crusade Timewalking"] = "燃烧的远征时光漫游"
L["Wrath of the Lich King Timewalking"] = "巫妖王之怒时光漫游"
L["Cataclysm Timewalking"] = "大地的裂变时光漫游"
L["Mists of Pandaria Timewalking"] = "潘达利亚之谜时光漫游"
L["Warlords of Draenor Timewalking"] = "德拉诺之王时光漫游"
L["Legion Timewalking"] = "军团时光漫游"
L["Pet Battle"] = "小宠物对战"
L["Shadowlands World Bosses"] = "暗影国度世界BOSS"
L["Queen's Conservatory"] = "女王的温室"
L["Mythic+ dungeons"] = "大秘境"
L["Night Fae dailies"] = "法夜日常"
L["Mushroom Network"] = "蘑网"
L["Marasmius"] = "玛拉斯缪斯"
L["Paragon reward."] = "巅峰声望奖励"
L["Soulshape"] = "灵魂变形"
L["Pilgrim's Bounty"] = "感恩节"

L["Normal or Heroic"] = "普通或英雄"
L["Heroic"] = "英雄"
L["Hardmode"] = "困难模式"
L["Any"] = "任何"

-- Database
L["Alpaca Soul"] = "羊驼之魂"
L["Ardenmoth Soul"] = "炽蓝蛾之魂"

L["Boar Soul"] = "野猪之魂"
L["Boar Soul Guide"] = "可以从任何德拉诺之王时光漫游地下城的尾王处掉落."

L["Bunny Soul"] = "兔子之魂"
L["Bunny Soul Guide"] = "暗影国度宠物对战世界任务几率获得."

L["Cat Soul"] = "猫之魂"
L["Cat Soul Guide"] = "炽蓝仙野多处巨树树顶会刷新猫形态的失落之魂(梦歌沼泽, 闪瀑盆地, 瓦尔仙林, 冬日林谷或利爪之缘). 使用/soothe即可获得灵魂变形."

L["Cat Soul (Well Fed)"] = "猫之魂(加肥)"
L["Cat Soul (Well Fed) Guide"] = "一旦你解锁了猫之魂后就可以使用. 首先得到幽魂饲料然后回到森林之心, 玛欧是一只睡在女王温室入口附近篮子里的猫魂.\n对着他/meow(他会告诉你他饿了)然后给他喂食幽魂饲料. 你会立即收到灵魂变形(不需要交出任务)."

L["Chicken Soul"] = "鸡之魂"
L["Chicken Soul Guide"] = "首先获得幽魂饲料, 然后在鸡形态的失落之魂对其使用/chicken, 给它喂食幽魂饲料."

L["Cloud Serpent Soul"] = "云端翔龙之魂"
L["Cloud Serpent Soul Guide"] = "可以从任何潘达利亚之谜时光漫游地下城的尾王处掉落."

L["Cobra Soul"] = "眼镜蛇之魂"
L["Cobra Soul Guide"] = "在竞技场或评级战场中获胜的奖励几率获得."

L["Corgi Soul"] = "柯基之魂"
L["Corgi Soul Guide"] = "耀星是一个行走在森林之心的柯基犬灵魂. 使用/pet你会立即得到灵魂变形(不需要交出任务)"

L["Crane Soul"] = "仙鹤之魂"
L["Cricket Soul"] = "蟋蟀之魂"
L["Direhorn Soul"] = "恐角龙之魂"
L["Eagle Soul"] = "老鹰之魂"
L["Equine Soul"] = "角马之魂"

L["Frog Soul"] = "青蛙之魂"
L["Frog Soul Guide"] = "可从任何盟约地区获得."

L["Goat Soul"] = "山羊之魂"

L["Gryphon Soul"] = "狮鹫之魂"
L["Gryphon Soul Guide"] = "在竞技场、随机战场或评级战场中获胜后几率获得."

L["Gulper Soul"] = "巨口蟾之魂"
L["Gulper Soul Guide"] = "任何品质的灵种获得, 但是需要一个%s."

L["Hippo Soul"] = "河马之魂"
L["Hippo Soul Guide"] = "法夜突袭奖励."

L["Hippogryph Soul"] = "角鹰兽之魂"

L["Hyena Soul"] = "土狼之魂"
L["Hyena Soul Guide"] = "任何钥石等级掉落."

L["Jormungar Soul"] = "冰虫之魂"
L["Jormungar Soul Guide"] = "可以从任何巫妖王之怒时光漫游地下城的尾王处掉落."

L["Kodo Soul"] = "科多兽之魂"
L["Kodo Soul Guide"] = "可以从任何大地的裂变时光漫游地下城的尾王处掉落."

L["Leonine Soul"] = "狮子之魂"
L["Lupine Soul"] = "狼之魂"
L["Mammoth Soul"] = "猛犸象之魂"

L["Moose Soul"] = "驼鹿之魂"
L["Moose Soul Guide"] = "你必须击败7个不同的稀有BOSS中的5个, 从泊星剧场的表演中获得."

L["Otter Soul"] = "水獭之魂"
L["Otter Soul Guide"] = "水獭形态的失落之魂可以在英雄之眠下方水池刷新(60分钟刷新). 使用/hug即可获得."

L["Owl Soul"] = "猫头鹰之魂"
L["Owl Soul Guide"] = "可以从任何军团时光漫游地下城的尾王处掉落."

L["Owlcat Soul"] = "鹰头猫之魂"
L["Porcupine Soul"] = "箭猪之魂"
L["Prairie Dog Soul"] = "草原土拨鼠之魂"
L["Ram Soul"] = "公羊之魂"
L["Raptor Soul"] = "迅猛龙之魂"

L["Rat Soul"] = "老鼠之魂"
L["Rat Soul Guide"] = "当他对你说悄悄话时用/yes或/nod回答以获得他的商品."

L["Runestag Soul"] = "符文牡鹿之魂"
L["Runestag Soul Guide"] = "在炽蓝仙野的东北部刷新."

L["Saurid Soul"] = "细颚龙之魂"
L["Saurid Soul Guide"] = "山洞内. 选中山洞后面的神秘的垃圾堆/bow即可获得."

L["Saurolisk Soul"] = "巨蜥之魂"
L["Saurolisk Hatchling Soul"] = "巨蜥幼体之魂"
L["Shadowstalker Soul"] = "暗影追猎者之魂"

L["Shoveltusk Soul"] = "铲齿鹿之魂"
L["Shoveltusk Soul Guide"] = "乱斗：人机对决几率获得."

L["Shrieker Soul"] = "尖啸者之魂"
L["Snake Soul"] = "蛇之魂"
L["Snapper Soul"] = "龙龟之魂"

L["Spider Soul"] = "蜘蛛之魂"
L["Spider Soul Guide"] = "使用%s进入刻希亚裂隙. 每天有4个隙缚宝箱在随机地点刷新."

L["Sporebat Soul"] = "孢子蝠之魂"
L["Sporebat Soul Guide"] = "可以从任何燃烧的远征时光漫游地下城的尾王处掉落."

L["Stag Soul"] = "牡鹿之魂"
L["Stag Soul Guide"] = "刻希亚法夜访客日常."

L["Tiger Soul"] = "老虎之魂"

L["Turkey Soul"] = "火鸡之魂"
L["Turkey Soul Guide"] = "到阵营主城感恩节盛宴餐桌.\n在感恩节盛宴餐桌上吃五种食物各五次获取分享之魂Buff, 再分别吃五种食物一次获得."

L["Ursine Soul"] = "熊之魂"
L["Veilwing Soul"] = "帷翼之魂"

L["Vulpine Soul"] = "狐狸之魂"
L["Vulpine Soul Guide"] = "你收藏的第一个灵魂变形!"

L["Wolfhawk Soul"] = "狼鹰之魂"
L["Wolfhawk Soul Guide"] = "你需要使用灵魂变形来跨越障碍."

L["Wyvern Soul"] = "双足飞龙之魂"
L["Yak Soul"] = "牦牛之魂"
