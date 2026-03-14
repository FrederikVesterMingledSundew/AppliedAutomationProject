#ifndef MYSTDLIB_H
#define MYSTDLIB_H

#include <stdlib.h>

template<typename T> inline T abs(T x)
{
	return x < 0 ? -x : x;
}

#define range(i, arr) for (int i = 0; i < (sizeof(arr) / sizeof(arr[0])); ++i)

#endif
