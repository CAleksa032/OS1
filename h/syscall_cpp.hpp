#ifndef PROJECT_BASE_V1_1_SYSCALL_CPP_HPP
#define PROJECT_BASE_V1_1_SYSCALL_CPP_HPP

#include "syscall_c.h"
#include "../lib/hw.h"
#include "tcb.hpp"

void* operator new (size_t);
void* operator new[] (size_t);
void operator delete (void*);
void operator delete[](void *tmp);


class Thread {
public:
    Thread (void (*body)(void*), void* arg){}
    virtual ~Thread ();
    int start ();
    static void dispatch ();
    static int sleep (time_t);
    void join();
protected:
    Thread (){myHandle = nullptr;}
    virtual void run () {}
private:
    thread_t myHandle;
    static void wrapper(void* thr){ if(thr) ((Thread*)thr)->run(); }
};


#endif //PROJECT_BASE_V1_1_SYSCALL_CPP_HPP
