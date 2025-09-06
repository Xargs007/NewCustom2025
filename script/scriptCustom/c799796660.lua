--E・HERO バブルマン
function c799796660.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c799796660.spcon)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(799796660,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c799796660.condition)
	e2:SetTarget(c799796660.target)
	e2:SetOperation(c799796660.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e02:SetCode(EVENT_BE_MATERIAL)
	e02:SetCondition(c799796660.condition2)
	--e02:SetTarget(c20721930.target)
	e02:SetOperation(c799796660.operation2)
	c:RegisterEffect(e02)
end

function c799796660.condition2(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL))
end
function c799796660.operation2(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(799796660)==0 then
			--draw card
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_QUICK_O)
			e1:SetDescription(aux.Stringid(799796660,1))
			e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e1:SetCode(EVENT_SUMMON_SUCCESS)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCountLimit(1,799796660)
			e1:SetTarget(c799796660.target3)
			e1:SetOperation(c799796660.operation3)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(799796660,RESET_EVENT+0x1fe0000,0,1)
			local e2=e1:Clone()
			e2:SetCode(EVENT_SPSUMMON_SUCCESS)
			e2:SetDescription(aux.Stringid(799796660,1))
			e2:SetCountLimit(1,799796660)
			rc:RegisterEffect(e2,true)
			rc:RegisterFlagEffect(799796660,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

function c799796660.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c799796660.filter(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c799796660.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c799796660.filter,tp,LOCATION_HAND,0,1,e:GetHandler())
end
function c799796660.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c799796660.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c799796660.filter,tp,LOCATION_HAND,0,1,e:GetHandler()) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c799796660.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c799796660.operation3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c799796660.filter,tp,LOCATION_HAND,0,1,e:GetHandler()) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end