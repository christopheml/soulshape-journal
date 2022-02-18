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

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "koKR", false)
if not L then return end

-- UI elements
L["TAB_TITLE"] = "영혼형상"
L["COUNT_LABEL"] = "전체"
L["UNTRACKABLE_TOOLTIP_TITLE"] = "이 영혼형상은 자동으로 감지할 수 없습니다."
L["UNTRACKABLE_TOOLTIP_CLICK_ME"] = "이미 영혼형상을 가지고 있고 %s 을 수집된 것으로 표시하려면 클릭하세요."
L["WARNING_NOT_NIGHT_FAE"] = "나이트페이 성약단이 아닙니다,\n지금은 새로운 영혼형상을 수집할 수 없습니다."

-- Labels
L["Loot"] = "전리품"
L["Quest"] = "퀘스트"
L["Campaign"] = "대장정"
L["World Event"] = "월드 이벤트"
L["World Quest"] = "월드 퀘스트"
L["NPC"] = true
L["Region"] = "지역"
L["Cost"] = "비용"
L["Faction"] = "진영"
L["Profession"] = "전문기술"
L["Covenant Feature"] = "성약 특성"
L["Difficulty"] = "난이도"
L["Coordinates"] = "좌표"
L["Renown"] = "평판"
L["Spell"] = "주문"
L["Vendor"] = "상인"

-- Zone Names
L["Shadowlands"] = "어둠땅"
L["Ardenweald"] = "몽환숲"
L["Bastion"] = "승천의 보루"
L["Revendreth"] = "레벤드레스"
L["Maldraxxus"] = "말드락서스"
L["Oribos"] = "오리보스"
L["The Maw"] = "나락"
L["Torghast"] = "토르가스트"
L["The Adamant Vaults"] = "철화의 석실"
L["Korthia"] = "코르시아"
L["De Other Side"] = "저편"
L["Mists of Tirna Scithe"] = "티르너 사이드의 안개"
L["Tazavesh, the Veiled Market"] = "미지의 시장 타자베쉬"
L["Castle Nathria"] = "나스리아 성채"
L["Sanctum of Domination"] = "지배의 성소"

-- Quest and Campaign Names (could be translated automatically through the API?)
L["Drust and Ashes"] = "드러스트와 재"
L["Mending a Broken Hart"] = "상처받은 마음을 치유하려면"
L["The Power of Elune"] = "엘룬의 힘"
L["Night Warrior's Curse"] = "밤 전사의 저주"
L["The Power of Night"] = "밤의 힘"

-- Item Names (could be translated automatically through the API?)
L["Bounty of the Grove Wardens"] = "숲 감시자의 선물"
L["Queen's Conservatory Cache"] = "여왕의 정원 보관함"
L["War Chest of the Wild Hunt"] = "야생 사냥단의 전쟁 상자"
L["Wild Hunt Supplies"] = "야생 사냥단 보급품"
L["Synvir Lockbox"] = "신비르 금고"
L["Stygian Lockbox"] = "저승석 금고"
L["Riftbound Cache"] = "균열결속 보관함"
L["Wildseed Root Grain"] = "야생씨앗 뿌리 곡식"
L["Repaired Riftkey"] = "수리된 균열의 열쇠"

-- NPC Names (could be translated automatically through the API?)
L["Lost Soul"] = "길 잃은 영혼"
L["Ma'oh"] = "마오"
L["Sparkle"] = "반짝이"
L["Aithlyn"] = "아이슬린"
L["Liawyn"] = "엘윈"
L["The Grand Menagerie"] = "대사육장"
L["Master Clerk Salorn"] = "총지배인 살로른"
L["Lady Sylvanas Windrunner"] = "여군주 실바나스 윈드러너"
L["Mueh'Zala"] = "무에젤라"
L["Mistcaller"] = "미스트콜러"
L["Cortinarius"] = "코르티나리우스"
L["Sire Denathrius"] = "대영주 데나트리우스"
L["Skuld Vit"] = "스컬드 비트"
L["So'leah"] = "소레아"
L["Valfir the Unrelenting"] = "무자비한 발피르"
L["Spindlenose"] = "스핀들노즈"
L["Shopkeeper"] = "가게 주인"
L["Mystic Rainbowhorn"] = "신비한 무지개뿔"

-- Others
L["Burning Crusade Timewalking"] = "불타는 성전 시간여행"
L["Wrath of the Lich King Timewalking"] = "리치왕의 분노 시간여행"
L["Cataclysm Timewalking"] = "대격변 시간여행"
L["Mists of Pandaria Timewalking"] = "판다리아의 안개 시간여행"
L["Warlords of Draenor Timewalking"] = "드레노어의 전쟁군주 시간여행"
L["Legion Timewalking"] = "군단 시간여행"
L["Pet Battle"] = "애완동물 전투"
L["Shadowlands World Bosses"] = "어둠땅 월드 보스"
L["Queen's Conservatory"] = "여왕의 정원"
L["Mythic+ dungeons"] = "신화 쐐기 던전"
L["Night Fae dailies"] = "나이트페이 일일 퀘스트"
L["Mushroom Network"] = "버섯 연결망"
L["Marasmius"] = "마라스미우스"
L["Paragon reward."] = "확고한 동맹 보급품."
L["Soulshape"] = "영혼형상"
L["Pilgrim's Bounty"] = "순례자의 감사절"
L["Covenant Callings reward chests"] = "성약의 단 부름 퀘스트 보상 상자"

L["Normal or Heroic"] = "일반 혹은 영웅"
L["Heroic"] = "영웅"
L["Hardmode"] = "하드모드"
L["Any"] = "어느"

-- Database
L["Alpaca Soul"] = "알파카의 영혼"
L["Ardenmoth Soul"] = "몽환나방의 영혼"

L["Boar Soul"] = "멧돼지의 영혼"
L["Boar Soul Guide"] = "드레노어의 전쟁군주 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Bunny Soul"] = "토끼의 영혼"
L["Bunny Soul Guide"] = "애완동물 전투 월드 퀘스트에서 가끔 보상이 주어집니다."

L["Cat Soul"] = "고양이의 영혼"
L["Cat Soul Guide"] = "고양이의 영혼은 나이트페이 령 전도체를 통해 강화되는 거대한 꿈의 나무(꿈결노래 기슭, 반짝폭포 분지, 티르너바알, 겨울잠 골짜기 혹은 발톱 벼랑)의 꼭대기에서 확인할 수 있습니다. 영혼형상을 얻기 위해 /달래 를 사용하세요."

L["Cat Soul (Well Fed)"] = "고양이의 영혼 (잘 먹음)"
L["Cat Soul (Well Fed) Guide"] = "고양이 영혼형상을 잠금 해제한 후 사용할 수 있습니다. 먼저 혼령의 먹이를 얻은 후, 다시 숲의 심장부로 향합니다. 마오는 여왕의 정원 입구 근처의 바구니에서 잠을 자고 있는 고양이 영혼입니다.\n그에게 /야옹을 하고(배가 고프다고 말할 것이다) 혼령의 먹이를 먹이세요. 영혼의 모양을 즉시 받을 수 있습니다(퀘스트 제출 필요 없음)."

L["Chicken Soul"] = "닭의 영혼"
L["Chicken Soul Guide"] = "먼저 혼령의 먹이를 구하고, 닭의 영혼에게 /닭 을 사용하고 혼령의 먹이를 먹이세요."

L["Cloud Serpent Soul"] = "운룡의 영혼"
L["Cloud Serpent Soul Guide"] = "판다리아의 안개 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Cobra Soul"] = "코브라 영혼"
L["Cobra Soul Guide"] = "투기장 또는 평점제 전장에서 승리하면 가끔 보상을 받습니다."

L["Corgi Soul"] = "코기의 영혼"
L["Corgi Soul Guide"] = "반짝이는 숨의 심장부를 돌아다니는 코기의 영혼입니다. 그를 /귀여움 을 하여 쓰다듬으면 영혼형상을 즉시 받게 됩니다(퀘스트 제출 필요 없음)"

L["Crane Soul"] = "학의 영혼"
L["Cricket Soul"] = "귀뚜라미의 영혼"
L["Direhorn Soul"] = "공포뿔의 영혼"
L["Eagle Soul"] = "독수리의 영혼"
L["Equine Soul"] = "준마의 영혼"

L["Frog Soul"] = "개구리의 영혼"
L["Frog Soul Guide"] = "모든 성약 영역에서 사용할 수 있습니다."

L["Goat Soul"] = "염소의 영혼"
L["Goat Soul Guide"] = "나이트페이에서 뿐만 아니라 모든 부름 퀘스트 완료 상자에서 드랍할 수 있습니다."

L["Gryphon Soul"] = "그리핀의 영혼"
L["Gryphon Soul Guide"] = "소규모 전장, 투기장, 무작위 전장 또는 평점제 전장에서 승리하면 가끔 보상을 받습니다."

L["Gulper Soul"] = "두꺼비의 영혼"
L["Gulper Soul Guide"] = "모든 품질의 영혼으로 얻을 수 있지만 하나의 %s 만 사용하십시오."

L["Hippo Soul"] = "하마의 영혼"
L["Hippo Soul Guide"] = "나이트페이 습격 보상."

L["Hippogryph Soul"] = "히포그리프 영혼형상"

L["Hyena Soul"] = "하이에나 영혼"
L["Hyena Soul Guide"] = "신화+ 던전 드랍"

L["Jormungar Soul"] = "요르문가르의 영혼"
L["Jormungar Soul Guide"] = "리치왕의 분노 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Kodo Soul"] = "코도의 영혼"
L["Kodo Soul Guide"] = "대격변 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Leonine Soul"] = "사자의 영혼"
L["Lupine Soul"] = "늑대의 영혼"
L["Mammoth Soul"] = "매머드의 영혼"

L["Moose Soul"] = "엘크의 영혼"
L["Moose Soul Guide"] = "원형 극장 공연에서 7명의 다른 희귀 보스 중 5명을 물리쳤어야 합니다."

L["Otter Soul"] = "수달의 영혼"
L["Otter Soul Guide"] = "수달의 영혼은 영웅의 안식처 아래 호수에서 스폰될 수 있습니다(60분 리스폰). /포옹 을 하면 영혼형상 퀘스트 아이템을 받을 수 있습니다."

L["Owl Soul"] = "올빼미의 영혼"
L["Owl Soul Guide"] = "군단 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Owlcat Soul"] = "올빼미냥이의 영혼"
L["Porcupine Soul"] = "호저의 영혼"
L["Prairie Dog Soul"] = "땅다람쥐의 영혼"
L["Ram Soul"] = "산양의 영혼"
L["Raptor Soul"] = "랩터의 영혼"

L["Rat Soul"] = "쥐의 영혼"
L["Rat Soul Guide"] = "그가 당신에게 속삭일 때 /예 또는 /끄덕 으로 대답하여 그의 물건에 접근할 수 있습니다."

L["Runestag Soul"] = "룬수사슴의 영혼"
L["Runestag Soul Guide"] = "몽환숲의 북동쪽에 나타납니다."

L["Saurid Soul"] = "사우리드의 영혼"
L["Saurid Soul Guide"] = "동굴 내부. 동굴 뒤에 있는 쓰레기 더미를 목표로 삼고 /인사 를 합니다."

L["Saurolisk Soul"] = "사우로리스크의 영혼"
L["Saurolisk Hatchling Soul"] = "새끼 사우로리스크의 영혼"
L["Shadowstalker Soul"] = "그림자추적자의 영혼"

L["Shoveltusk Soul"] = "뾰족엄니의 영혼"
L["Shoveltusk Soul Guide"] = "모든 PvP 난투에서 승리하면 가끔 보상을 받습니다."

L["Shrieker Soul"] = "비명꾼의 영혼"
L["Snake Soul"] = "뱀의 영혼"
L["Snapper Soul"] = "거북의 영혼"

L["Spider Soul"] = "거미의 영혼"
L["Spider Soul Guide"] = "%s 을 사용하여 균열 차원문을 통해 이동합니다. 무작위 위치에서 매일 4개의 균열결속 보관함이 생성됩니다."

L["Sporebat Soul"] = "포자박쥐의 영혼"
L["Sporebat Soul Guide"] = "불타는 성전 시간여행 던전의 마지막 보스로부터 드랍될 수 있습니다."

L["Stag Soul"] = "순록의 영혼"
L["Stag Soul Guide"] = "코르시아의 모든 나이트페이 일일 퀘스트에서 보상으로 무작위로 제공될 수 있습니다."

L["Tiger Soul"] = "호랑이의 영혼"

L["Turkey Soul"] = "칠면조의 영혼"
L["Turkey Soul Guide"] = "진영 수도로 이동하여 푸짐한 잔칫상을 찾으십시오.\n음식 버프가 5개 있을 때까지 모든 음식을 먹고 영혼형상을 얻을 때까지 음식을 계속 먹고 자리를 바꾸세요."

L["Ursine Soul"] = "곰의 영혼"
L["Veilwing Soul"] = "장막날개의 영혼"

L["Vulpine Soul"] = "여우의 형상"
L["Vulpine Soul Guide"] = "처음으로 수집되는 영혼형상"

L["Wolfhawk Soul"] = "늑대매의 영혼"
L["Wolfhawk Soul Guide"] = "장벽을 넘으려면 영혼형상을 사용해야 합니다."

L["Wyvern Soul"] = "와이번의 영혼"
L["Yak Soul"] = "야크의 영혼"
