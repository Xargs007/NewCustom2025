--Domain of the Dark Ruler
--魔宮の賄賂
function c911000464.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c911000464.condition)
	e1:SetTarget(c911000464.target)
	e1:SetOperation(c911000464.activate)
	c:RegisterEffect(e1)
end
function c911000464.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c911000464.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
	--Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c911000464.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	--Duel.Draw(1-tp,1,REASON_EFFECT)
end


--function c911000464.initial_effect(c)
	--Activate
	--local e1=Effect.CreateEffect(c)
	--e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	--e1:SetType(EFFECT_TYPE_ACTIVATE)
	--e1:SetCode(EVENT_CHAINING)
	--c:RegisterEffect(e1)
	--disable
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(911000464,0))
	--e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	--e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	--e1:SetRange(LOCATION_MZONE)
	--e1:SetCode(EVENT_CHAINING)
	--e1:SetCondition(c911000464.discon)
	--e1:SetCost(c911000464.discost)
	--e1:SetTarget(c911000464.distg)
	--e1:SetOperation(c911000464.disop)
	--c:RegisterEffect(e1)
--end

--function c911000464.discon(e,tp,eg,ep,ev,re,r,rp)
	--return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		--and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
--end
--function c911000464.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	--Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
--end
--function c911000464.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return true end
	--Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
--end
--function c911000464.disop(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	--Duel.NegateActivation(ev)
--end