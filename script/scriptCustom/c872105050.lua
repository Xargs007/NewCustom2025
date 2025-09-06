--騎士の称号
--Five Star Twilight
function c872105050.initial_effect(c)
	c:EnableReviveLimit()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(872105050,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c872105050.spDMcon)
	e1:SetCost(c872105050.cost)
	e1:SetCountLimit(1,872105050)
	--e1:SetTarget(c872105050.target)
	e1:SetTarget(c872105050.destg)
	e1:SetOperation(c872105050.spop2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(872105050,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c872105050.spDMGcon)
	e2:SetCost(c872105050.cost2)
	e2:SetCountLimit(1,872105050)
	--e1:SetTarget(c872105050.target)
	e2:SetTarget(c872105050.destg)
	e2:SetOperation(c872105050.spop3)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	--e5:SetCondition(c872105050.recon)
	--e5:SetTarget(c14141448.thtg2)
	--e5:SetOperation(c14141448.tgop2)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)

end
--
function c872105050.cDMfilter(c,tp)
	return c:IsCode(46986414) and c:IsFaceup(tp)
end
function c872105050.spDMcon(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.IsExistingMatchingCard(c911001771.cDMfilter,tp,LOCATION_ONFIELD,0,1,nil))
end
--
function c872105050.cDMGfilter(c,tp)
	return c:IsCode(38033121) and c:IsFaceup(tp)
end
function c872105050.spDMGcon(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.IsExistingMatchingCard(c911001771.cDMGfilter,tp,LOCATION_ONFIELD,0,1,nil))
end
--
c872105050.dark_magician_list=true
function c872105050.costfilter(c)
	return c:IsFaceup() and c:IsCode(46986414)
end
function c872105050.costfilter2(c)
	return c:IsFaceup() and c:IsCode(38033121)
end
function c872105050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c872105050.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c872105050.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c872105050.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c872105050.costfilter2,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c872105050.costfilter2,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c872105050.spfilter(c,e,tp)
	return c:IsCode(50725996) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c872105050.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c872105050.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c872105050.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c872105050.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()~=0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
--
function c872105050.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c872105050.spop2(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,50725996)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c872105050.spop3(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local token=Duel.CreateToken(tp,50725997)
	Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	token:SetStatus(STATUS_PROC_COMPLETE,true)
	token:SetStatus(STATUS_SPSUMMON_TURN,true)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c872105050.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c872105050.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,50725996,0,0x4011,2500,2100,1,RACE_WARRIOR,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,50725996)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)	
	end
	Duel.SpecialSummonComplete()
end
---
function c872105050.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c872105050.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

