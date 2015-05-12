--Creation Magician
function c17086528.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c17086528.ptg)
	e2:SetOperation(c17086528.pop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c17086528.target)
	e3:SetOperation(c17086528.operation)
	c:RegisterEffect(e3)
	--no battle damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e6)
end
function c17086528.filter1(c,tp)
	local lv1=c:GetRank()
	return lv1>0 and c:IsFaceup() and Duel.IsExistingTarget(c17086528.filter2,tp,LOCATION_MZONE,0,1,c,lv1)
end
function c17086528.filter2(c,rc,at,lv1)
	local lv2=c:GetLevel()
	return lv2>4 and lv2~=lv1 and c:IsFaceup()
end
function c17086528.ptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c17086528.filter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c17086528.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc1=g1:GetFirst()
	e:SetLabelObject(tc1)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26864586,0))
	
end
function c17086528.pop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local tc2=Duel.SelectTarget(tp,c17086528.filter2,tp,LOCATION_MZONE,0,1,1,tc1):GetFirst()
	local lv=tc2:GetLevel()
		if tc1:IsFaceup() and tc1:IsRelateToEffect(e) and tc2:IsFaceup() and tc2:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_RANK)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc1:RegisterEffect(e1)
	end
end

function c17086528.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
end
function c17086528.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c17086528.sccon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)>Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
end

