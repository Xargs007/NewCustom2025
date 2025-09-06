--機械天使の絶対儀式 cyber absolute
function c21844578.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21844578,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,21844578)
	e1:SetTarget(c21844578.thtg)
	e1:SetOperation(c21844578.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
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
	e02:SetCondition(c21844578.condition)
	e02:SetOperation(c21844578.operation)
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
	e07:SetValue(46986414)
	c:RegisterEffect(e07)
end
function c21844578.thfilter(c)
	return (c:IsSetCard(0x8)) and c:IsAbleToHand() and not c:IsCode(21844578)
end
function c21844578.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21844578.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c21844578.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c21844578.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--material effect
function c21844578.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c21844578.condition(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c21844578.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(21844578)==0 then
			-- double attack
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EXTRA_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCondition(c21844578.atkcon)
			e1:SetValue(1)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(21844578,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

function c21844578.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_MONSTER)
end
