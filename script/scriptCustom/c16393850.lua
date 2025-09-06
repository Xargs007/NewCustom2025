--神竜騎士フェルグラント Divine
function c16393850.initial_effect(c)
	--xyz summon
	--aux.AddXyzProcedure(c,nil,8,2)
	--aux.AddFusionProcFun2(c,c16393850.mfilter1,c16393850.mfilter2,true)
	--aux.AddFusionProcFun2(c,c16393850.mfilter1,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),true)
	Fusion.AddProcMixN(c,true,true,c16393850.mfilter1,1,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16393850,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c16393850.costLP)
	e1:SetTarget(c16393850.target)
	e1:SetOperation(c16393850.operation)
	c:RegisterEffect(e1)
end
function c16393850.mfilter1(c)
	return c:IsRace(RACE_DRAGON) and c:GetLevel()>6
end
function c16393850.mfilter2(c)
	return c:IsRace(RACE_WARRIOR) --and c:GetLevel()==6
end
function c16393850.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c16393850.costLP(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c16393850.filter(c)
	return c:IsFaceup()
end
function c16393850.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c16393850.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16393850.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c16393850.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c16393850.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(c16393850.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c16393850.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
