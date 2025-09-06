--次元均衡
function c90901250.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--aux.AddFusionProcFun2(c,c90901250.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--aux.AddFusionProcCodeFun(c,38033121,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1,false,false)
	--aux.AddFusionProcCodeFun(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x30a2),aux.FilterBoolFunction(Card.IsFusionSetCard,0x20a2),1,false,false)
	--aux.AddFusionProcCodeFun(c,aux.FilterBoolFunction(Card.IsCode,38033121),aux.FilterBoolFunction(c90901250.ffffilter),1,false,false)
	Fusion.AddProcMix(c,false,false,CARD_DARK_MAGICIAN_GIRL,aux.FilterBoolFunction(c90901250.ffffilter))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c90901250.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	--local e02=Effect.CreateEffect(c)
	--e02:SetType(EFFECT_TYPE_FIELD)
	--e02:SetCode(EFFECT_SPSUMMON_PROC)
	--e02:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	--e02:SetRange(LOCATION_EXTRA)
	--e02:SetCondition(c90901250.sprcon)
	--e02:SetOperation(c90901250.sprop)
	--c:RegisterEffect(e02)
	--effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90901250,0))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,90901250)
	e2:SetCost(c90901250.costLP)
	e2:SetTarget(c90901250.target1)
	e2:SetOperation(c90901250.operation1)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90901250,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,90901250)
	--e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	--e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	--e3:SetCondition(c90901250.con1)
	e3:SetCost(c90901250.costBani)
	e3:SetTarget(c90901250.target2)
	e3:SetOperation(c90901250.operation2)
	c:RegisterEffect(e3)
	--change name
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetCode(EFFECT_CHANGE_CODE)
	--e4:SetRange(LOCATION_MZONE)
	--e4:SetValue(38033121)
	--c:RegisterEffect(e4)
end
c90901250.material_setcode={0x10a2,0x20a2}
function c90901250.ffffilter(c)
	return c:IsSetCard(0x20a2) and c:IsType(TYPE_MONSTER)
end
function c90901250.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c90901250.spfilter1(c,tp)
	return c:IsFusionCode(38033121) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial(nil,true)
		and Duel.IsExistingMatchingCard(c90901250.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c90901250.spfilter2(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c90901250.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c90901250.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c90901250.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(90901250,2))
	local g1=Duel.SelectMatchingCard(tp,c90901250.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(90901250,3))
	local g2=Duel.SelectMatchingCard(tp,c90901250.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.PayLPCost(tp,1000)
	Duel.SendtoGrave(g1,nil,2,REASON_COST)
end
--function c90901250.ffilter(c)
--	return c:IsCode(38033121) --or c:IsCode(80014003)--c:IsSetCard(0x9d) c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO)
--end
function c90901250.con1(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(900901251)==0
end
function c90901250.costLP(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c90901250.costBani(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c90901250.costCombi(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.PayLPCost(tp,500)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c90901250.filter1(c)
	return c:IsControlerCanBeChanged()
end
function c90901250.filter2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90901250.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c90901250.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90901250.filter1,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c90901250.filter1,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c90901250.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c90901250.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c90901250.filter2,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c90901250.filter2,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c90901250.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetControl(tc,tp,PHASE_END,1) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
function c90901250.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
