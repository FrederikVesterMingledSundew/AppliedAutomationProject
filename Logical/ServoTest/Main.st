
PROGRAM _INIT
	(* Insert code here *)
	PowerON.Axis := ADR( FeederAxis );
	Home.Axis := ADR ( FeederAxis );
	MoveVelocity.Axis := ADR( FeederAxis );
	StopMotion.Axis := ADR( FeederAxis );
	ResetDrive.Axis := ADR( FeederAxis );
	
	MoveVelocity.Acceleration := 1.0;
	MoveVelocity.Deceleration := 1.0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	(*Feeder.Axis := ADR( FeederAxis );
	Feeder.Enable := TRUE;
	Feeder.Velocity := STRING_TO_REAL( HMI_FeederVelocity );
	Feeder();*)
	
	IF HMI_Stop AND State = SERVO_MOVE_VEL THEN
		State := SERVO_STOP;
	END_IF
	
	IF HMI_Reset THEN
		State := SERVO_RESET;
	END_IF
	
	CASE State OF 
		
		SERVO_IDLE:
			
			IF HMI_Start THEN
				ServoRun := FALSE;
				State := SERVO_POWER_ON;
			END_IF
		
		SERVO_POWER_ON:
			
			
			PowerON.Enable := TRUE;
			PowerON();
			
			IF PowerON.Status THEN
				//State := SERVO_MOVE_VEL;
				State := SERVO_HOMING;
			END_IF;
		
		SERVO_HOMING:
			
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
		
			
			IF MoveVelocity.Velocity <> STRING_TO_REAL( HMI_FeederVelocity ) THEN
				MoveVelocity.Execute := FALSE;
				MoveVelocity.Velocity := STRING_TO_REAL( HMI_FeederVelocity );
			ELSE
				MoveVelocity.Execute := TRUE;
			END_IF
			IF HMI_FeederDir THEN
				MoveVelocity.Direction := mcDIR_NEGATIVE;
			ELSE
				MoveVelocity.Direction := mcDIR_POSITIVE;
			END_IF
			MoveVelocity();
		
			IF MoveVelocity.Error THEN
				State := SERVO_ERROR;
				MoveVelocity( Execute := FALSE );
				ErrorState := 'MOVE_VEL';
			END_IF
		
		SERVO_STOP:
			
			MoveVelocity( Execute := FALSE );
			StopMotion.Execute := TRUE;
			StopMotion();
			
			IF StopMotion.Done THEN
				StopMotion( Execute := FALSE );
				State := SERVO_IDLE;
			END_IF
		
		SERVO_POWER_OFF:
		
			PowerON( Enable := FALSE );
		
			IF PowerON.Busy = FALSE THEN
				State := SERVO_IDLE;
			END_IF
		
		SERVO_RESET:
		
			MoveVelocity( Execute := FALSE );
			
			ResetDrive.Execute := TRUE;
			ResetDrive();
		
			IF ResetDrive.Done THEN
				ResetDrive( Execute := FALSE );
				State := SERVO_POWER_OFF;
			END_IF
		
		SERVO_ERROR:
		
			IF ResetServo THEN
				ResetServo := FALSE;
				State := SERVO_RESET;
				ErrorState := '';
			END_IF
		
		
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

