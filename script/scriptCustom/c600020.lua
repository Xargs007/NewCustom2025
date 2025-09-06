--Cat Stampede
function c600020.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c600020.damtg)
	e1:SetOperation(c600020.damop)
	c:RegisterEffect(e1)
end
function c600020.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e))
end
function c600020.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c600020.filter,c:GetControler(),LOCATION_GRAVE,0,nil)*300
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct)
end
function c600020.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c600020.filter,c:GetControler(),LOCATION_GRAVE,0,nil)*300
	Duel.Damage(p,ct,REASON_EFFECT)
end