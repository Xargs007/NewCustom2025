--Fearful Earthbound (Fix)
function c700009.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_ATTACK,TIMING_END_PHASE+TIMING_MAIN_END)
	c:RegisterEffect(e1)
	--atk
	--local e01=Effect.CreateEffect(c)
	--e01:SetType(EFFECT_TYPE_FIELD)
	--e01:SetRange(LOCATION_SZONE)
	--e01:SetCode(EFFECT_UPDATE_ATTACK)
	--e01:SetTargetRange(0,LOCATION_MZONE)
	--e01:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	--e01:SetCondition(c62188962.atkcon2)
	--e01:SetValue(-500)
	c:RegisterEffect(e01)
	--atk damage and atk reduce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700009,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE+EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c700009.atkcon)
	e2:SetTarget(c700009.target)
	e2:SetOperation(c700009.operation)
	c:RegisterEffect(e2)
	--sent to hand for GY
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_TOHAND)
	e02:SetType(EFFECT_TYPE_IGNITION)
	e02:SetRange(LOCATION_GRAVE)
	e02:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e02:SetCondition(aux.exccon)
	e02:SetCondition(c700009.cond)
	e02:SetCost(c700009.cost)
	e02:SetTarget(c700009.thtg)
	e02:SetOperation(c700009.thop)
	c:RegisterEffect(e02)
end

function c700008.cond(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>0
		and Duel.IsExistingTarget(c700009.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler())
end
function c700009.filter(c)
	return c:IsSetCard(0x235) and c:IsAbleToHand()
end
function c700009.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c700009.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700009.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c700009.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c700009.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

function c700009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end


--function c62188962.atkcon2(e)
--	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
--end
function c700009.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
end	
function c700009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c700009.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
	
end
