
ACTION States: 
	CASE PACK_ML OF
		ABORTING:
			PACK_ML := ABORTED;
		ABORTED:
			PACK_ML := CLEARING;
		CLEARING:
			PACK_ML := STOPPED;
		STOPPING:
			PACK_ML := ABORTED;
		STOPPED:
			PACK_ML := RESETTING;
		RESETTING:
			PACK_ML := IDLE;
		IDLE:
			PACK_ML := STARTING;
		STARTING:
			PACK_ML := EXECUTE;
		EXECUTE:
			
			(*
			
			The belt should run. If we are in an acceptable region we should go to the position of tray and catch it with the robot.
			This program only tells the robot TO run, not where TO run.
			
			*)
			IF ACCEPTED_DISTANCE > ABS(ROBOT_CATCH_DISTANCE - IO_Input.Distance) THEN
				IF IO_Input.ROBOT_READY THEN
					IO_Output.BELT_START := FALSE;
					IO_Output.ROBOT_RUN_PRG := TRUE;
				ELSE
					IO_Output.BELT_START := FALSE;
					IO_Output.ROBOT_RUN_PRG := FALSE;
				END_IF
			ELSE
				IO_Output.ROBOT_RUN_PRG := FALSE;
				
				IF (ROBOT_CATCH_DISTANCE - IO_Input.Distance) > 0 THEN
					IO_Output.BELT_CONST_SPEED := TRUE;
					IO_Output.BELT_DIR := TRUE;
					IO_Output.BELT_START := TRUE;
				ELSE
					IO_Output.BELT_CONST_SPEED := TRUE;
					IO_Output.BELT_DIR := FALSE;
					IO_Output.BELT_START := TRUE;
				END_IF
				
			END_IF
			
			//PACK_ML := COMPLETING;
		SUSPENDING:
			PACK_ML := SUSPENDED;
		SUSPENDED:
			PACK_ML := UNSUSPENDING;
		UNSUSPENDING:
			PACK_ML := EXECUTE;
		HOLDING:
			PACK_ML := HELD;
		HELD:
			PACK_ML := UNHOLDING;
		UNHOLDING:
			PACK_ML := EXECUTE;
		COMPLETING:
			PACK_ML := COMPLETED;
		COMPLETED:
			PACK_ML := RESETTING;
	END_CASE
END_ACTION
