function c700005.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x235),3,true)
	--aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_GRAVE,3,aux.tdcfop(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c700005.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c700005.sprcon)
	e2:SetOperation(c700005.sprop)
	c:RegisterEffect(e2)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e01:SetCondition(c700005.con)
	e01:SetValue(1)
	e01:SetCountLimit(2,700005)
	c:RegisterEffect(e01)
	local e02=e01:Clone()
	e02:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e02)
	--disable eff of grave opponent
	--cannot remove
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_REMOVE)
	e4:SetRange(LOCATION_MZONE)
	--e4:SetTargetRange(LOCATION_GRAVE,0)
	e4:SetTargetRange(0,LOCATION_GRAVE)
	--e4:SetCondition(c700005.contp)
	e4:SetCondition(c700005.conntp)
	c:RegisterEffect(e4)
	--local e5=e4:Clone()
	--e5:SetTargetRange(0,LOCATION_GRAVE)
	--e5:SetCondition(c700005.conntp)
	--c:RegisterEffect(e5)
	--necro valley
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_NECRO_VALLEY)
	e6:SetRange(LOCATION_MZONE)
	--e6:SetTargetRange(LOCATION_GRAVE,0)
	e6:SetTargetRange(0,LOCATION_GRAVE)
	--e6:SetCondition(c700005.contp)
	e6:SetCondition(c700005.conntp)
	c:RegisterEffect(e6)
	--local e7=e6:Clone()
	--e7:SetTargetRange(0,LOCATION_GRAVE)
	--e7:SetCondition(c700005.conntp)
	--c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_NECRO_VALLEY)
	e8:SetRange(LOCATION_MZONE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	--e8:SetTargetRange(1,0)
	e8:SetTargetRange(0,1)
	--e8:SetCondition(c700005.contp)
	e8:SetCondition(c700005.conntp)
	c:RegisterEffect(e8)
	--local e9=e8:Clone()
	--e9:SetTargetRange(0,1)
	--e9:SetCondition(c700005.conntp)
	--c:RegisterEffect(e9)
	--disable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_CHAIN_SOLVING)
	e10:SetRange(LOCATION_MZONE)
	e10:SetOperation(c700005.disop)
	c:RegisterEffect(e10)
	--sp summon necro
	local e05=Effect.CreateEffect(c)
	e05:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_COIN+CATEGORY_SEARCH)
	e05:SetType(EFFECT_TYPE_QUICK_O)
	e05:SetRange(LOCATION_MZONE)
	e05:SetCode(EVENT_FREE_CHAIN)
	e05:SetCountLimit(1)
	e05:SetHintTiming(0,TIMING_END_PHASE)
	e05:SetCondition(c700005.discon)
	e05:SetTarget(c700005.targetop)
	e05:SetOperation(c700005.operationop)
	c:RegisterEffect(e05)
--[[	
	--sp summon necro
	local e05=Effect.CreateEffect(c)
--	e05:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e05:SetCategory(CATEGORY_COIN+CATEGORY_SPECIAL_SUMMON)
	e05:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--e05:SetProperty(EFFECT_FLAG_DELAY)
	e05:SetCode(EVENT_PHASE+PHASE_END)
	e05:SetRange(LOCATION_MZONE)
	--e05:SetProperty(EFFECT_FLAG_REPEAT)
	--e05:SetCountLimit(1)
	e05:SetCondition(c700005.discon)
	e05:SetTarget(c700005.targetop)
	e05:SetOperation(c700005.operation2)--(c700005.operationop)
	--e05:SetLabelObject(e01)
	c:RegisterEffect(e05)
	--instant
	--local e2=Effect.CreateEffect(c)
	--e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e2:SetType(EFFECT_TYPE_QUICK_O)
	--e2:SetRange(LOCATION_SZONE)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e2:SetHintTiming(0,TIMING_END_PHASE)
	--e2:SetCost(c48680970.cost2)
	--e2:SetTarget(c48680970.target2)
	--e2:SetOperation(c48680970.operation)
	--c:RegisterEffect(e2) 
	
	]]--
end

function c700005.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700005.filterc,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c700005.filterc(c)
	return (c:IsRace(RACE_FIEND) or c:IsRace(RACE_ZOMBIE)) and not c:IsCode(700005)
end
function c700005.filtercr(c,e,tp)
	return c:IsSetCard(0x235) and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c700005.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp --and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0)--Duel.GetMatchingGroupCount(c700004.filterg,tp,LOCATION_FIELD,0,nil)
end
function c700005.filterg(c)
	return not c:IsType(TYPE_TOKEN) 
end
function c700005.targetop(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700005.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp)
		and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0) end
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_GRAVE) and chkc:IsControler(tp) end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectTarget(tp,c700005.filtercr,tp,0,LOCATION_DECK+LOCATION_GRAVE,1,1,nil,e,tp)
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON+CATEGORY_COIN,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	--Duel.SetOperationInfo(0,CATEGORY_COIN,g,nil,1-tp,1)
end


function c700005.operationop(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.TossCoin(tp,1)
	if coin==1 then
		if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 and Duel.GetMatchingGroupCount(c700010.filtercr,1-tp,0,LOCATION_MZONE,nil)>2 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		--local g=Duel.SelectMatchingCard(tp,c700005.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
		local g=Duel.SelectTarget(tp,c700005.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
		--g:RegisterFlagEffect(700005,RESET_EVENT+RESETS_STANDARD,0,1)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,1-tp,1-tp,true,false,POS_FACEUP_DEFENCE)
			local tc=Duel.GetFirstTarget()
			--material use o tribute, trasform zombie
			local e002=Effect.CreateEffect(e:GetHandler())
			e002:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e002:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e002:SetCode(EVENT_BE_MATERIAL)
			e002:SetCondition(c700005.conditionmt)
			e002:SetOperation(c700005.operationmt)
			--Duel.RegisterEffect(e002,g) --el que funciona
			--Duel.RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1,fid)--el que funciona
			tc:RegisterEffect(e002,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			--g:RegisterEffect(e002,true)
			local e003=Effect.CreateEffect(e:GetHandler())
			e003:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e003:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e003:SetCode(EFFECT_FUSION_MATERIAL)
			e003:SetCondition(c700005.conditionmt)
			e003:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e003,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e004=Effect.CreateEffect(e:GetHandler())
			e004:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e004:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e004:SetCode(EFFECT_SYNCHRO_MATERIAL)
			e004:SetCondition(c700005.conditionmt)
			e004:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e004,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e005=Effect.CreateEffect(e:GetHandler())
			e005:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e005:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e005:SetCode(EFFECT_XYZ_MATERIAL)
			e005:SetCondition(c700005.conditionmt)
			e005:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e005,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e006=Effect.CreateEffect(e:GetHandler())
			e006:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e006:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e006:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
			e006:SetCondition(c700005.conditionmt)
			e006:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e006,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e007=Effect.CreateEffect(e:GetHandler())
			e007:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e007:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e007:SetCode(EFFECT_EXTRA_LINK_MATERIAL)
			e007:SetCondition(c700005.conditionmt)
			e007:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e007,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e007=Effect.CreateEffect(e:GetHandler())
			e007:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e007:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e007:SetCode(EFFECT_CHAIN_MATERIAL)
			e007:SetCondition(c700005.conditionmt)
			e007:SetOperation(c700005.operationmt)
			tc:RegisterEffect(e007,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			--no tribute
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetReset(RESET_PHASE+PHASE_END)
			e1:SetTargetRange(1,0)
			e1:SetLabelObject(e)
			e1:SetTarget(c700005.sumlimit1)
			tc:RegisterEffect(e1,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
			e2:SetCode(EFFECT_CANNOT_SUMMON)
			e2:SetReset(RESET_PHASE+PHASE_END)
			e2:SetTargetRange(1,0)
			tc:RegisterEffect(e2,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
			tc:RegisterEffect(e3,true)
			tc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
		end
	end
	if coin==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		--local g=Duel.SelectMatchingCard(tp,c700005.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
		local g=Duel.SelectTarget(tp,c700005.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP_DEFENCE)
		end
	end
end

function c700005.sumlimit1(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabelObject()~=se
end

--este codigo es para las habilidades que se le agregaran al monstruo normal invocado especialmente
function c700005.conditionmt(e,tp,eg,ep,ev,re,r,rp)
	return ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION)) or ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL)) or ((r==REASON_SYNCHRO) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO)) or
	((r==REASON_RITUAL) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL)) or ((r==REASON_XYZ) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ)) or
	((r==REASON_LINK) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_LINK))
end
function c700005.operationmt(e,tp,eg,ep,ev,re,r,rp)
    local rc=e:GetHandler():GetReasonCard()  
	while rc do
		if rc:GetFlagEffect(700005)==0 then
			--Race add zombie
			local e003=Effect.CreateEffect(e:GetHandler())
			e003:SetType(EFFECT_TYPE_SINGLE)
			e003:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e003:SetRange(LOCATION_MZONE)
			e003:SetCode(EFFECT_CHANGE_RACE)
			--e003:SetCode(EFFECT_ADD_RACE)
			e003:SetValue(RACE_ZOMBIE)
			rc:RegisterEffect(e003,true)
			rc:RegisterFlagEffect(700005,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=e:GetHandler():GetNext()
	end
end


--[[ error se repetia y tuve que poner una limitacion
function c700005.operationop(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.TossCoin(1-tp,1)
	if coin==1 then
		if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(1-tp,c700005.filtercr,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
			Duel.SpecialSummonStep(g,0,1-tp,1-tp,true,false,POS_DEFENCE)
		end
	end
	if coin==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c700005.filtercr,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			Duel.SpecialSummonStep(g,0,tp,tp,true,false,POS_DEFENCE)
		end
	end
end

]]--
function c700005.disop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsActiveType(TYPE_MONSTER) and loc==LOCATION_GRAVE then--re:GetHandler():IsSetCard(0x235)
		Duel.NegateEffect(ev)
	end
end

function c700005.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c700005.spfilter(c)
	return c:IsFusionSetCard(0x235) and c:IsCanBeFusionMaterial() and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckOrExtraAsCost()
end
function c700005.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c700005.spfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c700005.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c700005.spfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g:GetNext()
	end
	Duel.SendtoDeck(g,nil,3,REASON_COST)
end

function c700005.undefcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>1
end

--Negate effc grave

function c700005.contp(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandler():GetControler(),EFFECT_NECRO_VALLEY_IM)
end
function c700005.conntp(e)
	return not Duel.IsPlayerAffectedByEffect(1-e:GetHandler():GetControler(),EFFECT_NECRO_VALLEY_IM)
end
function c700005.disfilter1(c,im0,im1,targets)
	if c:IsControler(0) then return im0 and targets:IsContains(c) and c:IsHasEffect(EFFECT_NECRO_VALLEY)
	else return im1 and targets:IsContains(c) and c:IsHasEffect(EFFECT_NECRO_VALLEY) end
end
function c700005.disfilter2(c,im0,im1)
	if c:IsControler(0) then return im0 and c:IsHasEffect(EFFECT_NECRO_VALLEY)
	else return im1 and c:IsHasEffect(EFFECT_NECRO_VALLEY) end
end
function c700005.discheck(ev,category,re,im0,im1,targets)
	local ex,tg,ct,p,v=Duel.GetOperationInfo(ev,category)
	if not ex then return false end
	if tg and tg:GetCount()>0 then
		if targets then
			return tg:IsExists(c700005.disfilter1,1,nil,im0,im1,targets)
		else
			return tg:IsExists(c700005.disfilter2,1,re:GetHandler(),im0,im1)
		end
	end
	if v~=LOCATION_GRAVE then return false end
	if p~=PLAYER_ALL then
		if p==0 then return im0 else return im1 end
	end
	return im0 and im1
end
function c700005.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if not Duel.IsChainDisablable(ev) or tc:IsHasEffect(EFFECT_NECRO_VALLEY_IM) then return end
	local res=false
	local targets=nil
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	end
	local im0=not Duel.IsPlayerAffectedByEffect(0,EFFECT_NECRO_VALLEY_IM)
	local im1=not Duel.IsPlayerAffectedByEffect(1,EFFECT_NECRO_VALLEY_IM)
	if not res and c700005.discheck(ev,CATEGORY_SPECIAL_SUMMON,re,im0,im1,targets) then res=true end
	if not res and c700005.discheck(ev,CATEGORY_REMOVE,re,im0,im1,targets) then res=true end
	if not res and c700005.discheck(ev,CATEGORY_TOHAND,re,im0,im1,targets) then res=true end
	if not res and c700005.discheck(ev,CATEGORY_TODECK,re,im0,im1,targets) then res=true end
	if not res and c700005.discheck(ev,CATEGORY_LEAVE_GRAVE,re,im0,im1,targets) then res=true end
	if res then	Duel.NegateEffect(ev) end
end

