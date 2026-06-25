
(* TODO: Add your comment here *)
FUNCTION_BLOCK FB_ServoControl
	
	
	McPower.Axis	:= ADR( Axis );
	McHome.Axis 	:= ADR( Axis );
	McMoveVel.Axis 	:= ADR( Axis );
	McStop.Axis 	:= ADR( Axis );
	McReset.Axis 	:= ADR( Axis );
	
	McMoveVel.Acceleration := Acc;
	McMoveVel.Deceleration := Dec;
	
	
	IF NOT Enable AND isRunning THEN
		State := SERVO_POWER_OFF;
	ELSIF NOT Enable THEN
		State := SERVO_IDLE;
	ELSIF Stop AND isRunning THEN
		State := SERVO_STOP;
	END_IF
	
	
	CASE State OF 
		
		SERVO_OFF:
			
			ErrorCode := 0;
			
			IF Enable THEN
				isRunning := TRUE;
				State := SERVO_POWER_ON;
			END_IF
			
		SERVO_IDLE:
			
			ErrorCode := 0;
		
		SERVO_POWER_ON:
			
			McPower.Enable := TRUE;
			
			IF McPower.Status THEN
				State := SERVO_HOMING;
			END_IF;
			
			McPower();
		
		SERVO_HOMING:
			
			McHome.Position := 0;
			McHome.Execute := TRUE;
			
			IF McHome.Done THEN
				State := SERVO_MOVE_VEL;
				McHome.Execute := FALSE;
			ELSIF McHome.Error THEN
				McHome.Execute := FALSE;
				State := SERVO_ERROR;
				ErrorCode := 1001;
			END_IF
			
			McHome();
			
		SERVO_MOVE_VEL:
		
			McMoveVel.Velocity := Velocity;
			McMoveVel.Execute := TRUE;
		
			IF McMoveVel.Error THEN
				State := SERVO_ERROR;
				McMoveVel.Execute := FALSE;
				ErrorCode := 2001;
			END_IF
			
			McMoveVel();
		
		SERVO_STOP:
			
			McMoveVel.Execute := FALSE;
			McStop.Execute := TRUE;
			
			IF McStop.Done THEN
				isRunning := FALSE;
				McStop.Execute := FALSE;
				State := SERVO_IDLE;
			END_IF
		
			McStop();
			
		SERVO_POWER_OFF:
		
			McPower.Enable := FALSE;
		
			IF McPower.Busy = FALSE THEN
				State := SERVO_OFF;
			END_IF
			
			McPower();
		
		SERVO_RESET:
		
			McReset.Execute := TRUE;
		
			IF McReset.Done THEN
				McReset.Execute := FALSE;
				State := SERVO_IDLE;
			END_IF
		
			McReset();
			
		SERVO_ERROR:
		
			isRunning := FALSE;
			
			IF Reset THEN
				State := SERVO_RESET;
			END_IF
		
		
	END_CASE
	
END_FUNCTION_BLOCK
