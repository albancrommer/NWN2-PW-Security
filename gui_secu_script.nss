// Crom, 28/08/2011 15h
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
	int bTestPassword = TRUE;
	string sStoredPassword;
	int nPasswordTests;
	switch(nAction)
	{
		case 1:
			FloatingTextStringOnCreature("Mot de passe enregistré : '"+sInput+"'", OBJECT_SELF, FALSE, 10.0, 16711680, 16750848);
			SetCampaignString("SECU", "PWD_" + sPCPlayerName, sInput);
			bTestPassword = FALSE;
			
		case 2:
		
			if(bTestPassword)
			{
				sStoredPassword = GetCampaignString("SECU", "PWD_" + sPCPlayerName);
				
				if(sStoredPassword != sInput)
				{
					//Incorrect Password
					nPasswordTests = GetGlobalInt("PWD_TESTS_"+sPCPlayerName);
					nPasswordTests++;
					
					if(nPasswordTests >= 3)
					{
						SetGlobalInt("PWD_TESTS_"+sPCPlayerName, 0);
						BootPC(OBJECT_SELF);
						break;
					}
					else
					{
						SetGlobalInt("PWD_TESTS_"+sPCPlayerName, nPasswordTests);
						DisplayInputBox(OBJECT_SELF, 0, "Mot de passe incorrect, merci d'entrer votre Mot de Passe '"+GetModuleName()+"' pour entrer sur le server", "gui_secu_script", "gui_secu_script", TRUE, "SCREEN_STRINGINPUT_MESSAGEBOX",0,"Valider",0,"Quitter","");
					}
					break;
				}
			}
			//The password is correct/has been set
			
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

