--Necro Soldier
function c700020.initial_effect(c)
	-- change battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	--e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c700020.damcon)
	e1:SetTarget(c700020.damtg)
	e1:SetOperation(c700020.damop)
	c:RegisterEffect(e1)
	--spsumon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700020,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c700020.spcon)
	e2:SetTarget(c700020.sptg)
	e2:SetOperation(c700020.spop)
	c:RegisterEffect(e2)
	--send to hand for GY
	local e02=Effect.CreateEffect(c)
	e02:SetDescription(aux.Stringid(700020,1))
	e02:SetCategory(CATEGORY_DESTROY)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e02:SetCode(EVENT_TO_GRAVE)
	e02:SetCountLimit(1,700020)
	e02:SetCondition(c700020.descon)
	e02:SetTarget(c700020.destg)
	e02:SetOperation(c700020.desop)
	c:RegisterEffect(e02)
	local e3=e02:Clone()
	e3:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e3)
	local e4=e02:Clone()
	e4:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e4)
end

function c700020.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler()
	return ep==tp and ec and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
end
function c700020.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(e:GetHandler():GetControler())
end
function c700020.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
end

function c700020.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c700020.spfilter(c,e,tp)
	return c:IsCode(700020)--c:IsType(TYPE_MONSTER) and c:IsSetCard(0x235) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c700020.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_HAND) and chkc:IsControler(tp) and c700020.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c700020.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c700020.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c700020.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c700020.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c700020.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c700020.filter1(c)
	return (c:IsSetCard(0x235) and not c:IsCode(700020)) and c:IsAbleToHand()
end
function c700020.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c700020.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end