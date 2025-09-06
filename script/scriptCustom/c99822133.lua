--青眼の精霊龍
function c99822133.initial_effect(c)
	--synchro summon
	--aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xdd),1)
	Duel.EnableGlobalFlag(GLOBALFLAG_SPSUMMON_COUNT)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c99822133.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),true)
	--special summon rule
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_FIELD)
	e02:SetCode(EFFECT_SPSUMMON_PROC)
	e02:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e02:SetRange(LOCATION_EXTRA)
	e02:SetCondition(c99822133.sprcon)
	e02:SetOperation(c99822133.sprop)
	c:RegisterEffect(e02)
	--special summon limit
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_FIELD)
	--e1:SetCode(59822133)
	--e1:SetRange(LOCATION_MZONE)
	--e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	--e1:SetTargetRange(1,1)
	--c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99822133,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c99822133.negcon2)
	e2:SetTarget(c99822133.negtg)
	e2:SetOperation(c99822133.negop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(99822133,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	--e3:SetCondition(c99822133.spcon)
	e3:SetCost(c99822133.spcost)
	e3:SetTarget(c99822133.sptg2)
	e3:SetOperation(c99822133.spop2)
	c:RegisterEffect(e3)
	--spsummon count limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_COUNT_LIMIT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c99822133.spfilter3(c)
	return ((c:IsType(TYPE_TUNER) and c:GetLevel()==1) and not (c:IsRace(RACE_DRAGON))) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c99822133.spfilter2(c)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c99822133.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c99822133.spfilter3,tp,LOCATION_ONFIELD,0,1,nil,tp) and Duel.IsExistingMatchingCard(c99822133.spfilter2,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c99822133.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(99822133,2))
	local g1=Duel.SelectMatchingCard(tp,c99822133.spfilter3,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(99822133,3))
	local g2=Duel.SelectMatchingCard(tp,c99822133.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	--Duel.PayLPCost(tp,0)
	Duel.SendtoGrave(g1,nil,2,REASON_COST)
end
function c99822133.ffilter(c)
	return (c:IsType(TYPE_TUNER) and c:GetLevel()==1)
end
function c99822133.negcon2(e,tp,eg,ep,ev,re,r,rp)
	return re:GetActivateLocation()==LOCATION_GRAVE or Duel.IsChainNegatable(ev)
end
function c99822133.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsStatus(STATUS_CHAINING) and Duel.IsChainNegatable(ev) --(re:GetActivateLocation()==LOCATION_GRAVE)
end
function c99822133.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c99822133.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function c99822133.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c99822133.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c99822133.spfilter(c,e,tp)
	return ((c:IsRace(RACE_DRAGON) or (c:IsType(TYPE_TUNER) and c:GetLevel()==1 and c:IsAttribute(ATTRIBUTE_LIGHT))) and not c:IsFusionCode(99822133))  and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c99822133.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c99822133.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c99822133.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c99822133.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end



function c99822133.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c99822133.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c99822133.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectMatchingCard(tp,c99822133.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	--local tc=g:GetFirst()
	--if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENCE)~=0 then
	--	tc:RegisterFlagEffect(59822133,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		--local e1=Effect.CreateEffect(e:GetHandler())
		--e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		--e1:SetCode(EVENT_PHASE+PHASE_END)
	--	e1:SetCountLimit(1)
	--	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	--	e1:SetLabelObject(tc)
	--	e1:SetReset(RESET_PHASE+PHASE_END)
		--e1:SetCondition(c99822133.descon)
		--e1:SetOperation(c99822133.desop)
		--Duel.RegisterEffect(e1,tp)
	--end
end
function c99822133.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffect(99822133)~=0
end
function c99822133.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end
