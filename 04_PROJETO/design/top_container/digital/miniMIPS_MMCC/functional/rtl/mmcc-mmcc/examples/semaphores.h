#ifndef _SEMAPHORES_
#define _SEMAPHORES_
#define OPERATION_BASE_ADDRESS 0x38000
#define SEM_CREATE 0xC00
#define SEM_P      0x400
#define SEM_V      0x800

int sem_create(unsigned initial_value);
int sem_p(unsigned int num_sem);
int sem_v(unsigned int num_sem);

#endif