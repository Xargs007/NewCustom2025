--The God of Obelisk
--マイケル・ローレンス・ディーによってスクリプト
--scripted by MLD, credits to TPD & Cybercatman, updated by Larry126, mod by Xargs01
Duel.LoadScript("c421.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Summon with 3 Tribute
	local e1=aux.AddNormalSummonProcedure(c,true,false,3,3)
	local e2=aux.AddNormalSetProcedure(c,true,false,3,3)
	--Race "WARRIOR"
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_ADD_RACE)
	e3:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e3)
	--destory
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4012,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(s.cost)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
	--Change Battle Target when Special Summoned in Defense Position
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(911000235,0))
	e18:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e18:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e18:SetCode(EVENT_BE_BATTLE_TARGET)
	e18:SetRange(LOCATION_MZONE)
	e18:SetCountLimit(1)
	e18:SetCondition(s.changebattletargetcon)
	e18:SetOperation(s.changebattletargetop)
	c:RegisterEffect(e18)
	--Soul Energy Max
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4012,2))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(s.cost)
	e4:SetCondition(s.atkcon)
	e4:SetOperation(s.atkop)
	c:RegisterEffect(e4)
	aux.GlobalCheck(s,function()
		--avatar
		local av=Effect.CreateEffect(c)
		av:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		av:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		av:SetCode(EVENT_ADJUST)
		av:SetCondition(s.avatarcon)
		av:SetOperation(s.avatarop)
		Duel.RegisterEffect(av,0)
	end)
end
s.listed_names={21208154}

function s.changebattletargetcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttackTarget()
	return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefencePos()
end
function s.changebattletargetop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function s.avfilter(c)
	local atktes={c:GetCardEffect(EFFECT_SET_ATTACK_FINAL)}
	local ae=nil
	local de=nil
	for _,atkte in ipairs(atktes) do
		if atkte:GetOwner()==c and atkte:IsHasProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY) then
			ae=atkte:GetLabel()
		end
	end
	local deftes={c:GetCardEffect(EFFECT_SET_DEFENSE_FINAL)}
	for _,defte in ipairs(deftes) do
		if defte:GetOwner()==c and defte:IsHasProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY) then
			de=defte:GetLabel()
		end
	end
	return c:IsOriginalCode(21208154) and (ae~=9999999 or de~=9999999)
end
function s.avatarcon(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetMatchingGroupCount(s.avfilter,tp,0xff,0xff,nil)>0
end
function s.avatarop(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(s.avfilter,tp,0xff,0xff,nil)
	g:ForEach(function(c)
		local atktes={c:GetCardEffect(EFFECT_SET_ATTACK_FINAL)}
		for _,atkte in ipairs(atktes) do
			if atkte:GetOwner()==c and atkte:IsHasProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY) then
				atkte:SetValue(s.avaval)
				atkte:SetLabel(9999999)
			end
		end
		local deftes={c:GetCardEffect(EFFECT_SET_DEFENSE_FINAL)}
		for _,defte in ipairs(deftes) do
			if defte:GetOwner()==c and defte:IsHasProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY) then
				defte:SetValue(s.avaval)
				defte:SetLabel(9999999)
			end
		end
	end)
end
function s.avafilter(c)
	return c:IsFaceup() and c:GetCode()~=21208154
end
function s.avaval(e,c)
	local g=Duel.GetMatchingGroup(s.avafilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g==0 then 
		return 100
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		if val>=9999999 then
			return val
		else
			return val+100
		end
	end
end
-----------------------------------------------------------------
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,nil,2,false,nil,c)
		and ((not c:IsHasEffect(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		and not c:IsHasEffect(EFFECT_FORBIDDEN) and not c:IsHasEffect(EFFECT_CANNOT_ATTACK)
		and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_ATTACK_ANNOUNCE)
		and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_ATTACK))
		or c:IsHasEffect(EFFECT_UNSTOPPABLE_ATTACK)) end
	local g=Duel.SelectReleaseGroupCost(tp,nil,2,2,false,nil,c)
	Duel.Release(g,REASON_COST)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	--Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetHandler():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,4000)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,1-tp,LOCATION_MZONE)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	--Duel.Damage(1-tp,e:GetHandler():GetAttack(),REASON_EFFECT)
	Duel.Damage(1-tp,4000,REASON_EFFECT)
	Duel.Destroy(Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil),REASON_EFFECT)
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:CanAttack() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE+PHASE_BATTLE+PHASE_END+RESET_CHAIN)
		e1:SetValue(s.adval)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetCondition(s.damcon)
		e2:SetOperation(s.damop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE+PHASE_BATTLE+PHASE_END+RESET_CHAIN)
		c:RegisterEffect(e2)
		if c:IsImmuneToEffect(e1) or c:IsImmuneToEffect(e2) then return end
		local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
		if #g==0 or ((c:IsHasEffect(EFFECT_DIRECT_ATTACK) or not g:IsExists(aux.NOT(Card.IsHasEffect),1,nil,EFFECT_IGNORE_BATTLE_TARGET)) and Duel.SelectYesNo(tp,31)) then
			Duel.CalculateDamage(c,nil)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACKTARGET)
			Duel.CalculateDamage(c,g:Select(tp,1,1,nil):GetFirst())
		end
	end
end
function s.adval(e,c)
	local g=Duel.GetMatchingGroup(nil,0,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if #g==0 then
		return 9999999
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		if val<=9999999 then
			return 9999999
		else
			return val
		end
	end
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and e:GetHandler():GetAttack()>=9999999
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,Duel.GetLP(ep)*100)
end


--Obelisk the Tormentor
--[[
function c911000235.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,1,911000235)
	--summon with 3 tribute
	local e1=aux.AddNormalSummonProcedure(c,true,false,3,3)
	local e2=aux.AddNormalSetProcedure(c)
	--summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c911000235.sumsuc)
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	--e1:SetCondition(c911000235.sumoncon)
	--e1:SetOperation(c911000235.sumonop)
	--e1:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e1)
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_SINGLE)
	--e2:SetCode(EFFECT_LIMIT_SET_PROC)
	--e2:SetCondition(c911000235.setcon)
	--c:RegisterEffect(e2)
	--Cannot be Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c911000235.cannotsettg)
	c:RegisterEffect(e3)
	--Summon Cannot be Negated
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
	--Summon Success: Effects of non-DIVINE monsters Cannot be Activated
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetOperation(c911000235.sumnotnegatedop)
	c:RegisterEffect(e5)
 	--Race "Warrior"
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_ADD_RACE)
	e6:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e6)
	--Cannot be Tributed by Opponent
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_UNRELEASABLE_SUM)
	e7:SetValue(c911000235.nottributedval)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	e8:SetCondition(c911000235.nottributedcon)
	c:RegisterEffect(e8)
    --Cannot Switch Controller
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e9)
	--Cannot be Targeted by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c911000235.notargetedval)
	c:RegisterEffect(e10)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e11:SetValue(c911000235.nodestroyedval)
	c:RegisterEffect(e11)
	--Cannot be Removed
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e12)
	--Cannot Send to Grave
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_TO_GRAVE)
	e13:SetCondition(c911000235.togravecon)
	c:RegisterEffect(e13)
	--Cannot Return to Hand
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e14)
	--Cannot Return to Deck
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e15)
	--Effect Cannot be Negated
	local e16=Effect.CreateEffect(c)
	e16:SetType(EFFECT_TYPE_SINGLE)
	e16:SetCode(EFFECT_CANNOT_DISABLE)
	e16:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e16)
	--If Special Summoned: Send to Grave
	local e17=Effect.CreateEffect(c)
	e17:SetDescription(aux.Stringid(911000235,0))
	e17:SetCategory(CATEGORY_TOGRAVE)
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e17:SetRange(LOCATION_MZONE)
	e17:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e17:SetCountLimit(1)
	e17:SetCode(EVENT_PHASE+PHASE_END)
	e17:SetCondition(c911000235.specialsumtogravecon)
	e17:SetTarget(c911000235.specialsumtogravetg)
	e17:SetOperation(c911000235.specialsumtograveop)
	c:RegisterEffect(e17)
	--Change Battle Target when Special Summoned in Defense Position
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(911000235,0))
	e18:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e18:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e18:SetCode(EVENT_BE_BATTLE_TARGET)
	e18:SetRange(LOCATION_MZONE)
	e18:SetCountLimit(1)
	e18:SetCondition(c911000235.changebattletargetcon)
	e18:SetOperation(c911000235.changebattletargetop)
	c:RegisterEffect(e18)
	--God Hand Crusher
	local e19=Effect.CreateEffect(c)
	e19:SetDescription(aux.Stringid(911000235,0))
	e19:SetCategory(CATEGORY_DESTROY)
	e19:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e19:SetCode(EVENT_FREE_CHAIN)
	e19:SetHintTiming(TIMING_DAMAGE_STEP)
	e19:SetRange(LOCATION_MZONE)
	e19:SetCountLimit(1)
	e19:SetCost(c911000235.godhandcost)
	e19:SetTarget(c911000235.godhandtg)
	e19:SetOperation(c911000235.godhandop)
	c:RegisterEffect(e19)
	--Soul Energy-MAX
	local e20=Effect.CreateEffect(c)
	e20:SetDescription(aux.Stringid(911000235,1))
	e20:SetCategory(CATEGORY_ATKCHANGE)
	e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e20:SetCode(EVENT_FREE_CHAIN)
	e20:SetHintTiming(TIMING_DAMAGE_STEP)
	e20:SetRange(LOCATION_MZONE)
	e20:SetCountLimit(1)
	e20:SetCost(c911000235.energymaxcost)
	e20:SetOperation(c911000235.energymaxop)
	c:RegisterEffect(e20)
	--ATK/DEF effects only affect until the End Phase
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e21:SetProperty(EFFECT_FLAG_REPEAT)
	e21:SetRange(LOCATION_MZONE)
	e21:SetCode(EVENT_PHASE+PHASE_END)
	e21:SetCountLimit(1)
	e21:SetOperation(c911000235.atkdefresetop)
	c:RegisterEffect(e21)
	--"Cryomancer of the Ice Barrier" effect only affects until the End Phase
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e22:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e22:SetCountLimit(1)
	e22:SetCondition(c911000235.cryomancercon)
	e22:SetOperation(c911000235.cryomancerop)
	c:RegisterEffect(e22)
	--"Reptilianne Gorgon" effect only affects until the End Phase
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e23:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e23:SetRange(LOCATION_MZONE)
	e23:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e23:SetCountLimit(1)
	e23:SetCondition(c911000235.gorgoncon)
	e23:SetOperation(c911000235.gorgonop)
	c:RegisterEffect(e23)
	--"Harpie Lady 3" effect only affects until the End Phase
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e24:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e24:SetRange(LOCATION_MZONE)
	e24:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e24:SetCountLimit(1)
	e24:SetCondition(c911000235.harpiecon)
	e24:SetOperation(c911000235.harpieop)
	c:RegisterEffect(e24)
	--"Gora Turtle" effect only affects until the End Phase
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e25:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e25:SetRange(LOCATION_MZONE)
	e25:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e25:SetCountLimit(1)
	e25:SetCondition(c911000235.goraturtlecon)
	e25:SetOperation(c911000235.goraturtleop)
	c:RegisterEffect(e25)
	--"Defender of the Ice Barrier" effect only affects until the End Phase
	local e26=Effect.CreateEffect(c)
	e26:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e26:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e26:SetRange(LOCATION_MZONE)
	e26:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e26:SetCountLimit(1)
	e26:SetCondition(c911000235.defendercon)
	e26:SetOperation(c911000235.defenderop)
	c:RegisterEffect(e26)
	--"Photon Delta Wing" effect only affects until the End Phase
	local e27=Effect.CreateEffect(c)
	e27:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e27:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e27:SetRange(LOCATION_MZONE)
	e27:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e27:SetCountLimit(1)
	e27:SetCondition(c911000235.deltawingcon)
	e27:SetOperation(c911000235.deltawingop)
	c:RegisterEffect(e27)
	--"Thousand-Eyes Restrict" effect only affects until the End Phase
	local e28=Effect.CreateEffect(c)
	e28:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e28:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e28:SetRange(LOCATION_MZONE)
	e28:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e28:SetCountLimit(1)
	e28:SetCondition(c911000235.thousandeyescon)
	e28:SetOperation(c911000235.thousandeyesop)
	c:RegisterEffect(e28)
	--"Level Limit - Area B" effect only affects until the End Phase
	local e29=Effect.CreateEffect(c)
	e29:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e29:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e29:SetRange(LOCATION_MZONE)
	e29:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e29:SetCountLimit(1)
	e29:SetCondition(c911000235.levelareacon)
	e29:SetOperation(c911000235.levelareaop)
	c:RegisterEffect(e29)
	--"Swords of Concealing Light" effect only affects until the End Phase
	local e30=Effect.CreateEffect(c)
	e30:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e30:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e30:SetRange(LOCATION_MZONE)
	e30:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e30:SetCountLimit(1)
	e30:SetCondition(c911000235.concealinglightcon)
	e30:SetOperation(c911000235.concealinglightop)
	c:RegisterEffect(e30)
	--"Spiders' Lair" effect only affects until the End Phase
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e31:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e31:SetRange(LOCATION_MZONE)
	e31:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e31:SetCountLimit(1)
	e31:SetCondition(c911000235.spiderslaircon)
	e31:SetOperation(c911000235.spiderslairop)
	c:RegisterEffect(e31)
	--"Messenger of Peace" effect only affects until the End Phase
	local e32=Effect.CreateEffect(c)
	e32:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e32:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e32:SetRange(LOCATION_MZONE)
	e32:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e32:SetCountLimit(1)
	e32:SetCondition(c911000235.messengercon)
	e32:SetOperation(c911000235.messengerop)
	c:RegisterEffect(e32)
	--"Swords of Revealing Light" effect only affects until the End Phase
	local e33=Effect.CreateEffect(c)
	e33:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e33:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e33:SetRange(LOCATION_MZONE)
	e33:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e33:SetCountLimit(1)
	e33:SetCondition(c911000235.revealinglightcon)
	e33:SetOperation(c911000235.revealinglightop)
	c:RegisterEffect(e33)
	--"Swords of Burning Light" effect only affects until the End Phase
	local e34=Effect.CreateEffect(c)
	e34:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e34:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e34:SetRange(LOCATION_MZONE)
	e34:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e34:SetCountLimit(1)
	e34:SetCondition(c911000235.burninglightcon)
	e34:SetOperation(c911000235.burninglightop)
	c:RegisterEffect(e34)
	--"Final Attack Orders" effect only affects until the End Phase
	local e35=Effect.CreateEffect(c)
	e35:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e35:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e35:SetRange(LOCATION_MZONE)
	e35:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e35:SetCountLimit(1)
	e35:SetCondition(c911000235.finalorderscon)
	e35:SetOperation(c911000235.finalordersop)
	c:RegisterEffect(e35)
	--"Morphtronic Bind" effect only affects until the End Phase
	local e36=Effect.CreateEffect(c)
	e36:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e36:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e36:SetRange(LOCATION_MZONE)
	e36:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e36:SetCountLimit(1)
	e36:SetCondition(c911000235.morphtronicbindcon)
	e36:SetOperation(c911000235.morphtronicbindop)
	c:RegisterEffect(e36)
	--"Gravity Bind" effect only affects until the End Phase
	local e37=Effect.CreateEffect(c)
	e37:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e37:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e37:SetRange(LOCATION_MZONE)
	e37:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e37:SetCountLimit(1)
	e37:SetCondition(c911000235.gravitybindcon)
	e37:SetOperation(c911000235.gravitybindop)
	c:RegisterEffect(e37)
end
function c911000235.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c911000235.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c911000235.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c911000235.setcon(e,c)
	if not c then return true end
	return false
end
function c911000235.cannotsettg(e,c)
return c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c911000235.sumnotnegatedop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_MZONE+LOCATION_SZONE,LOCATION_SZONE+LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c911000235.cannotsettg)
	e1:SetReset(RESET_EVENT+EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e1)
end
function c911000235.triggertg(e)--c911000235.triggertg(e,c)
	local c=e:GetHandler()
	return (not c:IsRace(RACE_DEVINE))
end
function c911000235.nottributedval(e,re,rp)
	local c=e:GetHandler()
 	return not c:IsControler(tp)
end
function c911000235.nottributedcon(e,c)
	local c=e:GetHandler()
	return not c:IsControler(tp)
end
function c911000235.notargetedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c911000235.nodestroyedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c911000235.togravecon(e,c)
	local c=e:GetHandler()
	return not c:IsCode(10000000)
end
function c911000235.specialsumtogravecon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c911000235.specialsumtogravetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c911000235.specialsumtograveop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		Duel.BreakEffect()
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
function c911000235.changebattletargetcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttackTarget()
	return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefencePos()
end
function c911000235.changebattletargetop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c911000235.godhandcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 and Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) and Duel.GetFlagEffect(tp,911000235)==0 end
	Duel.RegisterFlagEffect(tp,911000235,RESET_PHASE+PHASE_END,0,1)
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c911000235.godhandtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,4000)
end
function c911000235.godhandop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,4000,REASON_EFFECT)
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	end
	function c911000235.energymaxcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler())  and Duel.GetFlagEffect(tp,911000235)==0 end
	Duel.RegisterFlagEffect(tp,911000235,RESET_PHASE+PHASE_END,0,1)
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c911000235.energymaxop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(999999999)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetCondition(c911000235.energymaxdmgcon)
		e2:SetOperation(c911000235.energymaxdmgop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
function c911000235.energymaxdmgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() or e:GetHandler()==Duel.GetAttacker()
end
function c911000235.energymaxdmgop(e,tp,eg,ep,ev,re,r,rp)
local X=Duel.GetLP(1-tp)
Duel.ChangeBattleDamage(ep,X)
end
function c911000235.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetBaseAttack())
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c:GetBaseDefense())
	c:RegisterEffect(e2)
end
function c911000235.cryomancerfilter(c)
	return c:IsFaceup() and c:IsCode(23950192)
end
function c911000235.cryomancercon(e)
	return Duel.IsExistingMatchingCard(c911000235.cryomancerfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c911000235.cryomancerop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.cryomancerimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.cryomancerimmunefilter(e,te)
	return te:GetHandler():IsCode(23950192)
end
--mod
function c911000235.gorgonfilter(e,te)
	return (e:GetHandler():IsFaceup() and e:GetHandler():IsCode(43426903))
end
function c911000235.gorgoncon(e)
	return Duel.IsExistingMatchingCard(c911000235.gorgonfilter,tp,0,LOCATION_MZONE,1,nil)
	--return Duel.IsExistingMatchingCard(c911000235.gorgonfilter,tp,0,LOCATION_MZONE,1,nil,nil)
end
function c911000235.gorgonop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.gorgonimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.gorgonimmunefilter(e,te)
	return te:GetHandler():IsCode(43426903)
end
--mod
function c911000235.harpiefilter(e,te)
	return (e:GetHandler():IsFaceup() and e:GetHandler():IsCode(54415063))
end
function c911000235.harpiecon(e)
	return Duel.IsExistingMatchingCard(c911000235.harpiefilter,tp,0,LOCATION_MZONE,1,nil)
	--return Duel.IsExistingMatchingCard(c911000235.harpiefilter,tp,0,LOCATION_MZONE,1,nil,nil)
end
function c911000235.harpieop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.harpieimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.harpieimmunefilter(e,te)
	return te:GetHandler():IsCode(54415063)
end
function c911000235.goraturtlefilter(c)
	return c:IsFaceup() and c:IsCode(80233946)
end
function c911000235.goraturtlecon(e)
	return Duel.IsExistingMatchingCard(c911000235.goraturtlefilter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c911000235.goraturtleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.goraturtleimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.goraturtleimmunefilter(e,te)
	return te:GetHandler():IsCode(80233946)
end
--mod
function c911000235.defenderfilter(e,te)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsCode(82498947)
end
function c911000235.defendercon(e)
	return Duel.IsExistingMatchingCard(c911000235.defenderfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c911000235.defenderop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.defenderimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.defenderimmunefilter(e,te)
	return te:GetHandler():IsCode(82498947)
end
--mod
function c911000235.deltawingfilter(e,te)
	return e:GetHandler()IsFaceup() and e:GetHandler()IsCode(100000240)
end

function c911000235.deltawingcon(e)
	return Duel.IsExistingMatchingCard(c911000235.deltawingfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c911000235.deltawingop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.deltawingimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.deltawingimmunefilter(e,te)
	return te:GetHandler():IsCode(100000240)
end
function c911000235.thousandeyesfilter(c)
	return c:IsFaceup() and c:IsCode(63519819)
end
function c911000235.thousandeyescon(e)
	return Duel.IsExistingMatchingCard(c911000235.thousandeyesfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c911000235.thousandeyesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.thousandeyesimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.thousandeyesimmunefilter(e,te)
	return te:GetHandler():IsCode(63519819)
end
function c911000235.levelareafilter(c)
	return c:IsFaceup() and c:IsCode(3136426)
end
function c911000235.levelareacon(e)
	return Duel.IsExistingMatchingCard(c911000235.levelareafilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c911000235.levelareaop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.levelareaimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.levelareaimmunefilter(e,te)
	return te:GetHandler():IsCode(3136426)
end
--mod
function c911000235.concealinglightfilter(e,te)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsCode(12923641)
end
function c911000235.concealinglightcon(e)
	return Duel.IsExistingMatchingCard(c911000235.concealinglightfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c911000235.concealinglightop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.concealinglightimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.concealinglightimmunefilter(e,te)
	return te:GetHandler():IsCode(12923641)
end
function c911000235.spiderslairfilter(e,te)
	return (e:GetHandler():IsFaceup() and e:GetHandler():IsCode(26640671))
end
function c911000235.spiderslaircon(e)
	return Duel.IsExistingMatchingCard(c911000235.spiderslairfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c911000235.spiderslairop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.spiderslairimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.spiderslairimmunefilter(e,te)
	return (te:GetHandler():IsCode(26640671))
end
function c911000235.messengerfilter(c)
	return (c:IsFaceup() and c:IsCode(44656491))
end
function c911000235.messengercon(e)
	return Duel.IsExistingMatchingCard(c911000235.messengerfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c911000235.messengerop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.messengerimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.messengerimmunefilter(e,te)
	return te:GetHandler():IsCode(44656491)
end
--mod
function c911000235.revealinglightfilter(e,te)
	return (te:GetHandler():IsFaceup() and te:GetHandler():IsCode(72302403))
end

function c911000235.revealinglightcon(e)
	return Duel.IsExistingMatchingCard(c911000235.revealinglightfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c911000235.revealinglightop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.revealinglightimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.revealinglightimmunefilter(e,te)
	return te:GetHandler():IsCode(72302403)
end
function c911000235.burninglightfilter(e,te)
	return (te:GetHandler():IsFaceup() and te:GetHandler():IsCode(93087299))
end
--mod
function c911000235.burninglightcon(e)
	return Duel.IsExistingMatchingCard(c911000235.burninglightfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c911000235.burninglightop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.burninglightimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.burninglightimmunefilter(e,te)
	return te:GetHandler():IsCode(93087299)
end
function c911000235.finalordersfilter(c)
	return (c:IsFaceup() and c:IsCode(52503575))
end
function c911000235.finalorderscon(e)
	return Duel.IsExistingMatchingCard(c911000235.finalordersfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c911000235.finalordersop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.finalordersimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.finalordersimmunefilter(e,te)
	return te:GetHandler():IsCode(52503575)
end
--mod
function c911000235.morphtronicbindfilter(e,te)
	return (te:GetHandler():IsFaceup() and te:GetHandler():IsCode(85101228))
end
function c911000235.morphtronicbindcon(e)
	return Duel.IsExistingMatchingCard(c911000235.morphtronicbindfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c911000235.morphtronicbindop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.morphtronicbindimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.morphtronicbindimmunefilter(e,te)
	return te:GetHandler():IsCode(85101228)
end
--mod
function c911000235.gravitybindfilter(e,te)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsCode(85742772)
end
function c911000235.gravitybindcon(e)
	return Duel.IsExistingMatchingCard(c911000235.gravitybindfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c911000235.gravitybindop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c911000235.gravitybindimmunefilter)
	c:RegisterEffect(e1)
end
function c911000235.gravitybindimmunefilter(e,te)
	return te:GetHandler():IsCode(85742772)
end
]]--
