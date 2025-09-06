--Cat Hero Blacky (Fix)
function c600003.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600003,0))
	--e1:SetCategory(CATEGORY_SUMMON)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	--e1:SetCost(c600003.spcost)
	e1:SetTarget(c600003.target)
	e1:SetOperation(c600003.operation)
	c:RegisterEffect(e1)
	--Activate(summon)
	local e01=Effect.CreateEffect(c)
	e01:SetCategory(CATEGORY_TODECK)
	e01:SetType(EFFECT_TYPE_QUICK_O)
	--e01:SetCode(EVENT_SUMMON_SUCCESS)
	e01:SetCode(EVENT_SPSUMMON_SUCCESS)
	e01:SetRange(LOCATION_HAND)
	e01:SetCost(c600003.cost)
	--e01:SetCondition(c5832914.condition1)
	e01:SetTarget(c600003.target1)
	e01:SetOperation(c600003.activate1)
	c:RegisterEffect(e01)
	--local e2=e01:Clone()
--  e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	--c:RegisterEffect(e2)
	--local e4=e01:Clone()
	--e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	--c:RegisterEffect(e4)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
end

function c600003.filter(c,e,tp)
	return  (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4)--c:GetCode()==100000171
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c600003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c600003.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c600003.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600003.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c600003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end

--function c600003.cfilter(c)
--  return c:IsFaceup() and c:IsType(TYPE_TOON)
--end
--function c600003.conditio1n(e,tp,eg,ep,ev,re,r,rp)
--  return Duel.IsExistingMatchingCard(c600003.cfilter,tp,LOCATION_MZONE,0,1,nil)
--end
function c600003.filter1(c,tp)
	return c:GetSummonPlayer()==tp and c:IsAbleToDeck()
end
function c600003.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c600003.filter1,1,nil,1-tp) end
	local g=eg:Filter(c600003.filter1,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c600003.activate1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end

