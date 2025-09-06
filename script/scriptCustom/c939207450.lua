--ペンギン・ソルジャー
function c939207450.initial_effect(c)
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(86346643,0))
	--e1:SetCategory(CATEGORY_TOHAND)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	--e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	--e1:SetTarget(c939207450.target)
	--e1:SetOperation(c939207450.operation)
	--c:RegisterEffect(e1)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(939207450,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(c939207450.tdcost1)
	e1:SetTarget(c939207450.tdtg3)
	e1:SetOperation(c939207450.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(939207450,0))
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e2:SetTarget(c939207450.tdtg2)
	e2:SetOperation(c939207450.operation)
	c:RegisterEffect(e2)
end
function c939207450.cfilter1(c)
	return c:IsType(TYPE_MONSTER)--c:IsCode(939207450) --and c:IsAbleToHandAsCost()
end
function c939207450.tdcost1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c29587993.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c939207450.cfilter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c939207450.cfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,2,REASON_COST)
end
function c939207450.tdtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c939207450.tdop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoHand(g,nil,2,REASON_EFFECT)
end
--
function c939207450.filter7(c)
	return c:IsFaceup() and c:IsCode(939207450) --and c:IsAbleToHand()
end
function c939207450.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c939207450.filter7(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c939207450.filter7,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c939207450.filter7,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end

function c939207450.tdtg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c939207450.filter2(chkc) end -- LOCATION_MZONE and chkc:IsAbleToHand()
	if chk==0 then return Duel.IsExistingTarget(c939207450.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end --Card.IsAbleToHand
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c939207450.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil) 
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g ,g:GetCount(),0,0)
end
--
function c939207450.filter2(c)
	return (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_EFFECT)) and c:IsLocation(LOCATION_MZONE)--return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c939207450.tdtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c939207450.filter2(chkc) end -- LOCATION_MZONE and chkc:IsAbleToHand()
	if chk==0 then return Duel.IsExistingTarget(c939207450.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end --Card.IsAbleToHand
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c939207450.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil) 
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g ,g:GetCount(),0,0)
end

function c939207450.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if tg then
		local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
