--幻想の黒魔導師
function c900901254.initial_effect(c)
	--xyz summon
	--aux.AddXyzProcedure(c,nil,7,2,c96471335.ovfilter,aux.Stringid(96471335,0))
	c:EnableReviveLimit()
	--aux.AddFusionProcCodeFun(c,(46986414),aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1,false,false)
	Fusion.AddProcMixN(c,false,false,CARD_DARK_MAGICIAN,1,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1)
	--spsummon fusion condition
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	--e1:SetValue(aux.fuslimit)
	--c:RegisterEffect(e1)
	--special summon rule
	--local e02=Effect.CreateEffect(c)
	--e02:SetType(EFFECT_TYPE_FIELD)
	--e02:SetCode(EFFECT_SPSUMMON_PROC)
	--e02:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	--e02:SetRange(LOCATION_EXTRA)
	--e02:SetCondition(c900901254.sprcon)
	--e02:SetOperation(c900901254.sprop)
	--c:RegisterEffect(e02)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(900901254,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	--e2:SetCost(c900901254.cost)
	e2:SetTarget(c900901254.target)
	e2:SetOperation(c900901254.operation)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(900901254,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c900901254.rmcon)
	e3:SetTarget(c900901254.rmtg)
	e3:SetOperation(c900901254.rmop)
	c:RegisterEffect(e3)
end
--
c900901254.listed_names={CARD_DARK_MAGICIAN,CARD_DARK_MAGICIAN_GIRL}
function c900901254.spfilter1(c,tp)
	return c:IsFusionCode(46986414) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial(nil,true)
		and Duel.IsExistingMatchingCard(c900901254.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c900901254.spfilter2(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c900901254.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c900901254.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c900901254.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(900901253,2))
	local g1=Duel.SelectMatchingCard(tp,c900901254.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(900901253,3))
	local g2=Duel.SelectMatchingCard(tp,c900901254.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
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
function c900901254.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,math.floor(Duel.GetLP(tp)/2)) end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c900901254.filter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c900901254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c900901254.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c900901254.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c900901254.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		--Duel.PayLPCost(tp,1000)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c900901254.filter2(c,e,tp)
	return c:IsType(TYPE_MONSTER)
end
function c900901254.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsType(TYPE_NORMAL) and tc:IsRace(RACE_SPELLCASTER)
end
function c900901254.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingMatchingCard(c900901254.filter2,tp,0,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c900901254.filter2,tp,0,LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.PayLPCost(tp,500)
end
function c900901254.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
