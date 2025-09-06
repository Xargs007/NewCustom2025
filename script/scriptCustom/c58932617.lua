--機械天使の絶対儀式 bustrix
function c58932617.initial_effect(c)
	--attack por 2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c58932617.regop)
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
	e02:SetCondition(c58932617.condition)
	e02:SetTarget(c58932617.target2)
	e02:SetOperation(c58932617.activate2)
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
	e07:SetValue(58932617)
	c:RegisterEffect(e07)
end


function c58932617.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(c58932617.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	--local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE+LOCATION_SZONE,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c58932617.activate2(e,tp)
	local g=Duel.SelectTarget(tp,c58932617.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,1,1,nil)--Duel.GetMatchingGroup(c58932617.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	end
end


function c58932617.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	e1:SetValue(c:GetBaseAttack()*2)
	c:RegisterEffect(e1)
end

--material effect
function c58932617.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function c58932617.condition(e,tp,eg,ep,ev,re,r,rp)
	return (r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL)
end
function c58932617.filter(c)
	return c:IsAbleToDeck()
end
function c58932617.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58932617.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c58932617.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c58932617.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58932617.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end