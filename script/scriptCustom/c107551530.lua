--ガーディアン・シール
function c107551530.initial_effect(c)
	--sum limit
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_CANNOT_SUMMON)
	--e1:SetCondition(c107551530.sumlimit)
	--c:RegisterEffect(e1)
	--local e2=e1:Clone()
	--e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	--c:RegisterEffect(e2)
	--local e3=e1:Clone()
	--e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	--c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(107551530,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCost(c107551530.descost)
	e4:SetTarget(c107551530.destg)
	e4:SetOperation(c107551530.desop)
	c:RegisterEffect(e4)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SPSUMMON_PROC)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetRange(LOCATION_HAND+LOCATION_DECK)
	e5:SetCondition(c107551530.spcon)
	c:RegisterEffect(e5)
end
function c107551530.cfilter(c)
	return c:IsFaceup() and c:IsCode(95638658)
end
function c107551530.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c107551530.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c107551530.costfilter(c,ec)
	return c:IsFaceup() and c:GetEquipTarget()==ec and c:IsAbleToGraveAsCost()
end
--function c107551530.descost(e,tp,eg,ep,ev,re,r,rp,chk)
--	if chk==0 then return Duel.IsExistingMatchingCard(c107551530.costfilter,tp,LOCATION_SZONE,0,1,nil,e:GetHandler()) end
--	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
--	local g=Duel.SelectMatchingCard(tp,c107551530.costfilter,tp,LOCATION_SZONE,0,1,1,nil,e:GetHandler())
--	Duel.SendtoGrave(g,REASON_COST)
--end
--Nueva funcion cost
--------------------------------------------------------------------------------------------------------
function c107551530.eqfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()--c:IsCode(55569674) and c:IsDestructable()--(c:IsCode(55569674) or c:IsCode(95515060) or c:IsCode(58427465) or c:IsCode(95638658) or c:IsCode(69243953) or c:IsCode(32022366) or c:IsCode(21900719)) and c:IsDestructable()
end
function c107551530.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipGroup():IsExists(c107551530.eqfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,c107551530.eqfilter,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
-------------------------------------------------------------------------------------------------------
function c107551530.desfilter(c)
	return c:IsDestructable()
end
function c107551530.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c107551530.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c107551530.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c107551530.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c107551530.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

function c107551530.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c107551530.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
