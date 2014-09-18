#include "other.h"

int sum1(int num)
{
    int tmp;
    if (num <= 1)
        return 1;

    tmp = 1 + sum1(num - 1);

    return tmp;
}
