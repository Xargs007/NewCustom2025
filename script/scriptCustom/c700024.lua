--Zorc Necrophades
function c700024.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c700024.spcon)
	e2:SetOperation(c700024.spop)
	c:RegisterEffect(e2)
    --Unafected Traps
    local e02=Effect.CreateEffect(c)
    e02:SetType(EFFECT_TYPE_SINGLE)
    e02:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e02:SetRange(LOCATION_MZONE)
    e02:SetCode(EFFECT_IMMUNE_EFFECT)
    e02:SetValue(c700024.efilter)
    c:RegisterEffect(e02)
    --Immune spell
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_IMMUNE_EFFECT)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetValue(c700024.efilter0)
    c:RegisterEffect(e3)
	--Cannot be Targeted by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(c700024.notargetedval)
	c:RegisterEffect(e12)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_SINGLE)
	e23:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e23:SetRange(LOCATION_MZONE)
	e23:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e23:SetValue(c700024.nodestroyedval)
	c:RegisterEffect(e23)
	--attackup
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetValue(c700024.AtkDefup)
	c:RegisterEffect(e22)
	--DEFup
	local e16=Effect.CreateEffect(c)
	e16:SetType(EFFECT_TYPE_SINGLE)
	e16:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e16:SetRange(LOCATION_MZONE)
	e16:SetCode(EFFECT_UPDATE_DEFENCE)
	e16:SetValue(c700024.AtkDefup)
	c:RegisterEffect(e16)
	--Atkkdown M Op
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_UPDATE_ATTACK)
	e8:SetValue(c700024.AtkDefdown)
	c:RegisterEffect(e8)
	--Defdown M Op
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_UPDATE_ATTACK)
	e9:SetValue(c700024.AtkDefdown)
	c:RegisterEffect(e9)
	--remove
	local e29=Effect.CreateEffect(c)
	--e29:SetDescription(aux.Stringid(40737112,1))
	e29:SetCategory(CATEGORY_REMOVE)
	e29:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e29:SetCode(EVENT_BATTLED)
	e29:SetCondition(c700024.rmcon)
	e29:SetTarget(c700024.rmtg)
	e29:SetOperation(c700024.rmop)
	c:RegisterEffect(e29)
end

function c700024.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c700024.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c700024.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsAbleToRemove() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end

function c700024.filter2(c)
	return c:IsType(TYPE_MONSTER) --and c:IsSetCard(0x235)
end
function c700024.filter3(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x235)
end

function c700024.AtkDefup(e,c)
	local var=Duel.GetMatchingGroupCount(c700024.filter2,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)
	return (100*var)
end
function c700024.AtkDefdown(e,c)
	local var=Duel.GetMatchingGroupCount(c700024.filter3,c:GetControler(),LOCATION_GRAVE,0,nil)
	return (-50*var)
end

--Immune tramps and magic fuction
function c700024.efilter(e,te)
    return te:IsActiveType(TYPE_TRAP) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
 
function c700024.efilter0(e,te)
    return te:IsActiveType(TYPE_SPELL) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

function c700024.notargetedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE) and not te:GetHandler():IsAttribute(ATTRIBUTE_LIGHT)--not te:IsActiveType(TYPE_SPELL)
end
function c700024.nodestroyedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE) and not te:GetHandler():IsAttribute(ATTRIBUTE_LIGHT) --not te:IsActiveType(TYPE_SPELL)
end

function c700024.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.CheckReleaseGroup(c:GetControler(),Card.IsSetCard,3,nil,0x235)
end
function c700024.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),Card.IsSetCard,3,3,nil,0x235)
	Duel.Release(g,REASON_COST)
end