//
// Created by os on 9/14/22.
//
#include "../h/memAllocator.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/tcb.hpp"
#include "../h/printing.hpp"

void *operator new(size_t size) {
    return mem_alloc(size);
}

void *operator new[](size_t size) {
    return mem_alloc(size);
}

void operator delete(void *tmp) {
    mem_free(tmp);
}

void operator delete[](void *tmp) {
    mem_free(tmp);
}




int Thread::start() {
    if(myHandle) return myHandle->getPid();
    else {
        return thread_create(&myHandle, &wrapper, this);
    }
}

void initThreads(){
    TCB::main=TCB::running=TCB::createThread(nullptr, nullptr, nullptr);
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::sleep(time_t) {
    return 0;
}

Thread::~Thread() {
    delete myHandle;
}

void Thread::join() {
    thread_join(&this->myHandle);
}





