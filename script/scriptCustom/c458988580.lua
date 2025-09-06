--ボンディング－H2O
function c458988580.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCondition(c458988580.con1)
	e1:SetCost(c458988580.coscost)
	--e1:SetTarget(c458988580.target)
	e1:SetOperation(c458988580.activate)
	c:RegisterEffect(e1)
end
function c458988580.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,2,nil,22587018)
		and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,58071123) end
	local g1=Duel.SelectReleaseGroup(tp,Card.IsCode,2,2,nil,22587018)
	local g2=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,58071123)
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
function c458988580.filter(c,e,tp)
	return c:IsCode(85066822) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c458988580.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c458988580.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c458988580.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c458988580.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
--
function c458988580.filter2(c,e,tp)
	return c:IsCode(22587018)
end
function c458988580.filter3(c,e,tp)
	return c:IsCode(58071123)
end
function c458988580.coscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c458988580.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,2,nil,tp) and Duel.IsExistingMatchingCard(c458988580.filter3,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c458988580.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,2,2,nil,tp)
	local cg2=Duel.SelectMatchingCard(tp,c458988580.filter3,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SendtoGrave(cg,REASON_COST)
	Duel.SendtoGrave(cg2,REASON_COST)
end
function c458988580.spop2(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	--local c=e:GetHandler()
	local token=Duel.CreateToken(tp,85066822)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
function c458988580.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
---