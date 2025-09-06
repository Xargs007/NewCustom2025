--Necro Maiden Of Macabre
function c700016.initial_effect(c)
	--c:EnableCounterPermit(0x3001)
	--recicle-GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700016,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c700016.condition)
	e1:SetOperation(c700016.desop)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c700016.attackup)
	c:RegisterEffect(e2)
	--send a deck, destroy
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e01:SetCategory(CATEGORY_DESTROY)
	e01:SetDescription(aux.Stringid(700016,1))
	e01:SetCode(EVENT_TO_GRAVE)
	e01:SetCondition(c700016.condtion1)
	e01:SetTarget(c700016.target2)
	e01:SetOperation(c700016.operation2)
	c:RegisterEffect(e01)
end

function c700016.condtion1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c700016.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c700016.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

function c700016.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end

function c700016.filter2(c)
	return c:IsType(TYPE_MONSTER) --and c:IsSetCard(0x235)
end

function c700016.attackup(e,c)
	local var=Duel.GetMatchingGroupCount(c700016.filter2,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)
	return (100*var)
end

function c700016.desop(e,tp,eg,ep,ev,re,r,rp)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsControler(1-tp) and c700016.filter2(chkc) end
	if chk==0 then return (Duel.IsExistingTarget(c700016.filter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) or Duel.IsExistingTarget(c700016.filter2,1-tp,LOCATION_GRAVE,0,1,e:GetHandler())) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATODECK)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATODECK)
	local g=Duel.SelectTarget(tp,c700016.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	local g2=Duel.SelectTarget(1-tp,c700016.filter2,1-tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	--local tc=Duel.GetFirstTarget()
	if Duel.IsExistingTarget(c700016.filter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) or Duel.IsExistingTarget(c700016.filter2,1-tp,LOCATION_GRAVE,0,1,e:GetHandler()) then
		--Duel.SendtoHand(g,ct,REASON_EFFECT)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
		Duel.ConfirmCards(tp,g2)
		Duel.ConfirmCards(1-tp,g)
	end
end
