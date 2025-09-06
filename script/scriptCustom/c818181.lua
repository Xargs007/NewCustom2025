--Kill Beell
function c818181.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,818181)
	e1:SetCondition(c818181.condition)
	e1:SetTarget(c818181.target)
	e1:SetOperation(c818181.activate)
	c:RegisterEffect(e1)
end
function c818181.cfilter(c)
	return c:IsFaceup() and c:IsCode(909090)
end
function c818181.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c818181.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c818181.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c818181.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c818181.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c818181.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c818181.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c818181.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end