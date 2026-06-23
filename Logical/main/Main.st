
PROGRAM _INIT
	(* Insert code here *)
	
	PACK_ML := CLEARING;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	States;  // action
	
	IO_Input.Distance;
	
	IO_Input.ROBOT_READY; //Kanal 601 - output på robot
	
	IO_Output.ROBOT_RUN_PRG; //Kanal 501 - input på robot
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

