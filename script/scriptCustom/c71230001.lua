--Black Magician Girl (fix)
-- ID único: 71230001

function c71230001.initial_effect(c)
    -- Invocación por fusión
    c:EnableReviveLimit()
    Fusion.AddProcMixN(c,true,true,aux.FilterBoolFunction(Card.IsSetCard,0x20a2),5)

    -- Efecto de banish al ser invocada por fusión
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c71230001.rmcon)
    e1:SetTarget(c71230001.rmtg)
    e1:SetOperation(c71230001.rmop)
    c:RegisterEffect(e1)

    -- Negar efecto
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_CHAINING)
    e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c71230001.negcon)
    e2:SetCost(c71230001.negcost)
    e2:SetTarget(c71230001.negtg)
    e2:SetOperation(c71230001.negop)
    c:RegisterEffect(e2)

    -- Invocar de Modo Especial desde el Cementerio
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_DESTROYED)
    e3:SetCondition(c71230001.spcon)
    e3:SetTarget(c71230001.sptg)
    e3:SetOperation(c71230001.spop)
    c:RegisterEffect(e3)
end

-- Aquí se incluirían las funciones auxiliares para los efectos, como rmcon, rmtg, rmop, negcon, negcost, negtg, negop, spcon, sptg, y spop.
function c71230001.rmcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end

function c71230001.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,1-tp,LOCATION_GRAVE)
end

function c71230001.rmop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,nil)
    if #g>0 then
        local rg=g:Select(tp,1,5,nil)
        Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    end
end

function c71230001.negcon(e,tp,eg,ep,ev,re,r,rp)
    return re~=e and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end

function c71230001.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
    Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end

function c71230001.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
    if re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end

function c71230001.negop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg,REASON_EFFECT)
    end
end

function c71230001.spcon(e,tp,eg,ep,ev,re,r,rp)
    return rp~=tp and e:GetHandler():GetPreviousControler()==tp and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end

function c71230001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c71230001.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end

function c71230001.spfilter(c,e,tp)
    return c:IsSetCard(0x20a2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c71230001.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local g=Duel.GetMatchingGroup(c71230001.spfilter,tp,LOCATION_REMOVED,0,nil,e,tp)
    if #g>0 then
        local sg=g:Select(tp,1,1,nil)
        Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
    end
end