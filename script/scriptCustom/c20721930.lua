--機械天使の絶対儀式 bustrix
local s,id=GetID()
function s.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(s.target2)
	e1:SetOperation(s.operation2)
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
	e02:SetCondition(s.condition)
	--e02:SetTarget(s.target)
	e02:SetOperation(s.operation)
	c:RegisterEffect(e02)
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
	--change name
	local e07=Effect.CreateEffect(c)
	e07:SetType(EFFECT_TYPE_SINGLE)
	e07:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e07:SetCode(EFFECT_CHANGE_CODE)
	e07:SetRange(LOCATION_MZONE)
	e07:SetValue(21844576)
	c:RegisterEffect(e07)
	local e08=e07:Clone()
	e08:SetRange(LOCATION_HAND)
	c:RegisterEffect(e08)
	local e09=e07:Clone()
	e09:SetRange(LOCATION_REMOVED)
	c:RegisterEffect(e09)
	local e010=e07:Clone()
	e010:SetRange(LOCATION_DECK)
	c:RegisterEffect(e010)
end
function s.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function s.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--material effect
function s.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(20721928)==0 then
			-- change position
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCategory(CATEGORY_POSITION)
			e1:SetDescription(aux.Stringid(20721928,0))
			e1:SetType(EFFECT_TYPE_QUICK_O)
			e1:SetCode(EVENT_FREE_CHAIN)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCountLimit(1)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e1:SetTarget(s.target)
			e1:SetOperation(s.activate)
			--e1:SetReset(RESET_EVENT+0x1fe0000)
			--e1:SetValue(1)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(20721928,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

function s.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end



function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
--[[
function s.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and (chkc:IsControler(1-tp) or chkc:IsControler(1-tp)) and chkc:IsFaceup() end
	if chk==0 then		
		e:SetLabel(0)
		return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	end
	local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	local cg=nil
	if e:GetLabel()==1 then cg=g:Filter(Card.IsAbleToChangeControler,nil)
	else cg=g:Filter(Card.IsControlerCanBeChanged,nil) end
	local sel=0
	Duel.Hint(HINT_SELECTMSG,tp,550)
	if cg:GetCount()==0 then
		sel=Duel.SelectOption(tp,aux.Stringid(98045062,0))
	else
		sel=Duel.SelectOption(tp,aux.Stringid(98045062,0))
	end
	if sel==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	end
	e:SetLabel(sel)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	--local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if e:GetLabel()==0 then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENCE,0,POS_FACEUP_ATTACK,0)
		end
	end
end
]]--

function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end