--E・HERO ワイルドマン
function c861884100.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c861884100.efilter)
	c:RegisterEffect(e1)
	--become material
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e02:SetCode(EVENT_BE_MATERIAL)
	e02:SetCondition(c861884100.condition)
	e02:SetTarget(c861884100.target2)
	e02:SetOperation(c861884100.activate2)
	c:RegisterEffect(e02)
end
function c861884100.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end

function c861884100.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(c861884100.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	--local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE+LOCATION_SZONE,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,3,0,0)
end
function c861884100.activate2(e,tp)
	local g=Duel.SelectTarget(tp,c861884100.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,1,3,nil)--Duel.GetMatchingGroup(c58932617.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,3,REASON_EFFECT)
	end
end



--material effect
function c861884100.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c861884100.condition(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c861884100.filter(c)
	return c:IsAbleToDeck()
end
function c861884100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c861884100.filter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c861884100.filter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c861884100.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c861884100.filter,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
