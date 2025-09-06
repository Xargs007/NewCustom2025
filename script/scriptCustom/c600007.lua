--Neko Fangirl
function c600007.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(600005,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c600007.condition)
	--e1:SetTarget(c600007.target)
	e1:SetOperation(c600007.activate)
	c:RegisterEffect(e1)
	--Recover your lp and damage opp lp
	local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	--e4:SetDescription(aux.Stringid(700023,2))
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c600007.mtcon)
	e4:SetTarget(c600007.damtg)
	e4:SetOperation(c600007.damop)
	c:RegisterEffect(e4)
end

function c600007.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c600007.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x150e)
end
function c600007.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x1538)
end
function c600007.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c600007.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local d=Duel.GetMatchingGroupCount(c600007.filter,tp,LOCATION_MZONE,0,nil)*200
	local d2=Duel.GetMatchingGroupCount(c600007.filter2,tp,LOCATION_MZONE,0,nil)*200
	Duel.Damage(1-tp,d,REASON_EFFECT)
	Duel.Recover(tp,d2,REASON_EFFECT)
end

function c600007.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end

function c600007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<5 then return false end
		local g=Duel.GetDecktopGroup(tp,5)
		local result=g:FilterCount(Card.IsAbleToHand,nil)>0
		return result
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c600007.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,5)
	local dg=Group.CreateGroup()
	local gg=Group.CreateGroup()
	Duel.ConfirmDecktop(g,5)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
			while tc do
				if (tc:IsSetCard(0x1538) or tc:IsSetCard(0x150e)) and tc:IsType(TYPE_MONSTER) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENCE) then
					Duel.DisableShuffleCheck()
					Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
				elseif tc:IsAbleToDeck() then
					dg:AddCard(tc)
				else gg:AddCard(tc) end
				tc=g:GetNext()
			end
		Duel.SpecialSummonComplete()
		if dg:GetCount()>0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoDeck(dg,nil,2,REASON_EFFECT)
			Duel.ShuffleDeck(tp)
		end
		if gg:GetCount()>0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoGrave(gg,REASON_EFFECT)
		end
	end
end
