--E・HERO ザ・ヒート
function c982663770.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c982663770.val)
	c:RegisterEffect(e1)
	--become material
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e02:SetCode(EVENT_BE_MATERIAL)
	--e02:SetCondition(c93302688.condition)
	--e02:SetTarget(c20721930.target)
	e02:SetOperation(c982663770.operation)
	c:RegisterEffect(e02)
end
function c982663770.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c982663770.val(e,c)
	return Duel.GetMatchingGroupCount(c982663770.filter,c:GetControler(),LOCATION_MZONE,0,nil)*400
end


--material effect
function c982663770.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c982663770.condition(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c982663770.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(982663770)==0 then
			--to hand
			local e4=Effect.CreateEffect(e:GetHandler())
			--e4:SetDescription(aux.Stringid(20366274,1))
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e4:SetRange(LOCATION_MZONE)
			e4:SetCode(EFFECT_UPDATE_ATTACK)
			e4:SetValue(c982663770.val2)
			rc:RegisterEffect(e4,true)
			rc:RegisterFlagEffect(982663770,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

function c982663770.val2(e,c)
	return Duel.GetMatchingGroupCount(c982663770.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end