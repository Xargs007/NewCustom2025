--XYZ－ドラゴン・キャノン
function c919981190.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--aux.AddFusionProcCode3(c,62651957,65622692,64500000,true,true)
	Fusion.AddProcMix(c,true,true,62651957,65622692,64500000)
	Fusion.AddContactProc(c,c919981190.contactfil,c919981190.contactop,c919981190.splimit)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c919981190.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCountLimit(1,(919981190 or 91998120 or 91998121 or 2111707 or 25119460 or 99724761))
	e2:SetCondition(c919981190.spcon)
	e2:SetOperation(c919981190.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(919981190,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(3,919981190)
	e3:SetCost(c919981190.descost)
	e3:SetTarget(c919981190.destg)
	e3:SetOperation(c919981190.desop)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(919981190,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c919981190.spcost)
	e4:SetTarget(c919981190.target)
	e4:SetOperation(c919981190.operation)
	c:RegisterEffect(e4)
end
function c919981190.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,nil)--Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c919981190.contactop(g)
	--Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_MATERIAL)
	Duel.SendtoGrave(g,POS_FACEUP,REASON_COST+REASON_MATERIAL)
end
function c919981190.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA+LOCATION_GRAVE)
end
function c919981190.spfilter(c,code)
	return c:IsFusionCode(code) and c:IsAbleToGraveAsCost()
end
function c919981190.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,nil,62651957)
		and Duel.IsExistingMatchingCard(c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,nil,65622692)
		and Duel.IsExistingMatchingCard(c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,nil,64500000)
end
function c919981190.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,62651957)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,65622692)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c919981190.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,64500000)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c919981190.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c919981190.filter(c)
	return c:IsDestructable()
end
function c919981190.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c919981190.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c919981190.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c919981190.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c919981190.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--
function c919981190.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,0,REASON_COST)
end
function c919981190.spmfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c919981190.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingTarget(c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,62651957)
		and Duel.IsExistingTarget(c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,65622692)
		and Duel.IsExistingTarget(c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,64500000) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,62651957)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,65622692)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c919981190.spmfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,64500000)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c919981190.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end