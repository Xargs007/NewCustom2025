--墓守の異端者
function c469557700.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetCondition(c469557700.con)
	e1:SetValue(c469557700.efilter)
	c:RegisterEffect(e1)

end
function c469557700.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x2e) or c:IsSetCard(0x91)) --c:IsCode(47355498) 
end
function c469557700.con(e)
	return Duel.IsExistingMatchingCard(c469557700.filter,0,LOCATION_ONFIELD,0,1,nil)
		or Duel.IsEnvironment(47355498)
end
function c469557700.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
