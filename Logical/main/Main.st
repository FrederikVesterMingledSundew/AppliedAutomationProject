
PROGRAM _INIT
	(* Insert code here *)
	
	PACK_ML := CLEARING;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	IF IO_Input._Distance < 1000 OR IO_Input._Distance > 32000 THEN
		IO_Input.Distance := 1.0;
	ELSE
		IO_Input.Distance := 0.00001033592*IO_Input._Distance+0.1581395;
	END_IF
	
	States;  // action
	
	IO_Input.ROBOT_READY; //Kanal 601 - output på robot
	
	IO_Output.ROBOT_RUN_PRG; //Kanal 501 - input på robot
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

