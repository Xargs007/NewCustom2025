--虚空の黒魔導師
--Ebon Void Magician
--Script by dest
function c900901253.initial_effect(c)
	--xyz summon
	--aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),7,2)
	--aux.AddFusionProcCodeFun(c,(46986414),aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1,false,false)
	Fusion.AddProcMixN(c,false,false,CARD_DARK_MAGICIAN,1,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--special summon rule
	--local e02=Effect.CreateEffect(c)
	--e02:SetType(EFFECT_TYPE_FIELD)
	--e02:SetCode(EFFECT_SPSUMMON_PROC)
	--e02:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	--e02:SetRange(LOCATION_EXTRA)
	--e02:SetCondition(c900901253.sprcon)
	--e02:SetOperation(c900901253.sprop)
	--c:RegisterEffect(e02)
	--act qp/trap in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCondition(c900901253.handcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(900901253)
	c:RegisterEffect(e4)
	--activate cost
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_ACTIVATE_COST)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	--e4:SetCost(c900901253.costchk)
	e5:SetTarget(c900901253.costtg)
	--e5:SetOperation(c900901253.costop)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c900901253.spcon)
	e6:SetTarget(c900901253.sptg)
	e6:SetOperation(c900901253.spop)
	c:RegisterEffect(e6)
end
--
c900901253.listed_names={CARD_DARK_MAGICIAN,CARD_DARK_MAGICIAN_GIRL}
function c900901253.spfilter1(c,tp)
	return c:IsFusionCode(46986414) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial(nil,true)
		and Duel.IsExistingMatchingCard(c900901253.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c900901253.spfilter2(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c900901253.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c900901253.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c900901253.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(900901253,2))
	local g1=Duel.SelectMatchingCard(tp,c900901253.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(900901253,3))
	local g2=Duel.SelectMatchingCard(tp,c900901253.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.PayLPCost(tp,1000)
	Duel.SendtoGrave(g1,nil,2,REASON_COST)
end
--
function c900901253.handcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c900901253.filterspcast,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c900901253.filterspcast(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
--
function c900901253.costtg(e,te,tp)
	local tc=te:GetHandler()
	return tc:IsLocation(LOCATION_HAND) and tc:IsType(TYPE_SPELL+TYPE_TRAP)
		and tc:GetEffectCount(EFFECT_QP_ACT_IN_NTPHAND)<=tc:GetEffectCount(900901253) and tc:GetEffectCount(EFFECT_TRAP_ACT_IN_HAND)<=tc:GetEffectCount(900901253)
end
function c900901253.costchk(e,te_or_c,tp)
	return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
end
function c900901253.costop(e,tp,eg,ep,ev,re,r,rp)
	--Duel.Hint(HINT_CARD,0,900901253)
	Duel.CheckLPCost(tp,500)
	Duel.PayLPCost(tp,500)
	--e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
function c900901253.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ((rp~=tp and c:IsReason(REASON_EFFECT) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)) 
		or c:IsReason(REASON_BATTLE))
end
function c900901253.spfilter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(900901253)
end
function c900901253.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c900901253.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c900901253.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c900901253.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(900901253,0)) then
		Duel.BreakEffect()
		local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local des=dg:Select(tp,1,1,nil)
		Duel.HintSelection(des)
		Duel.Destroy(des,REASON_EFFECT)
	end
end