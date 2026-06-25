
PROGRAM _INIT
	(* Insert code here *)
	
	//MoveVelocity.Acceleration := 1.0;
	//MoveVelocity.Deceleration := 10.0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	Feeder.Axis := ADR( FeederAxis );
	Feeder.Enable := TRUE;
	Feeder();
	
	(*CASE State OF 
		
		SERVO_IDLE:
			
			IF ServoRun THEN
				ServoRun := FALSE;
				State := SERVO_POWER_ON;
			END_IF
		
		SERVO_POWER_ON:
			
			PowerON.Axis := ADR( FeederAxis );
			PowerON.Enable := TRUE;
			PowerON();
			
			IF PowerON.Status THEN
				//State := SERVO_MOVE_VEL;
				State := SERVO_HOMING;
			END_IF;
		
		SERVO_HOMING:
			
			Home.Axis := ADR ( FeederAxis );
			Home.Position := 0;
			Home.Execute := TRUE;
			Home();
			
			IF Home.Done THEN
				State := SERVO_MOVE_VEL;
				Home( Execute := FALSE );
			ELSIF Home.Error THEN
				Home( Execute := FALSE );
				State := SERVO_ERROR;
				ErrorState := 'HOME';
			END_IF
			
		SERVO_MOVE_VEL:
		
			MoveVelocity.Axis := ADR( FeederAxis );
			MoveVelocity.Velocity := TestVelocity;
			MoveVelocity.Execute := TRUE;
			MoveVelocity();
		
			IF MoveVelocity.Error THEN
				State := SERVO_ERROR;
				MoveVelocity( Execute := FALSE );
				ErrorState := 'MOVE_VEL';
			END_IF
		
		SERVO_STOP:
			
			MoveVelocity.Execute := FALSE;
			StopMotion.Axis := ADR( FeederAxis );
			StopMotion.Execute := TRUE;
			StopMotion();
			
			IF StopMotion.Done THEN
				StopMotion.Execute := FALSE;
				State := SERVO_IDLE;
			END_IF
		
		SERVO_POWER_OFF:
		
			PowerON( Enable := FALSE );
		
			IF PowerON.Busy = FALSE THEN
				State := SERVO_IDLE;
			END_IF
		
		SERVO_RESET:
		
			ResetDrive.Axis := ADR( FeederAxis );
			ResetDrive.Execute := TRUE;
			ResetDrive();
		
			IF ResetDrive.Done THEN
				ResetDrive( Execute := FALSE );
				State := SERVO_IDLE;
			END_IF
		
		SERVO_ERROR:
		
			IF ResetServo THEN
				ResetServo := FALSE;
				State := SERVO_RESET;
				ErrorState := '';
			END_IF
		
		
	END_CASE*)
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

