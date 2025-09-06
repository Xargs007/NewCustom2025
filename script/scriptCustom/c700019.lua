-- Amulet of Affection
-- scripted by: UnknownGuest
function c700019.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c700019.cost)
	e1:SetTarget(c700019.target)
	e1:SetOperation(c700019.operation)
	c:RegisterEffect(e1)
	-- change battle damage
--	local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	--e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	--e2:SetCode(EVENT_BE_BATTLE_TARGET)
	--e2:SetRange(LOCATION_SZONE)
	--e2:SetCondition(c700019.damcon)
	--e2:SetTarget(c700019.damtg)
	--e2:SetOperation(c700019.damop)
	--c:RegisterEffect(e2)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_SET_CONTROL)
	e4:SetValue(c700019.damcon1)
	c:RegisterEffect(e4)
end

function c700019.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x235) and c:IsAbleToGraveAsCost() and not c:IsHasEffect(81674782) --c:IsDiscardable() and 
end

function c700019.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700019.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	local rc=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	--local sg=g:RandomSelect(tp,1)
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	--local rc=Duel.SelectTarget(tp,c700019.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(rc,REASON_COST+REASON_RELEASE)
end

function c700019.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0
end
function c700019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c700019.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c700019.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c700019.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c700019.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		-- Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		--e1:SetValue(1)
		e1:SetValue(c700019.eqlimit)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c700019.eqlimit(e,c)
	return e:GetHandlerPlayer()~=c:GetControler() or e:GetHandler():GetEquipTarget()==c
end
function c700019.damcon1(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ep==tp and ec --and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
end
--function c700019.damcon(e,tp,eg,ep,ev,re,r,rp)
--	local ec=e:GetHandler():GetEquipTarget()
--	return ep==tp and ec and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
--end
--function c700019.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
--	if chk==0 then return true end
--	Duel.SetTargetPlayer(e:GetHandler():GetControler())
--end
--function c700019.damop(e,tp,eg,ep,ev,re,r,rp)
--	Duel.ChangeBattleDamage(ep,0)
--end
