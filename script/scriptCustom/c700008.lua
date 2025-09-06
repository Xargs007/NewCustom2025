--Dark Necro Sanctuary
function c700008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	--local e01=Effect.CreateEffect(c)
	--e01:SetType(EFFECT_TYPE_SINGLE)
	--e01:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	--e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	--e01:SetValue(1)
	--e01:SetCountLimit(1)
	--c:RegisterEffect(e01)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c700008.val)
	c:RegisterEffect(e2)
	--Def
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e3)
	--Draw Necro for GY
	local e02=Effect.CreateEffect(c)
	e02:SetDescription(aux.Stringid(700008,0))
	e02:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e02:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e02:SetCode(EVENT_PREDRAW)
	e02:SetRange(LOCATION_FZONE)
	e02:SetCondition(c700008.condition)
	e02:SetTarget(c700008.target)
	e02:SetOperation(c700008.operation)
	c:RegisterEffect(e02)
	local e22=e02:Clone()
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCondition(c700008.condition1)
	c:RegisterEffect(e22)
end

function c700008.condition1(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>0
		and Duel.GetDrawCount(tp)>0 and Duel.IsExistingMatchingCard(c700008.filterb,tp,LOCATION_FZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c700008.filterb2,tp,LOCATION_GRAVE,0,1,nil) 
end
function c700008.filterb2(c)
	return c:IsCode(700008) and c:IsPreviousLocation(LOCATION_FZONE) and c:IsFaceup() --and c:IsLocation(LOCATION_GRAVE)
end
function c700008.filterb(c)
	return c:IsCode(100417010) and c:IsFaceup() --and c:IsLocation(LOCATION_GRAVE)
end

function c700008.val(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_FIEND+RACE_ZOMBIE)>0 then return 200
	--elseif bit.band(r,RACE_FAIRY)>0 then return -200
	else return 0 end
end

function c700008.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>0
		and Duel.GetDrawCount(tp)>0
end
function c700008.filter(c)
	return c:IsSetCard(0x235) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_FUSION)
end
function c700008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700008.filter,tp,LOCATION_GRAVE,0,3,nil) end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_GRAVE)
end
function c700008.operation(e,tp,eg,ep,ev,re,r,rp)
	_replace_count=_replace_count+1
	if _replace_count>_replace_max or not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c700008.filter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		--Duel.ShuffleDeck(tp)
		local tg=sg:RandomSelect(1-tp,1)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
