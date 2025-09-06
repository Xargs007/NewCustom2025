--沈黙の邪悪霊
function c903599951.initial_effect(c)
--[[	
	--Activate
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_ACTIVATE)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCondition(c903599951.redirectattackcon)
	--e1:SetTarget(c93599951.target)
	--e1:SetOperation(c903599951.redirectattackop)
	--c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(90901451,0))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	--e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	--e2:SetRange(LOCATION_MZONE)
	--e2:SetCondition(c90901451.condition)
	e2:SetCondition(c903599951.cbcon)
	--e2:SetCost(c903599951.costLP)
	e2:SetTarget(c903599951.target)
	e2:SetOperation(c903599951.activate)
	c:RegisterEffect(e2)
]]
--[[
	--effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90901451,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	---e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	--e2:SetCondition(c90901451.condition)
	e2:SetCondition(c903599951.con)
	e2:SetTarget(c903599951.target)
	e2:SetOperation(c903599951.activate)
	c:RegisterEffect(e2)
	]]
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c903599951.target3)
	e1:SetOperation(c903599951.operation)
	c:RegisterEffect(e1)
end
--[[function c903599951.sfilter1(c)
	return c:IsRace(RACE_WARRIOR) and c:IsFaceup()--c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_FAIRY) and c:IsFaceup()
end
function c903599951.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=Duel.GetAttackTarget()
	return bt and bt:IsControler(tp)
end
--effect 1
function c903599951.costLP(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500*c903599951.counterdamag) end
	Duel.PayLPCost(tp,(500*c903599951.counterdamag))
end
function c903599951.negcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() --and Duel.IsExistingMatchingCard(c903599951.sfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c903599951.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local a=Duel.GetAttacker()
	if chk==0 then return a and a:IsCanBeEffectTarget(e) and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,a) end
	Duel.SetTargetCard(a)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,a)
	c903599951.counterdamag = 2
	e:SetLabelObject(g:GetFirst())
end
function c903599951.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and (tc:IsFaceup() or tc:IsFacedown()) then
		if tc:IsDefencePos() then
			Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		end
		--Duel.ChangeAttacker(tc)
		Duel.ChangeAttackTarget(tc)
	end
end
]]

function c903599951.filter2(c)
	return (c:IsFaceup() or c:IsFacedown())
end

function c903599951.con2(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and (d:IsFaceup() or d:IsFacedown())
end
function c903599951.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local a=Duel.GetAttacker()
	if chk==0 then return a and a:IsCanBeEffectTarget(e) and (Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,a) or Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,a)) end--Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,a) end
	Duel.SetTargetCard(a)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,a)
	e:SetLabelObject(g:GetFirst())
end
function c903599951.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and (tc:IsFaceup() or tc:IsFacedown()) then
		if tc:IsDefense() then
			Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
			Duel.ChangeAttackTarget(tc)
		end
		--Duel.ChangeAttacker(tc)
		Duel.ChangeAttackTarget(tc)
	end
end

function c903599951.filter(c)
	return (c:IsFaceup() or c:IsFacedown())
end
function c903599951.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return  a and Duel.IsExistingMatchingCard(c903599951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c903599951.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c903599951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	local a=Duel.GetAttacker()
	if tc and a and a:IsFaceup() and not a:IsImmuneToEffect(e) and not a:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.BreakEffect()
		--Duel.HintSelection(tc)
		Duel.ChangeAttackTarget(tc)
	end
end

function c903599951.condition(e,tp,eg,ep,ev,re,r,rp)
	return r~=REASON_REPLACE and Duel.GetAttackTarget()==e:GetHandler() and Duel.GetAttacker():IsControler(1-tp)
end
function c903599951.filter3(c,at)
	return at:IsContains(c)
end
function c903599951.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker():GetAttackableTarget()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and at:IsContains(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c903599951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c903599951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,at)	
end
function c903599951.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local a=Duel.GetAttacker()
	if tc and tc:IsRelateToEffect(e) then
		Duel.CalculateDamage(a,tc)
	end
end

