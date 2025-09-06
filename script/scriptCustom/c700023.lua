--The Duke of Demise
function c700023.initial_effect(c)
	--fusion
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(c700023.filter),2,true)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c700023.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c700023.sprcon)
	e2:SetOperation(c700023.sprop)
	c:RegisterEffect(e2)
	--Race add
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_SINGLE)
	e02:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e02:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e02:SetCode(EFFECT_ADD_RACE)
	e02:SetValue(RACE_ZOMBIE)
	c:RegisterEffect(e02)
	--battle indestructable
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e01:SetValue(1)
	c:RegisterEffect(e01)
	--up atk
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e21:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e21:SetCode(EVENT_BATTLE_START)
	e21:SetCondition(c700023.mtcon)
	e21:SetOperation(c700023.atkop)
	--e21:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e21)
	--Battle Destroyed, banish card deck opp
	local e52=Effect.CreateEffect(c)
	e52:SetDescription(aux.Stringid(700023,0))
	e52:SetCategory(CATEGORY_REMOVE)
	e52:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e52:SetCountLimit(1,700023)
	e52:SetCode(EVENT_BATTLED)
	e52:SetCondition(c700023.rmcon)
	e52:SetTarget(c700023.rmtg)
	e52:SetOperation(c700023.rmop)
	c:RegisterEffect(e52)
	--Battle Destroyed, discard your deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(700023,1))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetCountLimit(1,700023)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c700023.rmcon)
	e3:SetTarget(c700023.target2)
	e3:SetOperation(c700023.activate2)
	c:RegisterEffect(e3)
	--maintain
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	--e4:SetDescription(aux.Stringid(700023,2))
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c700023.mtcon)
	e4:SetOperation(c700023.mtop)
	c:RegisterEffect(e4)
end

function c700023.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c700023.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)>1000 and Duel.SelectYesNo(tp,aux.Stringid(700023,2)) then
		Duel.PayLPCost(tp,1000)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end

function c700023.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	--e:SetLabelObject(bc)
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsStatus(STATUS_OPPO_BATTLE)
end

function c700023.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1)
end

function c700023.activate2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dis=1
	Duel.DiscardDeck(tp,dis,REASON_EFFECT)
end

function c700023.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end

function c700023.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	Duel.DisableShuffleCheck()
	Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
end

function c700023.filter(c)
	return c:IsRace(RACE_ZOMBIE+RACE_FIEND)
end

function c700023.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c700023.spfilter(c)
	return c:IsRace(RACE_ZOMBIE+RACE_FIEND) and c:IsCanBeFusionMaterial() and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckOrExtraAsCost() --c:IsFusionSetCard(0x235)
end
function c700023.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c700023.spfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c700023.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c700023.spfilter,tp,LOCATION_MZONE,0,2,2,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g:GetNext()
	end
	Duel.SendtoGrave(g,nil,2,REASON_COST)
end

function c700023.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_SINGLE)
	e31:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e31:SetCode(EFFECT_UPDATE_ATTACK)
	e31:SetValue(500)
	--e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e31)
end