--Cat World
function c600011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--ad up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c600011.val)
	c:RegisterEffect(e2)
	--ad up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetValue(c600011.val2)
	c:RegisterEffect(e3)
	--Destroy card in the field if destroy necro monster
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetDescription(aux.Stringid(600011,0))
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetRange(LOCATION_SZONE)
	--e4:SetCountLimit(1,700012)
	e4:SetCondition(c600011.condition)
	e4:SetTarget(c600011.damtg)
	e4:SetOperation(c600011.damop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetDescription(aux.Stringid(600011,0))
	e5:SetCode(EVENT_DESTROYED)
	e5:SetRange(LOCATION_SZONE)
	--e5:SetCountLimit(1,700012)
	e5:SetCondition(c600011.condition)
	e5:SetTarget(c600011.damtg)
	e5:SetOperation(c600011.damop)
	c:RegisterEffect(e5)
end
function c600011.val(e,c)
	if c:IsFaceup() and c:IsSetCard(0x1538) then return c:GetBaseAttack()
	else
	return 0
	end 
end

function c600011.val2(e,c)
	if c:IsFaceup() and c:IsSetCard(0x150e) then return c:GetBaseAttack()/2
	else
	return 0
	end 
end

--c600011.DestroyCount=0

function c600011.cfilter(c,tp)
	return (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) or c:IsReason(REASON_DESTROY)) and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e))  --and c:GetPreviousControler()==tp and c:IsLocation(LOCATION_GRAVE)
end
function c600011.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c600011.cfilter,1,nil,tp)
end
function c600011.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	--c600011.DestroyCount = c600011.DestroyCount + 1
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c600011.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	--local d=Duel.GetMatchingGroupCount(c600011.cfilter,tp,LOCATION_MZONE,0,nil)*300
	--local d=c600011.DestroyCount * 300
	Duel.Damage(1-tp,300,REASON_EFFECT)
	--c600011.DestroyCount=0
end

