--究極完全態・グレート・モス
function c485793790.initial_effect(c)
	--cannot be battle target
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c485793790.tg)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c485793790.recon)
	--e5:SetTarget(c14141448.thtg2)
	--e5:SetOperation(c14141448.tgop2)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)
	--others
	local e02=Effect.CreateEffect(c)
	e02:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e02:SetType(EFFECT_TYPE_SINGLE)
	e02:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e02)
	--local e03=e02:Clone()
	--e03:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	--c:RegisterEffect(e03)
	local e04=e02:Clone()
	e04:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e04)
end
function c485793790.recon(e)
	return e:GetHandler():IsFaceup() or e:GetHandler():IsFacedown()
end

function c485793790.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsRace(RACE_INSECT)
end

--[[
function c485793790.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c485793790.spcon)
	e2:SetOperation(c485793790.spop)
	c:RegisterEffect(e2)
end
function c485793790.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=6
end
function c485793790.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():FilterCount(c485793790.eqfilter,nil)>0
end
function c485793790.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c485793790.rfilter,1,nil)
end
function c485793790.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c485793790.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
]]