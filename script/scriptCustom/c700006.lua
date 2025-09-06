--Script by Xargs
function c700006.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x235),3)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	--e2:SetCondition(c700006.con)
	e2:SetValue(c700006.atkval)
	c:RegisterEffect(e2)
	--discard deck & destroy
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND)
	e02:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e02:SetCode(EVENT_FREE_CHAIN)
	e02:SetDescription(aux.Stringid(700006,0))
	e02:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e02:SetCountLimit(1,700006)
	e02:SetRange(LOCATION_MZONE)
	--e02:SetCondition(c700006.descon)
	e02:SetTarget(c700006.distg)
	e02:SetOperation(c700006.desop)
	c:RegisterEffect(e02)
	local e03=Effect.CreateEffect(c)
	e03:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND)
	e03:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e03:SetCode(EVENT_FREE_CHAIN)
	e03:SetDescription(aux.Stringid(700006,1))
	e03:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e03:SetCountLimit(1,700006)
	e03:SetRange(LOCATION_MZONE)
	--e02:SetCondition(c700006.descon)
	e03:SetTarget(c700006.distg2)
	e03:SetOperation(c700006.desop)
	c:RegisterEffect(e03)
	local e04=Effect.CreateEffect(c)
	e04:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND)
	e04:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e04:SetCode(EVENT_FREE_CHAIN)
	e04:SetDescription(aux.Stringid(700006,2))
	e04:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e04:SetCountLimit(1,700006)
	e04:SetRange(LOCATION_MZONE)
	--e02:SetCondition(c700006.descon)
	e04:SetTarget(c700006.distg3)
	e04:SetOperation(c700006.desop)
	c:RegisterEffect(e04)
end



function c700006.filterb(c)
	return (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsAbleToHand() and c:IsPreviousLocation(LOCATION_DECK) and c:IsFaceup() --and c:IsLocation(LOCATION_GRAVE)
end

function c700006.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	e:SetLabel(1)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c700006.distg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	e:SetLabel(2)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c700006.distg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	e:SetLabel(3)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c700006.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT)--(rp~=tp and c:IsReason(REASON_EFFECT) and c:GetPreviousControler()==tp)
end
function c700006.desop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local ct=e:GetLabel()

	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c700006.filterb(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700006.filterb,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c700006.filterb,tp,LOCATION_GRAVE,0,ct,ct,e:GetHandler())
	--local tc=Duel.GetFirstTarget()
	if Duel.IsExistingTarget(c700006.filterb,tp,LOCATION_GRAVE,0,1,e:GetHandler()) then
		Duel.SendtoHand(g,ct,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--atk
function c700006.atkval(e,c)
	return c:GetLinkedGroupCount()*400
end

function c700006.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700006.filterc,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp,zone)--Duel.IsExistingMatchingCard(c700005.filterc,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c700006.filterc(c)
	return (c:IsRace(RACE_FIEND) or c:IsRace(RACE_ZOMBIE)) and c:IsPosition(POS_FACEUP) and not c:IsCode(700006) --and not c:IsCode(700006)
end