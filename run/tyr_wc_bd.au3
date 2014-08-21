global const $kTimeouts 		= "4.5,2,20,4.5"				;	минуты
global const $kTimeoutHandlers 	= "selfbuff,dance,buff,COV"		;	функции

; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40

; Skills
global const $kAttackSkill1 = "{F2}"
global const $kAttackSkill2 = "{2}"
global const $kAttackSkill3 = "{3}"
global const $kAttackSkill4 = "{9}"
global const $kAttackSkill5 = "{F1}"

global const $kSelfBuff1 = "{F10}"
global const $kSelfBuff2 = "{F11}"

global const $kNextMacrosKey1 = "{6}"
global const $kNextMacrosKey2 = "{7}"
global const $kNextMacrosKey3 = "{8}"
global const $kZealot = "{F3}"
global const $kBison = "{F4}"
global const $kHawk = "{F5}"

global const $kDance = "{F1}"
global const $kBuff = "{NUMPAD1}"
global const $kCOV  = "{NUMPAD1}"

func OnAttack()
   Local $skill = Random(1, 5, 1)
   Switch $skill
    Case 1
        SendClient($kAttackSkill1, 1000)
    Case 2
        SendClient($kAttackSkill2, 1000)
    Case 3
        SendClient($kAttackSkill3, 1000)
    Case 4
        SendClient($kAttackSkill4, 1000)
    Case 5
        SendClient($kAttackSkill5, 1000)
   EndSwitch
endfunc

global $last_used = 0

func OnLimit()
	SendClient($kZealot, 1000)

	if $last_used  > 0 then
	   SendClient($kHawk, 800)
	   $last_used = 0
    else
	   SendClient($kBison, 800)
	   $last_used = 1
	EndIf
endfunc

func OnAllKill()
	PickDrop(Random(5, 10, 1))
endfunc

func NextTarget()
	SendClient($kNextTargetKey, 1000)
endfunc

func NextMacros()

   Local $target = Random(0, 2, 1)
   Switch $target
    Case 0
        SendClient($kNextMacrosKey1, 1000)
    Case 1
        SendClient($kNextMacrosKey2, 1000)
    Case 2
        SendClient($kNextMacrosKey3, 1000)
   EndSwitch
endfunc

func OnAttackTimeout()
	SendClient($kCancelTarget, 50)
	LookAroundChangePosition()
endfunc

func OnCheckHealthAndMana()
	if IsHealthLess($kBarThird) then
		OnLimit()
    endif

	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif

	if IsManaLess($kBarThird) then
		ManaPotion()
	endif
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/party.au3"
