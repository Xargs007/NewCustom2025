--ガーディアン・グラール
function c471508510.initial_effect(c)
	--sum limit
	--local e1=Effect.CreateEffect(c)
	--e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_CANNOT_SUMMON)
	--e1:SetCondition(c471508510.sumlimit)
	--c:RegisterEffect(e1)
	--local e2=e1:Clone()
	--e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	--c:RegisterEffect(e2)
	--local e3=e1:Clone()
	--e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	--c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c471508510.spcon)
	c:RegisterEffect(e4)
	--special summon arm hand
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SPSUMMON_PROC)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetRange(LOCATION_HAND+LOCATION_DECK)
	e5:SetCondition(c471508510.spcon2)
	c:RegisterEffect(e5)
end
function c471508510.cfilter(c)
	return c:IsFaceup() and c:IsCode(32022366)
end
function c471508510.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c471508510.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c471508510.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==1
		--and Duel.IsExistingMatchingCard(c471508510.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
--
function c471508510.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c471508510.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end