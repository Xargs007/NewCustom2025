--破壊竜ガンドラ
function c646814320.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon,flip
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c646814320.tgreg1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e3:SetOperation(c646814320.tgreg2)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(646814320,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	--e4:SetCost(c646814320.descost)
	e4:SetTarget(c646814320.destg)
	e4:SetOperation(c646814320.desop)
	c:RegisterEffect(e4)
	--to grave
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetDescription(aux.Stringid(646814320,1))
	e5:SetCategory(CATEGORY_TOGRAVE)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c646814320.tgcon)
	e5:SetTarget(c646814320.tgtg)
	e5:SetOperation(c646814320.tgop)
	c:RegisterEffect(e5)
	-- special summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SPSUMMON_PROC)
	e6:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e6:SetRange(LOCATION_HAND)
	c:RegisterEffect(e6)
	--auto destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(646814320,1))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetTarget(c646814320.tgtg)
	e7:SetOperation(c646814320.tgop)
	c:RegisterEffect(e7)
end

--function c82301904.sgfilter(c,p)
--	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(p)
--end
--function c82301904.sgop(e,tp,eg,ep,ev,re,r,rp)
--	local g=Duel.GetFieldGroup(tp,0xe,0xe)
--	Duel.SendtoGrave(g,REASON_EFFECT)
--	local og=Duel.GetOperatedGroup()
	--local ct=og:FilterCount(c82301904.sgfilter,nil,1-tp)
--	if ct>0 then
	--	Duel.BreakEffect()
	--	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
	--end
--end

function c646814320.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c646814320.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c646814320.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local ct=Duel.Destroy(sg,REASON_EFFECT,LOCATION_REMOVED)
	if ct>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(ct*300)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e:GetHandler():RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.Damage(tp,ct*300,REASON_EFFECT)
	end
end
function c646814320.tgreg1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(646814320,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end
function c646814320.tgreg1(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetDescription(aux.Stringid(646814320,1))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c646814320.tgcon)
	e1:SetTarget(c646814320.tgtg)
	e1:SetOperation(c646814320.tgop)
	c:RegisterEffect(e1)
end
function c646814320.tgreg2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(646814320,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
end
function c646814320.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(646814320)~=0
end
function c646814320.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c646814320.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
