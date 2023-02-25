//
// Created by os on 9/14/22.
//

#include "../h/memoryDesc.hpp"


MemoryDesc* insert(MemoryDesc *head, MemoryDesc *elem) {
    //ako je elem null izlazi
    if (!elem)return nullptr;

    //ako nema head-a
    if (!(head)) {
        elem->next = nullptr;
        head = elem;

        return head;
    }

    //ako elem dolazi na prvo mesto
    if (elem < head) {
        elem->next = head;
        head = elem;
        return head;
    }

    //ako elem dolazi na mesto u sredini
    MemoryDesc *tmp = head;
    while (tmp->next) {
        if (tmp->next > elem) {
            elem->next = tmp->next;
            tmp->next = elem;
            return head;
        }
        tmp = tmp->next;
    }

    //ako elem ide na kraj
    tmp->next = elem;
    elem->next = nullptr;

    return head;

}

MemoryDesc* remove(MemoryDesc *head, MemoryDesc *elem) {
    // ako lista ili elem vrate null
    if ((!(head)) || !elem) return nullptr;


    // ako je elem na pocetku liste
    if (head == elem) {
        head = (head)->next;
        elem->next = nullptr;
        return head;
    }

    // ako je na bilo kom drugom mestu
    MemoryDesc *tmp = head;
    while (tmp->next) {
        if (tmp->next == elem) {
            tmp->next = elem->next;
            elem->next = nullptr;
            return head;
        }
        tmp = tmp->next;
    }
    return head;
}

MemoryDesc* connect(MemoryDesc *head, MemoryDesc *elem) {
    //provera regularnosti head, elem
    if ((!(head)) || !elem) return nullptr;

    //u slucaju da je element head
    if(elem == head){
        if((head)->next && (((char*)(head) + (head)->size + MEM_BLOCK_SIZE) >= (char*)((head)->next))){
            (head)->size = (head)->size + (head)->next->size + MEM_BLOCK_SIZE;
            (head)->next = (head)->next->next;
        // nsiam siguran koja od ove dve linije treba da bude prva
        }
        return head;
    }

    //dovodjenje pokazivaca na element pre elem ako postoji
    MemoryDesc* tmp = head;
    while (tmp->next) {
        if (tmp->next == elem) {
            break;
        }
        tmp = tmp->next;
    }

    //pokazivac na mestu pre pokusava da se spoji sa elem, a zatim elem sa narednim ako postoji
    while(tmp->next){
        if (tmp->next && (((char *) tmp + tmp->size + MEM_BLOCK_SIZE) >= (char *) (tmp->next))) {
            tmp->size = tmp->size + tmp->next->size + MEM_BLOCK_SIZE;
            tmp->next = tmp->next->next;
            continue;
        }
        tmp = tmp->next;
        if(!tmp) break;
    }
    return head;
}
