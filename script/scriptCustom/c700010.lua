--Millenium Dark Necofear
local s,id=GetID()
function c700010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMixN(c,false,false,CARD_NECROFEAR,1,s.ffilter,1)
	aux.AddContactFusion(c,s.contactfil,s.contactop,s.splimit)
	--change name
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetCondition(c700010.con)
	e1:SetValue(31829185)
	c:RegisterEffect(e1)
	--invocar "necro"
	local e05=Effect.CreateEffect(c)
	e05:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_COIN+CATEGORY_SEARCH)
	e05:SetType(EFFECT_TYPE_QUICK_O)
	e05:SetDescription(aux.Stringid(id,0))
	e05:SetCountLimit(1)
	e05:SetRange(LOCATION_MZONE)
	e05:SetCode(EVENT_FREE_CHAIN)
	--e05:SetCountLimit(1,700010)
	e05:SetHintTiming(0,TIMING_END_PHASE)
	e05:SetCondition(c700010.discon)
	e05:SetTarget(c700010.targetop)
	e05:SetOperation(c700010.operationop)
	c:RegisterEffect(e05)
	--change attack target
	local e01=Effect.CreateEffect(c)
	e01:SetCategory(CATEGORY_CONTROL)
	e01:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e01:SetDescription(aux.Stringid(id,1))
	e01:SetType(EFFECT_TYPE_QUICK_O)
	e01:SetCountLimit(1)
	e01:SetCode(EVENT_ATTACK_ANNOUNCE)
	--e01:SetCountLimit(1,700010)
	e01:SetRange(LOCATION_MZONE)
	e01:SetCondition(c700010.condition)
	e01:SetTarget(c700010.target)
	e01:SetOperation(c700010.activate)
	c:RegisterEffect(e01)
end

s.listed_names={CARD_NECROFEAR}
s.material_setcode={0x235}
function s.ffilter(c,fc,sumtype,tp,sub,mg,sg)
	return c:IsFusionSetCard(0x235) and c:GetAttribute(fc,sumtype,tp)~=0 and (not sg or not sg:IsExists(s.fusfilter,1,c,c:GetAttribute(fc,sumtype,tp),fc,sumtype,tp)) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_NORMAL)
end
function s.fusfilter(c,attr,fc,sumtype,tp)
	return c:IsFusionSetCard(0x235) and c:IsAttribute(attr,fc,sumtype,tp) and not c:IsHasEffect(511002961)
end
function s.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
end
function s.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_MATERIAL)
end
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end

function c700010.cDMGfilter(c,tp)
	return c:IsCode(31829185) and c:IsFaceup(tp)
end

function c700010.con(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.IsExistingMatchingCard(c700010.cDMGfilter,tp,LOCATION_REMOVED,0,1,nil))
end

function c700010.filtercr(c,e,tp)
	return c:IsSetCard(0x235) and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_MONSTER) --and c:IsCanBeSpecialSummoned(e,0,1-tp,true,false)
end

function c700010.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp--Duel.GetTurnPlayer()~=tp --Duel.GetMatchingGroupCount(c700004.filterg,tp,LOCATION_FIELD,0,nil)
end
function c700010.filterg(c)
	return not c:IsType(TYPE_TOKEN) 
end
function c700010.targetop(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700010.filtercr,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,nil,e,tp)
		and ((Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) and Duel.GetMatchingGroupCount(c700010.filtercr,1-tp,0,LOCATION_MZONE,nil)<3) end
	if chkc then return chkc:IsLocation(LOCATION_REMOVED+LOCATION_GRAVE) and chkc:IsControler(tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED+LOCATION_GRAVE)
end


function c700010.operationop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and not Duel.GetMatchingGroupCount(c700010.filtercr,1-tp,0,LOCATION_MZONE,nil)>2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectMatchingCard(tp,c700010.filtercr,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local g=Duel.SelectTarget(tp,c700010.filtercr,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,1,nil,e,tp)
	--g:RegisterFlagEffect(700010,RESET_EVENT+RESETS_STANDARD,0,1)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,1-tp,1-tp,true,false,POS_FACEUP_DEFENCE)
		local tc=Duel.GetFirstTarget()
		--material use, trasform zombie
		local e002=Effect.CreateEffect(e:GetHandler())
		e002:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e002:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e002:SetCode(EVENT_BE_MATERIAL)
		e002:SetCondition(c700010.conditionmt)
		e002:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e002,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e003=Effect.CreateEffect(e:GetHandler())
		e003:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e003:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e003:SetCode(EFFECT_FUSION_MATERIAL)
		e003:SetCondition(c700010.conditionmt)
		e003:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e003,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e004=Effect.CreateEffect(e:GetHandler())
		e004:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e004:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e004:SetCode(EFFECT_SYNCHRO_MATERIAL)
		e004:SetCondition(c700010.conditionmt)
		e004:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e004,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e005=Effect.CreateEffect(e:GetHandler())
		e005:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e005:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e005:SetCode(EFFECT_XYZ_MATERIAL)
		e005:SetCondition(c700010.conditionmt)
		e005:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e005,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e006=Effect.CreateEffect(e:GetHandler())
		e006:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e006:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e006:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
		e006:SetCondition(c700010.conditionmt)
		e006:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e006,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e007=Effect.CreateEffect(e:GetHandler())
		e007:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e007:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e007:SetCode(EFFECT_EXTRA_LINK_MATERIAL)
		e007:SetCondition(c700010.conditionmt)
		e007:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e007,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e007=Effect.CreateEffect(e:GetHandler())
		e007:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e007:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e007:SetCode(EFFECT_CHAIN_MATERIAL)
		e007:SetCondition(c700010.conditionmt)
		e007:SetOperation(c700010.operationmt)
		tc:RegisterEffect(e007,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		--no tribute
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTargetRange(1,0)
		e1:SetLabelObject(e)
		e1:SetTarget(c700010.sumlimit1)
		tc:RegisterEffect(e1,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e2:SetCode(EFFECT_CANNOT_SUMMON)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetTargetRange(1,0)
		tc:RegisterEffect(e2,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
		tc:RegisterEffect(e3,true)
		tc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c700010.sumlimit1(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabelObject()~=se
end

--function c700010.filterC(c)
--	return c:IsControlerCanBeChanged()
--end
--este codigo es para las habilidades que se le agregaran al monstruo normal invocado especialmente
function c700010.conditionmt2(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetOwner()
	return ( ((r==REASON_RELEASE) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION)) or ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL)) or ((r==REASON_SYNCHRO) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO)) or
	((r==REASON_RITUAL) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL)) or ((r==REASON_XYZ) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ)) or
	((r==REASON_LINK) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_LINK)) ) and not (e:GetHandler():GetPreviousControler()==tp)--and not h:IsSetCard(0x235)--(h:IsSetCard(0x235) and c:IsHasCardTarget(h))
end
--este codigo es para las habilidades que se le agregaran al monstruo normal invocado especialmente
function c700010.conditionmt(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetOwner()
	return ( ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION)) or ((r==REASON_FUSION) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL)) or ((r==REASON_SYNCHRO) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO)) or
	((r==REASON_RITUAL) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL)) or ((r==REASON_XYZ) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ)) or
	((r==REASON_LINK) or (e:GetHandler():GetSummonType()==SUMMON_TYPE_LINK)) ) and not (e:GetHandler():GetPreviousControler()==tp)--and not h:IsSetCard(0x235)--(h:IsSetCard(0x235) and c:IsHasCardTarget(h))
end
function c700010.operationmt(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	--while rc do
		if rc:GetFlagEffect(700010)==0 then--and c700010.filterC(rc) then
			--Change Control
			local e51=Effect.CreateEffect(e:GetHandler())
			e51:SetType(EFFECT_TYPE_SINGLE)
			e51:SetCode(EFFECT_SET_CONTROL)
			e51:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_SINGLE_RANGE)
			e51:SetRange(LOCATION_MZONE)
			e51:SetValue(tp)
			--e1:SetReset(RESET_EVENT+0x1fc0000)
			e51:SetCondition(c700010.ctcon)
			rc:RegisterEffect(e51,true)
			rc:RegisterFlagEffect(700010,RESET_EVENT+0x1ff0000,0,1)
			--Race add zombie
			local e003=Effect.CreateEffect(e:GetHandler())
			e003:SetType(EFFECT_TYPE_SINGLE)
			e003:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e003:SetRange(LOCATION_MZONE)
			e003:SetCode(EFFECT_CHANGE_RACE)
			--e003:SetCode(EFFECT_ADD_RACE)
			e003:SetValue(RACE_ZOMBIE)
			e003:SetReset(RESET_EVENT+0x1ff0000)
			--e003:SetCondition(c700010.ctcon)
			rc:RegisterEffect(e003,true)
			rc:RegisterFlagEffect(700010,RESET_EVENT+0x1fe0000,0,1)
		end
		--rc=e:GetHandler():GetNext()
	--end
end
function c700010.ctcon(e)
	--local c=e:GetOwner()
	local h=e:GetHandler()
	return not h:IsSetCard(0x235)--(h:IsSetCard(0x235) and c:IsHasCardTarget(h))
end

function c700010.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
end
function c700010.filter11(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:IsSetCard(0x235) and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_MONSTER)
end
function c700010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local atr=Duel.GetAttacker()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700010.filter11(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700010.filter11,tp,0,LOCATION_MZONE,1,atr) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c700010.filter11,tp,0,LOCATION_MZONE,1,1,atr)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c700010.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local a=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if not Duel.GetControl(tc,tp,PHASE_BATTLE,1) then
			if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
				Duel.Destroy(tc,REASON_EFFECT)
			end
		elseif a:IsAttackable() and not a:IsImmuneToEffect(e) then
			Duel.CalculateDamage(a,tc)
		end
	end
end

