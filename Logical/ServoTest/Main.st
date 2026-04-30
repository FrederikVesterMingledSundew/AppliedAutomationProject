
PROGRAM _INIT
	(* Insert code here *)
	
	PowerON.Axis := 0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE State OF 
		
		SERVO_IDLE:
			
			IF ServoRun THEN
				State := SERVO_POWER_ON;
			END_IF
		
		SERVO_POWER_ON:
			
			PowerON.Axis := ADR( FeederAxis );
			PowerON.Enable := TRUE;
			PowerON();
			
			IF PowerON.Status THEN
				State := SERVO_MOVE_VEL;
			END_IF;
		
		SERVO_MOVE_VEL:
		
			MoveVelocity.Axis := ADR( FeederAxis );
			MoveVelocity.Velocity := 1000;
			MoveVelocity.Execute := TRUE;
			MoveVelocity();
		
			IF MoveVelocity.Error THEN
				State := SERVO_POWER_OFF;
			END_IF
		
		SERVO_POWER_OFF:
		
			PowerON( Enable := FALSE );
		
		
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

