--サイバー・エンジェル－韋駄天－
--Cyber Angel - Idaten
--Script by nekrozar
function c900206013.initial_effect(c)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(900206013,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c900206013.thcon)
	e1:SetTarget(c900206013.thtg)
	e1:SetOperation(c900206013.thop)
	c:RegisterEffect(e1)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(c900206013.tg2)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	e2:SetTarget(c900206013.tg2)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--atk/def up
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(900206013,1))
	--e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	--e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	--e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	--e2:SetCode(EVENT_RELEASE)
	--e2:SetTarget(c900206013.adtg)
	--e2:SetOperation(c900206013.adop)
	--c:RegisterEffect(e2)
	
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_FIELD)
	--e2:SetCode(EFFECT_UPDATE_ATTACK)
	--e2:SetRange(LOCATION_MZONE)
	--e2:SetTargetRange(0,LOCATION_MZONE)
	--e2:SetTarget(c900206013.tg)
	--e2:SetValue(1000)
	--c:RegisterEffect(e2)
	--local e02=Effect.CreateEffect(c)
	--e02:SetType(EFFECT_TYPE_FIELD)
	--e02:SetCode(EFFECT_UPDATE_DEFENCE)
	--e02:SetRange(LOCATION_MZONE)
	--e02:SetTargetRange(0,LOCATION_MZONE)
	--e02:SetTarget(c900206013.tg)
	--e02:SetValue(1000)
	--c:RegisterEffect(e02)
end
function c900206013.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and bit.band(c:GetType(),0x81)==0x81
end
function c900206013.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c900206013.thfilter(c)
	return c:GetType()==0x82 and c:IsAbleToHand()
end
function c900206013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900206013.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c900206013.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c900206013.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c900206013.adfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) --bit.band(c:GetType(),0x81)==0x81
end
function c900206013.adtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900206013.adfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c900206013.adop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c900206013.adfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		--e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENCE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end

function c900206013.tg2(e,c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
