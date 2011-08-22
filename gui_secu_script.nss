// Crom, 20/08/2011 14h
// crom29@hotmail.fr




void main(string sInput)
{

	int nAction;
	string sPCPlayerName = GetPCPlayerName(OBJECT_SELF);
	
	//Clean sInput
	while(GetStringLeft(sInput, 1) == " ")
		sInput = GetStringRight(sInput, GetStringLength(sInput)-1);
		
	while(GetStringRight(sInput, 1) == " ")
		sInput = GetStringLeft(sInput, GetStringLength(sInput)-1);
	
	
	if (sInput == "")
		nAction = 0;
	else
		nAction = GetLocalInt(OBJECT_SELF, "nPassWordAction");
		
		
	int n;
	effect eEffect;
	switch(nAction)
	{
		case 1:
			FloatingTextStringOnCreature("Mot de passe enregistré : '"+sInput+"'", OBJECT_SELF, FALSE, 10.0, 16711680, 16750848);
			SetCampaignString("SECU", "PWD_" + sPCPlayerName, sInput);
			
		case 2:
            SetCampaignInt("SECU", sPCPlayerName + "#" + sInput + "#" + GetPCPublicCDKey(OBJECT_SELF), TRUE);
            SetCampaignInt("SECU", sPCPlayerName + "#" + sInput + "#" + GetPCIPAddress(OBJECT_SELF), TRUE); 
			
			
			eEffect = GetFirstEffect(OBJECT_SELF);
			while(GetIsEffectValid(eEffect))
			{
				if(GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE)
				{
					RemoveEffect(OBJECT_SELF, eEffect);
				}
			eEffect = GetNextEffect(OBJECT_SELF);
			}
			break;
		//=================
		default:
			BootPC(OBJECT_SELF);
			break;
	}
}
