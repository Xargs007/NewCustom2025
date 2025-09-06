--Necro Knight
function c700013.initial_effect(c)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700013,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,700013)
	e1:SetTarget(c700013.target)
	e1:SetOperation(c700013.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,700013)
	c:RegisterEffect(e2)
	--summon success
	--remove
	local e01=Effect.CreateEffect(c)
	e01:SetCategory(CATEGORY_REMOVE)
	e01:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e01:SetDescription(aux.Stringid(700013,1))
	e01:SetCode(EVENT_TO_GRAVE)
	e01:SetCountLimit(1,700013)
	e01:SetCondition(c700013.condtion1)
	e01:SetTarget(c700013.rmtg)
	e01:SetOperation(c700013.rmop)
	c:RegisterEffect(e01)
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_TOHAND+CATEGORY_HANDES)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e02:SetDescription(aux.Stringid(700013,2))
	e02:SetCode(EVENT_TO_GRAVE)
	e02:SetCountLimit(1,700013)
	e02:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e02:SetCondition(c700013.condtion1)
	e02:SetTarget(c700013.thtg)
	e02:SetOperation(c700013.thop)
	c:RegisterEffect(e02)
end

function c700013.condtion1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end

function c700013.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,1-tp,LOCATION_DECK)
end

function c700013.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g2=Duel.GetDecktopGroup(1-tp,2)
	Duel.DisableShuffleCheck()
	Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
end

function c700013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end

function c700013.filterb(c)
	return c:IsSetCard(0x235) and c:IsAbleToHand() and c:IsFaceup() --and c:IsLocation(LOCATION_GRAVE)
end

function c700013.thop(e,tp,eg,ep,ev,re,r,rp)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c700013.filterb(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700013.filterb,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c700013.filterb,tp,LOCATION_GRAVE,0,2,2,e:GetHandler())
	--local tc=Duel.GetFirstTarget()
	if Duel.IsExistingTarget(c700013.filterb,tp,LOCATION_GRAVE,0,1,e:GetHandler()) then
		Duel.SendtoHand(g,2,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
	end
end


c700013.lvmi=6

function c700013.spfilter(c,e,tp)
	return c:IsLevelBelow(c700013.lvmi) and c:IsSetCard(0x235) and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP) and c:IsType(TYPE_MONSTER)
end
function c700013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c700013.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) and c700013.lvmi<=6 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c700013.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and c700013.lvmi<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c700013.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and c700013.lvmi >0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.ConfirmCards(1-tp,g)
		c700013.lvmi=c700013.lvmi-1
	end
end