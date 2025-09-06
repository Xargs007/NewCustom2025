--ウィジャ盤
function c942124380.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(942124380,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c942124380.condition)
	e2:SetOperation(c942124380.operation)
	c:RegisterEffect(e2)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c942124380.tgcon)
	e3:SetOperation(c942124380.tgop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c942124380.tgop)
	c:RegisterEffect(e4)
end
function c942124380.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c942124380.cfilter1(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c942124380.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c942124380.cfilter1,tp,LOCATION_SZONE,0,1,nil,31893528) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(942124380,1))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,31893528)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif not Duel.IsExistingMatchingCard(c942124380.cfilter1,tp,LOCATION_SZONE,0,1,nil,67287533) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(942124380,1))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,67287533)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif not Duel.IsExistingMatchingCard(c942124380.cfilter1,tp,LOCATION_SZONE,0,1,nil,94772232) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(942124380,1))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,94772232)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif not Duel.IsExistingMatchingCard(c942124380.cfilter1,tp,LOCATION_SZONE,0,1,nil,30170981) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(942124380,1))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,30170981)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Win(tp,0x15)
		end
	end
end
function c942124380.cfilter2(c,tp)
	local code=c:GetCode()
	return (code==942124380 or code==31893528 or code==67287533 or code==94772232 or code==30170981) and c:IsControler(tp)
end
function c942124380.cfilter3(c)
	local code=c:GetCode()
	return c:IsFaceup() and (code==942124380 or code==31893528 or code==67287533 or code==94772232 or code==30170981)
end
function c942124380.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c942124380.cfilter2,1,nil,tp)
end
function c942124380.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c942124380.cfilter3,tp,LOCATION_SZONE,0,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
