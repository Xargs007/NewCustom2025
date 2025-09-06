--Inviting Cat
function c600013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c600013.condition)
	e1:SetOperation(c600013.activate)
	c:RegisterEffect(e1)
end
function c600013.filter1(c,e,tp)
	return c:IsSetCard(0x1538) and c:IsType(TYPE_MONSTER) --and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c600013.filter2(c,e,tp)
	return (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER) --and c:IsRelease()
end
function c600013.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	and Duel.IsExistingMatchingCard(c600010.filter1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) --Duel.IsExistingMatchingCard(c600013.filter1,tp,0x13,0,1,nil,e,tp) 
	and Duel.CheckReleaseGroup(tp,c600009.filter2,1,nil) --Duel.CheckReleaseGroup(c:GetControler(),Card.IsSetCard,1,nil,0x150e) or 
end

function c600013.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local gr=Duel.SelectReleaseGroup(tp,c600009.filter2,1,1,nil)--Duel.SelectReleaseGroup(c:GetControler(),Card.IsCode,1,1,nil,100000170)
	if gr:GetCount()<1 then return false end		
	Duel.Release(gr,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectTarget(tp,c600013.filter1,tp,0x13,0,1,1,nil,e,tp)
	local g=Duel.SelectMatchingCard(tp,c600013.filter1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
