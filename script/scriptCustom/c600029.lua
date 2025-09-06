--Alchemic Cat
function c600029.initial_effect(c)
    --link summon  
    --aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_EFFECT),2)
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_EFFECT),2)
    c:EnableReviveLimit()
	--immune
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_FIELD)
	e02:SetCode(EFFECT_IMMUNE_EFFECT)
	e02:SetRange(LOCATION_MZONE)
	e02:SetTargetRange(LOCATION_MZONE+LOCATION_MZONE,0)
	e02:SetTarget(c600029.imutg)
	e02:SetValue(1)
	c:RegisterEffect(e02)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c600029.atktg)
	e2:SetValue(c600029.atkval)
	c:RegisterEffect(e2)
	--spsumon Cat
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600029,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	--e3:SetCondition(aux.exccon)
	e3:SetCost(c600029.cpcost)
	--e3:SetCondition(c600008.spcon)
	e3:SetTarget(c600029.sptg)
	e3:SetOperation(c600029.sumop)
	c:RegisterEffect(e3)
	--send to extra deck this card
	local e03=Effect.CreateEffect(c)
	e03:SetDescription(aux.Stringid(600029,0))
	e03:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e03:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e03:SetType(EFFECT_TYPE_IGNITION)
	e03:SetRange(LOCATION_GRAVE)
	e03:SetCountLimit(1)
	e03:SetCondition(aux.exccon)
	e03:SetCost(c600029.cpcost)
	--e3:SetCondition(c600008.spcon)
	e03:SetTarget(c600029.target)
	e03:SetOperation(c600029.operation)
	c:RegisterEffect(e03)
end
--function c600029.filter0(c)
	--return c:IsAbleToHand()
--end
function c600029.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	--local g=Duel.SelectTarget(tp,c600029.filter0,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c600029.operation(e,tp,eg,ep,ev,re,r,rp)
	--local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end

function c600029.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)  
    local c=e:GetHandler()  
    if chk==0 then return c:IsAbleToRemoveAsCost()  
        and Duel.IsExistingMatchingCard(c600029.rmfilter,tp,LOCATION_GRAVE,0,1,nil,c,e,tp,eg,ep,ev,re,r,rp) end  
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)  
    local g=Duel.SelectMatchingCard(tp,c600029.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil,c,e,tp,eg,ep,ev,re,r,rp)  
    Duel.Remove(g,POS_FACEUP,REASON_COST)  
end  
function c600029.rmfilter(c)
	return (c:IsType(TYPE_SPELL)) and c:IsFaceup() and not c:IsCode(600029)
end

function c600029.atktg(e,c)
	return (e:GetHandler():GetLinkedGroup():IsContains(c) or c==e:GetHandler()) and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsFaceup()
end
function c600029.atkfilter(c)
	return ((c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER) and c:IsFaceup()) and not c:IsCode(600029)
end
function c600029.atkval(e,c,tp)
	return Duel.GetMatchingGroup(c600029.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil):GetClassCount(Card.GetCode)*300
end

function c600029.imutg(e,c)
	return (e:GetHandler():GetLinkedGroup():IsContains(c) or c==e:GetHandler()) and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsFaceup()
end


function c600029.filter2(c,e,tp)
	return  (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)--c:GetCode()==100000171
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not (c:IsHasEffect(EFFECT_NECRO_VALLEY) or c:IsCode(600029))
end
function c600029.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c600029.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c600029.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c600029.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

function c600029.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) and (tc:IsSetCard(0x1538) or tc:IsSetCard(0x150e)) then
	
	end
	Duel.SpecialSummonComplete()
end

--function c600029.indtg(e,c)
	--return (e:GetHandler():GetLinkedGroup() and c:IsFaceup() and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e))) and not c:IsCode(600029)
--end

--function c600029.condition(e,tp,eg,ep,ev,re,r,rp)
	--return e:GetHandler():GetLinkedGroup() and e:GetHandler():IsFaceup() and (e:GetHandler():IsSetCard(0x1538) or e:GetHandler():IsSetCard(0x150e)) and e:GetHandler():IsType(TYPE_MONSTER)
--end

