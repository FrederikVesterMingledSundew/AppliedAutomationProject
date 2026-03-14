
#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include <cmath>
#include <string>
#include <vector>
#include <map>
#include "../Libraries/CppLibs/myStdLib.h"
//#include <myStdLib.h>

#define INDIFFERENT_SPEED_DIFF 0.5 // [m/s]

std::vector<double> something(50);

// amount of memory to be allocated for heap storage must be specified for every ANSI C++ program with the bur_heap_size variable
unsigned long bur_heap_size = 0xFFFF; 

void _INIT ProgramInit(void)
{
	// Insert code here 
	int PeriodInHz = 100;
	PWM_PERIOD = (1/PeriodInHz)*1000000;
	
	BELT_START = true;
	BELT_DIR = false;
	BELT_CONST_SPEED = false; //Hvis du flipper den her, kan du styre hastigheden på inverteren
}

void _CYCLIC ProgramCyclic(void)
{
	// Insert code here 
	if( !BELT_CONST_SPEED ) {
		
		if(fabs(BELT_SPEED - _BELT_CURRENT_SPEED_) > INDIFFERENT_SPEED_DIFF) {
			
			if(BELT_SPEED < _BELT_CURRENT_SPEED_) {
				
				_BELT_ACCELERATION_ = -1000;
			}
			else {
				
				_BELT_ACCELERATION_ = 1000;
			}
			
		}
		else {
			
			_BELT_ACCELERATION_ = 0;
		}
	}
	
	if(_BELT_ACCELERATION_ < 0) {
		
		_BELT_ACC_ = 0;
		_BELT_DEACC_ = abs(_BELT_ACCELERATION_);
	} else if(_BELT_ACCELERATION_ > 0) {
		
		_BELT_ACC_ = abs(_BELT_ACCELERATION_);
		_BELT_DEACC_ = 0;
	} else {
		
		_BELT_ACC_ = 0;
		_BELT_DEACC_ = 0;
	}
	
}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}
