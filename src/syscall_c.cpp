//
// Created by os on 9/14/22.
//

#include "../h/syscall_c.h"
#include "../h/printing.hpp"
void *mem_alloc(size_t size) {
    if(!size)return nullptr;
    __asm__ volatile ("mv a1, %0" : : "r" (size));
    __asm__ volatile ("mv a0, %0" : : "r" (0x01));
    __asm__ volatile ("ecall");
    uint64 volatile ret = 0;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return (void*)ret;
}

int mem_free(void* tmp) {
    if (!tmp) { return 0; }
    uint64 volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (tmp));
    __asm__ volatile ("mv a0, %0" : : "r" (0x02));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    tmp = nullptr;
    if(ret == 0)return 0;
    return -1;
}

void callRoutine(){

}

int thread_create(thread_t* handle, void (*start_routine)(void *), void *arg) {
    void* stack = mem_alloc(DEFAULT_STACK_SIZE);
    __asm__ volatile ("mv a1, %0" : : "r" ((uint64)handle));
    __asm__ volatile ("mv a2, %0" : : "r" ((uint64)start_routine));
    __asm__ volatile ("mv a3, %0" : : "r" ((uint64)arg));
    __asm__ volatile ("mv a0, %0" : : "r" (0x11));
    __asm__ volatile ("mv a4, %0" : : "r" ((uint64)stack));
    __asm__ volatile ("ecall");
    uint64* volatile ret = nullptr;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    //*handle = (thread_t)ret;


    if(ret == nullptr)return 0;
    return -1;
}

int thread_exit() {
    __asm__ volatile ("mv a0, %0" : : "r" (0x12));
    __asm__ volatile ("ecall");
    uint64 ret = 0;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    if(ret == 0)return 0;
    return -1;
}

void thread_dispatch() {
    __asm__ volatile ("mv a0, %0" : : "r" (0x13));
    __asm__ volatile ("ecall");

}

char getc() {
    __asm__ volatile ("mv a0, %0" : : "r" (0x41));
    __asm__ volatile ("ecall");
    uint64 ret=0;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return (char)ret;
}

void putc(char c) {
    __asm__ volatile ("mv a1, %0" : : "r" ((uint64)c));
    __asm__ volatile ("mv a0, %0" : : "r" (0x42));

    __asm__ volatile ("ecall");

}

void user_mode(){

    __asm__ volatile ("mv a0, %0" : : "r" (0x43));

    __asm__ volatile ("ecall");

    __asm__ volatile ("mv a0, %0" : : "r" (0x00));


}

void thread_join(thread_t* t){
    __asm__ volatile("mv a1,%0": : "r"(t));
    __asm__ volatile ("mv a0, %0" : : "r" (0x44));
    __asm__ volatile ("ecall");
    int i = 0;
    i = i+5;
}

