#include "semaphores.h"
int sem_create(unsigned initial_value)
{
  int *operation_address = (int *)(OPERATION_BASE_ADDRESS | SEM_CREATE | initial_value);
  int ret = *operation_address;
  return ret;
}
int sem_p(unsigned int num_sem){
  int *operation_address = (int *)(OPERATION_BASE_ADDRESS | SEM_P | num_sem);
  int ret = *operation_address;
  while (ret)
  { 
    asm("nop");
    asm("nop");
    asm("nop");
    ret = *operation_address;
  }
  return ret;
}
int sem_v(unsigned int num_sem){
  int *operation_address = (int *)(OPERATION_BASE_ADDRESS | SEM_V | num_sem);
  int ret = *operation_address;
  return ret;
}