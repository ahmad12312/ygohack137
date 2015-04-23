--ライオ·アリゲーター
function c1089.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c1089.condition)
	e1:SetTarget(c1089.target)
	c:RegisterEffect(e1)
end
function c1089.cfilter(c)
	return c:IsFaceup()
end
function c1089.condition(e)
	return Duel.IsExistingMatchingCard(c1089.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c1089.target(e,c)
	return true
end
