--Cat's Ear Tribe (Fix)
function c600027.initial_effect(c)
	--direct attack
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e01)
	--attack op reduce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c600027.atktg)
	e1:SetCondition(c600027.atkcon)
	e1:SetValue(200)
	c:RegisterEffect(e1)
	--attack Cats increase
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c600027.atkcon1)
	e2:SetTarget(c600027.atktg1)
	e2:SetValue(numbcats*200)
	c:RegisterEffect(e2)
	
end
numbcats=1
function c95841282.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and Duel.GetAttackTarget()==e:GetHandler()
end
function c600027.atktg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c600027.atkcon1(e)
	numbcats=numbcats+Duel.GetMatchingGroupCount(c600027.cfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c600027.atktg1(e,c)
	return c==e:GetHandler() and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)
end
function c600027.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)
