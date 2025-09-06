--Cursed Twin Dolls (Fix)
function c700004.initial_effect(c)
	--Activate
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_ACTIVATE)
	e01:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e01)
	--if discar, add yo hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700004,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c700004.condition)
	e1:SetTarget(c700004.target)
	e1:SetOperation(c700004.operation)
	c:RegisterEffect(e1)
	--destroy remplace for monster fiend and zombie
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c700004.desreptg)
	e4:SetOperation(c700004.desrepop)
	c:RegisterEffect(e4)
	--coin recover lp or send to opp deck
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e02:SetCategory(CATEGORY_COIN+CATEGORY_RECOVER+CATEGORY_DECKDES)
	e02:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e02:SetRange(LOCATION_SZONE)
	--e02:SetProperty(EFFECT_FLAG_REPEAT)
	e02:SetCountLimit(1)
	e02:SetCondition(c700004.discon)
	e02:SetTarget(c700004.targetop)
	e02:SetOperation(c700004.operationop)
	--e02:SetLabelObject(e01)
	c:RegisterEffect(e02)
	--coin recover lp or send to your deck
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_COIN+CATEGORY_RECOVER+CATEGORY_DECKDES)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	--e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCountLimit(1)
	e3:SetCondition(c700004.discon2)
	e3:SetTarget(c700004.targety)
	e3:SetOperation(c700004.operationy)
	--e3:SetLabelObject(e01)
	c:RegisterEffect(e3)	
	
end
function c700004.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_DECK)>0
end
function c700004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c700004.filter(c)
	return (c:IsCode(700004) and c:IsType(TYPE_SPELL)) and c:IsAbleToHand()
end
function c700004.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c700004.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end


function c700004.repfilter(c,e)
	return (c:IsRace(RACE_FIEND) or c:IsRace(RACE_ZOMBIE)) and c:IsDestructable(e)
		and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c700004.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c700004.repfilter,tp,LOCATION_MZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c700004.repfilter,tp,LOCATION_MZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		Duel.HintSelection(g)
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c700004.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end

function c700004.discon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE+LOCATION_SZONE)>0--Duel.GetMatchingGroupCount(c700004.filterg,tp,0,LOCATION_FIELD,nil)
end
function c700004.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetFieldGroupCount(1-tp,0,LOCATION_MZONE+LOCATION_SZONE)>0--Duel.GetMatchingGroupCount(c700004.filterg,tp,LOCATION_FIELD,0,nil)
end
function c700004.filterg(c)
	return not c:IsType(TYPE_TOKEN) 
end
function c700004.targetop(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return true end
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,0,LOCATION_MZONE+LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,1-tp,1)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_COIN+CATEGORY_RECOVER,nil,0,1-tp,0)
	--local ct=Duel.GetMatchingGroupCount(c700004.filterg,1-tp,LOCATION_FIELD,0,nil)
	--Duel.SetTargetPlayer(1-tp)
	--Duel.SetTargetParam(ct*200)
	--Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,1-tp,ct*200)
end
function c700004.operationop(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.TossCoin(1-tp,1)
	if coin==1 then
		local rt=Duel.GetFieldGroupCount(1-tp,0,LOCATION_MZONE+LOCATION_SZONE)*200
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		Duel.Recover(p,rt,REASON_EFFECT)
		--local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		--Duel.Recover(p,d,REASON_EFFECT)
	end
	if coin==0 then
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end

function c700004.targety(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return true end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE+LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
	--local ct=Duel.GetMatchingGroupCount(c700004.filterg,tp,0,LOCATION_FIELD,nil)
	--Duel.SetTargetPlayer(tp)
	--Duel.SetTargetParam(ct*200)
	--Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,ct*200)
end
function c700004.operationy(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.TossCoin(tp,1)
	if coin==1 then
		local rt=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE+LOCATION_SZONE)*200
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		Duel.Recover(p,rt,REASON_EFFECT)
	end
	if coin==0 then
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end