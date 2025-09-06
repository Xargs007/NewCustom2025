--ベリー・マジシャン・ガール
--Berry Magician Girl
--Script by mercury233
function c900207014.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(900207014,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c900207014.thtg)
	e1:SetOperation(c900207014.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(900207014,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BECOME_TARGET)
	e2:SetCondition(c900207014.spcon1)
	e2:SetTarget(c900207014.sptg)
	e2:SetOperation(c900207014.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(900207014,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c900207014.spcon2)
	e3:SetTarget(c900207014.sptg)
	e3:SetOperation(c900207014.spop)
	c:RegisterEffect(e3)
end
function c900207014.thfilter(c)
	return (c:IsSetCard(0x20a2) or c:IsSetCard(0x30a2) or c:IsCode(38033121) or c:IsCode(100200115) or c:IsCode(980000147) or c:IsCode(100200115) or c:IsCode(100909017) or c:IsCode(100909019) or c:IsSetCard(0x10a2) or c:IsSetCard(0x98) or c:IsCode(71413901) or c:IsCode(02525268) or c:IsCode(80304126) or c:IsCode(80014003)) and c:IsAbleToHand() and not (c:IsCode(87769556)) and c:IsType(TYPE_MONSTER)
end
function c900207014.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c900207014.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c900207014.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c900207014.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c900207014.spfilter(c,e,tp)
	return (c:IsSetCard(0x20a2) or c:IsSetCard(0x30a2) or c:IsCode(38033121) or c:IsCode(980000147) or c:IsSetCard(0x10a2) or c:IsCode(100200115) or c:IsCode(100909017) or c:IsCode(100909019) or c:IsCode(71413901) or c:IsCode(02525268) or c:IsSetCard(0x98) or c:IsCode(80304126) or c:IsCode(80014003)) and not c:IsCode(900207014) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c900207014.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(900207014)<1 and eg:IsContains(e:GetHandler()) and rp~=tp 
end
function c900207014.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(900207014)<1
end
function c900207014.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c900207014.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	e:GetHandler():RegisterFlagEffect(900207014,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c900207014.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENCE,POS_FACEUP_DEFENCE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c900207014.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
