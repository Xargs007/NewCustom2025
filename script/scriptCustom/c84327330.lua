--機械天使の絶対儀式 bustrix
function c84327330.initial_effect(c)
	--indestrutible
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetValue(c84327330.valcon)
	--e1:SetValue(1)
	c:RegisterEffect(e1)
	--battle indestructable
	--local e01=Effect.CreateEffect(c)
	--e01:SetType(EFFECT_TYPE_SINGLE)
	--e01:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	--e01:SetCountLimit(1)
	--e01:SetValue(c84327330.valcon)
	--e01:SetValue(1)
	--c:RegisterEffect(e01)
	--fusion material
	--local e01=Effect.CreateEffect(c)
	--e01:SetType(EFFECT_TYPE_SINGLE)
	--e01:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	--e01:SetCondition(c4141820.con)
	--e01:SetValue(1)
	--c:RegisterEffect(e01)
	--become material
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e02:SetCode(EVENT_BE_MATERIAL)
	e02:SetCondition(c84327330.condition)
	--e02:SetTarget(c20721930.target)
	e02:SetOperation(c84327330.operation)
	c:RegisterEffect(e02)
	--add setcode
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_SETCODE)
	e4:SetValue(0x3008)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e4:SetValue(0x08)
	c:RegisterEffect(e5)
	local e07=Effect.CreateEffect(c)
	e07:SetType(EFFECT_TYPE_SINGLE)
	e07:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e07:SetCode(EFFECT_CHANGE_CODE)
	e07:SetValue(84327329)
	c:RegisterEffect(e07)
end

function c84327330.valcon(e, re, r, rp)
	return (bit.band(r, REASON_BATTLE) ~= 0 or bit.band(r, REASON_EFFECT) ~= 0)
end
function c84327330.valcon2(e, re, r, rp)
	return bit.band(r, REASON_EFFECT) ~= 0
end
function c84327330.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84327330.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--material effect
function c84327330.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c84327330.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_FUSION
end
function c84327330.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(84327330)==0 then
			--Indestrutible
			--[[
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCountLimit(1,84327330)
			e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e1:SetValue(1)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(84327330,RESET_EVENT+0x1fe0000,0,1)
			]]--
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
			e1:SetCountLimit(1)
			e1:SetValue(c84327330.valcon)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(84327330,RESET_EVENT+0x1fe0000,0,1)
			--battle indestructable
			--local e01=Effect.CreateEffect(e:GetHandler())
			--e01:SetType(EFFECT_TYPE_SINGLE)
			--e01:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
			--e01:SetCountLimit(1,84327330)
			--e01:SetValue(c84327330.valcon)
			--rc:RegisterEffect(e01,true)
			--rc:RegisterFlagEffect(84327330,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end