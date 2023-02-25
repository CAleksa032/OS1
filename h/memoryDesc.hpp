#ifndef PROJECT_BASE_V1_1_MEMORYDESC_HPP
#define PROJECT_BASE_V1_1_MEMORYDESC_HPP

#include "../lib/hw.h"

class MemoryDesc {
public:
    size_t size;
    MemoryDesc* next;

    MemoryDesc(MemoryDesc* next):next(next){}
};

MemoryDesc* insert(MemoryDesc* head, MemoryDesc* elem);

MemoryDesc* remove(MemoryDesc* head, MemoryDesc* elem);

MemoryDesc* connect(MemoryDesc* head, MemoryDesc* elem);


#endif
