--Guardian Eatos
function c911001771.initial_effect(c)
	--sum limit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c911001771.sumlimit)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c911001771.spcon)
	c:RegisterEffect(e4)
	--remove
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(911001771,0))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c911001771.rmcost)
	e5:SetTarget(c911001771.rmtg)
	e5:SetOperation(c911001771.rmop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SPSUMMON_PROC)
	e6:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e6:SetRange(LOCATION_HAND+LOCATION_DECK)
	e6:SetCondition(c911001771.spcon2)
	c:RegisterEffect(e6)
	--special summon Dreadscythe
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(911001771,0))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_TO_GRAVE)--e7:SetCode(EVENT_BATTLE_DESTROYED)
	e7:SetCondition(c911001771.condition)
	e7:SetTarget(c911001771.target)
	e7:SetOperation(c911001771.operation)
	c:RegisterEffect(e7)
	--special summon arm hand

end

function c911001771.cfilter(c)
	return c:IsFaceup() and c:IsCode(55569674)
end
function c911001771.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c911001771.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c911001771.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and ((not Duel.IsExistingMatchingCard(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)) or (Duel.IsExistingMatchingCard(c911001771.cfilter,tp,LOCATION_ONFIELD,0,1,nil)))

end
function c911001771.eqfilter(c)
	return c:IsCode(55569674) and c:IsDestructable()--(c:IsCode(55569674) or c:IsCode(95515060) or c:IsCode(58427465) or c:IsCode(95638658) or c:IsCode(69243953) or c:IsCode(32022366) or c:IsCode(21900719)) and c:IsDestructable()
end
function c911001771.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipGroup():IsExists(c911001771.eqfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,c911001771.eqfilter,1,1,nil)
	Duel.Destroy(g,REASON_COST)
end
function c911001771.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c911001771.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
	if chk==0 then return tc and tc:IsType(TYPE_MONSTER) and tc:IsAbleToRemove() and tc:GetAttack()>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c911001771.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
	local sum=0
	while tc and tc:IsType(TYPE_MONSTER) and tc:IsAbleToRemove() and tc:GetAttack()>0 do
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		sum=sum+tc:GetAttack()
		tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(sum)
	c:RegisterEffect(e1)
end
--
function c911001771.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD+LOCATION_REMOVED)>0--e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c911001771.filter1(c,e,tp)
	return c:IsCode(18175965)
end
function c911001771.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c911001771.filter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c911001771.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c911001771.filter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
--
function c911001771.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and ((Duel.IsExistingMatchingCard(c911001771.cfilter,tp,LOCATION_ONFIELD,0,1,nil)))

end