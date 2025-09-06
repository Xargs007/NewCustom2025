--ラーの翼神竜－球体形
function c90000080.initial_effect(c)
	--Summon with 3 Tribute
	--c:SetUniqueOnField(1,1,911000235)
	--local e145=Effect.CreateEffect(c)
	--e145:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e145:SetDescription(aux.Stringid(90000080,0))
	--e145:SetType(EFFECT_TYPE_FIELD)
	--e145:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	--e145:SetRange(LOCATION_HAND)
	--e145:SetCondition(c90000080.ttcon4)
	--e145:SetOperation(c90000080.ttop4)
	--e145:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e145)
	--local e245=Effect.CreateEffect(c)
	--e245:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e245:SetDescription(aux.Stringid(90000080,1))
	--e245:SetType(EFFECT_TYPE_FIELD)
	--e245:SetRange(LOCATION_HAND)
	--e245:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	--e245:SetTargetRange(POS_FACEUP,1)
	--e245:SetCondition(c90000080.ttcon3)
	--e245:SetOperation(c90000080.ttop3)
	--e245:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e245)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000080,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP,3)
	e1:SetCondition(c90000080.spcon11)
	e1:SetOperation(c90000080.spop11)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000080,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e2:SetRange(LOCATION_HAND)
	--e1:SetTargetRange(POS_FACEUP,1)
	e2:SetCondition(c90000080.spcon12)
	e2:SetOperation(c90000080.spop12)
	c:RegisterEffect(e2)
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(90000080,0))
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	--e1:SetCondition(c90000080.sncon)
	--e1:SetOperation(c90000080.snop)
	--e1:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e1)
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(90000080,1))
	--e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	--e2:SetType(EFFECT_TYPE_SINGLE)
	--e2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	--e2:SetTargetRange(POS_FACEUP_ATTACK,1)
	--e2:SetCondition(c90000080.ttcon2)
	--e2:SetOperation(c90000080.ttop2)
	--e2:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_LIMIT_SET_PROC)
	e3:SetCondition(c90000080.setcon)
	c:RegisterEffect(e3)
	--cannot special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
	--control return
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetOperation(c90000080.retreg)
	c:RegisterEffect(e5)
	--attack limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e6)
	--cannot be target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(aux.imval1)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e8:SetValue(aux.tgoval)
	c:RegisterEffect(e8)
	--spsummon
	--local e9=Effect.CreateEffect(c)
	--e9:SetDescription(aux.Stringid(90000080,2))
	--e9:SetCategory(CATEGORY_SPECIAL_SUMMON)
	--e9:SetType(EFFECT_TYPE_IGNITION)
	--e9:SetRange(LOCATION_MZONE)
	--e9:SetCost(c90000080.spcost)
	--e9:SetTarget(c90000080.sptg)
	--e9:SetOperation(c90000080.spop)
	--c:RegisterEffect(e9)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(90000080,2))
	e9:SetCategory(CATEGORY_TOHAND)
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	--e9:SetCost(c90000080.spcost)
	e9:SetTarget(c90000080.target11)
	e9:SetOperation(c90000080.activate11)
	c:RegisterEffect(e9)
end
function c90000080.filter12(c)
	return (c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_DEVINE)) and (c:IsCode(10000010) or c:IsCode(110000013) or c:IsCode(90000080))
end
function c90000080.spcon11(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(Card.IsReleasable,c:GetControler(),0,LOCATION_MZONE,3,nil)
		and not Duel.IsExistingMatchingCard(c90000080.filter12,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c90000080.spop11(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,0,LOCATION_MZONE,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c90000080.spcon12(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(Card.IsReleasable,c:GetControler(),LOCATION_MZONE,0,3,nil)
		and not Duel.IsExistingMatchingCard(c90000080.filter12,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c90000080.spop12(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,LOCATION_MZONE,0,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c90000080.filter11(c)
	return (c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_DEVINE)) and (c:IsCode(10000010) or c:IsCode(110000013))
end
function c90000080.target11(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_MZONE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
	and Duel.IsExistingMatchingCard(c90000080.filter11,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c90000080.filter12,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c90000080.activate11(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local pos=tc:GetPosition()
	--local g=Duel.GetMatchingGroup(c90000080.filter11,tp,LOCATION_DECK,0,nil)
	local g=Duel.SelectMatchingCard(tp,c90000080.filter11,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tr=g:GetFirst()
	if tc and tc:IsRelateToEffect(e) then
		if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)>0 then
			--local tg=g:GetMaxGroup(Card.GetCode())
			if true then
				--local sg=tr:Select(tp,1,1,tc)
				--Duel.HintSelection(g)
				Duel.MoveToField(tr,tp,tp,LOCATION_MZONE,pos,true)
				local e1=Effect.CreateEffect(tr)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_BASE_ATTACK)
				e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
				e1:SetRange(LOCATION_MZONE)
				e1:SetValue(4000)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tr:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_SET_BASE_DEFENSE)
				e2:SetValue(4000)
				tr:RegisterEffect(e2)
				Duel.SpecialSummonComplete()
				Duel.ShuffleDeck(tp)
			end
		end
	end
end

function c90000080.ttcon3(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(Card.IsReleasable,c:GetControler(),0,LOCATION_MZONE,3,nil)
end
function c90000080.ttop3(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,0,LOCATION_MZONE,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c90000080.ttcon4(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(Card.IsReleasable,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
function c90000080.ttop4(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,LOCATION_MZONE,0,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c90000080.ttcon1(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c90000080.ttop1(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_COST)
end
function c90000080.ttcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>-3 and Duel.GetTributeCount(c,mg,true)>=3
end
function c90000080.ttop2(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local g=Duel.SelectTribute(tp,c,3,3,mg,true)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c90000080.setcon(e,c)
	if not c then return true end
	return false
end
function c90000080.retreg(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(90000080,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetLabel(Duel.GetTurnCount()+1)
	e1:SetCountLimit(1)
	e1:SetCondition(c90000080.retcon)
	e1:SetOperation(c90000080.retop)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c90000080.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel() and e:GetOwner():GetFlagEffect(90000080)~=0
end
function c90000080.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetOwner()
	c:ResetEffect(EFFECT_SET_CONTROL,RESET_CODE)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_CONTROL)
	e1:SetValue(c:GetOwner())
	e1:SetReset(RESET_EVENT+0xec0000)
	c:RegisterEffect(e1)
end
function c90000080.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c90000080.filter(c,e,tp)
	return (c:IsCode(10000010) or c:IsCode(110000013)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c90000080.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c90000080.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c90000080.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000080.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(4000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
