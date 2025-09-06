--Necro Bride Doll
function c700017.initial_effect(c)
	--Remove monster a GY, Summon Token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOKEN+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(700017,0))
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c700017.con)
	e2:SetTarget(c700017.target)
	e2:SetOperation(c700017.operation)
	c:RegisterEffect(e2)
	--destroy remplace for token
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetDescription(aux.Stringid(700017,1))
	e4:SetCountLimit(1)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c700017.desreptg)
	e4:SetOperation(c700017.desrepop)
	c:RegisterEffect(e4)
end


function c700017.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700017.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
--function c700017.filterc(c)
	--return (c:IsType(TYPE_MONSTER)) 
--end
function c700017.filter(c,tp)
	return c:IsFaceup() and c:IsAbleToRemove() --and c:IsType(TYPE_MONSTER)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,700018,0,0x4011,c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute()) and c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end

function c700017.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c700017.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tp)
		and not Duel.IsExistingTarget(c700017.repfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	--Duel.SelectTarget(tp,c700017.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,tp)
	local g=Duel.SelectTarget(tp,c700017.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	--Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function c700017.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and not Duel.IsExistingTarget(c700017.repfilter,tp,LOCATION_MZONE,0,1,nil,tp) --then return end
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,700018,0,0x4011,tc:GetAttack(),tc:GetDefense(),
			tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end
		local token=Duel.CreateToken(tp,700018)
		--token:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0xfe0000,1)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		e2:SetValue(tc:GetDefense())
		token:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetLevel())
		token:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(c:GetRace())
		token:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(c:GetAttribute())
		token:RegisterEffect(e5)
		--if tc:IsType(TYPE_EFFECT) and not token:IsType(TYPE_EFFECT) then
		--	local e6=Effect.CreateEffect(c)
		--	e6:SetType(EFFECT_TYPE_SINGLE)
		--	e6:SetCode(EFFECT_ADD_TYPE)
		--	e6:SetValue(TYPE_EFFECT)
		--	e6:SetReset(RESET_EVENT+0x1fe0000)
		--	token:RegisterEffect(e6)
		--end
		Duel.SpecialSummonComplete()
		c:SetCardTarget(token)
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end

function c700017.repfilter(c,e)
	return c:IsCode(700018) --(c:IsType(TYPE_TOKEN) and 
end

function c700017.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return (c:IsReason(REASON_DESTROY) or c:IsReason(REASON_EFFECT) or c:IsReason(REASON_BATTLE)) and c:IsFaceup() --not c:IsReason(REASON_REPLACE) and 
		and Duel.IsExistingMatchingCard(c700017.repfilter,tp,LOCATION_MZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c700017.repfilter,tp,LOCATION_MZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		--Duel.HintSelection(g)
		return true
	else return false end
end
function c700017.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end