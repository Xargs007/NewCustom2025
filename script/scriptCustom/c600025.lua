--Magicat (Fix)
function c600025.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600025,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c600025.tdcon)
	e1:SetTarget(c600025.tdtg)
	e1:SetOperation(c600025.tdop)
	c:RegisterEffect(e1)
end
function c600025.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and (r==REASON_SYNCHRO or r==REASON_SUMMON or r==REASON_SPSUMMON or r==REASON_DISSUMMON or r==REASON_FUSION or r==REASON_RITUAL or r==REASON_XYZ or r==REASON_LINK or r==REASON_MATERIAL)
		and (e:GetHandler():GetReasonCard():IsSetCard(0x1538) or e:GetHandler():GetReasonCard():IsSetCard(0x150e))
end
function c600025.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c600025.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c600025.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600025.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c600025.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c600025.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	end
end