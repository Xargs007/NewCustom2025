--フュージョン・ゲート Maschange friend
function c33550698.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Mask change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33550694,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c33550698.target01)
	e2:SetOperation(c33550698.activate01)
	c:RegisterEffect(e2)
	--tokken invocation
	local e02=Effect.CreateEffect(c)
	e02:SetDescription(aux.Stringid(100417010,0))
	e02:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_COIN)
	e02:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e02:SetCode(EVENT_ATTACK_ANNOUNCE)
	e02:SetCountLimit(1,33550698)
	e02:SetRange(LOCATION_SZONE)
	e02:SetCost(c33550698.cost2)
	e02:SetCondition(c33550698.atkcon)
	e02:SetTarget(c33550698.sumtg2)
	e02:SetOperation(c33550698.sumop2)
	c:RegisterEffect(e02)
	local e09=Effect.CreateEffect(c)
	e09:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e09:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e09:SetCode(EVENT_ATTACK_ANNOUNCE)
	e09:SetRange(LOCATION_GRAVE)
	e09:SetCountLimit(1,33550698)
	e09:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetCode(EVENT_FREE_CHAIN)
	--e02:SetCondition(aux.exccon)
	e09:SetCondition(c33550698.atkcon)
	e09:SetCost(c33550698.cost2)
	e09:SetTarget(c33550698.sumtg2)
	e09:SetOperation(c33550698.sumop2)
	c:RegisterEffect(e09)
end

function c33550698.Cardfilter(c)
	local code=c:GetCode()
	return code==63035435
end

function c33550698.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end

function c33550698.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>2
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_MONSTER) and not Duel.IsExistingMatchingCard(c33550698.Cardfilter,tp,LOCATION_SZONE+LOCATION_GRAVE+LOCATION_FZONE+LOCATION_REMOVED,0,1,nil)
end
function c33550698.sumtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33550698.sumop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,53527838)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end




-- Codigo functional
function c33550698.filter0(c)
	return c:IsCanBeFusionMaterial() and c:IsSetCard(0x8)
end

function c33550698.filter1(c,e)
	return c:IsCanBeFusionMaterial() and c:IsSetCard(0x8) and not c:IsImmuneToEffect(e)
end
function c33550698.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c.maskchange_calling and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION+0x10,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c33550698.target01(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c33550698.filter0,tp,LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c33550698.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c33550698.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c33550698.activate01(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c33550698.filter1,tp,LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c33550698.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c33550698.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION+0x10,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2,SUMMON_TYPE_FUSION+0x10)
		end
		tc:CompleteProcedure()
	end
end



----------