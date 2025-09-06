--賢者の宝石
function c136042010.initial_effect(c)
	--Summon Dark Magician Girl
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(136042010,0))
	e1:SetCountLimit(1,136042010)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c136042010.condition)
	e1:SetTarget(c136042010.target)
	e1:SetOperation(c136042010.activate)
	c:RegisterEffect(e1)
	---Summon Dark Magician
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(136042010,1))
	e2:SetCountLimit(1,136042010)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c136042010.condition2)
	e2:SetTarget(c136042010.target2)
	e2:SetOperation(c136042010.activate2)
	c:RegisterEffect(e2)
end

function c136042010.setfilter(c)
	return (c:IsCode(70168345) or c:IsCode(75190122) or c:IsCode(2314238) or c:IsCode(49702428)) and c:IsSSetable()
end

--Summon Dark Magician Girl

function c136042010.cfilter(c)
	return c:IsFaceup() and (c:IsCode(46986414))
end
function c136042010.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c136042010.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c136042010.filter(c,e,tp)
	return (c:IsCode(38033121)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c136042010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c136042010.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE)
end

function c136042010.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c136042010.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		if Duel.IsExistingMatchingCard(c136042010.setfilter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 --then
		and Duel.SelectYesNo(tp,aux.Stringid(136042010,2)) then
			--Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local st=Duel.SelectMatchingCard(tp,c136042010.setfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			--local tc=st:Select(tp,1,1,nil)
			Duel.SSet(tp,st)
			Duel.ConfirmCards(1-tp,st)
		end
	end
end


--Summon Dark Magician

function c136042010.cfilter2(c)
	return c:IsFaceup() and (c:IsCode(38033121))
end
function c136042010.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c136042010.cfilter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c136042010.filter2(c,e,tp)
	return (c:IsCode(46986414)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c136042010.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c136042010.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE)
end


function c136042010.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c136042010.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		if Duel.IsExistingMatchingCard(c136042010.setfilter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0-- then
		and Duel.SelectYesNo(tp,aux.Stringid(136042010,2)) then
			--Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local st=Duel.SelectMatchingCard(tp,c136042010.setfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			Duel.SSet(tp,st)
			Duel.ConfirmCards(1-tp,st)
		end
	end
end



