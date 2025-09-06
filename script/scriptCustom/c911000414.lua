--ハーピィ・ダンサー
function c911000414.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(911000412,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c911000414.sumlimit)
	e1:SetCost(c911000414.cost1)
	e1:SetTarget(c911000414.target1)
	e1:SetOperation(c911000414.activate1)
	c:RegisterEffect(e1)
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e02:SetType(EFFECT_TYPE_IGNITION)
	e02:SetRange(LOCATION_GRAVE)
	e02:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e02:SetCondition(aux.exccon)
	e02:SetCondition(c911000414.spcon)
	e02:SetCost(c911000414.cost2)
	e02:SetTarget(c911000414.target2)
	e02:SetOperation(c911000414.operation2)
	c:RegisterEffect(e02)
end

function c911000414.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_MONSTER)
end

c911000414.dark_magician_list=true

function c911000414.filterww(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c911000414.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c911000414.filterww,tp,LOCATION_MZONE,0,0,e:GetHandler())
end

function c911000414.sumlimit(e,tp)
	return Duel.IsExistingMatchingCard(c911000414.filter,tp,LOCATION_MZONE,0 ,1,nil)
end
--function c911000414.sumlimit2(e,tp)
	--return Duel.IsExistingMatchingCard(c911000414.filter,tp,LOCATION_MZONE,0 ,1,nil)--Duel.GetLocationCount(tp,LOCATION_MZONE)==0
--end
--function c911000414.sumlimit2(e,c)
	--return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
	--	and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
	--Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0
	--Duel.GetLocationCount(c,LOCATION_MZONE)<=0
--end
c911000414.countM=1

function c911000414.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c911000414.filter,tp,LOCATION_MZONE,1,1,nil) end --Duel.CheckReleaseGroup(tp,c911000412.filter,3,nil)
	--local g=Duel.SelectReleaseGroup(tp,c911000412.filter,3,1,nil)
	local g=Duel.SelectTarget(tp,c911000414.filter,tp,LOCATION_MZONE,0,1,1,nil)
	c911000414.countM=g:GetCount()
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end

function c911000414.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c911000414.sumfilter,tp,LOCATION_DECK,c911000414.countM,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,c911000414.countM,tp,LOCATION_DECK)
end

function c911000414.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c911000414.sumfilter,tp,LOCATION_DECK,0,1,c911000414.countM,nil,e,tp)
	if g:GetCount()~=0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end

function c911000414.filter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsFaceup() and c:IsAbleToDeck()
end

function c911000414.sumfilter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and (c:GetLevel()<=7) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not (c:IsCode(100417002) or c:IsCode(9596126))--and c:IsSummonable(true,nil)
end

--effect 2

function c911000414.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end

function c911000414.filter2(c,e,tp)
	return c:IsType(TYPE_FUSION) and c:GetLevel()<=6 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end

function c911000414.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c911000414.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c911000414.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c911000414.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)~=0 then
		--local e1=Effect.CreateEffect(e:GetHandler())
		--e1:SetType(EFFECT_TYPE_SINGLE)
		--e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		--e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		--e1:SetReset(RESET_EVENT+0x1fe0000)
		--tc:RegisterEffect(e1,true)
		--local e2=Effect.CreateEffect(e:GetHandler())
		--e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		--e2:SetCode(EVENT_PHASE+PHASE_END)
		--e2:SetCountLimit(1)
		--e2:SetRange(LOCATION_MZONE)
		--e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		--e2:SetOperation(c34206604.retop)
		--tc:RegisterEffect(e2)
	end
end
function c911000414.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
end

