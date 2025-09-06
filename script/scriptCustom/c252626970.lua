--墓守の暗殺者
function c252626970.initial_effect(c)
	--pos
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(252626970,0))
	--e1:SetCategory(CATEGORY_POSITION)
	--e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	--e1:SetCondition(c252626970.poscon)
	--e1:SetTarget(c252626970.postg)
	--e1:SetOperation(c252626970.posop)
	--c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(252626970,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c252626970.poscon)
	e2:SetTarget(c252626970.postg)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c252626970.posop)
	c:RegisterEffect(e2)
end
function c252626970.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(47355498)
end
function c252626970.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c252626970.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE,0,POS_FACEUP_ATTACK,0)
	end
end
