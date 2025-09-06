--ダーク・シティ masked hero New
function c53527838.initial_effect(c)
	--indes
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	--e1:SetCondition(c53527838.indcon)
	--e1:SetValue(1)
	--c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c53527838.upatkcon)
	e2:SetValue(c53527838.val)
	c:RegisterEffect(e2)
    --Cannot be Destroyed by the effects of Spell/Trap Cards and non-DIVINE monsters
	local e06=Effect.CreateEffect(c)
	e06:SetType(EFFECT_TYPE_SINGLE)
	e06:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e06:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e06:SetCondition(c53527838.undefcon)
	e06:SetValue(1)
	c:RegisterEffect(e06)
	--atk change def
	local e05=Effect.CreateEffect(c)
	e05:SetDescription(aux.Stringid(53527837,0))
	e05:SetCategory(CATEGORY_ATKCHANGE)
	e05:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e05:SetCode(EVENT_BE_BATTLE_TARGET)
	e05:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e05:SetCountLimit(1,53527838)
	e05:SetCondition(c53527838.atkcdefcon)
	e05:SetOperation(c53527838.changead)
	c:RegisterEffect(e05)
	--add setcode
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_SETCODE)
	e4:SetValue(0x3008)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetValue(0x08)
	c:RegisterEffect(e5)
	--disable spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(1,0)
	c:RegisterEffect(e6)
end

function c53527838.atkcdefcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>0
end
function c53527838.changead(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	while tc do
		local atk=tc:GetBaseAttack()
		local def=tc:GetBaseDefence()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		--e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(def)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENCE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
end

function c53527838.undefcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>1
end


function c53527838.upatkcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>3
end

function c53527838.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*300
end
