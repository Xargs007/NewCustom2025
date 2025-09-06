--Extra Fusion
local s,id=GetID()
--[[
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter0(c,e)
	return c:IsType(TYPE_FUSION) and c:IsCanBeFusionMaterial()
end
function s.filter1(c,e)
	return c:IsType(TYPE_FUSION) and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function s.filter2(c,e,tp,m,f)
	if not c:IsType(TYPE_FUSION) or (f and not f(c)) 
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	m:RemoveCard(c)
	local chk=c:CheckFusionMaterial(m,nil,tp)
	m:AddCard(c)
	return chk
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetMatchingGroup(s.filter0,tp,LOCATION_EXTRA+LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg1=Duel.GetMatchingGroup(s.filter1,tp,LOCATION_EXTRA+LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(s.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(s.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf)
	end
	if #sg1>0 or (sg2~=nil and #sg2>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		mg1:RemoveCard(tc)
		if mg2~=nil and #mg2>0 then
			mg2:RemoveCard(tc)
		end
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,tp)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,tp)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
]]

--Extra Fusion vieja
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,911000814+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter1(c,e)
	return c:IsCanBeFusionMaterial() --and not c:IsImmuneToEffect(e)
end
--function s.filter2(c,e,tp,m)
--	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,PLAYER_NONE,false,false)
--		and c:CheckFusionMaterial(m)
--end
function s.filter2(c,e,tp,m,f)
	if not c:IsType(TYPE_FUSION) or (f and not f(c)) 
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	m:RemoveCard(c)
	local chk=c:CheckFusionMaterial(m,nil,tp)
	m:AddCard(c)
	return chk
end
function s.cfilter(c)
	return (((c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsSetCard(0x46)) or (c:IsType(TYPE_QUICKPLAY) and c:IsSetCard(0xa5))) --return not c:IsPublic() and c:GetCode()~=911000814
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		--local mg=Duel.GetMatchingGroup(s.filter1,tp,0x4F,0,nil,e)
		local mg=Duel.GetMatchingGroup(s.filter1,tp,LOCATION_EXTRA+LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,nil)
		local rv=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
		return Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg) and rv:GetCount()>0
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--local mg=Duel.GetMatchingGroup(s.filter1,tp,0x4F,0,nil,e)
	local mg=Duel.GetMatchingGroup(s.filter1,tp,LOCATION_EXTRA+LOCATION_DECK+LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local sg=Duel.GetMatchingGroup(s.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg)
	if sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		--local mat=Duel.SelectFusionMaterial(tp,tc,mg)
		local mat=Duel.SelectFusionMaterial(tp,tc,mg,nil,tp)
		Duel.ConfirmCards(1-tp,mat)
		local rv=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local rvc=rv:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,rvc)
		tc:SetMaterial(mat)
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		tc:SetTurnCounter(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_SELF_TURN,tc:GetMaterialCount())
		--e1:SetReset(RESET_EVENT+PHASE_END+RESET_PHASE+RESET_END+RESET_SELF_TURN,tc:GetMaterialCount())
		e1:SetOperation(s.retop)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function s.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()~=tp then return end
	local time=c:GetMaterialCount()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==time then
		if c:IsLocation(LOCATION_MZONE) then
			Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
		end
	end
end

