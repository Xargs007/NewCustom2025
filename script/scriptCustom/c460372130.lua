--ガーディアン・トライス
function c460372130.initial_effect(c)
	--sum limit
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_CANNOT_SUMMON)
	--e1:SetCondition(c460372130.sumlimit)
	--c:RegisterEffect(e1)
	--local e2=e1:Clone()
	--e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	--c:RegisterEffect(e2)
	--local e3=e1:Clone()
	--e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	--c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(460372130,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c460372130.spcon)
	e4:SetTarget(c460372130.sptg)
	e4:SetOperation(c460372130.spop)
	c:RegisterEffect(e4)
	--special summon arm hand
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SPSUMMON_PROC)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetRange(LOCATION_HAND+LOCATION_DECK)
	e5:SetCondition(c460372130.spcon2)
	c:RegisterEffect(e5)
end
function c460372130.filter(c,e,tp)
	return c:IsCode(170000207) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) --and c:IsSetCard(0x8)
end
function c460372130.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c460372130.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c460372130.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c460372130.filter,tp,LOCATION_DECK+LOCATION_GRAVE0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end
function c460372130.cfilter(c)
	return c:IsFaceup() and c:IsCode(21900719)
end
function c460372130.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c460372130.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c460372130.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c460372130.spfilter(c,e,tp,rc)
	return c:IsLocation(LOCATION_GRAVE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c460372130.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local g=e:GetHandler():GetMaterial():Filter(c460372130.spfilter,nil,e,tp,e:GetHandler())
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c460372130.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=g:GetCount()
	if ct>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c460372130.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c460372130.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end