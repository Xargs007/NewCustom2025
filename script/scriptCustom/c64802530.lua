--フレンドッグ
function c64802530.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64802530,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVED)
	e1:SetCondition(c64802530.condition)
	e1:SetTarget(c64802530.target)
	e1:SetOperation(c64802530.activate)
	c:RegisterEffect(e1)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SPSUMMON_PROC)
	e6:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e6:SetRange(LOCATION_HAND)
	e6:SetCondition(c64802530.spcon2)
	c:RegisterEffect(e6)
	--cannot be battle target
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_FIELD)
	e01:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e01:SetRange(LOCATION_MZONE)
	e01:SetTargetRange(0,LOCATION_MZONE)
	e01:SetValue(c64802530.tg)
	c:RegisterEffect(e01)
end
function c64802530.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsSetCard(0x3008)
end
function c64802530.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and ((Duel.IsExistingMatchingCard(c64802530.cfilter,tp,LOCATION_ONFIELD,0,1,nil)))

end

function c64802530.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end

function c64802530.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)--and e:GetHandler():IsReason(REASON_BATTLE)
end
function c64802530.filter1(c)
	return c:IsSetCard(0x3008) and c:IsAbleToHand()
end
function c64802530.filter2(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c64802530.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c64802530.filter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingTarget(c64802530.filter2,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=Duel.SelectTarget(tp,c64802530.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=Duel.SelectTarget(tp,c64802530.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
		g1:Merge(g2)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
	end
end
function c64802530.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==2 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
