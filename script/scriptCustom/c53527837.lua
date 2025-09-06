--ダーク・シティ masked hero dark force
function c53527837.initial_effect(c)
	--negate attack y sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c53527837.condition2)
	e1:SetTarget(c53527837.target2)
	e1:SetOperation(c53527837.activate2)
	c:RegisterEffect(e1)
	--atk up
	local e05=Effect.CreateEffect(c)
	e05:SetDescription(aux.Stringid(53527837,0))
	e05:SetCategory(CATEGORY_ATKCHANGE)
	e05:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e05:SetCode(EVENT_BE_BATTLE_TARGET)
	e05:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e05:SetCountLimit(1,53527837)
	e05:SetTarget(c53527837.target)
	e05:SetOperation(c53527837.activate)
	c:RegisterEffect(e05)
	--add setcode
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_SETCODE)
	e4:SetValue(0x3008)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetValue(0x08)
	c:RegisterEffect(e5)
end



function c53527837.filter(c)
	return c:IsCode(53527837)
end
function c53527837.cfilter(c)
	return c:IsSetCard(0x8)
end
function c53527837.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c53527837.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c53527837.filter,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingTarget(c53527837.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c53527837.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c53527837.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g2:GetFirst():GetAttack()
	if atk<0 then atk=0 end
	e:SetLabel(atk)
end
function c53527837.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		--e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end





function c53527837.atkcon18(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
end

function c53527837.condition2(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c53527837.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c53527837.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end







--material effect
function c53527837.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c53527837.condition(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c53527837.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(53527837)==0 then
			--atk up
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetCategory(CATEGORY_ATKCHANGE)
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x8))
			--e2:SetCondition(c53527837.atkcon)
			e2:SetValue(c53527837.atkval2)
			rc:RegisterEffect(e2,true)
			rc:RegisterFlagEffect(53527837,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

function c53527837.atkcon(e)
	c53527837[0]=false
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c53527837.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(0xc008)
end
function c53527837.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetAttack()<d:GetAttack() then
		return 1000
	else return 0 end
end

function c53527837.atkval2(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetAttack()<d:GetAttack() then
		return 500
	else return 0 end
end
