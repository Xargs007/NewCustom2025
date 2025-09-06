--Mirage Spell
function c948130397.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c948130397.condition)
	e1:SetTarget(c948130397.target)
	e1:SetOperation(c948130397.activate)
	c:RegisterEffect(e1)
end
function c948130397.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c948130397.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local rec=tg:GetAttack()
	local rec2=tg:GetDefenSe()
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec2)
end
function c948130397.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		if Duel.NegateAttack(tc) then
			Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
			Duel.Recover(tp,tc:GetDefense(),REASON_EFFECT)
		end
	end
end

--[[
function c948130397.initial_effect(c)
--Get LP instead of ATK/DEF Change
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_RECOVER+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)--+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE (CATEGORY_RECOVER
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetHintTiming(0,0x1e0)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c948130397.tg)
e1:SetOperation(c948130397.op)
c:RegisterEffect(e1)
end

function c948130397.filter(c)
return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack() or c:GetDefence()~=c:GetBaseDefence()
end
function c948130397.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE,0) and c948130397.filter(chkc) and chkc:IsFaceup() end
if chk==0 then return Duel.IsExistingTarget(c948130397.filter,tp,LOCATION_MZONE,0,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
local g=Duel.SelectTarget(tp,c948130397.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
local tc=g:GetFirst()
local atk=tc:GetAttack()
local batk=tc:GetBaseAttack()
local def=tc:GetDefence()
local bdef=tc:GetBaseDefence()
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,(batk-atk) and (bdef-def) or (atk-batk) and (def-bdef))
end
function c948130397.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if tc:IsRelateToEffect(e) and tc:IsFaceup() then
local atk=tc:GetAttack()
local batk=tc:GetBaseAttack()
local def=tc:GetDefence()
local bdef=tc:GetBaseDefence()
if batk~=atk or bdef~=def then
local dif1=(batk>atk) and (batk-atk) or (atk-batk)
local dif2=(bdef>def) and (bdef-def) or (def-bdef)
local dif=dif1+dif2
local rec=Duel.Recover(tp,dif,REASON_EFFECT)
if rec>0 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK+EFFECT_UPDATE_DEFENCE)
e1:SetReset(RESET_EVENT+0x1ff0000)
e1:SetValue(dif)
tc:RegisterEffect(e1)
end

end
end
end]]