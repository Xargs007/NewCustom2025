--Necro Wall
function c700021.initial_effect(c)
	--battle indestructable
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e01:SetValue(1)
	e01:SetCountLimit(1)
	c:RegisterEffect(e01)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700021,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCondition(c700021.spcon)
	e1:SetTarget(c700021.sptg)
	e1:SetOperation(c700021.spop)
	c:RegisterEffect(e1)
end

function c700021.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c700021.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c700021.spop(e,tp,eg,ep,ev,re,r,rp)
	local token=Duel.CreateToken(tp,700022)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	--return to hand
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(700021,1))
	--e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c700021.spcon2)
	--e1:SetTarget(c700022.target)
	e1:SetOperation(c700021.tgop1)
	token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
end

function c700021.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end

function c700021.thfilter1(c)
	return true
end

function c700021.tgop1(e,tp,eg,ep,ev,re,r,rp)
   	local g=Duel.GetMatchingGroup(c700021.thfilter1,tp,0,LOCATION_HAND,nil):RandomSelect(tp,1)
	local tc=g:GetFirst()
	--local g=Duel.SelectMatchingCard(tp,c700022.thfilter1,1-tp,LOCATION_HAND,0,1,1,nil)
	if tc then--g:GetCount()>0 then
		Duel.SendtoGrave(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,tc)
	end
end