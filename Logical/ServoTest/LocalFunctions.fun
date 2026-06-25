
{REDUND_ERROR} FUNCTION_BLOCK FB_DigitalFilter (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		In : {REDUND_UNREPLICABLE} REAL; (*Raw input PV.*)
		CoefForward : REFERENCE TO ARRAY[0..4] OF REAL; (*Array containing b coefficients of the filter.*)
		CoefFeedback : REFERENCE TO ARRAY[0..4] OF REAL; (*Array containing a coefficients of the filter.*)
	END_VAR
	VAR_OUTPUT
		Out : REAL; (*Filtered ouput PV.*)
	END_VAR
	VAR
		BufferInput : ARRAY[0..4] OF REAL; (*Buffer of raw input PV.*)
		BufferOutput : ARRAY[0..4] OF REAL; (*Buffer of filtered output PV.*)
		FirstScan : BOOL := TRUE; (*Bool - Sets the buffers on first scan.*)
		idx : USINT := 0; (*Iterator for circular bufffers.*)
		i : USINT;
	END_VAR
END_FUNCTION_BLOCK

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
		State : E_ServoStates;
	END_VAR
END_FUNCTION_BLOCK
