--Necro Dark Spider
function c700012.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(700012,0))
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c700012.condtion1)
	e1:SetTarget(c700012.target1)
	e1:SetOperation(c700012.operation1)
	c:RegisterEffect(e1)
	--Destroy card in the field if destroy necro monster
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(700012,1))
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_MZONE)
	--e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,700012)
	e2:SetCondition(c700012.condition)
	e2:SetTarget(c700012.target2)
	e2:SetOperation(c700012.operation2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetDescription(aux.Stringid(700012,1))
	e3:SetCode(EVENT_DESTROYED)
	e3:SetRange(LOCATION_MZONE)
	--e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,700012)
	e3:SetCondition(c700012.condition)
	e3:SetTarget(c700012.target2)
	e3:SetOperation(c700012.operation2)
	c:RegisterEffect(e3)
	--add card is hand or remove card deck rival
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(700012,2))
	--e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e1:SetCode(EVENT_PHASE+PHASE_END)
	--e1:SetRange(LOCATION_MZONE)
	--e1:SetCountLimit(1,700012)
	--e1:SetCost(c700012.thcost)
	--e1:SetTarget(c700012.thtg)
	--e1:SetOperation(c700012.thop)
	--c:RegisterEffect(e1)
end

--function c700012.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return e:GetHandler():GetFlagEffect(700012)~=0 end
	--e:GetHandler():ResetFlagEffect(700012)
--end

function c700012.cfilter(c,tp)
	return (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) or c:IsReason(REASON_DESTROY)) and c:IsLocation(LOCATION_GRAVE) --and c:GetPreviousControler()==tp
end
function c700012.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c700012.cfilter,1,nil,tp)
end
function c700012.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c700012.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end



function c700012.condtion1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c700012.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c700012.operation1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end