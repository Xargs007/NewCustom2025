--X・HERO ワンダー・ドライバー
--Xtra HERO Wonder Driver
--Scripted by Eerie Code
function c1948618.initial_effect(c)
	--c:EnableReviveLimit()
	--aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x8),2,2)
	--set
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e1:SetDescription(aux.Stringid(1948619,0))
	--e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	--e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCountLimit(1,1948619)
	--e1:SetRange(LOCATION_MZONE)
	--e1:SetCondition(c1948618.setcon)
	--e1:SetTarget(c1948618.settg)
	--e1:SetOperation(c1948618.setop)
	--c:RegisterEffect(e1)
	--active fusion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,1948619)
	e1:SetCost(c1948618.spcost)
	e1:SetCondition(c1948618.setcon)
	e1:SetTarget(c1948618.tg)
	e1:SetOperation(c1948618.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,1948618)
	c:RegisterEffect(e2)
	local e02=e1:Clone()
	e02:SetCountLimit(1,1948618)
	e02:SetCode(EVENT_BECOME_TARGET)
	c:RegisterEffect(e02)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1)
	e3:SetCondition(c1948618.spcon)
	e3:SetTarget(c1948618.sptg)
	e3:SetOperation(c1948618.spop)
	c:RegisterEffect(e3)
end
function c1948618.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c1948618.setcfilter(c,tp,lg)
	return c:IsFaceup() and c:IsControler(tp) and c:IsSetCard(0x8)
end
function c1948618.setcon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler()
	return eg:IsExists(c1948618.setcfilter,1,nil,tp,lg)
end
function c1948618.setfilter(c)
	return ((c:IsType(TYPE_SPELL) and c:IsSetCard(0x46)) or (c:IsType(TYPE_QUICKPLAY) and c:IsSetCard(0xa5))) and c:IsSSetable()
end
function c1948618.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1948618.setfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c1948618.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c1948618.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsSSetable() then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c1948618.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE)
		or (rp==1-tp and c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp)
end
function c1948618.spfilter(c,e,tp)
	return c:IsSetCard(0x8) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not c:IsCode(1948618)
end
function c1948618.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1948618.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c1948618.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1948618.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end





function c1948618.filter1(c,e,tp,eg,ep,ev,re,r,rp)
	return c:CheckActivateEffect(false,true,false)~=nil and (((c:IsType(TYPE_SPELL) and c:IsSetCard(0x46))) or (c:IsCode(24094653) or c:IsCode(45906428) or c:IsCode(12071500)or c:IsCode(94820406) or c:IsCode(35255456) or c:IsCode(54283059)) and (c:IsCode(24094653) or c:IsCode(45906428) or c:IsCode(12071500) or c:IsCode(94820406) or c:IsCode(35255456) or c:IsCode(54283059)) or (c:IsSetCard(0xa5) and c:IsType(TYPE_QUICKPLAY)) and (c:IsCode(48130397) or c:IsCode(911000814) or c:IsCode(170000117)) and (c:IsCode(100000470) or c:IsCode(100405101))) and not (c:IsCode(77565204))
end
function c1948618.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c1948618.filter1,tp,LOCATION_DECK,0,1,nil) end
	local tc=Duel.SelectMatchingCard(tp,c1948618.filter1,tp,LOCATION_DECK,0,1,1,nil)
	e:SetLabel(1)
	local te,eg,ep,ev,re,r,rp=tc:GetFirst():CheckActivateEffect(false,true,true)
	e:SetLabelObject(tc:GetFirst())
	local tc=e:GetLabelObject()
	local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(false,true,true)
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	--Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c1948618.op(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
    if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	e:SetLabel(0)
end




--Magical Trick Mirror
--function c1948618.initial_effect(c)
	--copy Spell
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_ACTIVATE)
	--e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	--e1:SetCondition(c1948618.condition)
	--e1:SetTarget(c1948618.target)
	--e1:SetOperation(c1948618.operation)
	--c:RegisterEffect(e1)
--end
function c1948618.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c1948618.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil and not c:IsType(TYPE_FIELD)
end
function c1948618.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) or chkc:IsLocation(LOCATION_MZONE) and chkc:GetControler()~=tp and c511001112.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1948618.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c1948618.filter,tp,0,LOCATION_GRAVE,1,1,nil)
end
function c1948618.operation(e,tp,eg,ep,ev,re,r,rp)
 local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if c:IsRelateToEffect(e) and not tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
	end
	if c:IsRelateToEffect(e) and tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local code=tc:GetOriginalCode()
		c:CopyEffect(code,nil,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
		c:CancelToGrave()
	end
end

