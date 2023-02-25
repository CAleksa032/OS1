#include "../h/syscall_c.h"
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../h/printing.hpp"
#include "../h/memAllocator.hpp"
#include "../h/list.hpp"
extern void userMain();

void test(){
    //int* pok = (int*)mem_alloc(4);
    //pok++;

    int num_bytes = 100;
    void* allocated_memory = mem_alloc(num_bytes);
    printString("Allocated %d bytes of memory at address %p\n");
    print_addres(num_bytes);
    printString("\n");
    print_addres((uint64)allocated_memory);
    printString("\n");
    //printf("Allocated %d bytes of memory at address %p\n", num_bytes, allocated_memory);
    // Use the allocated memory for something
    for (int i = 0; i < num_bytes; i++) {
        *((char*)allocated_memory + i) = (char)i;
    }
    // Print the contents of the allocated memory
    printString("Allocated memory contents: ");
    for (int i = 0; i < num_bytes; i++) {
        print_addres(*((char*)allocated_memory + i));
        printString("\n");
        //printf("%d ", *((char*)allocated_memory + i));
    }
    printString("\n");
    int num_bytes2 = 70;
    void* allocated_memory2 = mem_alloc(num_bytes2);
    printString("Allocated %d bytes of memory at address %p\n");
    print_addres(num_bytes2);
    printString("\n");
    print_addres((uint64)allocated_memory2);
    printString("\n");
    for (int i = 0; i < num_bytes; i++) {
        *((char*)allocated_memory2 + i) = (char)(i + 10);
    }
    printString("Allocated memory contents: ");
    for (int i = 0; i < num_bytes2; i++) {
        print_addres(*((char*)allocated_memory2 + i));
        printString("\n");
        //printf("%d ", *((char*)allocated_memory + i));
    }
    printString("\n");
    // Free the allocated memory
    mem_free(allocated_memory2);
    mem_free(allocated_memory);
    *((char*)allocated_memory2 + 1) = (char)(10 + 10);
    printString("Freed allocated memory\n");
}
void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
        __putc('?');
        __putc('0' + x);
    }
    x++;
}

void checkStatus(int status) {
    static int y = 0;
    if(status) {
        __putc('0' + y);
        __putc('s');
    }
    y++;
}
void test2(){
    int velicinaZaglavlja = 64; // meni je ovoliko

    int *p1 = (int*)mem_alloc(15*sizeof(int)); // trebalo bi da predje jedan blok od 64
    checkNullptr(p1);
    int *p2 = (int*)mem_alloc(30*sizeof(int));
    checkNullptr(p2);

    int *p3 = (int*)mem_alloc(30*sizeof(int));
    checkNullptr(p3);

    checkStatus(mem_free(p1));
    checkStatus(mem_free(p3));
    checkStatus(mem_free(p2)); // p2 treba da se spoji sa p1 i p3

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    int *maxMemorija = (int*)mem_alloc(celaMemorija);
    checkNullptr(maxMemorija);

    checkStatus(mem_free(maxMemorija));
}

void test3(){
    int n = 10;
    char* niz = (char*)mem_alloc(10*sizeof(char));
    if(niz == nullptr) {
        __putc('?');
    }

    for(int i = 0; i < n; i++) {
        niz[i] = 'k';
    }

    for(int i = 0; i < n; i++) {
        __putc(niz[i]);
        __putc(' ');
    }

    int status = mem_free(niz);
    if(status != 0) {
        __putc('?');
    }
}

void test4(){
    int velicinaZaglavlja = 64; // meni je ovoliko

    const size_t maxMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    char* niz = (char*)mem_alloc(maxMemorija); // celokupan prostor
    if(niz == nullptr) {
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('k');
    }

    int status = mem_free(niz);
    if(status) {
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('?');
    }

}

void test5(){
    int n = 16;
    char** matrix = (char**)mem_alloc(n*sizeof(char*));
    checkNullptr(matrix);
    for(int i = 0; i < n; i++) {
        matrix[i] = (char *) mem_alloc(n * sizeof(char));
        checkNullptr(matrix[i]);
    }

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            matrix[i][j] = 'k';
        }
    }

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            __putc(matrix[i][j]);
            __putc(' ');
        }
        __putc('\n');
    }


    for(int i = 0; i < n; i++) {
        int status = mem_free(matrix[i]);
        checkStatus(status);
    }
    int status = mem_free(matrix);
    checkStatus(status);
}

void main()
{
    MemAllocator::memoryInit();
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
    user_mode();
    //test5();
    TCB::main=TCB::running=TCB::createThread(nullptr, nullptr, nullptr);
    userMain();

}
