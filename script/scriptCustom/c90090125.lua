--超魔導剣士－ブラック・パラディン
function c90090125.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--aux.AddFusionProcCodeFun(c,38033121,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),1,false,false)
	--aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x20a2),3,true)
	--aux.AddFusionProcCodeFun(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x30a2),aux.FilterBoolFunction(Card.IsFusionSetCard,0x20a2),2,false,false)
	--aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(c90090125.filmatfus),2,true)
	Fusion.AddProcMix(c,false,false,CARD_DARK_MAGICIAN_GIRL,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
    --Unafected Traps
    local e02=Effect.CreateEffect(c)
    e02:SetType(EFFECT_TYPE_SINGLE)
    e02:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e02:SetRange(LOCATION_MZONE)
    e02:SetCode(EFFECT_IMMUNE_EFFECT)
    e02:SetValue(c90090125.efilter)
    c:RegisterEffect(e02)
    --Unafected Monster
    local e022=Effect.CreateEffect(c)
    e022:SetType(EFFECT_TYPE_SINGLE)
    e022:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e022:SetRange(LOCATION_MZONE)
    e022:SetCode(EFFECT_IMMUNE_EFFECT)
    e022:SetValue(c90090125.efilter1)
    c:RegisterEffect(e022)
        -----
    --Immune spell
    --local e3=Effect.CreateEffect(c)
    --e3:SetType(EFFECT_TYPE_SINGLE)
    --e3:SetCode(EFFECT_IMMUNE_EFFECT)
    --e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    --e3:SetRange(LOCATION_MZONE)
    --e3:SetValue(c90090125.efilter0)
    --c:RegisterEffect(e3)
	--Cannot be Targeted by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c90090125.notargetedval)
	c:RegisterEffect(e2)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c90090125.nodestroyedval)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90090125,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c90090125.val)
	e4:SetCost(c90090125.descost)
	e4:SetTarget(c90090125.destg)
	e4:SetOperation(c90090125.desop)
	c:RegisterEffect(e4)
	--cannot attack effects others monsters
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c90090125.atkcon)
	e5:SetOperation(c90090125.atkop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_BATTLE_DAMAGE)
	e6:SetCondition(c90090125.damgcon)
	e6:SetOperation(c90090125.atkop2)
	c:RegisterEffect(e6)
	--if others monster attack, stop attack chaos magician girl
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_ATTACK_ANNOUNCE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(LOCATION_MZONE,0)
	e7:SetCondition(c90090125.tglimit2)
	e7:SetOperation(c90090125.atkop3)
	c:RegisterEffect(e7)
	
end

function c90090125.filmatfus(c)
	return (c:IsFusionSetCard(0x30a2) or c:IsFusionSetCard(0x20a2)) and c:IsType(TYPE_MONSTER)
end

function c90090125.tgli(c)
	return c:IsCode(90090125)-- and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c90090125.val(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetMatchingGroupCount(c90090125.tgli,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)>0
end
function c90090125.tgli(c)
	return c:IsCode(90090125)-- and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
--Immune tramps and magic fuction
function c90090125.efilter(e,te)
    return te:IsActiveType(TYPE_TRAP) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
 
function c90090125.efilter0(e,te)
    return te:IsActiveType(TYPE_SPELL) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c90090125.efilter1(e,te)
    return te:IsActiveType(TYPE_MONSTER) --and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

function c90090125.notargetedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE) and not te:IsActiveType(TYPE_SPELL)
end
function c90090125.nodestroyedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE) and not te:IsActiveType(TYPE_SPELL)
end

--destroy function
function c90090125.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c90090125.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c90090125.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
-- cannont attack restrintion
function c90090125.tglimit(e,c)
	return c:IsType(TYPE_MONSTER) and not tc:IsCode(90090125) --and not c:IsRace(RACE_SPELLCASTER)-- and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
-- your monsters attack
function c90090125.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:GetFlagEffect(90090125)==0
		and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE) 
end
function c90090125.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if chk==0 then return c:GetAttackAnnouncedCount()==0 end
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_FIELD)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e01:SetCode(EFFECT_CANNOT_ATTACK)
	e01:SetRange(LOCATION_MZONE)
	e01:SetTargetRange(LOCATION_MZONE,0)--e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e01:SetTarget(c90090125.tglimit)
	e01:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e01,true)
	c:RegisterFlagEffect(90090125,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
--cannont attack damage
function c90090125.damgcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c90090125.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_FIELD)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e01:SetCode(EFFECT_CANNOT_ATTACK)
	e01:SetRange(LOCATION_MZONE)
	e01:SetTargetRange(LOCATION_MZONE,0)--e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e01:SetTarget(c90090125.tglimit)
	e01:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e01,true)
	c:RegisterFlagEffect(90090125,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
-- stop attack chaos magician girl, if attack others monsters hendle own for magician girl
function c90090125.atakcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return (a:GetControler()==tp and a:IsRelateToBattle())
		or (a~=nil and a:GetControler()==tp and a:IsFaceup() and a:IsRelateToBattle())
end

function c90090125.atkop3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_FIELD)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e01:SetCode(EFFECT_CANNOT_ATTACK)
	e01:SetRange(LOCATION_MZONE)
	e01:SetTargetRange(LOCATION_MZONE,0)--e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e01:SetTarget(c90090125.tglimit3)
	e01:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e01,true)
	c:RegisterFlagEffect(90090125,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end

-- cannont attack restrintion others monsters
function c90090125.tglimit2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsType(TYPE_MONSTER) and not tc:IsCode(90090125)--and not (tc:IsRace(RACE_SPELLCASTER) or not tc:IsCode(90090125))-- 
end
function c90090125.tglimit3(e,c)
	return c:IsCode(90090125)-- and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
