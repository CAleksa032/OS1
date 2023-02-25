#include "../h/memAllocator.hpp"
#include "../lib/console.h"

MemoryDesc *MemAllocator::freeSpace = nullptr;

MemoryDesc *MemAllocator::usedSpace = nullptr;

void MemAllocator::memoryInit() {
    //pokazivac se inicijalizuje na pocetak heap-a
    freeSpace = (MemoryDesc *) HEAP_START_ADDR;
    MemoryDesc *tmp = freeSpace;

    //dodeljivanje celog memorijskog prostora
    tmp->size = (size_t) ((char *) HEAP_END_ADDR - (char *) HEAP_START_ADDR - MEM_BLOCK_SIZE);
    tmp->next = nullptr;
}

void *MemAllocator::alloc(size_t alSize) {
    alSize = (alSize % MEM_BLOCK_SIZE == 0) ? alSize : (alSize / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;

    MemoryDesc *tmp = freeSpace;
    while (tmp) {
        if (tmp->size == alSize + MEM_BLOCK_SIZE) {
            freeSpace= remove(freeSpace, tmp);
            usedSpace = insert(usedSpace, tmp);
            return (void *) ((char *) (tmp) + MEM_BLOCK_SIZE);
        } else if (tmp->size > alSize + MEM_BLOCK_SIZE) { // ako ima previse radi se kracenje
            freeSpace = remove(freeSpace, tmp);

            MemoryDesc *unusedSpace = (MemoryDesc *) ((char *) tmp + MEM_BLOCK_SIZE + alSize);
            //if(tmp->size)
            unusedSpace->size = (tmp->size - alSize - MEM_BLOCK_SIZE);
            unusedSpace->next = nullptr;


            tmp->size = alSize + MEM_BLOCK_SIZE;
            freeSpace = insert(freeSpace, unusedSpace);
            usedSpace = insert(usedSpace, tmp);
            return (void *) ((char *) (tmp) + MEM_BLOCK_SIZE);
        }

        tmp = tmp->next;
    }

    // nema segmenta, alokacija nije moguca
    return nullptr;
}


int MemAllocator::freeMem(void *toFree) {
    if (!toFree)return -1;

    MemoryDesc *tmp = (MemoryDesc*)((char*)(toFree) - MEM_BLOCK_SIZE);

    // skloni segment iz okupiranih, ubaci u slobodne i squash-uj
    usedSpace = remove(usedSpace, tmp);
    freeSpace = insert(freeSpace, tmp);
    freeSpace = connect(freeSpace,tmp);

    return 0;
}


