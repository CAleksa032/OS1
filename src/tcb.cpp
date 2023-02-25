#include "../h/tcb.hpp"
#include "../h/riscv.hpp"
#include "../h/printing.hpp"


//inicijalizacija statickih polja
TCB* TCB::running;
TCB *TCB::main;
int TCB::ID = 1;


TCB* TCB::createThread(Body body, void* arg, void* stack)
{
    return new TCB(body, arg, (uint64*)stack);
}

void TCB::yield()
{
    __asm__ volatile ("ecall");
}

void TCB::dispatch()
{
    TCB *old = running;
    if (old!= nullptr && !old->isFinished()) { Scheduler::put(old); }
    TCB *newT = running = Scheduler::get();


    TCB::contextSwitch(&old->context, &newT->context);
}

void TCB::threadWrapper()
{
    Riscv::popSppSpie();
    running->body(running->getArg());
    running->setFinished();
    TCB::dispatch();
}

int TCB::exit() {
    if (running == main) return -1;
    TCB *newThr = Scheduler::get();
    if(newThr) {
        TCB* old=running;
        //old->setFinished(true);
        TCB::contextSwitch(&old->context, &newThr->context);
        mem_free(old->stack); //da li ce se ikad vratiti ovde
    }
    return 0;
}

int TCB::getPid() const {
    return pid;
}

void TCB::setPid(int pid) {
    TCB::pid = pid;
}

void *TCB::getArg() const {
    return arg;
}

void TCB::setArg(void *arg) {
    TCB::arg = arg;
}

