
ACTION States: 
	CASE PACK_ML OF
		ABORTING:
			PackMLChar := 'ABORTING';
			PACK_ML := ABORTED;

		ABORTED:
			PackMLChar := 'ABORTED';
			PACK_ML := CLEARING;

		CLEARING:
			PackMLChar := 'CLEARING';
			PACK_ML := STOPPED;

		STOPPING:
			PackMLChar := 'STOPPING';
			PACK_ML := ABORTED;

		STOPPED:
			PackMLChar := 'STOPPED';
			PACK_ML := RESETTING;

		RESETTING:
			PackMLChar := 'RESETTING';
			PACK_ML := IDLE;

		IDLE:
			PackMLChar := 'IDLE';
			PACK_ML := STARTING;
			
		STARTING:
			PackMLChar := 'STARTING';
			PACK_ML := EXECUTE;
			
		EXECUTE:
			PackMLChar := 'EXECUTE';
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
			PackMLChar := 'SUSPENDING';
			PACK_ML := SUSPENDED;
			
		SUSPENDED:
			PackMLChar := 'SUSPENDED';
			PACK_ML := UNSUSPENDING;

		UNSUSPENDING:
			PackMLChar := 'UNSUSPENDING';
			PACK_ML := EXECUTE;

		HOLDING:
			PackMLChar := 'HOLDING';
			PACK_ML := HELD;

		HELD:
			PackMLChar := 'HELD';
			PACK_ML := UNHOLDING;

		UNHOLDING:
			PackMLChar := 'UNHOLDING';
			PACK_ML := EXECUTE;

		COMPLETING:
			PackMLChar := 'COMPLETING';
			PACK_ML := COMPLETED;

		COMPLETED:
			PackMLChar := 'COMPLETED';
			PACK_ML := RESETTING;

	END_CASE
END_ACTION
