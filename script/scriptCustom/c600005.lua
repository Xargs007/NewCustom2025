--Cathy The Mighty Cat Girl
function c600005.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(600005,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c600005.condition)
	--e1:SetTarget(c600005.target)
	e1:SetOperation(c600005.operation)
	c:RegisterEffect(e1)
end

function c600005.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end

function c600005.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(600005)==0 then
		--atk and def up
		local e02=Effect.CreateEffect(c)
		e02:SetType(EFFECT_TYPE_QUICK_O)
		e02:SetDescription(aux.Stringid(600005,0))
		e02:SetCountLimit(1,600005)
		e02:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
		e02:SetCode(EVENT_FREE_CHAIN)
		e02:SetHintTiming(TIMING_DAMAGE_STEP)
		e02:SetRange(LOCATION_MZONE)
		e02:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e02:SetCondition(c600005.condition2)
		e02:SetOperation(c600005.operation2)
		c:RegisterEffect(e02,true)
		c:RegisterFlagEffect(600005,RESET_EVENT+0x1fe0000,0,1)
	end
end

function c600005.condition2(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	--if a:IsCode(600005) or b:IsCode(600005) then return false end
	return ((d~=nil and a:GetControler()==tp and (a:IsSetCard(0x1538) or a:IsSetCard(0x150e)) and a:IsRelateToBattle()) 
		or (d~=nil and d:GetControler()==tp and d:IsFaceup() and (d:IsSetCard(0x1538) or d:IsSetCard(0x150e)) and d:IsRelateToBattle())) and not (a:IsCode(600005) or d:IsCode(600005))
end
function c600005.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	--if a:IsCode(600005) or b:IsCode(600005) then return end
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	if a:GetControler()==tp then
		e1:SetValue(2000)
		a:RegisterEffect(e1)
	else
		e1:SetValue(2000)
		d:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetOwnerPlayer(tp)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	if a:GetControler()==tp then
		e2:SetValue(700)
		a:RegisterEffect(e2)
	else
		e2:SetValue(700)
		d:RegisterEffect(e2)
	end
end

