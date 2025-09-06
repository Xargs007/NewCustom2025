--次元均衡
function c90901451.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--aux.AddFusionProcFun2(c,c900901250.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--aux.AddFusionProcCodeFun(c,(38033121),aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),1,true,true)
	--aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x20a2),2,true)
	--aux.AddFusionProcCodeFun(c,38033121,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,false,false)
	--aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(c90901451.ffffilter),2,true)
	Fusion.AddProcMixN(c,true,true,aux.FilterBoolFunction(c90901451.ffffilter),2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90901451,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCountLimit(2)
	e2:SetRange(LOCATION_MZONE)
	--e2:SetCondition(c90901451.condition)
	e2:SetCondition(c90901451.negcon)
	e2:SetCost(c90901451.costLP)
	e2:SetTarget(c90901451.target)
	e2:SetOperation(c90901451.activate)
	c:RegisterEffect(e2)
	--effect 2
	--local e3=Effect.CreateEffect(c)
	--e3:SetDescription(aux.Stringid(90901451,1))
	--e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e3:SetCode(EVENT_BE_BATTLE_TARGET)
	--e3:SetCountLimit(1)
	--e3:SetRange(LOCATION_MZONE)
	--e2:SetCondition(c90901451.condition)
	--e3:SetCondition(c90901451.negcon)
	--e3:SetCost(c90901451.costLP2)
	--e3:SetTarget(c90901451.target)
	--e3:SetOperation(c90901451.activate)
	--c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90901451,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_HAND)
	--e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	--e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCountLimit(1)
	e4:SetCondition(c90901451.val)
	--e3:SetCost(c90901250.costBani)
	e4:SetTarget(c90901451.target2)
	e4:SetOperation(c90901451.operation2)
	c:RegisterEffect(e4)
	--erraticator
	local e02=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(40854197,0))
	e02:SetCategory(CATEGORY_DESTROY)
	e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e02:SetCode(EVENT_TO_GRAVE)
	e02:SetCondition(c90901451.descon)
	e02:SetOperation(c90901451.spop3)
	c:RegisterEffect(e02)
	local e03=e02:Clone()
	e03:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e03)
	local e04=e02:Clone()
	e04:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e04)

end

function c90901451.ffffilter(c)
	return c:IsSetCard(0x20a2) and c:IsType(TYPE_MONSTER)
end

function c90901451.descon(e,tp,eg,ep,ev,re,r,rp)
	local mRn = Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)
	local mEn = Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and (mRn >= mEn) --tp~=Duel.GetTurnPlayer() 
	--return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c90901451.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c90901451.spop3(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,29436665)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
end
c90901451.counterdamag = 1
--effect 1
function c90901451.costLP(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500*c90901451.counterdamag) end
	Duel.PayLPCost(tp,(500*c90901451.counterdamag))
end
function c90901451.negcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup()
end
function c90901451.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local a=Duel.GetAttacker()
	if chk==0 then return a and a:IsCanBeEffectTarget(e) and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,a) end
	Duel.SetTargetCard(a)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,a)
	c90901451.counterdamag = 2
	e:SetLabelObject(g:GetFirst())
end
function c90901451.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and (tc:IsFaceup() or tc:IsFacedown()) then
		if tc:IsDefence() then
			Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		end
		--Duel.ChangeAttacker(tc)
		Duel.ChangeAttackTarget(tc)
	end
end
function c90901451.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	--Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c90901451.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local a=Duel.GetAttacker()
		if a and a:IsAttackable() and a:IsFaceup() and not a:IsImmuneToEffect(e) and not a:IsStatus(STATUS_ATTACK_CANCELED) then
			Duel.BreakEffect()
			Duel.ChangeAttackTarget(g:GetFirst())
			--local e1=Effect.CreateEffect(e:GetHandler())
			--e1:SetType(EFFECT_TYPE_SINGLE)
			--e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			--e1:SetReset(RESET_EVENT+0x1fe0000)
			--e1:SetValue(math.ceil(a:GetAttack()/2))
			--a:RegisterEffect(e1)
		end
	end
end

---efect 2


---efect 3

function c90901451.val(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetMatchingGroupCount(c90901451.tgli,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)>0
end
function c90901451.tgli(c)
	return c:IsCode(90901451)-- and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

function c90901451.filter2(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and (c:GetLevel()<6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c90901451.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_HAND) and chkc:IsControler(tp) and c90901451.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c90901451.filter2
	,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c90901451.filter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c90901451.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
