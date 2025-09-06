--魂の解放
function c57585000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c57585000.target)
	e1:SetOperation(c57585000.activate)
	c:RegisterEffect(e1)
end
function c57585000.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,5,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	local dam=g:FilterCount(Card.IsRelateToEffect,nil,e)*500
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,dam)
end
function c57585000.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local dam=g:FilterCount(Card.IsRelateToEffect,nil,e)*500
	Duel.Damage(tp,dam/2,REASON_EFFECT)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
