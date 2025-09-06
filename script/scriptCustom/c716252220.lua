--時の魔術師
function c716252220.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(716252220,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c716252220.destg)
	e1:SetOperation(c716252220.desop)
	c:RegisterEffect(e1)
end

function c716252220.copyfilter(c)
	return (c:IsCode(46986414)) and c:IsAbleToDeckAsCost() --(c:IsCode(46986414) or c:IsCode(88819587)) and c:IsAbleToDeckAsCost()
end
function c716252220.copycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c716252220.copyfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DECK)
	local g=Duel.SelectMatchingCard(tp,c716252220.copyfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,POS_FACEUP,1,REASON_COST)
end

function c716252220.confilter(c)
	return c:IsCode(46986414)
end
function c716252220.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c716252220.confilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil)
end

function c716252220.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c716252220.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(716252220,1))
	local coin=Duel.SelectOption(tp,60,61)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(716252220,3))
		e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
		e2:SetType(EFFECT_TYPE_IGNITION)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1,716252220+EFFECT_COUNT_CODE_DUEL)
		e2:SetCost(c716252220.copycost)
		e2:SetOperation(c716252220.spop3)
		e:GetHandler():RegisterEffect(e2)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.RaiseEvent(e:GetHandler(),716252220,e,0,0,tp,0)
	else
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum/2,REASON_EFFECT)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.RaiseEvent(e:GetHandler(),716252220,e,0,0,tp,0)
	end
end

function c716252220.spop3(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,923773030)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end

function c716252220.spop4(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,511000539)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
