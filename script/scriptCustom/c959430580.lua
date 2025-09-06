--E－HERO ヘル・ゲイナー
function c959430580.initial_effect(c)
	--extra atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(959430580,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c959430580.condition)
	e1:SetCost(c959430580.cost)
	e1:SetTarget(c959430580.target)
	e1:SetOperation(c959430580.operation)
	c:RegisterEffect(e1)
	--race
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetValue(0x8)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
	--race 2
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_FIELD)
	e02:SetRange(LOCATION_MZONE)
	e02:SetTargetRange(0,LOCATION_GRAVE)
	e02:SetCode(EFFECT_CHANGE_RACE)
	e02:SetValue(0x8)
	c:RegisterEffect(e02)
	e1:SetLabelObject(e02)
	local e04=Effect.CreateEffect(c)
	e04:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e04:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e04:SetCode(EVENT_BE_MATERIAL)
	e04:SetCondition(c959430580.condition2)
	--e02:SetTarget(c20721930.target)
	e04:SetOperation(c959430580.operation2)
	c:RegisterEffect(e04)
end


function c959430580.condition2(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c959430580.operation2(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	local c=e:GetHandler()
	while rc do
		if rc:GetFlagEffect(959430580)==0 then
			--race
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e2:SetCode(EFFECT_CHANGE_RACE)
			e2:SetValue(c:GetRace())
			e2:SetLabelObject(e2)
			rc:RegisterEffect(e02,true)
			rc:RegisterFlagEffect(959430580,RESET_EVENT+0x1fe0000,0,1)
			--race 2
			local e02=Effect.CreateEffect(e:GetHandler())
			e02:SetType(EFFECT_TYPE_FIELD)
			e02:SetRange(LOCATION_MZONE)
			e02:SetTargetRange(0,LOCATION_GRAVE)
			e02:SetCode(EFFECT_CHANGE_RACE)
			e02:SetValue(c:GetRace())
			e02:SetLabelObject(e02)
			rc:RegisterEffect(e02,true)
			rc:RegisterFlagEffect(959430580,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end



function c959430580.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,562)
	local rc=Duel.AnnounceRace(tp,1,0xffff)
	e:GetLabelObject():SetLabel(rc)
	e:GetHandler():SetHint(CHINT_RACE,rc)
end
function c959430580.value(e,c)
	return e:GetLabel()
end
function c959430580.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c959430580.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c959430580.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c959430580.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c959430580.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c959430580.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c959430580.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c959430580.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--extra atk
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(959430580,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	e2:SetCondition(c959430580.spcon)
	e2:SetTarget(c959430580.sptg)
	e2:SetOperation(c959430580.spop)
	e2:SetLabel(0)
	c:RegisterEffect(e2)
end
function c959430580.spcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=e:GetLabel()
	e:SetLabel(ct+1)
	return ct==1
end
function c959430580.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c959430580.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
