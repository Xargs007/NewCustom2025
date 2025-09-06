--グレート・モス
function c141414480.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(141414480,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,50720316)
	e1:SetCondition(c141414480.condition)
	e1:SetOperation(c141414480.spop3)
	c:RegisterEffect(e1)
	--destroy
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(141414480,0))
	--e2:SetCategory(CATEGORY_DESTROY)
	--e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--e2:SetCode(EVENT_TO_REMOVED)
	--e1:SetCountLimit(1,50720316)
	--e2:SetCondition(c141414480.descon)
	--e2:SetTarget(c141414480.thtg2)
	--e2:SetOperation(c141414480.tgop2)
	--c:RegisterEffect(e2)
	--local e3=e2:Clone()
	--e3:SetCode(EVENT_REMOVE)
	--c:RegisterEffect(e3)
	--local e4=e2:Clone()
	--e4:SetCode(EVENT_TO_DECK)
	--c:RegisterEffect(e4)
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c141414480.recon)
	--e5:SetTarget(c141414480.thtg2)
	--e5:SetOperation(c141414480.tgop2)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)
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
function c141414480.recon(e)
	return e:GetHandler():IsFaceup() or e:GetHandler():IsFacedown()
end
function c141414480.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c141414480.spop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,48579379)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,c:GetPreviousPosition(),true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
--
function c141414480.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end

function c141414480.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c141414480.thfilter2(c)
	return c:IsRace(RACE_INSECT) and not c:IsCode(87756343) and not c:IsCode(141414480) and not c:IsCode(48579379) and c:IsAbleToHand()
end
function c141414480.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c141414480.thfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c141414480.tgop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c141414480.thfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--[[
function c141414480.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c141414480.spcon)
	e2:SetOperation(c141414480.spop)
	c:RegisterEffect(e2)
end
function c141414480.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=4
end
function c141414480.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():IsExists(c141414480.eqfilter,1,nil)
end
function c141414480.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c141414480.rfilter,1,nil)
end
function c141414480.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c141414480.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
]]