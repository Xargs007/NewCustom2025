--Apprentice Illusion Magician by Tobito01
function c990000147.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c990000147.spcon)
	e1:SetOperation(c990000147.spop)
	c:RegisterEffect(e1)
	--search
	local e01=Effect.CreateEffect(c)
	e01:SetDescription(aux.Stringid(990000147,0))
	e01:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e01:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e01:SetCode(EVENT_SUMMON_SUCCESS)
	e01:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e01:SetTarget(c990000147.thtg)
	e01:SetOperation(c990000147.thop)
	c:RegisterEffect(e01)
	local e2=e01:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--atkup and defup
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_QUICK_O)
	e02:SetDescription(aux.Stringid(990000147,1))
	e02:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e02:SetCode(EVENT_FREE_CHAIN)
	e02:SetHintTiming(TIMING_DAMAGE_STEP)
	e02:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e02:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e02:SetCondition(c990000147.condition2)
	e02:SetCost(c990000147.cost2)
	e02:SetOperation(c990000147.operation2)
	c:RegisterEffect(e02)
	
end
function c990000147.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,0,1,c)
end
function c990000147.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end

function c990000147.filter(c)
	return c:IsCode(46986414) and c:IsAbleToHand()
end
function c990000147.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c990000147.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c990000147.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c990000147.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c990000147.condition2(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (d~=nil and a:GetControler()==tp and a:IsAttribute(ATTRIBUTE_DARK) and a:IsRace(RACE_SPELLCASTER) and a:IsRelateToBattle())
		or (d~=nil and d:GetControler()==tp and d:IsFaceup() and d:IsAttribute(ATTRIBUTE_DARK) and d:IsRace(RACE_SPELLCASTER) and d:IsRelateToBattle())
end
function c990000147.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c990000147.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
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
		e2:SetValue(2000)
		a:RegisterEffect(e2)
	else
		e2:SetValue(2000)
		d:RegisterEffect(e2)
	end
end
