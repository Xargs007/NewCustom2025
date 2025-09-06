--Counterbalance necro
function c700003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--discard opp deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetDescription(aux.Stringid(700003,1))
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCountLimit(1)
	e2:SetCondition(c700003.discon)
	e2:SetTarget(c700003.target)
	e2:SetOperation(c700003.activate)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--discard your deck
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetDescription(aux.Stringid(700003,1))
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCountLimit(1)
	e3:SetCondition(c700003.discon2)
	e3:SetTarget(c700003.target2)
	e3:SetOperation(c700003.activate2)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)	
	--discard deck & destroy
	local e02=Effect.CreateEffect(c)
	e02:SetCategory(CATEGORY_DECKDES+CATEGORY_DESTROY)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e02:SetCode(EVENT_DESTROYED)
	e02:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e02:SetCountLimit(1,700003)
	e02:SetCondition(c700003.descon)
	e02:SetTarget(c700003.distg)
	e02:SetOperation(c700003.desop)
	c:RegisterEffect(e02)
end

function c700003.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end

function c700003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end--Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,TYPE_MONSTER) end
	Duel.SetTargetPlayer(1-tp)
	--envia cartas igual al numero de monstruos en el campo, eso esta muy roto lo cambie a 1
	--local dam=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_MONSTER)*1
	--Duel.SetTargetParam(dam)
	--Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1)
end
function c700003.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=1--Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_MONSTER)*1
	Duel.DiscardDeck(1-tp,dam,REASON_EFFECT)
end

function c700003.discon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c700003.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end--Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,TYPE_MONSTER) end
	Duel.SetTargetPlayer(tp)
	--envia cartas igual al numero de monstruos en el campo, eso esta muy roto lo cambie a 1
	--local dis=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_MONSTER)*1
	--Duel.SetTargetParam(dis)
	--Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,dis)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1)
end
function c700003.activate2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dis=1--Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_MONSTER)*1
	Duel.DiscardDeck(tp,dis,REASON_EFFECT)
end

function c700003.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c700003.cfilter(c)
	return c:IsSetCard(0x235) and c:IsLocation(LOCATION_GRAVE)
end
function c700003.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT)--(rp~=tp and c:IsReason(REASON_EFFECT) and c:GetPreviousControler()==tp)
end
function c700003.desop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c700003.cfilter,nil)
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if ct~=0 and dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(700003,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sdg=dg:Select(tp,1,ct,nil)
		Duel.Destroy(sdg,REASON_EFFECT)
	end
end
