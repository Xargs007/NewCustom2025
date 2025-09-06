--Multiply (Fix)
function c600000.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c600000.target)
	e1:SetOperation(c600000.activate)
	c:RegisterEffect(e1)
end
function c600000.filter(c,e,tp)
	return c:IsAttackBelow(500) and c:IsFaceup() and c:IsLevelBelow(3) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0,c:GetType(),c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute()) and c:IsType(TYPE_MONSTER)
		--and Duel.IsPlayerCanSpecialSummonMonster(tp,700018,0,0x4011,c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute()) and c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function c600000.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c600000.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	--local g=Duel.SelectTarget(tp,c600000.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,0,0)
end

c600000.Gb=0

function c600000.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	if ft<1 or not Duel.IsExistingMatchingCard(c600000.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c600000.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
	c600000.Gb=tc
	local ct=0
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or ft==1 then ct=1
	else
		local nums = {}
		for i=1,ft do
			table.insert(nums, i)
		end
		ct=Duel.AnnounceNumber(tp,table.unpack(nums))
	end
	--local g=Group.CreateGroup()
	--tc=g:GetNext()
	for i=1,ct do
		local token=Duel.CreateToken(tp,600001)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		--token=g:GetFirst()
		--Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		--if i==1 then 
			local e01=Effect.CreateEffect(c)
			e01:SetType(EFFECT_TYPE_SINGLE)
			e01:SetRange(LOCATION_MZONE)
			e01:SetCode(EFFECT_CHANGE_CODE)
			e01:SetValue(tc:GetCode())
			e01:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e01)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(tc:GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_DEFENSE)
			e2:SetValue(tc:GetDefense())
			token:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CHANGE_LEVEL)
			e3:SetValue(tc:GetLevel())
			token:RegisterEffect(e3)
			local e4=e1:Clone()
			e4:SetCode(EFFECT_CHANGE_RACE)
			e4:SetValue(tc:GetRace())
			token:RegisterEffect(e4)
			local e5=e1:Clone()
			e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e5:SetValue(tc:GetAttribute())
			token:RegisterEffect(e5)
			--return to hand
			local e02=Effect.CreateEffect(c)
			e02:SetDescription(aux.Stringid(600000,0))
			e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
			e02:SetCode(EVENT_BATTLE_START)
			e02:SetCondition(c600000.spcon2)
			e02:SetOperation(c600000.tgop1)
			token:RegisterEffect(e02)
			if tc:IsType(TYPE_EFFECT) and not token:IsType(TYPE_EFFECT) then
				local e6=Effect.CreateEffect(c)
				e6:SetType(EFFECT_TYPE_SINGLE)
				e6:SetCode(EFFECT_ADD_TYPE)
				e6:SetValue(TYPE_EFFECT)
				e6:SetReset(RESET_EVENT+0x1fe0000)
				token:RegisterEffect(e6)
			end
			--g:AddCard(token)
	end
	Duel.SpecialSummonComplete()
end
function c600000.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end


function c600000.tgop1(e,tp,eg,ep,ev,re,r,rp)
   --	local g=Duel.GetMatchingGroup(c600000.thfilter1,tp,0,LOCATION_HAND,nil):RandomSelect(tp,1)
	--local tc=g:GetFirst()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	if ft<1 or not Duel.IsExistingMatchingCard(c600000.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) then return end
	local tc=c600000.Gb
	--local g=Duel.SelectMatchingCard(tp,c700022.thfilter1,1-tp,LOCATION_HAND,0,1,1,nil)
	if tc then--g:GetCount()>0 then
		local ct=0
		if Duel.IsPlayerAffectedByEffect(tp,59822133) or ft==1 then ct=1
		else
			ct=2
		end
		--local g=Group.CreateGroup()
		for i=1,ct do
		local token=Duel.CreateToken(tp,600001)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		--if i==1 then 
			local e01=Effect.CreateEffect(c)
			e01:SetType(EFFECT_TYPE_SINGLE)
			e01:SetRange(LOCATION_MZONE)
			e01:SetCode(EFFECT_CHANGE_CODE)
			e01:SetValue(tc:GetCode())
			e01:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e01)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(tc:GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_DEFENSE)
			e2:SetValue(tc:GetDefense())
			token:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CHANGE_LEVEL)
			e3:SetValue(tc:GetLevel())
			token:RegisterEffect(e3)
			local e4=e1:Clone()
			e4:SetCode(EFFECT_CHANGE_RACE)
			e4:SetValue(tc:GetRace())
			token:RegisterEffect(e4)
			local e5=e1:Clone()
			e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e5:SetValue(tc:GetAttribute())
			token:RegisterEffect(e5)
			if tc:IsType(TYPE_EFFECT) and not token:IsType(TYPE_EFFECT) then
				local e6=Effect.CreateEffect(c)
				e6:SetType(EFFECT_TYPE_SINGLE)
				e6:SetCode(EFFECT_ADD_TYPE)
				e6:SetValue(TYPE_EFFECT)
				e6:SetReset(RESET_EVENT+0x1fe0000)
				token:RegisterEffect(e6)
			end
			--c:SetCardTarget(g:GetFirst())
		end
		--Duel.SpecialSummon(g,0,tp,tp,false,false,tc:GetPosition())
		Duel.SpecialSummonComplete()
	end
end
