--E・HERO ゴッド・ネオス
function c81111109.initial_effect(c)
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x8),5,true)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c81111109.fuscon)
	e1:SetOperation(c81111109.fusop)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81111109,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c81111109.copycost)
	e2:SetOperation(c81111109.copyop)
	c:RegisterEffect(e2)
	--spsummon condition
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(aux.fuslimit)
	c:RegisterEffect(e3)
	--special summon rule 2
	local e02=Effect.CreateEffect(c)
	e02:SetType(EFFECT_TYPE_FIELD)
	e02:SetCode(EFFECT_SPSUMMON_PROC)
	e02:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e02:SetRange(LOCATION_EXTRA)
	e02:SetCondition(c81111109.spcon)
	e02:SetOperation(c81111109.spop)
	c:RegisterEffect(e02)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c81111109.atkval)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UNRELEASABLE_SUM)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e6)
	--cannot be fusion material
	local e7=e5:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e7)
	--indes
	local e8=e5:Clone()
	e8:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e8)
end

function c81111109.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c81111109.spfilter(c)
	return c:IsAbleToDeckOrExtraAsCost() and c:IsCode(89943723)
end
function c81111109.spfilter2(c)
	return c:IsAbleToDeckOrExtraAsCost() and c:IsSetCard(0x1f)
end
function c81111109.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<0 then return false end
	local g=Duel.GetMatchingGroup(c81111109.spfilter,tp,LOCATION_ONFIELD,0,nil)
	local nsg=Duel.GetMatchingGroup(c81111109.spfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	if g:GetCount()==0 or nsg:GetClassCount(Card.GetCode)<=5 then return false end
	if ft>0 then return true end
	local f1=g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f2=nsg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	if ft==-2 then return f1+f2==3
	elseif ft==-1 then return f1+f2>=2
	else return f1+f2>=1 end
end
function c81111109.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c81111109.spfilter,tp,LOCATION_ONFIELD,0,nil)
	local nsg=Duel.GetMatchingGroup(c81111109.spfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	g:Merge(nsg)
	local rg=Group.CreateGroup()
	local tc=nil
	for i=1,7 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		if i==1 then
			tc=g:FilterSelect(tp,Card.IsCode,1,1,nil,89943723):GetFirst()
		elseif ft<=0 then
			tc=g:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=g:Select(tp,1,1,nil):GetFirst()
		end
		if tc then
			rg:AddCard(tc)
			g:Remove(Card.IsCode,nil,tc:GetCode())
		end
		rg:AddCard(tc)
		g:Remove(Card.IsCode,nil,tc:GetCode())
		ft=ft+1
	end
	local cg=rg:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(rg,nil,2,REASON_COST)
end



function c81111109.atkfilter(c)
	return c:GetFlagEffect(81111109)>0
end
function c81111109.atkval(e,c)
	return Duel.GetMatchingGroupCount(c81111109.atkfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*500
end
function c81111109.fuscon(e,g,gc,chkf)
	if g==nil then return false end
	if gc then return false end
	local g1=g:Filter(Card.IsSetCard,nil,0x9)
	local c1=g1:GetCount()
	local g2=g:Filter(Card.IsSetCard,nil,0x1f)
	local c2=g2:GetCount()
	local g3=g:Filter(Card.IsSetCard,nil,0x8)
	local c3=g3:GetCount()
	local ag=g1:Clone()
	ag:Merge(g2)
	ag:Merge(g3)
	if chkf~=PLAYER_NONE and not ag:IsExists(aux.FConditionCheckF,1,nil,chkf) then return false end
	return c1>0 and c2>0 and c3>0 and ag:GetCount()>=5 and (c1>1 or c3>1 or g1:GetFirst()~=g3:GetFirst())
end
function c81111109.fusop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	if gc then return end
	local g1=eg:Filter(Card.IsSetCard,nil,0x9)
	local g2=eg:Filter(Card.IsSetCard,nil,0x1f)
	local g3=eg:Filter(Card.IsSetCard,nil,0x8)
	local ag=g1:Clone()
	ag:Merge(g2)
	ag:Merge(g3)
	local tc=nil local f1=0 local f2=0 local f3=0
	local mg=Group.CreateGroup()
	for i=1,5 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		if i==1 and chkf~=PLAYER_NONE then
			tc=ag:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf):GetFirst()
		else tc=ag:Select(tp,1,1,nil):GetFirst() end
		if g1:IsContains(tc) then
			g1:RemoveCard(tc)
			if g3:IsContains(tc) then g3:RemoveCard(tc) f1=f1+1 f3=f3+1
			else f1=f1+2 end
		elseif g2:IsContains(tc) then g2:RemoveCard(tc) f2=f2+1
		else g3:RemoveCard(tc) f3=f3+2 end
		ag:RemoveCard(tc)
		mg:AddCard(tc)
		if i==3 then
			if f1==0 and f2==0 then ag:Sub(g3)
			elseif f1==0 and f3==0 then ag:Sub(g2)
			elseif f2==0 and f3==0 then ag:Sub(g1) end
		end
		if i==4 then
			if f1==0 then ag=g1
			elseif f2==0 then ag=g2
			elseif f3==0 then ag=g3
			elseif f1==1 and f3==1 then ag:Sub(g2) end
		end
	end
	Duel.SetFusionMaterial(mg)
end
function c81111109.copyfilter(c)
	return (c:IsSetCard(0x9) or c:IsSetCard(0x1f) or c:IsSetCard(0x8)) and c:IsType(TYPE_MONSTER)
		and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemoveAsCost()
end
function c81111109.copycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81111109.copyfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c81111109.copyfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:GetFirst():RegisterFlagEffect(81111109,RESET_EVENT+0x1fe0000,0,1)
	e:SetLabelObject(g:GetFirst())
end
function c81111109.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc then
		local code=tc:GetOriginalCode()
		local cid=c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END,1)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(81111109,1))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		e1:SetLabel(cid)
		e1:SetOperation(c81111109.rstop)
		c:RegisterEffect(e1)
	end
end

function c81111109.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
