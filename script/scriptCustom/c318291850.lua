--ダーク・ネクロフィア
function c318291850.initial_effect(c)
	--c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c318291850.spcon)
	e1:SetOperation(c318291850.spop)
	c:RegisterEffect(e1)
	--reg
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	--e2:SetCode(EVENT_TO_GRAVE)
	--e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	--e2:SetOperation(c318291850.tgop)
	--c:RegisterEffect(e2)
	--local e02=Effect.CreateEffect(c)
	--e02:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	--e02:SetCode(EVENT_TO_GRAVE)
	--e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	--e02:SetCondition(c318291850.tgop2con)
	--e02:SetOperation(c318291850.tgop2)
	--c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1)
	--e3:SetCondition(c318291850.tgop2con2)
	e3:SetCondition(c318291850.spcon2111)
	e3:SetTarget(c318291850.eqtg)
	e3:SetOperation(c318291850.eqop)
	c:RegisterEffect(e3)
	--search
	--local e4=Effect.CreateEffect(c)
	--e4:SetDescription(aux.Stringid(318291850,0))
	--e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--e4:SetCode(EVENT_TO_GRAVE)
	--e4:SetCountLimit(1)
	--e4:SetCondition(c318291850.condition)
	--e4:SetTarget(c318291850.target)
	--e4:SetOperation(c318291850.operation)
	--c:RegisterEffect(e4)
	--send to hand for GY
	--local e22=Effect.CreateEffect(c)
	--e22:SetDescription(aux.Stringid(318291850,1))
	--e22:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e22:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--e22:SetCode(EVENT_TO_GRAVE)
	--e22:SetCountLimit(1)
	--e22:SetCondition(c318291850.descon)
	--e22:SetTarget(c318291850.target)
	--e22:SetOperation(c318291850.operation)
	--c:RegisterEffect(e22)
	--local e13=e22:Clone()
	--e13:SetCode(EVENT_REMOVE)
	--c:RegisterEffect(e13)
	--local e14=e22:Clone()
	--e14:SetCode(EVENT_TO_DECK)
	--c:RegisterEffect(e14)
	--indes
	--indestrutible
	--local e03=Effect.CreateEffect(c)
	--e03:SetType(EFFECT_TYPE_SINGLE)
	--e03:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e03:SetRange(LOCATION_GRAVE)
	--e03:SetTargetRange(LOCATION_SZONE,0)
	--e03:SetCountLimit(1)
	--e03:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	--e03:SetTarget(c318291850.indval)
	--e03:SetValue(1)
	--c:RegisterEffect(e03)
	local e03=Effect.CreateEffect(c)
	e03:SetType(EFFECT_TYPE_FIELD)
	e03:SetRange(LOCATION_GRAVE)
	e03:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e03:SetTargetRange(LOCATION_FZONE,0)
	e03:SetCountLimit(1)
	e03:SetTarget(c318291850.indval)
	e03:SetValue(1)
	c:RegisterEffect(e03)
	--search
	local e001=Effect.CreateEffect(c)
	--e001:SetDescription(aux.Stringid(50720316,0))
	e001:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e001:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e001:SetCode(EVENT_TO_GRAVE)
	e001:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	--e001:SetCountLimit(1)
	--e001:SetCost(c50720316.cost)
	e001:SetCondition(c318291850.regcon12)
	e001:SetTarget(c318291850.thtg21)
	e001:SetOperation(c318291850.tgop21)
	c:RegisterEffect(e001)
	--reg
	local e003=Effect.CreateEffect(c)
	e003:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e003:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e003:SetCode(EVENT_TO_GRAVE)
	e003:SetCondition(c318291850.regcon11)
	e003:SetOperation(c318291850.regop11)
	c:RegisterEffect(e003)
	--Activate
	--local e4=Effect.CreateEffect(c)
	--e4:SetCategory(CATEGORY_DAMAGE)
	--e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	--e4:SetCondition(c318291850.dmcon)
	--e4:SetCountLimit(1)
	--e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	--e4:SetHintTiming(TIMING_DAMAGE_STEP)
	--e4:SetRange(LOCATION_GRAVE)
	--e4:SetCondition(c318291850.atakcon)
	--e4:SetTarget(c318291850.target)
	--e4:SetOperation(c318291850.activate)
	--c:RegisterEffect(e4)
	--if not c318291850.global_check then
	--	c318291850.global_check=true
	--	local ge1=Effect.CreateEffect(c)
		--ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		--ge1:SetCode(EVENT_DESTROYED)
	--	ge1:SetCode(EVENT_TO_GRAVE)
	--	ge1:SetOperation(c318291850.checkop)
	--	Duel.RegisterEffect(ge1,0)
	--end
end
c318291850.immflag=false
function c318291850.spcon2111(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(318291850)>0
end
function c318291850.regcon12(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE+LOCATION_DECK+LOCATION_HAND) --and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_DESTROY)) --and c:GetDestination()==LOCATION_GRAVE
end
function c318291850.regcon11(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_DESTROY)) --and c:GetDestination()==LOCATION_GRAVE
end
function c318291850.regop11(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(318291850,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c318291850.filter122(c)
	return c:IsFaceup() and (c:IsCode(100417010) or c:IsCode(511000119))
end

function c318291850.atakcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	--return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		--and Duel.IsExistingMatchingCard(c511004006.spfilter,tp,LOCATION_GRAVE,0,3,nil)
	return not Duel.IsExistingMatchingCard(c318291850.filter122,tp,LOCATION_GRAVE+LOCATION_SZONE+LOCATION_FZONE+LOCATION_HAND,0,1,nil)
end

function c318291850.thtg21(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c318291850.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c318291850.tgop21(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c318291850.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c318291850.dmcon(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return Duel.GetAttacker():GetControler()~=tp and e:GetHandler():GetLocation()==LOCATION_GRAVE and not Duel.IsExistingMatchingCard(c318291850.filter122,tp,LOCATION_GRAVE+LOCATION_SZONE+LOCATION_FZONE+LOCATION_HAND,0,1,nil)--Duel.GetAttacker():GetFlagEffect(511004006)>0 and Duel.GetAttacker():GetControler()~=tp
end


function c318291850.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c318291850.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c318291850.filter1(c)
	return c:IsFaceup() and (c:IsCode(100417010) or c:IsCode(511000119) or c:IsCode(94212438)) and c:IsAbleToHand()
end
function c318291850.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c318291850.filter1,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c318291850.dfilter(c)
	return c:IsCode(318291850)
end

--function c318291850.indval(e,re,rp)
--	return rp~=e:GetHandlerPlayer() and (e:GetHandler():IsCode(100417010) or e:GetHandler():IsCode(511000119) or e:GetHandler():IsCode(94212438))--
--end
function c318291850.indval(e,c)
	return c:IsFaceup() and (c:IsCode(100417010) or c:IsCode(511000119) or c:IsCode(94212438) or c:IsCode(94212438))
end

function c318291850.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c318291850.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_DECK)
end
function c318291850.filter(c)
	return (c:IsCode(100417010) or c:IsCode(511000119) or c:IsCode(94212438)) and c:IsAbleToHand()
end
function c318291850.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c318291850.filter,tp,LOCATION_DECK+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		--local tc=g:GetFirst()
		--if tc:IsLocation(LOCATION_HAND) then
		--	local e1=Effect.CreateEffect(e:GetHandler())
		--	e1:SetType(EFFECT_TYPE_FIELD)
		--	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		--	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		--	e1:SetTargetRange(1,0)
		--	e1:SetValue(c318291850.aclimit)
		--	e1:SetLabel(tc:GetCode())
		--	e1:SetReset(RESET_PHASE+PHASE_END)
		--	Duel.RegisterEffect(e1,tp)
		--end
	end
end
function c318291850.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end

function c318291850.spfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsAbleToRemoveAsCost()
end
function c318291850.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c318291850.spfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c318291850.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c318291850.spfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c318291850.tgop2con(e)
	return not (Duel.IsEnvironment(100417010) or Duel.IsEnvironment(511000119))
end
function c318291850.tgop2con2(e)
	local c=e:GetHandler() -- (Duel.IsEnvironment(100417010) or Duel.IsEnvironment(511000119) or Duel.IsEnvironment(94212438)) and   c:IsPreviousLocation(LOCATION_MZONE) and 
	return c:GetDestination()==LOCATION_GRAVE and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_DESTROY)) --end
end

function c318291850.tgop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ((c:GetPreviousControler()==tp or c:GetPreviousControler()==1-tp) and c:IsPreviousLocation(LOCATION_MZONE+LOCATION_SZONE)) or bit.band(r,REASON_DESTROY)~=0 then
		c:RegisterFlagEffect(318291850,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,2)
	end
end
function c318291850.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
		and rp~=tp and bit.band(r,REASON_DESTROY)~=0 then
		c:RegisterFlagEffect(318291850,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c318291850.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(318291850)>0
end
function c318291850.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c318291850.eqlimit(e,c)
	return e:GetOwner()==c
end
function c318291850.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then --and (bit.band(r,REASON_DESTROY)~=0 or bit.band(r,REASON_BATTLE)~=0)
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c318291850.eqlimit)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e2)
	end
end
