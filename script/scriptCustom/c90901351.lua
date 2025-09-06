function c90901351.initial_effect(c)
	--fusion material
	--aux.AddFusionProcFun2(c,c900901250.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--fusion material
	c:EnableReviveLimit()
	--aux.AddFusionProcCodeFun(c,38033121,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,false,false)
	--aux.AddFusionProcCodeFun(c,aux.FilterBoolFunction(c90901351.filmatfus),aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,false,false)
	Fusion.AddProcMix(c,false,false,aux.FilterBoolFunction(c90901351.filmatfus),aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--atkup
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e01:SetCode(EFFECT_UPDATE_ATTACK)
	e01:SetRange(LOCATION_MZONE)
	e01:SetValue(c90901351.val)
	c:RegisterEffect(e01)
	--atkup2
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c90901351.val2)
	c:RegisterEffect(e2)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90901351,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c90901351.negcon)
	e2:SetTarget(c90901351.negtg)
	e2:SetOperation(c90901351.negop)
	c:RegisterEffect(e2)

end

function c90901351.filmatfus(c)
	return c:IsSetCard(0x30a2) or c:IsSetCard(0x20a2)
end
function c90901351.val(e,c)
	return Duel.GetMatchingGroupCount(c90901351.filter,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)*100
end

function c90901351.filter(c)
	return c:IsRace(RACE_SPELLCASTER)
end
function c90901351.val2(e,c)
	return Duel.GetMatchingGroupCount(c90901351.filter2,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)*150
end

function c90901351.filter2(c)
	return c:IsRace(RACE_DRAGON)
end
function c90901351.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsStatus(STATUS_CHAINING) and Duel.IsChainNegatable(ev) --(re:GetActivateLocation()==LOCATION_GRAVE)
end
function c90901351.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c90901351.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end