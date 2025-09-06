--E・HERO ネクロダークマン
function c892521530.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(892521530,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetCondition(c892521530.ntcon)
	e1:SetTarget(c892521530.nttg)
	c:RegisterEffect(e1)
	--disable
	local e01=Effect.CreateEffect(c)
	e01:SetDescription(aux.Stringid(97268402,0))
	e01:SetCategory(CATEGORY_TOGRAVE)
	e01:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e01:SetType(EFFECT_TYPE_QUICK_O)
	e01:SetCode(EVENT_FREE_CHAIN)
	e01:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e01:SetRange(LOCATION_HAND)
	e01:SetCost(c892521530.cost)
	--e01:SetTarget(c892521530.thfilter1)
	e01:SetOperation(c892521530.tgop1)
	c:RegisterEffect(e01)
end

function c892521530.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c892521530.thfilter1(c)
	return true
end
function c892521530.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c892521530.thfilter1,1-tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_HAND)
end
function c892521530.tgop1(e,tp,eg,ep,ev,re,r,rp)
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
   	local g=Duel.GetMatchingGroup(c892521530.thfilter1,tp,0,LOCATION_HAND,nil):RandomSelect(tp,1)
	--local g=Duel.SelectMatchingCard(tp,c892521530.thfilter1,1-tp,LOCATION_HAND,0,1,1,nil):RandomSelect(tp,1)
	local tc=g:GetFirst()
	--local g=Duel.SelectMatchingCard(tp,c892521530.thfilter1,1-tp,LOCATION_HAND,0,1,1,nil)
	if tc and g:GetCount()>0 then--if tc then --g:GetCount()>0 then
		--Duel.SendtoGrave(tc,nil,REASON_EFFECT)
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.ConfirmCards(tp,tc)
	end
end


function c892521530.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c892521530.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x3008)
end
