--サイレント・ソードマン LV7
function c37267042.initial_effect(c)
	--c:EnableReviveLimit()
	--cannot special summon
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	--e1:SetValue(aux.FALSE)
	--c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_SZONE)
	e2:SetTarget(c37267042.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE) --extra
	e3:SetOperation(c37267042.disop)
	c:RegisterEffect(e3)
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
c37267042.lvupcount=1
c37267042.lvup={74388797}
c37267042.lvdncount=2
c37267042.lvdn={1995986,74388797}
function c37267042.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c37267042.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end
