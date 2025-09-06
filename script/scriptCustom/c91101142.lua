--サイレント・ソードマン LV0
function c91101142.initial_effect(c)
	--c:EnableReviveLimit()
	--Update ATK and Level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCountLimit(1)
	e1:SetCondition(c91101142.rcon)
	e1:SetOperation(c91101142.rop)
	c:RegisterEffect(e1)
	--change name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetValue(c91101142.val)
	c:RegisterEffect(e2)
    --Unafected Traps
    local e02=Effect.CreateEffect(c)
    e02:SetType(EFFECT_TYPE_SINGLE)
    e02:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e02:SetRange(LOCATION_MZONE)
    e02:SetCode(EFFECT_IMMUNE_EFFECT)
    e02:SetValue(c91101142.efilter)
    c:RegisterEffect(e02)
	--cannot special summon
	local e03=Effect.CreateEffect(c)
	e03:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e03:SetType(EFFECT_TYPE_SINGLE)
	e03:SetCode(EFFECT_SPSUMMON_CONDITION)
	e03:SetValue(aux.FALSE)
	c:RegisterEffect(e03)
end
--Immune magic fuction
function c91101142.efilter(e,te)
    return te:IsActiveType(TYPE_SPELL) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

function c91101142.rcon(e,tp,eg,ep,ev,re,r,rp)
	local ect=e:GetHandler():GetEffectCount(91101142)
	return ep~=tp and 10-ect>0
end
function c91101142.rop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	local ect=c:GetEffectCount(91101142)
	if 10-ect<ct then
		ct=10-ct
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(ct*400)
	c:RegisterEffect(e1)
	for i=1,ct do
		if ct<=3 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(91101142)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
		end
	end
end

function c91101142.val(e,c)
	local ect=e:GetHandler():GetEffectCount(91101142)
	if ect>0 and ect<3 then
		return 73665146+ect
	else --ect==3 then
		return 72443568
	end
end