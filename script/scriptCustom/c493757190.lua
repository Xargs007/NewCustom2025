--サイバー・チュチュ
function c493757190.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c493757190.dacon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c493757190.negcost)
	e2:SetTarget(c493757190.target2)
	e2:SetOperation(c493757190.operation2)
	c:RegisterEffect(e2)
end
function c493757190.filter(c,atk)
	return c:IsFacedown() or c:GetAttack()<=atk
end
function c493757190.dacon(e)
	return not Duel.IsExistingMatchingCard(c493757190.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end

--new
function c493757190.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c493757190.filter2(c)
	--return (((c:IsRace(RACE_FAIRY) or c:IsRace(RACE_WARRIOR) or (bit.band(c:GetType(),0x82)==0x82)) and not c:IsCode(493757190))) and c:IsAbleToHand()
	return c:IsAbleToDeck() and not c:IsCode(493757190)--(((c:IsRace(RACE_FAIRY) or c:IsRace(RACE_WARRIOR)) and not c:IsCode(493757190))) and c:IsAbleToHand()
end
function c493757190.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVED+LOCATION_REMOVED) and chkc:IsControler(tp) and c493757190.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c493757190.filter2,tp,LOCATION_GRAVED+LOCATION_REMOVED,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATODECK)
	local g=Duel.SelectTarget(tp,c493757190.filter2,tp,LOCATION_GRAVED+LOCATION_REMOVED,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c493757190.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
