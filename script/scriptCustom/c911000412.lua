--ハーピィ・ダンサー
function c911000412.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(911000412,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c911000412.sumlimit)
	e1:SetCost(c911000412.cost1)
	e1:SetTarget(c911000412.target1)
	e1:SetOperation(c911000412.activate1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(911000412,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c911000412.sumlimit2)
	e2:SetCost(c911000412.cost2)
	e2:SetTarget(c911000412.target2)
	e2:SetOperation(c911000412.activate2)
	c:RegisterEffect(e2)
end

function c911000412.sumlimit(e,tp)
	return Duel.IsExistingMatchingCard(c911000412.filter,tp,LOCATION_MZONE,0 ,1,nil)
end

c911000412.countM=1

function c911000412.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c911000412.filter,tp,LOCATION_MZONE,3,1,nil) end --Duel.CheckReleaseGroup(tp,c911000412.filter,3,nil)
	--local g=Duel.SelectReleaseGroup(tp,c911000412.filter,3,1,nil)
	local g=Duel.SelectTarget(tp,c911000412.filter,tp,LOCATION_MZONE,0,1,3,nil)
	c911000412.countM=g:GetCount()
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end

function c911000412.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c911000412.sumfilter,tp,LOCATION_DECK,c911000412.countM,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,c911000412.countM,tp,LOCATION_DECK)
end

function c911000412.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c911000412.sumfilter,tp,LOCATION_DECK,0,3,c911000412.countM,nil,e,tp)
	if g:GetCount()~=0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end

function c911000412.filter(c)
	return c:IsSetCard(0x8) and c:IsFaceup() and c:IsAbleToDeck()
end

function c911000412.sumfilter(c,e,tp)
	return c:IsSetCard(0x1f) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)--and c:IsSummonable(true,nil)
end

--effect 2

function c911000412.sumlimit2(e,tp)
	return Duel.IsExistingMatchingCard(c911000412.filter2,tp,LOCATION_MZONE,0 ,1,nil)
end

function c911000412.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c911000412.filter2,tp,LOCATION_MZONE,3,1,nil) end--Duel.CheckReleaseGroup(tp,c911000412.filter2,1,nil) end
	--local g=Duel.SelectReleaseGroup(tp,c911000412.filter,3,1,nil)
	local g=Duel.SelectTarget(tp,c911000412.filter2,tp,LOCATION_MZONE,0,1,3,nil)
	c911000412.countM=g:GetCount()
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end

function c911000412.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c911000412.sumfilter2,tp,LOCATION_DECK,3,c911000412.countM,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,c911000412.countM,tp,LOCATION_DECK)
end

function c911000412.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c911000412.sumfilter2,tp,LOCATION_DECK,0,3,c911000412.countM,nil,e,tp)
	if g:GetCount()~=0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end

function c911000412.filter2(c)
	return c:IsSetCard(0x1f) and c:IsFaceup() and c:IsAbleToDeck()
end

function c911000412.sumfilter2(c,e,tp)
	return c:IsSetCard(0x8) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)--and c:IsSummonable(true,nil)
end

