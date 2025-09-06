--Stray Cat Girl
function c600009.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c600009.condition)
	e1:SetCost(c600009.cost)
	e1:SetTarget(c600009.target)
	e1:SetOperation(c600009.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c600009.con)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c600009.con(e,c)
	return e:GetHandler():IsAttackPos() 
end
function c600009.costfilter(c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_BEAST) --c:GetLevel()==1
end
function c600009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c600009.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c600009.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c600009.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp
end
function c600009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c600009.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
