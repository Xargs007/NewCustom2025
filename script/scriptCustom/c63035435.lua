--摩天楼 －スカイスクレイパー－
function c63035435.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c63035435.atkcon)
	e2:SetTarget(c63035435.atktg)
	e2:SetValue(c63035435.atkval)
	c:RegisterEffect(e2)
	--tokken invocation
	local e02=Effect.CreateEffect(c)
	e02:SetDescription(aux.Stringid(100417010,0))
	e02:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_COIN)
	e02:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e02:SetCode(EVENT_ATTACK_ANNOUNCE)
	e02:SetCountLimit(1,63035435)
	e02:SetRange(LOCATION_SZONE)
	e02:SetCost(c63035435.cost2)
	e02:SetCondition(c63035435.atkcon2)
	--e02:SetTarget(c63035435.sumtg2)
	e02:SetOperation(c63035435.spop3)
	c:RegisterEffect(e02)
	local e09=Effect.CreateEffect(c)
	e09:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e09:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e09:SetCode(EVENT_ATTACK_ANNOUNCE)
	e09:SetRange(LOCATION_GRAVE)
	e09:SetCountLimit(1,63035435)
	e09:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e02:SetCondition(aux.exccon)
	e09:SetCondition(c63035435.atkcon2)
	e09:SetCost(c63035435.cost2)
	--e09:SetTarget(c63035435.sumtg2)
	e09:SetOperation(c63035435.spop3)
	c:RegisterEffect(e09)
end

function c63035435.Cardfilter(c)
	local code=c:GetCode()
	return code==33550698
end

function c63035435.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end

function c63035435.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>2
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_MONSTER) and not Duel.IsExistingMatchingCard(c63035435.Cardfilter,tp,LOCATION_SZONE+LOCATION_GRAVE+LOCATION_FZONE+LOCATION_REMOVED,0,1,nil)
end
function c63035435.spop3(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,88820237)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
function c63035435.sumtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c63035435.sumop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,88820237)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

function c63035435.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c63035435.atkcon(e)
	c63035435[0]=false
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c63035435.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(0x8)
end
function c63035435.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c63035435[0] or c:GetAttack()<d:GetAttack() then
		c63035435[0]=true
		return 1000
	else return 0 end
end
