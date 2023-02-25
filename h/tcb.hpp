//
// Created by os on 8/22/22.
//

#ifndef PROJECT_BASE_V1_1_TCB_HPP
#define PROJECT_BASE_V1_1_TCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"
#include "../h/syscall_cpp.hpp"




// _thread po tekstu zadatka
class TCB
{
public:
    ~TCB() { mem_free(stack); }

    bool isFinished() const { return finished; }

    void setFinished() {finished = true;}

    using Body = void (*)(void*);

    static TCB *createThread(Body body, void* arg, void* stack);

    static void yield();

    int getPid() const;

    void setPid(int pid);

    static void dispatch();

    static int exit();

    void *getArg() const;

    void setArg(void *arg);


private:

    static uint64 constexpr STACK_SIZE = 1024;
    static uint64 constexpr TIME_SLICE = 2;

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    //ATRIBUTI KLASE
    Body body;
    void* arg;
    uint64* volatile stack;
    bool finished;
    int pid;
    Context context;

    static int ID;



    // konstruktor
private:
    explicit TCB(Body body, void* arg, uint64* stackS):
            body(body),
            arg(arg),
            finished(false)
    {
        //stack = body != nullptr ? (uint64*)mem_alloc(sizeof(uint64[STACK_SIZE])) : nullptr;
        if (body != nullptr)
        {
            stack = (uint64*)mem_alloc(STACK_SIZE * sizeof(uint64*));
            context = {(uint64) &threadWrapper,
                       (uint64) &stack[DEFAULT_STACK_SIZE]};

        }
        else
        {
            stack = nullptr;
            context = {0, 0};
        }
        if (body != nullptr) { Scheduler::put(this); }
        pid = ID++;
    }


public:
    static TCB* running;
    static TCB* main;


private:
    friend class Riscv;
    static void contextSwitch(Context *oldContext, Context *runningContext);
    static void threadWrapper();
};

#endif

