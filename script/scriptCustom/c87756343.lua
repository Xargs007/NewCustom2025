--ラーバモス
function c877563430.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(877563430,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,877563430)
	e1:SetCondition(c877563430.condition)
	e1:SetTarget(c877563430.target)
	e1:SetOperation(c877563430.spop3)
	c:RegisterEffect(e1)
	--others
	local e02=Effect.CreateEffect(c)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e02:SetType(EFFECT_TYPE_SINGLE)
	e02:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e02)
	--local e03=e02:Clone()
	--e03:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	--c:RegisterEffect(e03)
	local e04=e02:Clone()
	e04:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e04)
end

function c877563430.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c877563430.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c877563430.spop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,14141448)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,c:GetPreviousPosition(),true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

--[[function c877563430.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c877563430.spcon)
	e2:SetOperation(c877563430.spop)
	c:RegisterEffect(e2)
end
function c877563430.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=2
end
function c877563430.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():FilterCount(c877563430.eqfilter,nil)>0
end
function c877563430.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c877563430.rfilter,1,nil)
end
function c877563430.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c877563430.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
]]