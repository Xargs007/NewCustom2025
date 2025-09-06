--Kozmo－ダーク・ローズ Hero viento by Xargs01 of 2025
function c93302688.initial_effect(c)
    --search
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(93302688,0))
    e1:SetCategory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e1:SetCountLimit(1)
    e1:SetTarget(c93302688.thtg)
    e1:SetOperation(c93302688.thop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)

    --add setcode
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e4:SetCode(EFFECT_ADD_SETCODE)
    e4:SetValue(0x3008)
    c:RegisterEffect(e4)

    local e5=e4:Clone()
    e5:SetValue(0x08)
    c:RegisterEffect(e5)

    --become material
    local e02=Effect.CreateEffect(c)
    e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e02:SetCode(EVENT_BE_MATERIAL)
    e02:SetOperation(c93302688.operation)
    c:RegisterEffect(e02)
end

--material effect
function c93302688.con(e)
    return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end

function c93302688.condition(e,tp,eg,ep,ev,re,r,rp)
    return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end

function c93302688.operation(e,tp,eg,ep,ev,re,r,rp)
    local rc=eg:GetFirst()
    while rc do
        if rc:GetFlagEffect(93302688)==0 then
            --to hand
            local e4=Effect.CreateEffect(e:GetHandler())
            e4:SetDescription(aux.Stringid(20366274,1))
            e4:SetCategory(CATEGORY_TODECK)
            e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
            e4:SetCode(EVENT_BATTLE_START)
            e4:SetCondition(c93302688.descon)
            e4:SetTarget(c93302688.destg)
            e4:SetOperation(c93302688.desop)
            rc:RegisterEffect(e4,true)
            rc:RegisterFlagEffect(93302688,RESET_EVENT+0x1fe0000,0,1)
        end
        rc=eg:GetNext()
    end
end

function c93302688.descon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    local mRn = Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)
    local mEn = Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)
    return bc and (mRn >= mEn)
end

function c93302688.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler():GetBattleTarget(),1,0,0)
end

function c93302688.desop(e,tp,eg,ep,ev,re,r,rp)
    local bc=e:GetHandler():GetBattleTarget()
    if bc:IsRelateToBattle() then
        Duel.SendtoDeck(bc,nil,1,REASON_EFFECT) -- Asegúrate de pasar 'tp' aquí
    end
end

function c93302688.thfilter(c)
    return c:IsAbleToDeck()
end

function c93302688.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(1-tp) and c93302688.thfilter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c93302688.thfilter,tp,0,LOCATION_SZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)  -- Línea corregida
    local g=Duel.SelectTarget(tp,c93302688.thfilter,tp,0,LOCATION_SZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end

function c93302688.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc and tc:IsRelateToEffect(e) then
        Duel.SendtoDeck(tc,nil,1,REASON_EFFECT) -- Asegúrate de pasar 'tp' aquí
    end
end