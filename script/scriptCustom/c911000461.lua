--Monster Replace
function c911000461.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c911000461.target)
	e1:SetOperation(c911000461.activate)
	c:RegisterEffect(e1)
end

function c911000461.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsAttribute(ATTRIBUTE_DIVINE)
end

function c911000461.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then 
		return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,0,1,nil) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE) > 0
			and Duel.IsExistingMatchingCard(c911000461.filter,tp,LOCATION_HAND,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g = Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end

function c911000461.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc = Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local pos = tc:GetPosition()
	
	if Duel.SendtoHand(tc, nil, REASON_EFFECT) > 0 and tc:IsLocation(LOCATION_HAND) then
		local g = Duel.GetMatchingGroup(c911000461.filter, tp, LOCATION_HAND, 0, nil)
		if g:GetCount() == 0 then return end
		
		local tg = g:GetMaxGroup(Card.GetAttack)
		local sg
		if tg:GetCount() > 1 then
			sg = tg:Select(tp, 1, 1, nil)
		else
			sg = tg
		end
		Duel.HintSelection(sg)
		Duel.MoveToField(sg:GetFirst(), tp, tp, LOCATION_MZONE, pos, true)
	end
end