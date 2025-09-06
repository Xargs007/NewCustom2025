--THE EVIL GOD ZORK
function c976426800.initial_effect(c)
 
                     
        --summon with 3 tribute
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
    e1:SetCondition(c976426800.ttcon)
    e1:SetOperation(c976426800.ttop)
    e1:SetValue(SUMMON_TYPE_ADVANCE)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_LIMIT_SET_PROC)
    e2:SetCondition(c976426800.setcon)
    c:RegisterEffect(e2)
    --summon
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    c:RegisterEffect(e3)
    --summon success
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_SUMMON_SUCCESS)
    e4:SetOperation(c976426800.sumsuc)
    c:RegisterEffect(e4)
     
     
                --race R
    local e19=e4:Clone()--Effect.CreateEffect(c)
    e19:SetType(EFFECT_TYPE_SINGLE)
    e19:SetCode(EFFECT_CHANGE_RACE)
    e19:SetRange(LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK+LOCATION_OVERLAY)
    e19:SetValue(RACE_FIEND)
    c:RegisterEffect(e19)
         
     
         
         
     
        --atkup
    --local e4=Effect.CreateEffect(c)
    --e4:SetDescription(aux.Stringid(976426800,0))
    --e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)   
    --e4:SetCategory(CATEGORY_ATKCHANGE)
    --e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
    --e4:SetRange(LOCATION_MZONE)
    --e4:SetCountLimit(1)
    --e4:SetProperty(EFFECT_FLAG_REPEAT)
    --e4:SetCondition(c976426800.atkcon)
    --e4:SetOperation(c976426800.atkop)
    --c:RegisterEffect(e4)
 
     
     
        --cannot be target
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET+EFFECT_CANNOT_CHANGE_CONTROL+EFFECT_INDESTRUCTABLE_EFFECT+EFFECT_CANNOT_REMOVE)
    e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)--EFFECT_FLAG_SINGLE_RANGE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetValue(1)
    c:RegisterEffect(e5)
    --to grave
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(976426800,0))
    e6:SetCategory(CATEGORY_TOGRAVE)
    e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e6:SetRange(LOCATION_MZONE)
    e6:SetProperty(EFFECT_FLAG_REPEAT)
    e6:SetCode(EVENT_PHASE+PHASE_END)
    e6:SetCondition(c976426800.tgcon)
    e6:SetTarget(c976426800.tgtg)
    e6:SetOperation(c976426800.tgop)
    c:RegisterEffect(e6)
     
     
            --dice
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(976426800,0))
    e7:SetCategory(CATEGORY_DAMAGE)
    e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e7:SetCode(EVENT_BATTLE_DESTROYING)
    e7:SetCondition(c976426800.damcon)
    e7:SetTarget(c976426800.damtg)
    e7:SetOperation(c976426800.damop)
    c:RegisterEffect(e7)
     
     
     
        --no battle damage
    --local e7=Effect.CreateEffect(c)
    --e7:SetType(EFFECT_TYPE_SINGLE)
    --e7:SetCode(EFFECT_NO_BATTLE_DAMAGE)
    --c:RegisterEffect(e7)
     
            --battle indestructable
    --local e8=Effect.CreateEffect(c)
    --e8:SetType(EFFECT_TYPE_SINGLE)
    --e8:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
   -- e8:SetValue(1)--SetValue(c976426800.bfilter)--e3:SetValue(1)--
    --c:RegisterEffect(e8)
     
 
     
        --Unafected Traps
    local e9=Effect.CreateEffect(c)
    e9:SetType(EFFECT_TYPE_SINGLE)
    e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e9:SetRange(LOCATION_MZONE)
    e9:SetCode(EFFECT_IMMUNE_EFFECT)
    e9:SetValue(c976426800.efilter)
    c:RegisterEffect(e9)
     
        -----
 
    --Immune spell
    local e10=Effect.CreateEffect(c)
    e10:SetType(EFFECT_TYPE_SINGLE)
    e10:SetCode(EFFECT_IMMUNE_EFFECT)
    e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e10:SetRange(LOCATION_MZONE)
    e10:SetValue(c976426800.efilter0)
    c:RegisterEffect(e10)
         
     
    --INDESTRUCTABLE_EFFECT
        local e11=Effect.CreateEffect(c)
        e11:SetType(EFFECT_TYPE_SINGLE)
        e11:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
        e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e11:SetValue(1)
        --e15:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
        c:RegisterEffect(e11)
     
 
    --No damage
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_SINGLE)
    e12:SetCode(EFFECT_NO_BATTLE_DAMAGE)
    e12:SetCondition(c976426800.dacon)
    c:RegisterEffect(e12)
 
        local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_SINGLE)
    e13:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
    e13:SetValue(1)
    --e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,1)
    c:RegisterEffect(e13)
     
            --Activate no Damage --Obelisk
    local e14=Effect.CreateEffect(c)
    e14:SetDescription(aux.Stringid(976426800,0))
    e14:SetType(EFFECT_TYPE_QUICK_O)
    e14:SetCode(EVENT_FREE_CHAIN)
	e14:SetCountLimit(1)
    e14:SetRange(LOCATION_MZONE)
    e14:SetCost(c976426800.dacost)
    e14:SetOperation(c976426800.daoperation)
    c:RegisterEffect(e14)
 
     
        --YAMI
    local e15=Effect.CreateEffect(c)
    e15:SetType(EFFECT_TYPE_SINGLE)
    e15:SetCode(EFFECT_UPDATE_ATTACK)
    e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e15:SetRange(LOCATION_MZONE)
    --e15:SetValue(c976426800.val)
    c:RegisterEffect(e15)
    local e16=e15:Clone()
    e16:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e16)
     
     
 
     
            --code
                 
 
     
                --NO BATTLE DAMAGE
 
 
     
        --update atk,def
    local e17=Effect.CreateEffect(c)
    e17:SetType(EFFECT_TYPE_SINGLE)
    e17:SetCode(EFFECT_UPDATE_ATTACK)
    e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e17:SetRange(LOCATION_MZONE)
    e17:SetValue(c976426800.val)
    c:RegisterEffect(e17)
    local e18=e17:Clone()
    e18:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e18)
     
 
            --cannot be fusion material
    local e20=Effect.CreateEffect(c)
    e20:SetType(EFFECT_TYPE_SINGLE)
    e20:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e20:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
    e20:SetValue(1)
    c:RegisterEffect(e20)
     
            --unreleaseable nonsum
    local e21=Effect.CreateEffect(c)
    e21:SetType(EFFECT_TYPE_SINGLE)
    e21:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e21:SetRange(LOCATION_MZONE)
    e21:SetCode(EFFECT_UNRELEASABLE_NONSUM)
    e21:SetValue(1)
    c:RegisterEffect(e21)
	--Summon Success: Effects of non-DIVINE monsters Cannot be Activated
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e22:SetCode(EVENT_SUMMON_SUCCESS)
	e22:SetOperation(c976426800.sumnotnegatedop)
	c:RegisterEffect(e22)
	--Cannot be Tributed by Opponent
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_SINGLE)
	e23:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e23:SetRange(LOCATION_MZONE)
	e23:SetCode(EFFECT_UNRELEASABLE_SUM)
	e23:SetValue(c976426800.nottributedval)
	c:RegisterEffect(e23)
	local e24=e23:Clone()
	e24:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	e24:SetCondition(c976426800.nottributedcon)
	c:RegisterEffect(e24)
    --Cannot Switch Controller
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_SINGLE)
	e25:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e25:SetRange(LOCATION_MZONE)
	e25:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e25)
	--Cannot be Targeted by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e26=Effect.CreateEffect(c)
	e26:SetType(EFFECT_TYPE_SINGLE)
	e26:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e26:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e26:SetRange(LOCATION_MZONE)
	e26:SetValue(c976426800.notargetedval)
	c:RegisterEffect(e26)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e28=Effect.CreateEffect(c)
	e28:SetType(EFFECT_TYPE_SINGLE)
	e28:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e28:SetRange(LOCATION_MZONE)
	e28:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e28:SetValue(c976426800.nodestroyedval)
	c:RegisterEffect(e28)
	--Cannot be Removed
	local e29=Effect.CreateEffect(c)
	e29:SetType(EFFECT_TYPE_SINGLE)
	e29:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e29:SetRange(LOCATION_MZONE)
	e29:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e29)
	--Cannot Send to Grave
	local e30=Effect.CreateEffect(c)
	e30:SetType(EFFECT_TYPE_SINGLE)
	e30:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e30:SetRange(LOCATION_MZONE)
	e30:SetCode(EFFECT_CANNOT_TO_GRAVE)
	e30:SetCondition(c976426800.togravecon)
	c:RegisterEffect(e30)
	--Cannot Return to Hand
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_SINGLE)
	e31:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e31:SetRange(LOCATION_MZONE)
	e31:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e31)
	--Cannot Return to Deck
	local e32=Effect.CreateEffect(c)
	e32:SetType(EFFECT_TYPE_SINGLE)
	e32:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e32:SetRange(LOCATION_MZONE)
	e32:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e32)
end
function c976426800.notargetedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c976426800.nottributedval(e,re,rp)
	local c=e:GetHandler()
 	return not c:IsControler(tp)
end
function c976426800.nottributedcon(e,c)
	local c=e:GetHandler()
	return not c:IsControler(tp)
end
function c976426800.sumnotnegatedop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_MZONE+LOCATION_SZONE,LOCATION_SZONE+LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c976426800.triggertg)
	e1:SetReset(RESET_EVENT+EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e1)
end
function c976426800.triggertg(e,c)
	return not c:IsRace(RACE_DEVINE)
end
function c976426800.nodestroyedval(e,te)
	return not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c976426800.togravecon(e,c)
	local c=e:GetHandler()
	return not c:IsCode(10000000)
end
 
------ Battle Destroyed
--function c976426800.bfilter(c)
    --local code=c:GetCode()
    --return code==110000004--c:IsAttribute(0x2f)--4194304=Creator God
--end
 
 
    --EFECTOS Zork
     
function c976426800.spfilter(c)
    local code=c:GetCode()
    return code==46955770 --or code==86569121
end
 
function c976426800.ttcon(e,c)
    if c==nil then return true end
     
        local g=Duel.GetReleaseGroup(c:GetControler())
     
    return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
         and Duel.GetTributeCount(c)>=3 --and g:IsExists(c976426800.spfilter,1,nil)
end
function c976426800.ttop(e,tp,eg,ep,ev,re,r,rp,c)
    local g=Duel.SelectTribute(tp,c,3,3)
    c:SetMaterial(g)
    Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c976426800.setcon(e,c)
    if not c then return true end
    return false
end
function c976426800.sumsuc(e,tp,eg,ep,ev,re,r,rp)
    Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
 
 
 
------ NO BATTLE DAMAGE
function c976426800.filter(c)
    return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c976426800.dacon(e)
    return  Duel.IsExistingMatchingCard(c976426800.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
 
 
 
 
 
 
-------YAMI_
function c976426800.yfilter(c)
    return c:IsFaceup() and (c:IsCode(59197169) or c:IsCode(511000119))
        end
 
 
--SI SE QUITA "yd" A ydfilter quita daño de batalla + daño de efecto 
function c976426800.val(e,c)
        if Duel.GetEnvironment()~=(59197169 or 511000119) then return 0 end
    return Duel.GetMatchingGroupCount(c976426800.ydfilter,0,0x14,0x14,nil)*500
end
 
function c976426800.ydfilter(c)
    return c:IsAttribute(ATTRIBUTE_DARK) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())--c:IsRace(RACE_DRAGON)
end
 
 
 
--function c976426800.val(e,c)
    --if Duel.GetEnvironment()~=59197169 then return 0 end
    --local v=Duel.GetLP(c:GetControler())-Duel.GetLP(1-c:GetControler())
    --if v>0 then return v else return 0 end
 
    --return Duel.GetMatchingGroupCount(c976426800.filter,0,nil,ATTRIBUTE_DARK)*500
--end
 
--function c976426800.filter(c)
    --return c:IsAttribute(ATTRIBUTE_DARK) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
--end
 
 
 
--IsRace(RACE_DRAGON)
 
 
 
-----------To Grave
 
function c976426800.tgcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetPreviousLocation()==LOCATION_GRAVE
     
end
function c976426800.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c976426800.tgop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsFaceup() then
        Duel.SendtoGrave(c,REASON_EFFECT)
    end
end
     
    -------
-- ATK_UP
--function c976426800.atkcon(e,tp,eg,ep,ev,re,r,rp)
    --return tp==Duel.GetTurnPlayer()
--end
--function c976426800.atkop(e,tp,eg,ep,ev,re,r,rp)
    --local c=e:GetHandler()
    --local e1=Effect.CreateEffect(c)
    --e1:SetType(EFFECT_TYPE_SINGLE)
    --e1:SetCode(EFFECT_UPDATE_ATTACK)
    --e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
        --e1:SetReset(RESET_EVENT+0x1ff0000)
    --e1:SetValue(300)
    --c:RegisterEffect(e1)
--end
 
 
 
 
 
 
 
    -------atk/up osiris
--function c976426800.adval(e,c)
    --return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*350
--end
-----
 
function c976426800.damcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    return c:IsRelateToBattle() and bc:IsType(TYPE_MONSTER)-- bc:IsLocation(LOCATION_GRAVE) and
end
function c976426800.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    local dam=bc:GetBaseAttack()
    if dam<0 then dam=0 end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(dam)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c976426800.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
end
 
-----------------No Damage Effect
 
function c976426800.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLP(tp)> 1 end--Duel.CheckLPCost(tp,1000) end
    Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c976426800.daoperation(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CHANGE_DAMAGE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
    e1:SetTargetRange(1,0)
    e1:SetValue(0)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
end
 
 
 
 
 
-- -- R
function c976426800.efilter(e,te)
    return te:IsActiveType(TYPE_TRAP)
end
 
function c976426800.efilter0(e,te)
    return te:IsActiveType(TYPE_SPELL) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end