--Prima Light
----------------------------------------------
----------------------------------------------
function c611000132.initial_effect(c)
	--c:EnableReviveLimit()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(611000132,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c611000132.spDMcon)
	e1:SetCost(c611000132.cost)
	e1:SetCountLimit(1,611000132)
	--e1:SetTarget(c87210505.target)
	e1:SetOperation(c611000132.spop2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(611000132,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c611000132.spDMGcon)
	e2:SetCost(c611000132.cost2)
	e2:SetCountLimit(1,611000132)
	--e1:SetTarget(c87210505.target)
	e2:SetOperation(c611000132.spop2)
	c:RegisterEffect(e2)

end
--
function c611000132.cDMfilter(c,tp)
	return c:IsCode(97023549) and c:IsFaceup(tp)
end
function c611000132.spDMcon(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.IsExistingMatchingCard(c911001771.cDMfilter,tp,LOCATION_ONFIELD,0,1,nil))
end
--
function c611000132.cDMGfilter(c,tp)
	return c:IsCode(49375719) and c:IsFaceup(tp)
end
function c611000132.spDMGcon(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.IsExistingMatchingCard(c911001771.cDMGfilter,tp,LOCATION_ONFIELD,0,1,nil))
end
--
function c611000132.costfilter(c)
	return c:IsFaceup() and c:IsCode(97023549)
end
function c611000132.costfilter2(c)
	return c:IsFaceup() and c:IsCode(49375719)
end
function c611000132.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c611000132.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c611000132.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c611000132.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c611000132.costfilter2,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c611000132.costfilter2,1,1,nil)
	Duel.Release(g,REASON_COST)
end
--
function c611000132.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c611000132.spop2(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,611001598)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
---
