//
// Created by os on 9/14/22.
//

#ifndef PROJECT_BASE_V1_1_MEMALLOCATOR_HPP
#define PROJECT_BASE_V1_1_MEMALLOCATOR_HPP

#include "../lib/hw.h"
#include "memoryDesc.hpp"

class MemAllocator {
public:
    // lista slobodne i zauzete memorije
    static MemoryDesc *freeSpace;
    static MemoryDesc *usedSpace;

    static void memoryInit();

    static void* alloc(size_t);

    static int freeMem(void*);


};


#endif //PROJECT_BASE_V1_1_MEMALLOCATOR_HPP




