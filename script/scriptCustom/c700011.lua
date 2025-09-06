--Necro Cycle
function c700011.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,700011)
	e1:SetTarget(c700011.target7)
	--e1:SetOperation(c700011.spop1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(700011,1))
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,700011)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c700011.spcon1)
	e2:SetTarget(c700011.sptg1)
	e2:SetOperation(c700011.spop1)
	c:RegisterEffect(e2)
	--to hand
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCategory(CATEGORY_TOHAND)
	e6:SetDescription(aux.Stringid(700011,0))
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c700011.condtion)
	e6:SetTarget(c700011.target)
	e6:SetOperation(c700011.operation)
	c:RegisterEffect(e6)
	--spsummon necrofear
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e02:SetType(EFFECT_TYPE_QUICK_O)
	e02:SetDescription(aux.Stringid(700011,2))
	e02:SetCode(EVENT_FREE_CHAIN)
	e02:SetRange(LOCATION_SZONE)
	e02:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e02:SetCountLimit(1,700011)
	e02:SetHintTiming(0,TIMING_END_PHASE)
	e02:SetCondition(c700011.condition1)
	e02:SetCost(c700011.cost)
	e02:SetTarget(c700011.target1)
	e02:SetOperation(c700011.op7)
	c:RegisterEffect(e02)
end

function c700011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700011.spfil,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c700011.spfil,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

function c700011.spfil(c)
	return (c:IsRace(RACE_FIEND) or c:IsRace(RACE_ZOMBIE)) and c:IsAbleToRemoveAsCost() and not c:IsCode(31829185)
end

function c700011.spfil2(c)
	return c:IsType(TYPE_MONSTER)
end

function c700011.condition1(e,tp,eg,ep,ev,re,r,rp)--c700011.condition1(e,c)
	if c==nil then return true end
	--local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c700011.spfil,tp,LOCATION_GRAVE,0,2,nil)
		and Duel.IsExistingMatchingCard(c700011.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
		and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)>2 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=0
end

function c700011.filter3(c,e,tp)
	return c:IsCode(31829185)
end

function c700011.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c700011.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)>2 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c700011.op7(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c700011.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c700011.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x235) and c:IsType(TYPE_MONSTER)
end
function c700011.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700011.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c700011.spfilter1(c,e,tp)
	return c:IsSetCard(0x235) and c:IsLevelBelow(4) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and not c:IsType(TYPE_FUSION)
end
function c700011.spfilter2(c,e,tp)
	return c:IsSetCard(0x235) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_EFFECT) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and not c:IsType(TYPE_FUSION)
end
function c700011.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_DECK) and chkc:IsControler(tp) and c700011.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c700011.spfilter1,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetFlagEffect(tp,700011)==0 end
	Duel.RegisterFlagEffect(tp,700011,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c700011.spfilter1,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	local atk=g:GetFirst():GetTextAttack()
	local def=g:GetFirst():GetTextDefense()
	--local def=g:GetFirst():GetTextDefence()
	if g:GetFirst():IsType(TYPE_EFFECT) and atk > def then
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(atk)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,atk)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	elseif g:GetFirst():IsType(TYPE_EFFECT) and atk < def then
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(def)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,def)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

function c700011.target7(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c700011.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc) end
	if chk==0 then return true end
	if c700011.spcon1(e,tp,eg,ep,ev,re,r,rp) and c700011.sptg1(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(700011,1)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c700011.spop1)
		c700011.sptg1(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end

function c700011.spop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
--[[
function c700011.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700011.filter3,tp,LOCATION_MZONE,0,1,nil)
end
function c700011.filter3(c,e,tp)
	return c:IsSetCard(0x235) and c:IsFaceup()
end
function c700011.filter4(c,e,tp)
	return c:IsSetCard(0x235) --and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsType(TYPE_FUSION)
end
function c700011.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c700011.filter4,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c700011.filter3,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c700011.op7(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c700011.filter4,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
]]--
--function c700011.condition(e,tp,eg,ep,ev,re,r,rp)
--	return bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_DECK)>0
--end

function c700011.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c700011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c700011.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end