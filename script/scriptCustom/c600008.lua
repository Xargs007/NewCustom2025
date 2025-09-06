--Sleepy Cat
function c600008.initial_effect(c)
	--battle indestructable
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e01:SetValue(1)
	e01:SetCountLimit(1)
	c:RegisterEffect(e01)
	---Recover LP
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600008,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,600008)
	e1:SetRange(LOCATION_MZONE)
	--e1:SetCondition(c600008.spcon)
	e1:SetTarget(c600008.retg)
	e1:SetOperation(c600008.reop)
	c:RegisterEffect(e1)
	--Change pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600008,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1,600008)
	--e2:SetCondition(c600008.spcon)
	e2:SetTarget(c600008.tgset)
	e2:SetOperation(c600008.setop)
	c:RegisterEffect(e2)
	--spsumon Cat or Cat Girl
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600008,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,600008)
	--e3:SetCondition(c600008.spcon)
	e3:SetTarget(c600008.sptg)
	e3:SetOperation(c600008.sumop)
	c:RegisterEffect(e3)
	--[[
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(600008,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	--e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	e1:SetTarget(c600008.tg)
	e1:SetOperation(c600008.op)
	c:RegisterEffect(e1)
	
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600008,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,600008)
	e1:SetRange(LOCATION_MZONE)
	--e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	e1:SetTarget(c600008.retg)
	e1:SetOperation(c600008.reop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600008,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCountLimit(1,600008)
	e2:SetRange(LOCATION_MZONE)
	--e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	e2:SetTarget(c600008.tgset)
	e2:SetOperation(c600008.setop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600008,2))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCountLimit(1,600008)
	e3:SetRange(LOCATION_MZONE)
	--e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	e3:SetTarget(c600008.tgsp)
	e3:SetOperation(c600008.spop)
	c:RegisterEffect(e3)
	]]--
end

function c600008.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c600008.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c600008.reop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,1000,REASON_EFFECT)
end

function c600008.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c600008.tgset(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c600008.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c600008.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE)
	end
end


function c600008.filter2(c,e,tp)
	return  (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)--c:GetCode()==100000171
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c600008.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c600008.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c600008.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c600008.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

--[[
function c600008.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsSetCard(0x1538) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	--end
	else  --if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
]]--

function c600008.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENCE) and (tc:IsSetCard(0x1538) or tc:IsSetCard(0x150e)) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end

--[[
function c600008.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c600008.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
    local c=e:GetHandler()  
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc~=c and c600008.filter(chkc) end  
    if chk==0 then return c600008.filter(c)  
        and Duel.IsExistingTarget(c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c) end  
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)  
    local g=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)  
    g:AddCard(c)  
    Duel.SetOperationInfo(0,CATEGORY_POSITION,g,2,0,0)  
end  
function c600008.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	--if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc~=c and c600008.filter(chkc) end  
	if chk==0 then return Duel.IsExistingTarget(c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c600008.posop(e,tp,eg,ep,ev,re,r,rp)
	--local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local tc=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE,0,POS_FACEUP_ATTACK,0)
	end
end


c600008.Option=0
function c600008.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c600008.filter2(c,e,tp)
	return  (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)--c:GetCode()==100000171
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c600008.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if Duel.SelectYesNo(tp,aux.Stringid(600008,0)) then
		if chk==0 then return true end
		c600008.Option=0
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
	elseif Duel.SelectYesNo(tp,aux.Stringid(600008,1)) then
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and c600008.filter(chkc) end
		if chk==0 then return Duel.IsExistingTarget(c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		c600008.Option=1
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	else--elseif Duel.SelectYesNo(tp,aux.Stringid(600008,2)) then
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c600008.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
		c600008.Option=2
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
	end
end
function c600008.op(e,tp,eg,ep,ev,re,r,rp)
	if c600008.Option==0 then
		Duel.Recover(tp,1000,REASON_EFFECT)
	elseif c600008.Option==1 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE)
		end
	else
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c600008.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
		--if g:GetCount()>0 then
		--	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		--end
		if g:GetCount()>0 and Duel.SpecialSummonStep(g,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			g:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			g:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
		end
	end
end


 --- efectos viejos

function c600008.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c600008.reop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,1000,REASON_EFFECT)
end

function c600008.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c600008.tgset(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c600008.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c600008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c600008.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE)
	end
end

function c600008.filter2(c,e,tp)
	return  (c:IsSetCard(0x1538) or c:IsSetCard(0x150e)) and c:IsType(TYPE_MONSTER)--c:GetCode()==100000171
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c600008.tgsp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c600008.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c600008.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600008.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	--if g:GetCount()>0 then
	--	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	--end
	if g:GetCount()>0 and Duel.SpecialSummonStep(g,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		g:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		g:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
]]--

