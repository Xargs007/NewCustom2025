--Curse Necrofear 
--Scripted by Eerie Code
--Necro and Fusion Version.
local s,id=GetID()
function s.initial_effect(c)
	--c:EnableUnsummonable()
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,31829185,700001,700010,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(s.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(s.sprcon)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(s.regop)
	c:RegisterEffect(e3)
end

function s.spfilter(c,code)
	return c:IsFusionCode(code)
end
function s.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<-2 then return false end
	local g1=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,31829185)
	local g2=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,700001)
	local g3=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,700010)
	if g1:GetCount()==0 or g2:GetCount()==0 or g3:GetCount()==0 then return false end
	if ft>0 then return true end
	local f1=g1:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f2=g2:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f3=g3:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	if ft==-2 then return f1+f2+f3==3
	elseif ft==-1 then return f1+f2+f3>=2
	else return f1+f2+f3>=1 end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g1=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,31829185)
	local g2=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,700001)
	local g3=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_REMOVED,0,nil,700010)
	g1:Merge(g2)
	g1:Merge(g3)
	local g=Group.CreateGroup()
	local tc=nil
	for i=1,3 do
		--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)28297833 100417010 94212438
		if ft<=0 then
			tc=g1:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=g1:Select(tp,1,1,nil):GetFirst()
		end
		g:AddCard(tc)
		if tc:IsFusionCode(31829185) then
			g1:Remove(Card.IsFusionCode,nil,31829185)
		elseif tc:IsFusionCode(700001) then
			g1:Remove(Card.IsFusionCode,nil,700001)
		elseif tc:IsFusionCode(700010) then
			g1:Remove(Card.IsFusionCode,nil,700010)
		end
		ft=ft+1
	end
	local cg=g:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	--Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.PayLPCost(tp,1000)
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetReasonPlayer()~=tp then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(id,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,id+1)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(s.sptg2)
		e1:SetOperation(s.spop2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local ct=Duel.GetMatchingGroup(aux.FilterFaceupFunction(Card.IsType,TYPE_SPELL+TYPE_TRAP),tp,LOCATION_ONFIELD,0,nil):GetClassCount(Card.GetCode)
	if #g>0 and ct>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,math.min(ct,#g),nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end

