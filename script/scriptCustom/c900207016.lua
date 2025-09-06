--キウイ・マジシャン・ガール
--Kiwi Magician Girl
--Script by mercury233
local s,id=GetID()
function s.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(900207016,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(s.conditionN1)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	local e02=e1:Clone()
	e02:SetCode(EVENT_CHAINING)
	e02:SetCondition(s.conditionN2)
	c:RegisterEffect(e02)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE,0)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTargetRange(0,0xff)
	e3:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
	e3:SetValue(s.tglimit)
	c:RegisterEffect(e3)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	return true
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function s.atkfilter(c)
	return (c:IsSetCard(0x20a2) or c:IsRace(RACE_SPELLCASTER) or c:IsSetCard(0x30a2) or c:IsSetCard(0x10a2) or c:IsSetCard(0x98) or c:IsCode(38033121) or c:IsCode(71413901) or c:IsCode(02525268) or c:IsCode(80014003) or c:IsCode(80304126) or c:IsCode(100200115) or c:IsCode(38033121) or c:IsCode(900901250) or c:IsCode(900901251) or c:IsCode(900901253) or c:IsCode(900901254) or c:IsCode(900901255))
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetMatchingGroup(s.atkfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(s.atkfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil)
	if tg:GetCount()>0 and g:GetCount()>0 then
		local d=g:GetClassCount(Card.GetCode)*300
		local sc=tg:GetFirst()
		while sc do
			--sc=tg:GetNext()
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			--e2:SetValue(1)--antes era setvalue (1)
			e2:SetTarget(s.indtg)
			e2:SetReset(RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e2)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
			sc:RegisterEffect(e3)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(d)
			sc:RegisterEffect(e1)
			--local e3=e2:Clone()
			--e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			--sc:RegisterEffect(e3)
			--local e3=Effect.CreateEffect(c)
			--e3:SetType(EFFECT_TYPE_SINGLE)
			--e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
			--e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			--e3:SetRange(LOCATION_MZONE)
			--e3:SetValue(1)
			--e3:SetReset(RESET_PHASE+PHASE_END)
			--c:RegisterEffect(e3)
			sc=tg:GetNext()
		end
	end
end
function s.nodestroyedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function s.indtg(e,c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) and c:IsLocation(LOCATION_MZONE)
end
function s.tglimit(e,re,c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) and c:IsLocation(LOCATION_MZONE)
end

function s.conditionN1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if tc:IsControler(1-tp) then
		tc=Duel.GetAttackTarget()
		bc=Duel.GetAttacker()
	end
	if not tc or not bc or tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
	e:SetLabelObject(tc)
	if bc==Duel.GetAttackTarget() and bc:IsDefensePos() then return false end
	if bc:IsPosition(POS_FACEUP_DEFENSE) and bc==Duel.GetAttacker() then
		if not bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return false end
		if bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
			if bc:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 then
				if tc:IsAttackPos() then
					if bc:GetDefense()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetDefense()~=0
					else
						return bc:GetDefense()>=tc:GetAttack()
					end
				else
					return bc:GetDefense()>tc:GetDefense()
				end
			elseif bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
				if tc:IsAttackPos() then
					if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetAttack()~=0
					else
						return bc:GetAttack()>=tc:GetAttack()
					end
				else
					return bc:GetAttack()>tc:GetDefense()
				end
			end
		end
	else
		if tc:IsAttackPos() then
			if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
				return bc:GetAttack()~=0
			else
				return bc:GetAttack()>=tc:GetAttack()
			end
		else
			return bc:GetAttack()>tc:GetDefense()
		end
	end
end
function s.cfilter1(c,e,tp)
	return c:IsOnField() and c:IsType(TYPE_MONSTER) and c:IsControler(tp) and (not e or c:IsRelateToEffect(e)) and (c:IsSetCard(0x20a2) or c:IsSetCard(0x30a2) or c:IsSetCard(0x10a2) or c:IsSetCard(0x98) or c:IsCode(38033121) or c:IsCode(71413901) or c:IsCode(02525268) or c:IsCode(80014003) or c:IsCode(80304126) or c:IsCode(900901250) or c:IsCode(900901251) or c:IsCode(900901253) or c:IsCode(900901254) or c:IsCode(900901255))
end
function s.conditionN2(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if tg==nil then return false end
	local g=tg:Filter(s.cfilter1,nil,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return ex and tc+g:GetCount()-tg:GetCount()>0
end
