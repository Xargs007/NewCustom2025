--神の宣告
function c414200280.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c414200280.condition)
	e1:SetTarget(c414200280.target)
	e1:SetOperation(c414200280.activate)
	c:RegisterEffect(e1)
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e02:SetType(EFFECT_TYPE_IGNITION)
	e02:SetRange(LOCATION_GRAVE)
	e02:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	e02:SetCondition(aux.exccon)
	--e02:SetCondition(c414200280.negcon)
	e02:SetCost(c414200280.negcost)
	e02:SetTarget(c414200280.target2)
	e02:SetOperation(c414200280.operation2)
	c:RegisterEffect(e02)
end
c414200280.dark_magician_list=true
function c414200280.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c414200280.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	--if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
	--	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	--end
	--Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c414200280.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	--if re:GetHandler():IsRelateToEffect(re) then
	--	Duel.Destroy(eg,REASON_EFFECT)
	--end
	--Duel.Draw(1-tp,1,REASON_EFFECT)
end

--new
function c414200280.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c414200280.filter2(c,e,tp)
	return (c:IsCode(46986414) or c:IsCode(38033121)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c414200280.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c414200280.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c414200280.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c414200280.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.ConfirmCards(1-tp,g)
	end
end
