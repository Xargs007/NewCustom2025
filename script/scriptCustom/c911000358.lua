--Miracle of Draconian Wrath
function c911000358.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c911000358.condition)
	e1:SetTarget(c911000358.target)
	e1:SetOperation(c911000358.operation)
	c:RegisterEffect(e1)
end
function c911000358.cfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsSetCard(0xdd)
end
function c911000358.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c911000358.cfilter,nil,tp)
	return g
end
function c911000358.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c911000358.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingMatchingCard(c911000358.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c911000358.filter,tp,LOCATION_DECK,0,2,2,nil)
end
function c911000358.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>1 then
		Duel.SSet(tp,g:GetFirst())
		Duel.SSet(tp,g:GetNext())
		Duel.ConfirmCards(1-tp,g)
	end
end
