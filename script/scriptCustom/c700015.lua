--Necro Disgraced Mage
function c700015.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700015,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCountLimit(1,700015)
	--e1:SetCondition(c700015.condition)
	e1:SetTarget(c700015.target1)
	e1:SetOperation(c700015.operation4)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetCountLimit(1,700015)
	e2:SetCondition(c700015.damcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,700015)
	e3:SetTarget(c700015.desreptg)
	c:RegisterEffect(e3)
	--recover card of grave
	local e01=Effect.CreateEffect(c)
	e01:SetCategory(CATEGORY_DISABLE)
	e01:SetType(EFFECT_TYPE_IGNITION)
	e01:SetDescription(aux.Stringid(700015,1))
	e01:SetRange(LOCATION_GRAVE)
	e01:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e01:SetCountLimit(1,700015)
	--e2:SetCode(EVENT_FREE_CHAIN)
	e01:SetCondition(aux.exccon)
	e01:SetCost(c700015.negcost)
	e01:SetTarget(c700015.target2)
	e01:SetOperation(c700015.operation2)
	c:RegisterEffect(e01)
end

function c700015.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetAttackTarget()==c or (Duel.GetAttacker()==c and Duel.GetAttackTarget()~=nil) end
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c700015.operation4(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local c=Duel.GetAttacker()
	if c:IsRelateToBattle() then g:AddCard(c) end
	c=Duel.GetAttackTarget()
	if c~=nil and c:IsRelateToBattle() then g:AddCard(c) end
	if g:GetCount()>0 then
		--Duel.SendtoHand(g, nil, REASON_EFFECT)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end

function c700015.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not bc:IsType(TYPE_TOKEN) and bc:GetLeaveFieldDest()==0
end
function c700015.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	--local bc=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	if bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetCode(EFFECT_SEND_REPLACE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetTarget(c700015.reptg)
		e1:SetOperation(c700015.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
	end
end

function c700015.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_DESTROY)) end
	return true
end
function c700015.repop(e,tp,eg,ep,ev,re,r,rp)
	--local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
end
function c700015.damcon(e)
	return e:GetHandler()==Duel.GetAttackTarget()
end
function c700015.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	--local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return (c:IsReason(REASON_DESTROY) or c:IsReason(REASON_EFFECT)) and c:IsFaceup() end --and g:GetCount()>0 --c:IsReason(REASON_BATTLE) or 
	if Duel.SelectYesNo(tp,aux.Stringid(700015,0)) then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		--Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		return true
	else return false end
end

function c700015.filter22(c)
	return c:IsAbleToHand() --and not c:IsCode(700015)--c:GetType()==TYPE_SPELL and c:IsAbleToHand()
end

function c700015.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c700015.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c700015.filter22(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700015.filter22,tp,LOCATION_GRAVE,0,5,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c700015.filter22,tp,LOCATION_GRAVE,0,5,5,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c700015.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
