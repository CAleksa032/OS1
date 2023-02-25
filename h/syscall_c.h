#pragma once

#include "../lib/hw.h"


class TCB;
typedef TCB* thread_t;

#ifdef __cplusplus
extern "C" {
#endif

//--------------alokacija memorije--------------
void* mem_alloc(size_t size);
int mem_free(void*);

//--------------niti--------------


int thread_create(TCB** handle, void (*start_routine)(void*), void* arg);
int thread_exit();
void thread_dispatch();

//void user_mode();
void putc(char c);
char getc();
void user_mode();

void thread_join(thread_t* t);

#ifdef __cplusplus
}
#endif


