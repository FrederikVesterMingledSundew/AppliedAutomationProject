
{REDUND_ERROR} FUNCTION_BLOCK FB_ServoControl (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Axis : REFERENCE TO McAxisType;
		Enable : BOOL;
		Stop : BOOL;
		Reset : BOOL;
		Velocity : REAL;
		Acc : REAL := 1.0;
		Dec : REAL := 1.0;
	END_VAR
	VAR_OUTPUT
		Error : BOOL;
		ErrorCode : INT;
		isRunning : BOOL;
	END_VAR
	VAR
		McPower : MC_Power;
		McHome : MC_Home;
		McStop : MC_Stop;
		McReset : MC_Reset;
		McMoveVel : MC_MoveVelocity;
		State : E_ServoStates := SERVO_OFF;
	END_VAR
END_FUNCTION_BLOCK
