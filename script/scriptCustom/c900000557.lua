--未来への希望
function c900000557.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c900000557.condition)
	e1:SetCost(c900000557.newcost)
	e1:SetTarget(c900000557.target)
	e1:SetOperation(c900000557.activate)
	c:RegisterEffect(e1)
end

function c900000557.newcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900000557.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c900000557.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end

function c900000557.cfilter(c)
	return c:IsCode(89943723) and c:IsFaceup()
end
function c900000557.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c900000557.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c900000557.costfilter(c)
	return (c:IsCode(24094653) or ((c:GetType()==TYPE_SPELL))) and (c:IsCode(24094653) or c:IsCode(45906428) or c:IsCode(12071500) or c:IsCode(94820406) or c:IsCode(35255456) or c:IsCode(54283059)) and (c:IsCode(24094653) or c:IsCode(45906428) or c:IsCode(12071500) or c:IsCode(94820406) or c:IsCode(35255456) or c:IsCode(54283059)) and (c:IsSetCard(0xa5) and c:IsType(TYPE_QUICKPLAY)) and (c:IsCode(48130397) or c:IsCode(77565204) or c:IsCode(911000814) or c:IsCode(170000117)) and c:IsAbleToDeck()
end
function c900000557.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900000557.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c900000557.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c900000557.filter1(c,tp)
	if not c:IsAbleToGrave() then return false end
	return Duel.IsExistingMatchingCard(c900000557.filter2,tp,LOCATION_EXTRA,0,1,nil,c)
end
function c900000557.filter2(c,mc)
	return c.material and mc:IsCode(table.unpack(c.material)) and c:IsSetCard(0x9)
end
function c900000557.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900000557.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c900000557.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c900000557.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,nil,tp)
	Duel.SendtoGrave(g,REASON_EFFECT)
end

function c900000557.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c900000557.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c900000557.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectMatchingCard(tp,c900000557.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,ft,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
