//
// Created by marko on 20.4.22..
//
#include "../lib/mem.h"
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"

void Riscv::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra");
    ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    uint64 arg[5];
    __asm__ volatile ("mv %0, a0" : "=r" (arg[0]));
    __asm__ volatile ("mv %0, a1" : "=r" (arg[1]));
    __asm__ volatile ("mv %0, a2" : "=r" (arg[2]));
    __asm__ volatile ("mv %0, a3" : "=r" (arg[3]));
    __asm__ volatile ("mv %0, a4" : "=r" (arg[4]));

    //promenjljiva u kojoj se cuva povratna vrednost
    uint64 ret = 0;
    TCB* t;
    //ecall iz korisnickog rezima ili iz privilegovanog
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL )
    {
        //obradjuje kod operacije
        switch(arg[0]){
            //mem alloc
            case 0x01UL:
                ret = (uint64)MemAllocator::alloc((uint64)arg[1]);
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
                break;
            //mem free
            case 0x02UL:
                ret = (uint64)MemAllocator::freeMem((void*)arg[1]);
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
                break;

            //thread exit
            case 0x12UL:
                ret = (uint64)TCB::exit();
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
                break;
            //dispatch
            case 0x13UL:
                uint64 volatile sepc,sstatus;
                __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
                __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
                TCB::dispatch();
                __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
                __asm__ volatile ("csrw  sepc, %[sepc]" : : [sepc] "r"(sepc));
                break;
            //getc
            case 0x41UL:
                arg[0]=(uint64)__getc();
                __asm__ volatile ("mv a0, %[ime]" : : [ime] "r"(arg[0]));
                break;
            //putc
            case 0x42:
                __putc((char)arg[1]);
                break;
            case 0x43:
                __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(1UL << 8));
                break;
            //join
            case 0x44UL:
                uint64 volatile sepc3,sstatus3;
                t = (TCB*)arg[1];
                t = (TCB*)t->body;
                while(!t->finished){
                    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc3));
                    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus3));
                    TCB::dispatch();
                    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus3));
                    __asm__ volatile ("csrw  sepc, %[sepc]" : : [sepc] "r"(sepc3));
                }

                break;
                //create thread
            case 0x11UL:
                uint64 sepc2;
                __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc2));
                TCB* ret2 = TCB::createThread((void(*)(void*))arg[2],(void*)arg[3],(void*)arg[4]);
                __asm__ volatile ("csrw sepc, %[ime]" : : [ime] "r"(sepc2));
                thread_t* tmp = (thread_t*)arg[1];
                *tmp = ret2;

                if(ret2){
                    __asm__ volatile ("mv a0, %0" : : "r" (ret2));
                }else{
                    __asm__ volatile ("mv a0, %0" : : "r" (0));
                }
                break;
        }
        uint64  volatile sepc = r_sepc();
        w_sepc(sepc+4);
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000001UL)
    {
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        __asm __volatile("csrc sip, 0x02");
    }
    else
    {
        __asm __volatile("csrc sip, 0x02");
    }
    console_handler();
}