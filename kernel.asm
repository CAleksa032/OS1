
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	30813103          	ld	sp,776(sp) # 80007308 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3a0030ef          	jal	ra,800033bc <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	4a5010ef          	jal	ra,80002d48 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05813583          	ld	a1,88(sp)
    800010d4:	06013603          	ld	a2,96(sp)
    800010d8:	06813683          	ld	a3,104(sp)
    800010dc:	07013703          	ld	a4,112(sp)
    800010e0:	07813783          	ld	a5,120(sp)
    800010e4:	08013803          	ld	a6,128(sp)
    800010e8:	08813883          	ld	a7,136(sp)
    800010ec:	09013903          	ld	s2,144(sp)
    800010f0:	09813983          	ld	s3,152(sp)
    800010f4:	0a013a03          	ld	s4,160(sp)
    800010f8:	0a813a83          	ld	s5,168(sp)
    800010fc:	0b013b03          	ld	s6,176(sp)
    80001100:	0b813b83          	ld	s7,184(sp)
    80001104:	0c013c03          	ld	s8,192(sp)
    80001108:	0c813c83          	ld	s9,200(sp)
    8000110c:	0d013d03          	ld	s10,208(sp)
    80001110:	0d813d83          	ld	s11,216(sp)
    80001114:	0e013e03          	ld	t3,224(sp)
    80001118:	0e813e83          	ld	t4,232(sp)
    8000111c:	0f013f03          	ld	t5,240(sp)
    80001120:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001124:	10010113          	addi	sp,sp,256

    80001128:	10200073          	sret
    8000112c:	0000                	unimp
	...

0000000080001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <mem_alloc>:
//

#include "../h/syscall_c.h"
#include "../h/printing.hpp"
void *mem_alloc(size_t size) {
    if(!size)return nullptr;
    80001144:	02050e63          	beqz	a0,80001180 <mem_alloc+0x3c>
void *mem_alloc(size_t size) {
    80001148:	fe010113          	addi	sp,sp,-32
    8000114c:	00813c23          	sd	s0,24(sp)
    80001150:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0" : : "r" (size));
    80001154:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (0x01));
    80001158:	00100793          	li	a5,1
    8000115c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001160:	00000073          	ecall
    uint64 volatile ret = 0;
    80001164:	fe043423          	sd	zero,-24(s0)
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001168:	00050793          	mv	a5,a0
    8000116c:	fef43423          	sd	a5,-24(s0)
    return (void*)ret;
    80001170:	fe843503          	ld	a0,-24(s0)
}
    80001174:	01813403          	ld	s0,24(sp)
    80001178:	02010113          	addi	sp,sp,32
    8000117c:	00008067          	ret
    if(!size)return nullptr;
    80001180:	00000513          	li	a0,0
}
    80001184:	00008067          	ret

0000000080001188 <mem_free>:

int mem_free(void* tmp) {
    if (!tmp) { return 0; }
    80001188:	04050663          	beqz	a0,800011d4 <mem_free+0x4c>
int mem_free(void* tmp) {
    8000118c:	fe010113          	addi	sp,sp,-32
    80001190:	00813c23          	sd	s0,24(sp)
    80001194:	02010413          	addi	s0,sp,32
    uint64 volatile ret = 0;
    80001198:	fe043423          	sd	zero,-24(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (tmp));
    8000119c:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (0x02));
    800011a0:	00200793          	li	a5,2
    800011a4:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800011a8:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    800011ac:	00050793          	mv	a5,a0
    800011b0:	fef43423          	sd	a5,-24(s0)
    tmp = nullptr;
    if(ret == 0)return 0;
    800011b4:	fe843783          	ld	a5,-24(s0)
    800011b8:	00079a63          	bnez	a5,800011cc <mem_free+0x44>
    800011bc:	00000513          	li	a0,0
    return -1;
}
    800011c0:	01813403          	ld	s0,24(sp)
    800011c4:	02010113          	addi	sp,sp,32
    800011c8:	00008067          	ret
    return -1;
    800011cc:	fff00513          	li	a0,-1
    800011d0:	ff1ff06f          	j	800011c0 <mem_free+0x38>
    if (!tmp) { return 0; }
    800011d4:	00000513          	li	a0,0
}
    800011d8:	00008067          	ret

00000000800011dc <_Z11callRoutinev>:

void callRoutine(){
    800011dc:	ff010113          	addi	sp,sp,-16
    800011e0:	00813423          	sd	s0,8(sp)
    800011e4:	01010413          	addi	s0,sp,16

}
    800011e8:	00813403          	ld	s0,8(sp)
    800011ec:	01010113          	addi	sp,sp,16
    800011f0:	00008067          	ret

00000000800011f4 <thread_create>:

int thread_create(thread_t* handle, void (*start_routine)(void *), void *arg) {
    800011f4:	fc010113          	addi	sp,sp,-64
    800011f8:	02113c23          	sd	ra,56(sp)
    800011fc:	02813823          	sd	s0,48(sp)
    80001200:	02913423          	sd	s1,40(sp)
    80001204:	03213023          	sd	s2,32(sp)
    80001208:	01313c23          	sd	s3,24(sp)
    8000120c:	04010413          	addi	s0,sp,64
    80001210:	00050993          	mv	s3,a0
    80001214:	00058913          	mv	s2,a1
    80001218:	00060493          	mv	s1,a2
    void* stack = mem_alloc(DEFAULT_STACK_SIZE);
    8000121c:	00001537          	lui	a0,0x1
    80001220:	00000097          	auipc	ra,0x0
    80001224:	f24080e7          	jalr	-220(ra) # 80001144 <mem_alloc>
    __asm__ volatile ("mv a1, %0" : : "r" ((uint64)handle));
    80001228:	00098593          	mv	a1,s3
    __asm__ volatile ("mv a2, %0" : : "r" ((uint64)start_routine));
    8000122c:	00090613          	mv	a2,s2
    __asm__ volatile ("mv a3, %0" : : "r" ((uint64)arg));
    80001230:	00048693          	mv	a3,s1
    __asm__ volatile ("mv a0, %0" : : "r" (0x11));
    80001234:	01100793          	li	a5,17
    80001238:	00078513          	mv	a0,a5
    __asm__ volatile ("mv a4, %0" : : "r" ((uint64)stack));
    8000123c:	00050713          	mv	a4,a0
    __asm__ volatile ("ecall");
    80001240:	00000073          	ecall
    uint64* volatile ret = nullptr;
    80001244:	fc043423          	sd	zero,-56(s0)
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001248:	00050793          	mv	a5,a0
    8000124c:	fcf43423          	sd	a5,-56(s0)
    //*handle = (thread_t)ret;


    if(ret == nullptr)return 0;
    80001250:	fc843783          	ld	a5,-56(s0)
    80001254:	02079263          	bnez	a5,80001278 <thread_create+0x84>
    80001258:	00000513          	li	a0,0
    return -1;
}
    8000125c:	03813083          	ld	ra,56(sp)
    80001260:	03013403          	ld	s0,48(sp)
    80001264:	02813483          	ld	s1,40(sp)
    80001268:	02013903          	ld	s2,32(sp)
    8000126c:	01813983          	ld	s3,24(sp)
    80001270:	04010113          	addi	sp,sp,64
    80001274:	00008067          	ret
    return -1;
    80001278:	fff00513          	li	a0,-1
    8000127c:	fe1ff06f          	j	8000125c <thread_create+0x68>

0000000080001280 <thread_exit>:

int thread_exit() {
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a0, %0" : : "r" (0x12));
    8000128c:	01200793          	li	a5,18
    80001290:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001294:	00000073          	ecall
    uint64 ret = 0;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001298:	00050793          	mv	a5,a0
    if(ret == 0)return 0;
    8000129c:	00079a63          	bnez	a5,800012b0 <thread_exit+0x30>
    800012a0:	00000513          	li	a0,0
    return -1;
}
    800012a4:	00813403          	ld	s0,8(sp)
    800012a8:	01010113          	addi	sp,sp,16
    800012ac:	00008067          	ret
    return -1;
    800012b0:	fff00513          	li	a0,-1
    800012b4:	ff1ff06f          	j	800012a4 <thread_exit+0x24>

00000000800012b8 <thread_dispatch>:

void thread_dispatch() {
    800012b8:	ff010113          	addi	sp,sp,-16
    800012bc:	00813423          	sd	s0,8(sp)
    800012c0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a0, %0" : : "r" (0x13));
    800012c4:	01300793          	li	a5,19
    800012c8:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800012cc:	00000073          	ecall

}
    800012d0:	00813403          	ld	s0,8(sp)
    800012d4:	01010113          	addi	sp,sp,16
    800012d8:	00008067          	ret

00000000800012dc <getc>:

char getc() {
    800012dc:	ff010113          	addi	sp,sp,-16
    800012e0:	00813423          	sd	s0,8(sp)
    800012e4:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a0, %0" : : "r" (0x41));
    800012e8:	04100793          	li	a5,65
    800012ec:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800012f0:	00000073          	ecall
    uint64 ret=0;
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    800012f4:	00050513          	mv	a0,a0
    return (char)ret;
}
    800012f8:	0ff57513          	andi	a0,a0,255
    800012fc:	00813403          	ld	s0,8(sp)
    80001300:	01010113          	addi	sp,sp,16
    80001304:	00008067          	ret

0000000080001308 <putc>:

void putc(char c) {
    80001308:	ff010113          	addi	sp,sp,-16
    8000130c:	00813423          	sd	s0,8(sp)
    80001310:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0" : : "r" ((uint64)c));
    80001314:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (0x42));
    80001318:	04200793          	li	a5,66
    8000131c:	00078513          	mv	a0,a5

    __asm__ volatile ("ecall");
    80001320:	00000073          	ecall

}
    80001324:	00813403          	ld	s0,8(sp)
    80001328:	01010113          	addi	sp,sp,16
    8000132c:	00008067          	ret

0000000080001330 <user_mode>:

void user_mode(){
    80001330:	ff010113          	addi	sp,sp,-16
    80001334:	00813423          	sd	s0,8(sp)
    80001338:	01010413          	addi	s0,sp,16

    __asm__ volatile ("mv a0, %0" : : "r" (0x43));
    8000133c:	04300793          	li	a5,67
    80001340:	00078513          	mv	a0,a5

    __asm__ volatile ("ecall");
    80001344:	00000073          	ecall

    __asm__ volatile ("mv a0, %0" : : "r" (0x00));
    80001348:	00000793          	li	a5,0
    8000134c:	00078513          	mv	a0,a5


}
    80001350:	00813403          	ld	s0,8(sp)
    80001354:	01010113          	addi	sp,sp,16
    80001358:	00008067          	ret

000000008000135c <thread_join>:

void thread_join(thread_t* t){
    8000135c:	ff010113          	addi	sp,sp,-16
    80001360:	00813423          	sd	s0,8(sp)
    80001364:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a1,%0": : "r"(t));
    80001368:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (0x44));
    8000136c:	04400793          	li	a5,68
    80001370:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001374:	00000073          	ecall
    int i = 0;
    i = i+5;
}
    80001378:	00813403          	ld	s0,8(sp)
    8000137c:	01010113          	addi	sp,sp,16
    80001380:	00008067          	ret

0000000080001384 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001384:	fe010113          	addi	sp,sp,-32
    80001388:	00113c23          	sd	ra,24(sp)
    8000138c:	00813823          	sd	s0,16(sp)
    80001390:	00913423          	sd	s1,8(sp)
    80001394:	02010413          	addi	s0,sp,32
    80001398:	00050493          	mv	s1,a0
    LOCK();
    8000139c:	00100613          	li	a2,1
    800013a0:	00000593          	li	a1,0
    800013a4:	00006517          	auipc	a0,0x6
    800013a8:	fcc50513          	addi	a0,a0,-52 # 80007370 <lockPrint>
    800013ac:	00000097          	auipc	ra,0x0
    800013b0:	c54080e7          	jalr	-940(ra) # 80001000 <copy_and_swap>
    800013b4:	fe0514e3          	bnez	a0,8000139c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800013b8:	0004c503          	lbu	a0,0(s1)
    800013bc:	00050a63          	beqz	a0,800013d0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800013c0:	00000097          	auipc	ra,0x0
    800013c4:	f48080e7          	jalr	-184(ra) # 80001308 <putc>
        string++;
    800013c8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800013cc:	fedff06f          	j	800013b8 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800013d0:	00000613          	li	a2,0
    800013d4:	00100593          	li	a1,1
    800013d8:	00006517          	auipc	a0,0x6
    800013dc:	f9850513          	addi	a0,a0,-104 # 80007370 <lockPrint>
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	c20080e7          	jalr	-992(ra) # 80001000 <copy_and_swap>
    800013e8:	fe0514e3          	bnez	a0,800013d0 <_Z11printStringPKc+0x4c>
}
    800013ec:	01813083          	ld	ra,24(sp)
    800013f0:	01013403          	ld	s0,16(sp)
    800013f4:	00813483          	ld	s1,8(sp)
    800013f8:	02010113          	addi	sp,sp,32
    800013fc:	00008067          	ret

0000000080001400 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001400:	fd010113          	addi	sp,sp,-48
    80001404:	02113423          	sd	ra,40(sp)
    80001408:	02813023          	sd	s0,32(sp)
    8000140c:	00913c23          	sd	s1,24(sp)
    80001410:	01213823          	sd	s2,16(sp)
    80001414:	01313423          	sd	s3,8(sp)
    80001418:	01413023          	sd	s4,0(sp)
    8000141c:	03010413          	addi	s0,sp,48
    80001420:	00050993          	mv	s3,a0
    80001424:	00058a13          	mv	s4,a1
    LOCK();
    80001428:	00100613          	li	a2,1
    8000142c:	00000593          	li	a1,0
    80001430:	00006517          	auipc	a0,0x6
    80001434:	f4050513          	addi	a0,a0,-192 # 80007370 <lockPrint>
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	bc8080e7          	jalr	-1080(ra) # 80001000 <copy_and_swap>
    80001440:	fe0514e3          	bnez	a0,80001428 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001444:	00000913          	li	s2,0
    80001448:	00090493          	mv	s1,s2
    8000144c:	0019091b          	addiw	s2,s2,1
    80001450:	03495a63          	bge	s2,s4,80001484 <_Z9getStringPci+0x84>
        cc = getc();
    80001454:	00000097          	auipc	ra,0x0
    80001458:	e88080e7          	jalr	-376(ra) # 800012dc <getc>
        if(cc < 1)
    8000145c:	02050463          	beqz	a0,80001484 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80001460:	009984b3          	add	s1,s3,s1
    80001464:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001468:	00a00793          	li	a5,10
    8000146c:	00f50a63          	beq	a0,a5,80001480 <_Z9getStringPci+0x80>
    80001470:	00d00793          	li	a5,13
    80001474:	fcf51ae3          	bne	a0,a5,80001448 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80001478:	00090493          	mv	s1,s2
    8000147c:	0080006f          	j	80001484 <_Z9getStringPci+0x84>
    80001480:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001484:	009984b3          	add	s1,s3,s1
    80001488:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000148c:	00000613          	li	a2,0
    80001490:	00100593          	li	a1,1
    80001494:	00006517          	auipc	a0,0x6
    80001498:	edc50513          	addi	a0,a0,-292 # 80007370 <lockPrint>
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	b64080e7          	jalr	-1180(ra) # 80001000 <copy_and_swap>
    800014a4:	fe0514e3          	bnez	a0,8000148c <_Z9getStringPci+0x8c>
    return buf;
}
    800014a8:	00098513          	mv	a0,s3
    800014ac:	02813083          	ld	ra,40(sp)
    800014b0:	02013403          	ld	s0,32(sp)
    800014b4:	01813483          	ld	s1,24(sp)
    800014b8:	01013903          	ld	s2,16(sp)
    800014bc:	00813983          	ld	s3,8(sp)
    800014c0:	00013a03          	ld	s4,0(sp)
    800014c4:	03010113          	addi	sp,sp,48
    800014c8:	00008067          	ret

00000000800014cc <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800014cc:	ff010113          	addi	sp,sp,-16
    800014d0:	00813423          	sd	s0,8(sp)
    800014d4:	01010413          	addi	s0,sp,16
    800014d8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800014dc:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800014e0:	0006c603          	lbu	a2,0(a3)
    800014e4:	fd06071b          	addiw	a4,a2,-48
    800014e8:	0ff77713          	andi	a4,a4,255
    800014ec:	00900793          	li	a5,9
    800014f0:	02e7e063          	bltu	a5,a4,80001510 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800014f4:	0025179b          	slliw	a5,a0,0x2
    800014f8:	00a787bb          	addw	a5,a5,a0
    800014fc:	0017979b          	slliw	a5,a5,0x1
    80001500:	00168693          	addi	a3,a3,1
    80001504:	00c787bb          	addw	a5,a5,a2
    80001508:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000150c:	fd5ff06f          	j	800014e0 <_Z11stringToIntPKc+0x14>
    return n;
}
    80001510:	00813403          	ld	s0,8(sp)
    80001514:	01010113          	addi	sp,sp,16
    80001518:	00008067          	ret

000000008000151c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000151c:	fc010113          	addi	sp,sp,-64
    80001520:	02113c23          	sd	ra,56(sp)
    80001524:	02813823          	sd	s0,48(sp)
    80001528:	02913423          	sd	s1,40(sp)
    8000152c:	03213023          	sd	s2,32(sp)
    80001530:	01313c23          	sd	s3,24(sp)
    80001534:	04010413          	addi	s0,sp,64
    80001538:	00050493          	mv	s1,a0
    8000153c:	00058913          	mv	s2,a1
    80001540:	00060993          	mv	s3,a2
    LOCK();
    80001544:	00100613          	li	a2,1
    80001548:	00000593          	li	a1,0
    8000154c:	00006517          	auipc	a0,0x6
    80001550:	e2450513          	addi	a0,a0,-476 # 80007370 <lockPrint>
    80001554:	00000097          	auipc	ra,0x0
    80001558:	aac080e7          	jalr	-1364(ra) # 80001000 <copy_and_swap>
    8000155c:	fe0514e3          	bnez	a0,80001544 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001560:	00098463          	beqz	s3,80001568 <_Z8printIntiii+0x4c>
    80001564:	0804c463          	bltz	s1,800015ec <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001568:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000156c:	00000593          	li	a1,0
    }

    i = 0;
    80001570:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001574:	0009079b          	sext.w	a5,s2
    80001578:	0325773b          	remuw	a4,a0,s2
    8000157c:	00048613          	mv	a2,s1
    80001580:	0014849b          	addiw	s1,s1,1
    80001584:	02071693          	slli	a3,a4,0x20
    80001588:	0206d693          	srli	a3,a3,0x20
    8000158c:	00006717          	auipc	a4,0x6
    80001590:	c7470713          	addi	a4,a4,-908 # 80007200 <digits>
    80001594:	00d70733          	add	a4,a4,a3
    80001598:	00074683          	lbu	a3,0(a4)
    8000159c:	fd040713          	addi	a4,s0,-48
    800015a0:	00c70733          	add	a4,a4,a2
    800015a4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800015a8:	0005071b          	sext.w	a4,a0
    800015ac:	0325553b          	divuw	a0,a0,s2
    800015b0:	fcf772e3          	bgeu	a4,a5,80001574 <_Z8printIntiii+0x58>
    if(neg)
    800015b4:	00058c63          	beqz	a1,800015cc <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800015b8:	fd040793          	addi	a5,s0,-48
    800015bc:	009784b3          	add	s1,a5,s1
    800015c0:	02d00793          	li	a5,45
    800015c4:	fef48823          	sb	a5,-16(s1)
    800015c8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800015cc:	fff4849b          	addiw	s1,s1,-1
    800015d0:	0204c463          	bltz	s1,800015f8 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    800015d4:	fd040793          	addi	a5,s0,-48
    800015d8:	009787b3          	add	a5,a5,s1
    800015dc:	ff07c503          	lbu	a0,-16(a5)
    800015e0:	00000097          	auipc	ra,0x0
    800015e4:	d28080e7          	jalr	-728(ra) # 80001308 <putc>
    800015e8:	fe5ff06f          	j	800015cc <_Z8printIntiii+0xb0>
        x = -xx;
    800015ec:	4090053b          	negw	a0,s1
        neg = 1;
    800015f0:	00100593          	li	a1,1
        x = -xx;
    800015f4:	f7dff06f          	j	80001570 <_Z8printIntiii+0x54>

    UNLOCK();
    800015f8:	00000613          	li	a2,0
    800015fc:	00100593          	li	a1,1
    80001600:	00006517          	auipc	a0,0x6
    80001604:	d7050513          	addi	a0,a0,-656 # 80007370 <lockPrint>
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	9f8080e7          	jalr	-1544(ra) # 80001000 <copy_and_swap>
    80001610:	fe0514e3          	bnez	a0,800015f8 <_Z8printIntiii+0xdc>
}
    80001614:	03813083          	ld	ra,56(sp)
    80001618:	03013403          	ld	s0,48(sp)
    8000161c:	02813483          	ld	s1,40(sp)
    80001620:	02013903          	ld	s2,32(sp)
    80001624:	01813983          	ld	s3,24(sp)
    80001628:	04010113          	addi	sp,sp,64
    8000162c:	00008067          	ret

0000000080001630 <_Z12print_addresm>:

void print_addres(uint64 num){
    80001630:	fc010113          	addi	sp,sp,-64
    80001634:	02113c23          	sd	ra,56(sp)
    80001638:	02813823          	sd	s0,48(sp)
    8000163c:	02913423          	sd	s1,40(sp)
    80001640:	03213023          	sd	s2,32(sp)
    80001644:	04010413          	addi	s0,sp,64
    80001648:	00050913          	mv	s2,a0
    LOCK();
    8000164c:	00100613          	li	a2,1
    80001650:	00000593          	li	a1,0
    80001654:	00006517          	auipc	a0,0x6
    80001658:	d1c50513          	addi	a0,a0,-740 # 80007370 <lockPrint>
    8000165c:	00000097          	auipc	ra,0x0
    80001660:	9a4080e7          	jalr	-1628(ra) # 80001000 <copy_and_swap>
    80001664:	fe0514e3          	bnez	a0,8000164c <_Z12print_addresm+0x1c>
    if(num == 0){
    80001668:	02090863          	beqz	s2,80001698 <_Z12print_addresm+0x68>
        UNLOCK();
        return;
    }

    char buffer[20];
    int i = 0;
    8000166c:	00000493          	li	s1,0
    while (num > 0){
    80001670:	04090a63          	beqz	s2,800016c4 <_Z12print_addresm+0x94>
        buffer[i++] = (num % 10) + '0';
    80001674:	00a00713          	li	a4,10
    80001678:	02e977b3          	remu	a5,s2,a4
    8000167c:	03078793          	addi	a5,a5,48
    80001680:	fe040693          	addi	a3,s0,-32
    80001684:	009686b3          	add	a3,a3,s1
    80001688:	fef68423          	sb	a5,-24(a3)
        num /= 10;
    8000168c:	02e95933          	divu	s2,s2,a4
        buffer[i++] = (num % 10) + '0';
    80001690:	0014849b          	addiw	s1,s1,1
    while (num > 0){
    80001694:	fddff06f          	j	80001670 <_Z12print_addresm+0x40>
        putc('0');
    80001698:	03000513          	li	a0,48
    8000169c:	00000097          	auipc	ra,0x0
    800016a0:	c6c080e7          	jalr	-916(ra) # 80001308 <putc>
        UNLOCK();
    800016a4:	00000613          	li	a2,0
    800016a8:	00100593          	li	a1,1
    800016ac:	00006517          	auipc	a0,0x6
    800016b0:	cc450513          	addi	a0,a0,-828 # 80007370 <lockPrint>
    800016b4:	00000097          	auipc	ra,0x0
    800016b8:	94c080e7          	jalr	-1716(ra) # 80001000 <copy_and_swap>
    800016bc:	fe0514e3          	bnez	a0,800016a4 <_Z12print_addresm+0x74>
    800016c0:	0400006f          	j	80001700 <_Z12print_addresm+0xd0>
    }
    while(i > 0) {
    800016c4:	02905063          	blez	s1,800016e4 <_Z12print_addresm+0xb4>
        putc(buffer[--i]);
    800016c8:	fff4849b          	addiw	s1,s1,-1
    800016cc:	fe040793          	addi	a5,s0,-32
    800016d0:	009787b3          	add	a5,a5,s1
    800016d4:	fe87c503          	lbu	a0,-24(a5)
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	c30080e7          	jalr	-976(ra) # 80001308 <putc>
    800016e0:	fe5ff06f          	j	800016c4 <_Z12print_addresm+0x94>
    }
    UNLOCK();
    800016e4:	00000613          	li	a2,0
    800016e8:	00100593          	li	a1,1
    800016ec:	00006517          	auipc	a0,0x6
    800016f0:	c8450513          	addi	a0,a0,-892 # 80007370 <lockPrint>
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	90c080e7          	jalr	-1780(ra) # 80001000 <copy_and_swap>
    800016fc:	fe0514e3          	bnez	a0,800016e4 <_Z12print_addresm+0xb4>
    80001700:	03813083          	ld	ra,56(sp)
    80001704:	03013403          	ld	s0,48(sp)
    80001708:	02813483          	ld	s1,40(sp)
    8000170c:	02013903          	ld	s2,32(sp)
    80001710:	04010113          	addi	sp,sp,64
    80001714:	00008067          	ret

0000000080001718 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    80001718:	fe010113          	addi	sp,sp,-32
    8000171c:	00113c23          	sd	ra,24(sp)
    80001720:	00813823          	sd	s0,16(sp)
    80001724:	00913423          	sd	s1,8(sp)
    80001728:	01213023          	sd	s2,0(sp)
    8000172c:	02010413          	addi	s0,sp,32
    80001730:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001734:	00100793          	li	a5,1
    80001738:	02a7f863          	bgeu	a5,a0,80001768 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000173c:	00a00793          	li	a5,10
    80001740:	02f577b3          	remu	a5,a0,a5
    80001744:	02078e63          	beqz	a5,80001780 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001748:	fff48513          	addi	a0,s1,-1
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	fcc080e7          	jalr	-52(ra) # 80001718 <_Z9fibonaccim>
    80001754:	00050913          	mv	s2,a0
    80001758:	ffe48513          	addi	a0,s1,-2
    8000175c:	00000097          	auipc	ra,0x0
    80001760:	fbc080e7          	jalr	-68(ra) # 80001718 <_Z9fibonaccim>
    80001764:	00a90533          	add	a0,s2,a0
}
    80001768:	01813083          	ld	ra,24(sp)
    8000176c:	01013403          	ld	s0,16(sp)
    80001770:	00813483          	ld	s1,8(sp)
    80001774:	00013903          	ld	s2,0(sp)
    80001778:	02010113          	addi	sp,sp,32
    8000177c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001780:	00000097          	auipc	ra,0x0
    80001784:	b38080e7          	jalr	-1224(ra) # 800012b8 <thread_dispatch>
    80001788:	fc1ff06f          	j	80001748 <_Z9fibonaccim+0x30>

000000008000178c <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    8000178c:	fe010113          	addi	sp,sp,-32
    80001790:	00113c23          	sd	ra,24(sp)
    80001794:	00813823          	sd	s0,16(sp)
    80001798:	00913423          	sd	s1,8(sp)
    8000179c:	01213023          	sd	s2,0(sp)
    800017a0:	02010413          	addi	s0,sp,32
    threads[2]->join();
    800017a4:	00006517          	auipc	a0,0x6
    800017a8:	be453503          	ld	a0,-1052(a0) # 80007388 <threads+0x10>
    800017ac:	00001097          	auipc	ra,0x1
    800017b0:	4fc080e7          	jalr	1276(ra) # 80002ca8 <_ZN6Thread4joinEv>
    for (uint64 i = 0; i < 10; i++) {
    800017b4:	00000913          	li	s2,0
    800017b8:	0380006f          	j	800017f0 <_ZN7WorkerA11workerBodyAEPv+0x64>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800017bc:	00000097          	auipc	ra,0x0
    800017c0:	afc080e7          	jalr	-1284(ra) # 800012b8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    800017c4:	00148493          	addi	s1,s1,1
    800017c8:	000027b7          	lui	a5,0x2
    800017cc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800017d0:	0097ee63          	bltu	a5,s1,800017ec <_ZN7WorkerA11workerBodyAEPv+0x60>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800017d4:	00000713          	li	a4,0
    800017d8:	000077b7          	lui	a5,0x7
    800017dc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800017e0:	fce7eee3          	bltu	a5,a4,800017bc <_ZN7WorkerA11workerBodyAEPv+0x30>
    800017e4:	00170713          	addi	a4,a4,1
    800017e8:	ff1ff06f          	j	800017d8 <_ZN7WorkerA11workerBodyAEPv+0x4c>
    for (uint64 i = 0; i < 10; i++) {
    800017ec:	00190913          	addi	s2,s2,1
    800017f0:	00900793          	li	a5,9
    800017f4:	0527e063          	bltu	a5,s2,80001834 <_ZN7WorkerA11workerBodyAEPv+0xa8>
        printString("A: i="); printInt(i); printString("\n");
    800017f8:	00005517          	auipc	a0,0x5
    800017fc:	82850513          	addi	a0,a0,-2008 # 80006020 <CONSOLE_STATUS+0x10>
    80001800:	00000097          	auipc	ra,0x0
    80001804:	b84080e7          	jalr	-1148(ra) # 80001384 <_Z11printStringPKc>
    80001808:	00000613          	li	a2,0
    8000180c:	00a00593          	li	a1,10
    80001810:	0009051b          	sext.w	a0,s2
    80001814:	00000097          	auipc	ra,0x0
    80001818:	d08080e7          	jalr	-760(ra) # 8000151c <_Z8printIntiii>
    8000181c:	00005517          	auipc	a0,0x5
    80001820:	b9c50513          	addi	a0,a0,-1124 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001824:	00000097          	auipc	ra,0x0
    80001828:	b60080e7          	jalr	-1184(ra) # 80001384 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000182c:	00000493          	li	s1,0
    80001830:	f99ff06f          	j	800017c8 <_ZN7WorkerA11workerBodyAEPv+0x3c>
        }
    }

    printString("A finished!\n");
    80001834:	00004517          	auipc	a0,0x4
    80001838:	7f450513          	addi	a0,a0,2036 # 80006028 <CONSOLE_STATUS+0x18>
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	b48080e7          	jalr	-1208(ra) # 80001384 <_Z11printStringPKc>
    finishedA = true;
    80001844:	00100793          	li	a5,1
    80001848:	00006717          	auipc	a4,0x6
    8000184c:	b4f70823          	sb	a5,-1200(a4) # 80007398 <finishedA>
}
    80001850:	01813083          	ld	ra,24(sp)
    80001854:	01013403          	ld	s0,16(sp)
    80001858:	00813483          	ld	s1,8(sp)
    8000185c:	00013903          	ld	s2,0(sp)
    80001860:	02010113          	addi	sp,sp,32
    80001864:	00008067          	ret

0000000080001868 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001868:	fe010113          	addi	sp,sp,-32
    8000186c:	00113c23          	sd	ra,24(sp)
    80001870:	00813823          	sd	s0,16(sp)
    80001874:	00913423          	sd	s1,8(sp)
    80001878:	01213023          	sd	s2,0(sp)
    8000187c:	02010413          	addi	s0,sp,32
    threads[0]->join();
    80001880:	00006517          	auipc	a0,0x6
    80001884:	af853503          	ld	a0,-1288(a0) # 80007378 <threads>
    80001888:	00001097          	auipc	ra,0x1
    8000188c:	420080e7          	jalr	1056(ra) # 80002ca8 <_ZN6Thread4joinEv>
    for (uint64 i = 0; i < 16; i++) {
    80001890:	00000913          	li	s2,0
    80001894:	0380006f          	j	800018cc <_ZN7WorkerB11workerBodyBEPv+0x64>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	a20080e7          	jalr	-1504(ra) # 800012b8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    800018a0:	00148493          	addi	s1,s1,1
    800018a4:	000027b7          	lui	a5,0x2
    800018a8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800018ac:	0097ee63          	bltu	a5,s1,800018c8 <_ZN7WorkerB11workerBodyBEPv+0x60>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800018b0:	00000713          	li	a4,0
    800018b4:	000077b7          	lui	a5,0x7
    800018b8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800018bc:	fce7eee3          	bltu	a5,a4,80001898 <_ZN7WorkerB11workerBodyBEPv+0x30>
    800018c0:	00170713          	addi	a4,a4,1
    800018c4:	ff1ff06f          	j	800018b4 <_ZN7WorkerB11workerBodyBEPv+0x4c>
    for (uint64 i = 0; i < 16; i++) {
    800018c8:	00190913          	addi	s2,s2,1
    800018cc:	00f00793          	li	a5,15
    800018d0:	0527e063          	bltu	a5,s2,80001910 <_ZN7WorkerB11workerBodyBEPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800018d4:	00004517          	auipc	a0,0x4
    800018d8:	76450513          	addi	a0,a0,1892 # 80006038 <CONSOLE_STATUS+0x28>
    800018dc:	00000097          	auipc	ra,0x0
    800018e0:	aa8080e7          	jalr	-1368(ra) # 80001384 <_Z11printStringPKc>
    800018e4:	00000613          	li	a2,0
    800018e8:	00a00593          	li	a1,10
    800018ec:	0009051b          	sext.w	a0,s2
    800018f0:	00000097          	auipc	ra,0x0
    800018f4:	c2c080e7          	jalr	-980(ra) # 8000151c <_Z8printIntiii>
    800018f8:	00005517          	auipc	a0,0x5
    800018fc:	ac050513          	addi	a0,a0,-1344 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001900:	00000097          	auipc	ra,0x0
    80001904:	a84080e7          	jalr	-1404(ra) # 80001384 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001908:	00000493          	li	s1,0
    8000190c:	f99ff06f          	j	800018a4 <_ZN7WorkerB11workerBodyBEPv+0x3c>
        }
    }
    printString("B finished!\n");
    80001910:	00004517          	auipc	a0,0x4
    80001914:	73050513          	addi	a0,a0,1840 # 80006040 <CONSOLE_STATUS+0x30>
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	a6c080e7          	jalr	-1428(ra) # 80001384 <_Z11printStringPKc>
    finishedB = true;
    80001920:	00100793          	li	a5,1
    80001924:	00006717          	auipc	a4,0x6
    80001928:	a6f70aa3          	sb	a5,-1419(a4) # 80007399 <finishedB>
    thread_dispatch();
    8000192c:	00000097          	auipc	ra,0x0
    80001930:	98c080e7          	jalr	-1652(ra) # 800012b8 <thread_dispatch>
}
    80001934:	01813083          	ld	ra,24(sp)
    80001938:	01013403          	ld	s0,16(sp)
    8000193c:	00813483          	ld	s1,8(sp)
    80001940:	00013903          	ld	s2,0(sp)
    80001944:	02010113          	addi	sp,sp,32
    80001948:	00008067          	ret

000000008000194c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    8000194c:	fe010113          	addi	sp,sp,-32
    80001950:	00113c23          	sd	ra,24(sp)
    80001954:	00813823          	sd	s0,16(sp)
    80001958:	00913423          	sd	s1,8(sp)
    8000195c:	01213023          	sd	s2,0(sp)
    80001960:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001964:	00000493          	li	s1,0
    80001968:	0400006f          	j	800019a8 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000196c:	00004517          	auipc	a0,0x4
    80001970:	6e450513          	addi	a0,a0,1764 # 80006050 <CONSOLE_STATUS+0x40>
    80001974:	00000097          	auipc	ra,0x0
    80001978:	a10080e7          	jalr	-1520(ra) # 80001384 <_Z11printStringPKc>
    8000197c:	00000613          	li	a2,0
    80001980:	00a00593          	li	a1,10
    80001984:	00048513          	mv	a0,s1
    80001988:	00000097          	auipc	ra,0x0
    8000198c:	b94080e7          	jalr	-1132(ra) # 8000151c <_Z8printIntiii>
    80001990:	00005517          	auipc	a0,0x5
    80001994:	a2850513          	addi	a0,a0,-1496 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001998:	00000097          	auipc	ra,0x0
    8000199c:	9ec080e7          	jalr	-1556(ra) # 80001384 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800019a0:	0014849b          	addiw	s1,s1,1
    800019a4:	0ff4f493          	andi	s1,s1,255
    800019a8:	00200793          	li	a5,2
    800019ac:	fc97f0e3          	bgeu	a5,s1,8000196c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800019b0:	00004517          	auipc	a0,0x4
    800019b4:	6a850513          	addi	a0,a0,1704 # 80006058 <CONSOLE_STATUS+0x48>
    800019b8:	00000097          	auipc	ra,0x0
    800019bc:	9cc080e7          	jalr	-1588(ra) # 80001384 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800019c0:	00700313          	li	t1,7
    thread_dispatch();
    800019c4:	00000097          	auipc	ra,0x0
    800019c8:	8f4080e7          	jalr	-1804(ra) # 800012b8 <thread_dispatch>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800019cc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800019d0:	00004517          	auipc	a0,0x4
    800019d4:	69850513          	addi	a0,a0,1688 # 80006068 <CONSOLE_STATUS+0x58>
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	9ac080e7          	jalr	-1620(ra) # 80001384 <_Z11printStringPKc>
    800019e0:	00000613          	li	a2,0
    800019e4:	00a00593          	li	a1,10
    800019e8:	0009051b          	sext.w	a0,s2
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	b30080e7          	jalr	-1232(ra) # 8000151c <_Z8printIntiii>
    800019f4:	00005517          	auipc	a0,0x5
    800019f8:	9c450513          	addi	a0,a0,-1596 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	988080e7          	jalr	-1656(ra) # 80001384 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001a04:	00c00513          	li	a0,12
    80001a08:	00000097          	auipc	ra,0x0
    80001a0c:	d10080e7          	jalr	-752(ra) # 80001718 <_Z9fibonaccim>
    80001a10:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001a14:	00004517          	auipc	a0,0x4
    80001a18:	65c50513          	addi	a0,a0,1628 # 80006070 <CONSOLE_STATUS+0x60>
    80001a1c:	00000097          	auipc	ra,0x0
    80001a20:	968080e7          	jalr	-1688(ra) # 80001384 <_Z11printStringPKc>
    80001a24:	00000613          	li	a2,0
    80001a28:	00a00593          	li	a1,10
    80001a2c:	0009051b          	sext.w	a0,s2
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	aec080e7          	jalr	-1300(ra) # 8000151c <_Z8printIntiii>
    80001a38:	00005517          	auipc	a0,0x5
    80001a3c:	98050513          	addi	a0,a0,-1664 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	944080e7          	jalr	-1724(ra) # 80001384 <_Z11printStringPKc>
    80001a48:	0400006f          	j	80001a88 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001a4c:	00004517          	auipc	a0,0x4
    80001a50:	60450513          	addi	a0,a0,1540 # 80006050 <CONSOLE_STATUS+0x40>
    80001a54:	00000097          	auipc	ra,0x0
    80001a58:	930080e7          	jalr	-1744(ra) # 80001384 <_Z11printStringPKc>
    80001a5c:	00000613          	li	a2,0
    80001a60:	00a00593          	li	a1,10
    80001a64:	00048513          	mv	a0,s1
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	ab4080e7          	jalr	-1356(ra) # 8000151c <_Z8printIntiii>
    80001a70:	00005517          	auipc	a0,0x5
    80001a74:	94850513          	addi	a0,a0,-1720 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	90c080e7          	jalr	-1780(ra) # 80001384 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001a80:	0014849b          	addiw	s1,s1,1
    80001a84:	0ff4f493          	andi	s1,s1,255
    80001a88:	00500793          	li	a5,5
    80001a8c:	fc97f0e3          	bgeu	a5,s1,80001a4c <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    80001a90:	00004517          	auipc	a0,0x4
    80001a94:	5f050513          	addi	a0,a0,1520 # 80006080 <CONSOLE_STATUS+0x70>
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	8ec080e7          	jalr	-1812(ra) # 80001384 <_Z11printStringPKc>
    finishedC = true;
    80001aa0:	00100793          	li	a5,1
    80001aa4:	00006717          	auipc	a4,0x6
    80001aa8:	8ef70b23          	sb	a5,-1802(a4) # 8000739a <finishedC>
    //thread_dispatch();
}
    80001aac:	01813083          	ld	ra,24(sp)
    80001ab0:	01013403          	ld	s0,16(sp)
    80001ab4:	00813483          	ld	s1,8(sp)
    80001ab8:	00013903          	ld	s2,0(sp)
    80001abc:	02010113          	addi	sp,sp,32
    80001ac0:	00008067          	ret

0000000080001ac4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80001ac4:	fe010113          	addi	sp,sp,-32
    80001ac8:	00113c23          	sd	ra,24(sp)
    80001acc:	00813823          	sd	s0,16(sp)
    80001ad0:	00913423          	sd	s1,8(sp)
    80001ad4:	01213023          	sd	s2,0(sp)
    80001ad8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001adc:	00a00493          	li	s1,10
    80001ae0:	0400006f          	j	80001b20 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001ae4:	00004517          	auipc	a0,0x4
    80001ae8:	5ac50513          	addi	a0,a0,1452 # 80006090 <CONSOLE_STATUS+0x80>
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	898080e7          	jalr	-1896(ra) # 80001384 <_Z11printStringPKc>
    80001af4:	00000613          	li	a2,0
    80001af8:	00a00593          	li	a1,10
    80001afc:	00048513          	mv	a0,s1
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	a1c080e7          	jalr	-1508(ra) # 8000151c <_Z8printIntiii>
    80001b08:	00005517          	auipc	a0,0x5
    80001b0c:	8b050513          	addi	a0,a0,-1872 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001b10:	00000097          	auipc	ra,0x0
    80001b14:	874080e7          	jalr	-1932(ra) # 80001384 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001b18:	0014849b          	addiw	s1,s1,1
    80001b1c:	0ff4f493          	andi	s1,s1,255
    80001b20:	00c00793          	li	a5,12
    80001b24:	fc97f0e3          	bgeu	a5,s1,80001ae4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80001b28:	00004517          	auipc	a0,0x4
    80001b2c:	57050513          	addi	a0,a0,1392 # 80006098 <CONSOLE_STATUS+0x88>
    80001b30:	00000097          	auipc	ra,0x0
    80001b34:	854080e7          	jalr	-1964(ra) # 80001384 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001b38:	00500313          	li	t1,5
    thread_dispatch();
    80001b3c:	fffff097          	auipc	ra,0xfffff
    80001b40:	77c080e7          	jalr	1916(ra) # 800012b8 <thread_dispatch>

    uint64 result = fibonacci(16);
    80001b44:	01000513          	li	a0,16
    80001b48:	00000097          	auipc	ra,0x0
    80001b4c:	bd0080e7          	jalr	-1072(ra) # 80001718 <_Z9fibonaccim>
    80001b50:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001b54:	00004517          	auipc	a0,0x4
    80001b58:	55450513          	addi	a0,a0,1364 # 800060a8 <CONSOLE_STATUS+0x98>
    80001b5c:	00000097          	auipc	ra,0x0
    80001b60:	828080e7          	jalr	-2008(ra) # 80001384 <_Z11printStringPKc>
    80001b64:	00000613          	li	a2,0
    80001b68:	00a00593          	li	a1,10
    80001b6c:	0009051b          	sext.w	a0,s2
    80001b70:	00000097          	auipc	ra,0x0
    80001b74:	9ac080e7          	jalr	-1620(ra) # 8000151c <_Z8printIntiii>
    80001b78:	00005517          	auipc	a0,0x5
    80001b7c:	84050513          	addi	a0,a0,-1984 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	804080e7          	jalr	-2044(ra) # 80001384 <_Z11printStringPKc>
    80001b88:	0400006f          	j	80001bc8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001b8c:	00004517          	auipc	a0,0x4
    80001b90:	50450513          	addi	a0,a0,1284 # 80006090 <CONSOLE_STATUS+0x80>
    80001b94:	fffff097          	auipc	ra,0xfffff
    80001b98:	7f0080e7          	jalr	2032(ra) # 80001384 <_Z11printStringPKc>
    80001b9c:	00000613          	li	a2,0
    80001ba0:	00a00593          	li	a1,10
    80001ba4:	00048513          	mv	a0,s1
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	974080e7          	jalr	-1676(ra) # 8000151c <_Z8printIntiii>
    80001bb0:	00005517          	auipc	a0,0x5
    80001bb4:	80850513          	addi	a0,a0,-2040 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80001bb8:	fffff097          	auipc	ra,0xfffff
    80001bbc:	7cc080e7          	jalr	1996(ra) # 80001384 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001bc0:	0014849b          	addiw	s1,s1,1
    80001bc4:	0ff4f493          	andi	s1,s1,255
    80001bc8:	00f00793          	li	a5,15
    80001bcc:	fc97f0e3          	bgeu	a5,s1,80001b8c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80001bd0:	00004517          	auipc	a0,0x4
    80001bd4:	4e850513          	addi	a0,a0,1256 # 800060b8 <CONSOLE_STATUS+0xa8>
    80001bd8:	fffff097          	auipc	ra,0xfffff
    80001bdc:	7ac080e7          	jalr	1964(ra) # 80001384 <_Z11printStringPKc>
    finishedD = true;
    80001be0:	00100793          	li	a5,1
    80001be4:	00005717          	auipc	a4,0x5
    80001be8:	7af70ba3          	sb	a5,1975(a4) # 8000739b <finishedD>
    thread_dispatch();
    80001bec:	fffff097          	auipc	ra,0xfffff
    80001bf0:	6cc080e7          	jalr	1740(ra) # 800012b8 <thread_dispatch>
}
    80001bf4:	01813083          	ld	ra,24(sp)
    80001bf8:	01013403          	ld	s0,16(sp)
    80001bfc:	00813483          	ld	s1,8(sp)
    80001c00:	00013903          	ld	s2,0(sp)
    80001c04:	02010113          	addi	sp,sp,32
    80001c08:	00008067          	ret

0000000080001c0c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80001c0c:	fe010113          	addi	sp,sp,-32
    80001c10:	00113c23          	sd	ra,24(sp)
    80001c14:	00813823          	sd	s0,16(sp)
    80001c18:	00913423          	sd	s1,8(sp)
    80001c1c:	02010413          	addi	s0,sp,32


    threads[0] = new WorkerA();
    80001c20:	01000513          	li	a0,16
    80001c24:	00001097          	auipc	ra,0x1
    80001c28:	e74080e7          	jalr	-396(ra) # 80002a98 <_Znwm>
    int start ();
    static void dispatch ();
    static int sleep (time_t);
    void join();
protected:
    Thread (){myHandle = nullptr;}
    80001c2c:	00053423          	sd	zero,8(a0)
    WorkerA():Thread() {}
    80001c30:	00005797          	auipc	a5,0x5
    80001c34:	5f878793          	addi	a5,a5,1528 # 80007228 <_ZTV7WorkerA+0x10>
    80001c38:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80001c3c:	00005497          	auipc	s1,0x5
    80001c40:	73c48493          	addi	s1,s1,1852 # 80007378 <threads>
    80001c44:	00a4b023          	sd	a0,0(s1)
    printString("ThreadA created\n");
    80001c48:	00004517          	auipc	a0,0x4
    80001c4c:	48050513          	addi	a0,a0,1152 # 800060c8 <CONSOLE_STATUS+0xb8>
    80001c50:	fffff097          	auipc	ra,0xfffff
    80001c54:	734080e7          	jalr	1844(ra) # 80001384 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80001c58:	01000513          	li	a0,16
    80001c5c:	00001097          	auipc	ra,0x1
    80001c60:	e3c080e7          	jalr	-452(ra) # 80002a98 <_Znwm>
    80001c64:	00053423          	sd	zero,8(a0)
    WorkerB():Thread() {}
    80001c68:	00005797          	auipc	a5,0x5
    80001c6c:	5e878793          	addi	a5,a5,1512 # 80007250 <_ZTV7WorkerB+0x10>
    80001c70:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80001c74:	00a4b423          	sd	a0,8(s1)
    printString("ThreadB created\n");
    80001c78:	00004517          	auipc	a0,0x4
    80001c7c:	46850513          	addi	a0,a0,1128 # 800060e0 <CONSOLE_STATUS+0xd0>
    80001c80:	fffff097          	auipc	ra,0xfffff
    80001c84:	704080e7          	jalr	1796(ra) # 80001384 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80001c88:	01000513          	li	a0,16
    80001c8c:	00001097          	auipc	ra,0x1
    80001c90:	e0c080e7          	jalr	-500(ra) # 80002a98 <_Znwm>
    80001c94:	00053423          	sd	zero,8(a0)
    WorkerC():Thread() {}
    80001c98:	00005797          	auipc	a5,0x5
    80001c9c:	5e078793          	addi	a5,a5,1504 # 80007278 <_ZTV7WorkerC+0x10>
    80001ca0:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80001ca4:	00a4b823          	sd	a0,16(s1)
    printString("ThreadC created\n");
    80001ca8:	00004517          	auipc	a0,0x4
    80001cac:	45050513          	addi	a0,a0,1104 # 800060f8 <CONSOLE_STATUS+0xe8>
    80001cb0:	fffff097          	auipc	ra,0xfffff
    80001cb4:	6d4080e7          	jalr	1748(ra) # 80001384 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80001cb8:	01000513          	li	a0,16
    80001cbc:	00001097          	auipc	ra,0x1
    80001cc0:	ddc080e7          	jalr	-548(ra) # 80002a98 <_Znwm>
    80001cc4:	00053423          	sd	zero,8(a0)
    WorkerD():Thread() {}
    80001cc8:	00005797          	auipc	a5,0x5
    80001ccc:	5d878793          	addi	a5,a5,1496 # 800072a0 <_ZTV7WorkerD+0x10>
    80001cd0:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80001cd4:	00a4bc23          	sd	a0,24(s1)
    printString("ThreadD created\n");
    80001cd8:	00004517          	auipc	a0,0x4
    80001cdc:	43850513          	addi	a0,a0,1080 # 80006110 <CONSOLE_STATUS+0x100>
    80001ce0:	fffff097          	auipc	ra,0xfffff
    80001ce4:	6a4080e7          	jalr	1700(ra) # 80001384 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80001ce8:	00000493          	li	s1,0
    80001cec:	00300793          	li	a5,3
    80001cf0:	0297c863          	blt	a5,s1,80001d20 <_Z20Threads_CPP_API_testv+0x114>
        threads[i]->start();
    80001cf4:	00349713          	slli	a4,s1,0x3
    80001cf8:	00005797          	auipc	a5,0x5
    80001cfc:	68078793          	addi	a5,a5,1664 # 80007378 <threads>
    80001d00:	00e787b3          	add	a5,a5,a4
    80001d04:	0007b503          	ld	a0,0(a5)
    80001d08:	00001097          	auipc	ra,0x1
    80001d0c:	ec4080e7          	jalr	-316(ra) # 80002bcc <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80001d10:	0014849b          	addiw	s1,s1,1
    80001d14:	fd9ff06f          	j	80001cec <_Z20Threads_CPP_API_testv+0xe0>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80001d18:	00001097          	auipc	ra,0x1
    80001d1c:	f4c080e7          	jalr	-180(ra) # 80002c64 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80001d20:	00005797          	auipc	a5,0x5
    80001d24:	6787c783          	lbu	a5,1656(a5) # 80007398 <finishedA>
    80001d28:	fe0788e3          	beqz	a5,80001d18 <_Z20Threads_CPP_API_testv+0x10c>
    80001d2c:	00005797          	auipc	a5,0x5
    80001d30:	66d7c783          	lbu	a5,1645(a5) # 80007399 <finishedB>
    80001d34:	fe0782e3          	beqz	a5,80001d18 <_Z20Threads_CPP_API_testv+0x10c>
    80001d38:	00005797          	auipc	a5,0x5
    80001d3c:	6627c783          	lbu	a5,1634(a5) # 8000739a <finishedC>
    80001d40:	fc078ce3          	beqz	a5,80001d18 <_Z20Threads_CPP_API_testv+0x10c>
    80001d44:	00005797          	auipc	a5,0x5
    80001d48:	6577c783          	lbu	a5,1623(a5) # 8000739b <finishedD>
    80001d4c:	fc0786e3          	beqz	a5,80001d18 <_Z20Threads_CPP_API_testv+0x10c>
    }

    for (auto thread: threads) { delete thread; }
    80001d50:	00005497          	auipc	s1,0x5
    80001d54:	62848493          	addi	s1,s1,1576 # 80007378 <threads>
    80001d58:	0080006f          	j	80001d60 <_Z20Threads_CPP_API_testv+0x154>
    80001d5c:	00848493          	addi	s1,s1,8
    80001d60:	00005797          	auipc	a5,0x5
    80001d64:	63878793          	addi	a5,a5,1592 # 80007398 <finishedA>
    80001d68:	00f48e63          	beq	s1,a5,80001d84 <_Z20Threads_CPP_API_testv+0x178>
    80001d6c:	0004b503          	ld	a0,0(s1)
    80001d70:	fe0506e3          	beqz	a0,80001d5c <_Z20Threads_CPP_API_testv+0x150>
    80001d74:	00053783          	ld	a5,0(a0)
    80001d78:	0087b783          	ld	a5,8(a5)
    80001d7c:	000780e7          	jalr	a5
    80001d80:	fddff06f          	j	80001d5c <_Z20Threads_CPP_API_testv+0x150>
}
    80001d84:	01813083          	ld	ra,24(sp)
    80001d88:	01013403          	ld	s0,16(sp)
    80001d8c:	00813483          	ld	s1,8(sp)
    80001d90:	02010113          	addi	sp,sp,32
    80001d94:	00008067          	ret

0000000080001d98 <_Z8userMainv>:

//#include "../test/ThreadSleep_C_API_test.hpp"
// thread_sleep test C API
//#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta

void userMain() {
    80001d98:	ff010113          	addi	sp,sp,-16
    80001d9c:	00113423          	sd	ra,8(sp)
    80001da0:	00813023          	sd	s0,0(sp)
    80001da4:	01010413          	addi	s0,sp,16
    //Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	e64080e7          	jalr	-412(ra) # 80001c0c <_Z20Threads_CPP_API_testv>
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80001db0:	00813083          	ld	ra,8(sp)
    80001db4:	00013403          	ld	s0,0(sp)
    80001db8:	01010113          	addi	sp,sp,16
    80001dbc:	00008067          	ret

0000000080001dc0 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80001dc0:	ff010113          	addi	sp,sp,-16
    80001dc4:	00113423          	sd	ra,8(sp)
    80001dc8:	00813023          	sd	s0,0(sp)
    80001dcc:	01010413          	addi	s0,sp,16
    80001dd0:	00005797          	auipc	a5,0x5
    80001dd4:	45878793          	addi	a5,a5,1112 # 80007228 <_ZTV7WorkerA+0x10>
    80001dd8:	00f53023          	sd	a5,0(a0)
    80001ddc:	00001097          	auipc	ra,0x1
    80001de0:	d34080e7          	jalr	-716(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001de4:	00813083          	ld	ra,8(sp)
    80001de8:	00013403          	ld	s0,0(sp)
    80001dec:	01010113          	addi	sp,sp,16
    80001df0:	00008067          	ret

0000000080001df4 <_ZN7WorkerAD0Ev>:
    80001df4:	fe010113          	addi	sp,sp,-32
    80001df8:	00113c23          	sd	ra,24(sp)
    80001dfc:	00813823          	sd	s0,16(sp)
    80001e00:	00913423          	sd	s1,8(sp)
    80001e04:	02010413          	addi	s0,sp,32
    80001e08:	00050493          	mv	s1,a0
    80001e0c:	00005797          	auipc	a5,0x5
    80001e10:	41c78793          	addi	a5,a5,1052 # 80007228 <_ZTV7WorkerA+0x10>
    80001e14:	00f53023          	sd	a5,0(a0)
    80001e18:	00001097          	auipc	ra,0x1
    80001e1c:	cf8080e7          	jalr	-776(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001e20:	00048513          	mv	a0,s1
    80001e24:	00001097          	auipc	ra,0x1
    80001e28:	cc4080e7          	jalr	-828(ra) # 80002ae8 <_ZdlPv>
    80001e2c:	01813083          	ld	ra,24(sp)
    80001e30:	01013403          	ld	s0,16(sp)
    80001e34:	00813483          	ld	s1,8(sp)
    80001e38:	02010113          	addi	sp,sp,32
    80001e3c:	00008067          	ret

0000000080001e40 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80001e40:	ff010113          	addi	sp,sp,-16
    80001e44:	00113423          	sd	ra,8(sp)
    80001e48:	00813023          	sd	s0,0(sp)
    80001e4c:	01010413          	addi	s0,sp,16
    80001e50:	00005797          	auipc	a5,0x5
    80001e54:	40078793          	addi	a5,a5,1024 # 80007250 <_ZTV7WorkerB+0x10>
    80001e58:	00f53023          	sd	a5,0(a0)
    80001e5c:	00001097          	auipc	ra,0x1
    80001e60:	cb4080e7          	jalr	-844(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001e64:	00813083          	ld	ra,8(sp)
    80001e68:	00013403          	ld	s0,0(sp)
    80001e6c:	01010113          	addi	sp,sp,16
    80001e70:	00008067          	ret

0000000080001e74 <_ZN7WorkerBD0Ev>:
    80001e74:	fe010113          	addi	sp,sp,-32
    80001e78:	00113c23          	sd	ra,24(sp)
    80001e7c:	00813823          	sd	s0,16(sp)
    80001e80:	00913423          	sd	s1,8(sp)
    80001e84:	02010413          	addi	s0,sp,32
    80001e88:	00050493          	mv	s1,a0
    80001e8c:	00005797          	auipc	a5,0x5
    80001e90:	3c478793          	addi	a5,a5,964 # 80007250 <_ZTV7WorkerB+0x10>
    80001e94:	00f53023          	sd	a5,0(a0)
    80001e98:	00001097          	auipc	ra,0x1
    80001e9c:	c78080e7          	jalr	-904(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001ea0:	00048513          	mv	a0,s1
    80001ea4:	00001097          	auipc	ra,0x1
    80001ea8:	c44080e7          	jalr	-956(ra) # 80002ae8 <_ZdlPv>
    80001eac:	01813083          	ld	ra,24(sp)
    80001eb0:	01013403          	ld	s0,16(sp)
    80001eb4:	00813483          	ld	s1,8(sp)
    80001eb8:	02010113          	addi	sp,sp,32
    80001ebc:	00008067          	ret

0000000080001ec0 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80001ec0:	ff010113          	addi	sp,sp,-16
    80001ec4:	00113423          	sd	ra,8(sp)
    80001ec8:	00813023          	sd	s0,0(sp)
    80001ecc:	01010413          	addi	s0,sp,16
    80001ed0:	00005797          	auipc	a5,0x5
    80001ed4:	3a878793          	addi	a5,a5,936 # 80007278 <_ZTV7WorkerC+0x10>
    80001ed8:	00f53023          	sd	a5,0(a0)
    80001edc:	00001097          	auipc	ra,0x1
    80001ee0:	c34080e7          	jalr	-972(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001ee4:	00813083          	ld	ra,8(sp)
    80001ee8:	00013403          	ld	s0,0(sp)
    80001eec:	01010113          	addi	sp,sp,16
    80001ef0:	00008067          	ret

0000000080001ef4 <_ZN7WorkerCD0Ev>:
    80001ef4:	fe010113          	addi	sp,sp,-32
    80001ef8:	00113c23          	sd	ra,24(sp)
    80001efc:	00813823          	sd	s0,16(sp)
    80001f00:	00913423          	sd	s1,8(sp)
    80001f04:	02010413          	addi	s0,sp,32
    80001f08:	00050493          	mv	s1,a0
    80001f0c:	00005797          	auipc	a5,0x5
    80001f10:	36c78793          	addi	a5,a5,876 # 80007278 <_ZTV7WorkerC+0x10>
    80001f14:	00f53023          	sd	a5,0(a0)
    80001f18:	00001097          	auipc	ra,0x1
    80001f1c:	bf8080e7          	jalr	-1032(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001f20:	00048513          	mv	a0,s1
    80001f24:	00001097          	auipc	ra,0x1
    80001f28:	bc4080e7          	jalr	-1084(ra) # 80002ae8 <_ZdlPv>
    80001f2c:	01813083          	ld	ra,24(sp)
    80001f30:	01013403          	ld	s0,16(sp)
    80001f34:	00813483          	ld	s1,8(sp)
    80001f38:	02010113          	addi	sp,sp,32
    80001f3c:	00008067          	ret

0000000080001f40 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80001f40:	ff010113          	addi	sp,sp,-16
    80001f44:	00113423          	sd	ra,8(sp)
    80001f48:	00813023          	sd	s0,0(sp)
    80001f4c:	01010413          	addi	s0,sp,16
    80001f50:	00005797          	auipc	a5,0x5
    80001f54:	35078793          	addi	a5,a5,848 # 800072a0 <_ZTV7WorkerD+0x10>
    80001f58:	00f53023          	sd	a5,0(a0)
    80001f5c:	00001097          	auipc	ra,0x1
    80001f60:	bb4080e7          	jalr	-1100(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001f64:	00813083          	ld	ra,8(sp)
    80001f68:	00013403          	ld	s0,0(sp)
    80001f6c:	01010113          	addi	sp,sp,16
    80001f70:	00008067          	ret

0000000080001f74 <_ZN7WorkerDD0Ev>:
    80001f74:	fe010113          	addi	sp,sp,-32
    80001f78:	00113c23          	sd	ra,24(sp)
    80001f7c:	00813823          	sd	s0,16(sp)
    80001f80:	00913423          	sd	s1,8(sp)
    80001f84:	02010413          	addi	s0,sp,32
    80001f88:	00050493          	mv	s1,a0
    80001f8c:	00005797          	auipc	a5,0x5
    80001f90:	31478793          	addi	a5,a5,788 # 800072a0 <_ZTV7WorkerD+0x10>
    80001f94:	00f53023          	sd	a5,0(a0)
    80001f98:	00001097          	auipc	ra,0x1
    80001f9c:	b78080e7          	jalr	-1160(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80001fa0:	00048513          	mv	a0,s1
    80001fa4:	00001097          	auipc	ra,0x1
    80001fa8:	b44080e7          	jalr	-1212(ra) # 80002ae8 <_ZdlPv>
    80001fac:	01813083          	ld	ra,24(sp)
    80001fb0:	01013403          	ld	s0,16(sp)
    80001fb4:	00813483          	ld	s1,8(sp)
    80001fb8:	02010113          	addi	sp,sp,32
    80001fbc:	00008067          	ret

0000000080001fc0 <_ZN7WorkerA3runEv>:
    void run() override {
    80001fc0:	ff010113          	addi	sp,sp,-16
    80001fc4:	00113423          	sd	ra,8(sp)
    80001fc8:	00813023          	sd	s0,0(sp)
    80001fcc:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80001fd0:	00000593          	li	a1,0
    80001fd4:	fffff097          	auipc	ra,0xfffff
    80001fd8:	7b8080e7          	jalr	1976(ra) # 8000178c <_ZN7WorkerA11workerBodyAEPv>
    }
    80001fdc:	00813083          	ld	ra,8(sp)
    80001fe0:	00013403          	ld	s0,0(sp)
    80001fe4:	01010113          	addi	sp,sp,16
    80001fe8:	00008067          	ret

0000000080001fec <_ZN7WorkerB3runEv>:
    void run() override {
    80001fec:	ff010113          	addi	sp,sp,-16
    80001ff0:	00113423          	sd	ra,8(sp)
    80001ff4:	00813023          	sd	s0,0(sp)
    80001ff8:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80001ffc:	00000593          	li	a1,0
    80002000:	00000097          	auipc	ra,0x0
    80002004:	868080e7          	jalr	-1944(ra) # 80001868 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002008:	00813083          	ld	ra,8(sp)
    8000200c:	00013403          	ld	s0,0(sp)
    80002010:	01010113          	addi	sp,sp,16
    80002014:	00008067          	ret

0000000080002018 <_ZN7WorkerC3runEv>:
    void run() override {
    80002018:	ff010113          	addi	sp,sp,-16
    8000201c:	00113423          	sd	ra,8(sp)
    80002020:	00813023          	sd	s0,0(sp)
    80002024:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002028:	00000593          	li	a1,0
    8000202c:	00000097          	auipc	ra,0x0
    80002030:	920080e7          	jalr	-1760(ra) # 8000194c <_ZN7WorkerC11workerBodyCEPv>
    }
    80002034:	00813083          	ld	ra,8(sp)
    80002038:	00013403          	ld	s0,0(sp)
    8000203c:	01010113          	addi	sp,sp,16
    80002040:	00008067          	ret

0000000080002044 <_ZN7WorkerD3runEv>:
    void run() override {
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00113423          	sd	ra,8(sp)
    8000204c:	00813023          	sd	s0,0(sp)
    80002050:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002054:	00000593          	li	a1,0
    80002058:	00000097          	auipc	ra,0x0
    8000205c:	a6c080e7          	jalr	-1428(ra) # 80001ac4 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002060:	00813083          	ld	ra,8(sp)
    80002064:	00013403          	ld	s0,0(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <_Z4testv>:
#include "../h/printing.hpp"
#include "../h/memAllocator.hpp"
#include "../h/list.hpp"
extern void userMain();

void test(){
    80002070:	fd010113          	addi	sp,sp,-48
    80002074:	02113423          	sd	ra,40(sp)
    80002078:	02813023          	sd	s0,32(sp)
    8000207c:	00913c23          	sd	s1,24(sp)
    80002080:	01213823          	sd	s2,16(sp)
    80002084:	01313423          	sd	s3,8(sp)
    80002088:	03010413          	addi	s0,sp,48
    //int* pok = (int*)mem_alloc(4);
    //pok++;

    int num_bytes = 100;
    void* allocated_memory = mem_alloc(num_bytes);
    8000208c:	06400513          	li	a0,100
    80002090:	fffff097          	auipc	ra,0xfffff
    80002094:	0b4080e7          	jalr	180(ra) # 80001144 <mem_alloc>
    80002098:	00050913          	mv	s2,a0
    printString("Allocated %d bytes of memory at address %p\n");
    8000209c:	00004517          	auipc	a0,0x4
    800020a0:	08c50513          	addi	a0,a0,140 # 80006128 <CONSOLE_STATUS+0x118>
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	2e0080e7          	jalr	736(ra) # 80001384 <_Z11printStringPKc>
    print_addres(num_bytes);
    800020ac:	06400513          	li	a0,100
    800020b0:	fffff097          	auipc	ra,0xfffff
    800020b4:	580080e7          	jalr	1408(ra) # 80001630 <_Z12print_addresm>
    printString("\n");
    800020b8:	00004517          	auipc	a0,0x4
    800020bc:	30050513          	addi	a0,a0,768 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	2c4080e7          	jalr	708(ra) # 80001384 <_Z11printStringPKc>
    print_addres((uint64)allocated_memory);
    800020c8:	00090513          	mv	a0,s2
    800020cc:	fffff097          	auipc	ra,0xfffff
    800020d0:	564080e7          	jalr	1380(ra) # 80001630 <_Z12print_addresm>
    printString("\n");
    800020d4:	00004517          	auipc	a0,0x4
    800020d8:	2e450513          	addi	a0,a0,740 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800020dc:	fffff097          	auipc	ra,0xfffff
    800020e0:	2a8080e7          	jalr	680(ra) # 80001384 <_Z11printStringPKc>
    //printf("Allocated %d bytes of memory at address %p\n", num_bytes, allocated_memory);
    // Use the allocated memory for something
    for (int i = 0; i < num_bytes; i++) {
    800020e4:	00000793          	li	a5,0
    800020e8:	06300713          	li	a4,99
    800020ec:	00f74a63          	blt	a4,a5,80002100 <_Z4testv+0x90>
        *((char*)allocated_memory + i) = (char)i;
    800020f0:	00f90733          	add	a4,s2,a5
    800020f4:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < num_bytes; i++) {
    800020f8:	0017879b          	addiw	a5,a5,1
    800020fc:	fedff06f          	j	800020e8 <_Z4testv+0x78>
    }
    // Print the contents of the allocated memory
    printString("Allocated memory contents: ");
    80002100:	00004517          	auipc	a0,0x4
    80002104:	05850513          	addi	a0,a0,88 # 80006158 <CONSOLE_STATUS+0x148>
    80002108:	fffff097          	auipc	ra,0xfffff
    8000210c:	27c080e7          	jalr	636(ra) # 80001384 <_Z11printStringPKc>
    for (int i = 0; i < num_bytes; i++) {
    80002110:	00000493          	li	s1,0
    80002114:	06300793          	li	a5,99
    80002118:	0297c663          	blt	a5,s1,80002144 <_Z4testv+0xd4>
        print_addres(*((char*)allocated_memory + i));
    8000211c:	009907b3          	add	a5,s2,s1
    80002120:	0007c503          	lbu	a0,0(a5)
    80002124:	fffff097          	auipc	ra,0xfffff
    80002128:	50c080e7          	jalr	1292(ra) # 80001630 <_Z12print_addresm>
        printString("\n");
    8000212c:	00004517          	auipc	a0,0x4
    80002130:	28c50513          	addi	a0,a0,652 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80002134:	fffff097          	auipc	ra,0xfffff
    80002138:	250080e7          	jalr	592(ra) # 80001384 <_Z11printStringPKc>
    for (int i = 0; i < num_bytes; i++) {
    8000213c:	0014849b          	addiw	s1,s1,1
    80002140:	fd5ff06f          	j	80002114 <_Z4testv+0xa4>
        //printf("%d ", *((char*)allocated_memory + i));
    }
    printString("\n");
    80002144:	00004517          	auipc	a0,0x4
    80002148:	27450513          	addi	a0,a0,628 # 800063b8 <CONSOLE_STATUS+0x3a8>
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	238080e7          	jalr	568(ra) # 80001384 <_Z11printStringPKc>
    int num_bytes2 = 70;
    void* allocated_memory2 = mem_alloc(num_bytes2);
    80002154:	04600513          	li	a0,70
    80002158:	fffff097          	auipc	ra,0xfffff
    8000215c:	fec080e7          	jalr	-20(ra) # 80001144 <mem_alloc>
    80002160:	00050993          	mv	s3,a0
    printString("Allocated %d bytes of memory at address %p\n");
    80002164:	00004517          	auipc	a0,0x4
    80002168:	fc450513          	addi	a0,a0,-60 # 80006128 <CONSOLE_STATUS+0x118>
    8000216c:	fffff097          	auipc	ra,0xfffff
    80002170:	218080e7          	jalr	536(ra) # 80001384 <_Z11printStringPKc>
    print_addres(num_bytes2);
    80002174:	04600513          	li	a0,70
    80002178:	fffff097          	auipc	ra,0xfffff
    8000217c:	4b8080e7          	jalr	1208(ra) # 80001630 <_Z12print_addresm>
    printString("\n");
    80002180:	00004517          	auipc	a0,0x4
    80002184:	23850513          	addi	a0,a0,568 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	1fc080e7          	jalr	508(ra) # 80001384 <_Z11printStringPKc>
    print_addres((uint64)allocated_memory2);
    80002190:	00098513          	mv	a0,s3
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	49c080e7          	jalr	1180(ra) # 80001630 <_Z12print_addresm>
    printString("\n");
    8000219c:	00004517          	auipc	a0,0x4
    800021a0:	21c50513          	addi	a0,a0,540 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800021a4:	fffff097          	auipc	ra,0xfffff
    800021a8:	1e0080e7          	jalr	480(ra) # 80001384 <_Z11printStringPKc>
    for (int i = 0; i < num_bytes; i++) {
    800021ac:	00000793          	li	a5,0
    800021b0:	06300713          	li	a4,99
    800021b4:	00f74c63          	blt	a4,a5,800021cc <_Z4testv+0x15c>
        *((char*)allocated_memory2 + i) = (char)(i + 10);
    800021b8:	00f98733          	add	a4,s3,a5
    800021bc:	00a7869b          	addiw	a3,a5,10
    800021c0:	00d70023          	sb	a3,0(a4)
    for (int i = 0; i < num_bytes; i++) {
    800021c4:	0017879b          	addiw	a5,a5,1
    800021c8:	fe9ff06f          	j	800021b0 <_Z4testv+0x140>
    }
    printString("Allocated memory contents: ");
    800021cc:	00004517          	auipc	a0,0x4
    800021d0:	f8c50513          	addi	a0,a0,-116 # 80006158 <CONSOLE_STATUS+0x148>
    800021d4:	fffff097          	auipc	ra,0xfffff
    800021d8:	1b0080e7          	jalr	432(ra) # 80001384 <_Z11printStringPKc>
    for (int i = 0; i < num_bytes2; i++) {
    800021dc:	00000493          	li	s1,0
    800021e0:	04500793          	li	a5,69
    800021e4:	0297c663          	blt	a5,s1,80002210 <_Z4testv+0x1a0>
        print_addres(*((char*)allocated_memory2 + i));
    800021e8:	009987b3          	add	a5,s3,s1
    800021ec:	0007c503          	lbu	a0,0(a5)
    800021f0:	fffff097          	auipc	ra,0xfffff
    800021f4:	440080e7          	jalr	1088(ra) # 80001630 <_Z12print_addresm>
        printString("\n");
    800021f8:	00004517          	auipc	a0,0x4
    800021fc:	1c050513          	addi	a0,a0,448 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	184080e7          	jalr	388(ra) # 80001384 <_Z11printStringPKc>
    for (int i = 0; i < num_bytes2; i++) {
    80002208:	0014849b          	addiw	s1,s1,1
    8000220c:	fd5ff06f          	j	800021e0 <_Z4testv+0x170>
        //printf("%d ", *((char*)allocated_memory + i));
    }
    printString("\n");
    80002210:	00004517          	auipc	a0,0x4
    80002214:	1a850513          	addi	a0,a0,424 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	16c080e7          	jalr	364(ra) # 80001384 <_Z11printStringPKc>
    // Free the allocated memory
    mem_free(allocated_memory2);
    80002220:	00098513          	mv	a0,s3
    80002224:	fffff097          	auipc	ra,0xfffff
    80002228:	f64080e7          	jalr	-156(ra) # 80001188 <mem_free>
    mem_free(allocated_memory);
    8000222c:	00090513          	mv	a0,s2
    80002230:	fffff097          	auipc	ra,0xfffff
    80002234:	f58080e7          	jalr	-168(ra) # 80001188 <mem_free>
    *((char*)allocated_memory2 + 1) = (char)(10 + 10);
    80002238:	01400793          	li	a5,20
    8000223c:	00f980a3          	sb	a5,1(s3)
    printString("Freed allocated memory\n");
    80002240:	00004517          	auipc	a0,0x4
    80002244:	f3850513          	addi	a0,a0,-200 # 80006178 <CONSOLE_STATUS+0x168>
    80002248:	fffff097          	auipc	ra,0xfffff
    8000224c:	13c080e7          	jalr	316(ra) # 80001384 <_Z11printStringPKc>
}
    80002250:	02813083          	ld	ra,40(sp)
    80002254:	02013403          	ld	s0,32(sp)
    80002258:	01813483          	ld	s1,24(sp)
    8000225c:	01013903          	ld	s2,16(sp)
    80002260:	00813983          	ld	s3,8(sp)
    80002264:	03010113          	addi	sp,sp,48
    80002268:	00008067          	ret

000000008000226c <_Z12checkNullptrPv>:
void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    8000226c:	00050e63          	beqz	a0,80002288 <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80002270:	00005717          	auipc	a4,0x5
    80002274:	12c70713          	addi	a4,a4,300 # 8000739c <_ZZ12checkNullptrPvE1x>
    80002278:	00072783          	lw	a5,0(a4)
    8000227c:	0017879b          	addiw	a5,a5,1
    80002280:	00f72023          	sw	a5,0(a4)
    80002284:	00008067          	ret
void checkNullptr(void* p) {
    80002288:	ff010113          	addi	sp,sp,-16
    8000228c:	00113423          	sd	ra,8(sp)
    80002290:	00813023          	sd	s0,0(sp)
    80002294:	01010413          	addi	s0,sp,16
        __putc('?');
    80002298:	03f00513          	li	a0,63
    8000229c:	00003097          	auipc	ra,0x3
    800022a0:	1e0080e7          	jalr	480(ra) # 8000547c <__putc>
        __putc('0' + x);
    800022a4:	00005517          	auipc	a0,0x5
    800022a8:	0f852503          	lw	a0,248(a0) # 8000739c <_ZZ12checkNullptrPvE1x>
    800022ac:	0305051b          	addiw	a0,a0,48
    800022b0:	0ff57513          	andi	a0,a0,255
    800022b4:	00003097          	auipc	ra,0x3
    800022b8:	1c8080e7          	jalr	456(ra) # 8000547c <__putc>
    x++;
    800022bc:	00005717          	auipc	a4,0x5
    800022c0:	0e070713          	addi	a4,a4,224 # 8000739c <_ZZ12checkNullptrPvE1x>
    800022c4:	00072783          	lw	a5,0(a4)
    800022c8:	0017879b          	addiw	a5,a5,1
    800022cc:	00f72023          	sw	a5,0(a4)
}
    800022d0:	00813083          	ld	ra,8(sp)
    800022d4:	00013403          	ld	s0,0(sp)
    800022d8:	01010113          	addi	sp,sp,16
    800022dc:	00008067          	ret

00000000800022e0 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    800022e0:	00051e63          	bnez	a0,800022fc <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('s');
    }
    y++;
    800022e4:	00005717          	auipc	a4,0x5
    800022e8:	0b870713          	addi	a4,a4,184 # 8000739c <_ZZ12checkNullptrPvE1x>
    800022ec:	00472783          	lw	a5,4(a4)
    800022f0:	0017879b          	addiw	a5,a5,1
    800022f4:	00f72223          	sw	a5,4(a4)
    800022f8:	00008067          	ret
void checkStatus(int status) {
    800022fc:	ff010113          	addi	sp,sp,-16
    80002300:	00113423          	sd	ra,8(sp)
    80002304:	00813023          	sd	s0,0(sp)
    80002308:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    8000230c:	00005517          	auipc	a0,0x5
    80002310:	09452503          	lw	a0,148(a0) # 800073a0 <_ZZ11checkStatusiE1y>
    80002314:	0305051b          	addiw	a0,a0,48
    80002318:	0ff57513          	andi	a0,a0,255
    8000231c:	00003097          	auipc	ra,0x3
    80002320:	160080e7          	jalr	352(ra) # 8000547c <__putc>
        __putc('s');
    80002324:	07300513          	li	a0,115
    80002328:	00003097          	auipc	ra,0x3
    8000232c:	154080e7          	jalr	340(ra) # 8000547c <__putc>
    y++;
    80002330:	00005717          	auipc	a4,0x5
    80002334:	06c70713          	addi	a4,a4,108 # 8000739c <_ZZ12checkNullptrPvE1x>
    80002338:	00472783          	lw	a5,4(a4)
    8000233c:	0017879b          	addiw	a5,a5,1
    80002340:	00f72223          	sw	a5,4(a4)
}
    80002344:	00813083          	ld	ra,8(sp)
    80002348:	00013403          	ld	s0,0(sp)
    8000234c:	01010113          	addi	sp,sp,16
    80002350:	00008067          	ret

0000000080002354 <_Z5test2v>:
void test2(){
    80002354:	fd010113          	addi	sp,sp,-48
    80002358:	02113423          	sd	ra,40(sp)
    8000235c:	02813023          	sd	s0,32(sp)
    80002360:	00913c23          	sd	s1,24(sp)
    80002364:	01213823          	sd	s2,16(sp)
    80002368:	01313423          	sd	s3,8(sp)
    8000236c:	03010413          	addi	s0,sp,48
    int velicinaZaglavlja = 64; // meni je ovoliko

    int *p1 = (int*)mem_alloc(15*sizeof(int)); // trebalo bi da predje jedan blok od 64
    80002370:	03c00513          	li	a0,60
    80002374:	fffff097          	auipc	ra,0xfffff
    80002378:	dd0080e7          	jalr	-560(ra) # 80001144 <mem_alloc>
    8000237c:	00050993          	mv	s3,a0
    checkNullptr(p1);
    80002380:	00000097          	auipc	ra,0x0
    80002384:	eec080e7          	jalr	-276(ra) # 8000226c <_Z12checkNullptrPv>
    int *p2 = (int*)mem_alloc(30*sizeof(int));
    80002388:	07800513          	li	a0,120
    8000238c:	fffff097          	auipc	ra,0xfffff
    80002390:	db8080e7          	jalr	-584(ra) # 80001144 <mem_alloc>
    80002394:	00050493          	mv	s1,a0
    checkNullptr(p2);
    80002398:	00000097          	auipc	ra,0x0
    8000239c:	ed4080e7          	jalr	-300(ra) # 8000226c <_Z12checkNullptrPv>

    int *p3 = (int*)mem_alloc(30*sizeof(int));
    800023a0:	07800513          	li	a0,120
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	da0080e7          	jalr	-608(ra) # 80001144 <mem_alloc>
    800023ac:	00050913          	mv	s2,a0
    checkNullptr(p3);
    800023b0:	00000097          	auipc	ra,0x0
    800023b4:	ebc080e7          	jalr	-324(ra) # 8000226c <_Z12checkNullptrPv>

    checkStatus(mem_free(p1));
    800023b8:	00098513          	mv	a0,s3
    800023bc:	fffff097          	auipc	ra,0xfffff
    800023c0:	dcc080e7          	jalr	-564(ra) # 80001188 <mem_free>
    800023c4:	00000097          	auipc	ra,0x0
    800023c8:	f1c080e7          	jalr	-228(ra) # 800022e0 <_Z11checkStatusi>
    checkStatus(mem_free(p3));
    800023cc:	00090513          	mv	a0,s2
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	db8080e7          	jalr	-584(ra) # 80001188 <mem_free>
    800023d8:	00000097          	auipc	ra,0x0
    800023dc:	f08080e7          	jalr	-248(ra) # 800022e0 <_Z11checkStatusi>
    checkStatus(mem_free(p2)); // p2 treba da se spoji sa p1 i p3
    800023e0:	00048513          	mv	a0,s1
    800023e4:	fffff097          	auipc	ra,0xfffff
    800023e8:	da4080e7          	jalr	-604(ra) # 80001188 <mem_free>
    800023ec:	00000097          	auipc	ra,0x0
    800023f0:	ef4080e7          	jalr	-268(ra) # 800022e0 <_Z11checkStatusi>

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    800023f4:	00005797          	auipc	a5,0x5
    800023f8:	f2c7b783          	ld	a5,-212(a5) # 80007320 <_GLOBAL_OFFSET_TABLE_+0x30>
    800023fc:	0007b503          	ld	a0,0(a5)
    80002400:	00005797          	auipc	a5,0x5
    80002404:	ef87b783          	ld	a5,-264(a5) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002408:	0007b783          	ld	a5,0(a5)
    8000240c:	40f50533          	sub	a0,a0,a5
    80002410:	fc050513          	addi	a0,a0,-64
    80002414:	00655513          	srli	a0,a0,0x6
    80002418:	fff50513          	addi	a0,a0,-1
    int *maxMemorija = (int*)mem_alloc(celaMemorija);
    8000241c:	00651513          	slli	a0,a0,0x6
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	d24080e7          	jalr	-732(ra) # 80001144 <mem_alloc>
    80002428:	00050493          	mv	s1,a0
    checkNullptr(maxMemorija);
    8000242c:	00000097          	auipc	ra,0x0
    80002430:	e40080e7          	jalr	-448(ra) # 8000226c <_Z12checkNullptrPv>

    checkStatus(mem_free(maxMemorija));
    80002434:	00048513          	mv	a0,s1
    80002438:	fffff097          	auipc	ra,0xfffff
    8000243c:	d50080e7          	jalr	-688(ra) # 80001188 <mem_free>
    80002440:	00000097          	auipc	ra,0x0
    80002444:	ea0080e7          	jalr	-352(ra) # 800022e0 <_Z11checkStatusi>
}
    80002448:	02813083          	ld	ra,40(sp)
    8000244c:	02013403          	ld	s0,32(sp)
    80002450:	01813483          	ld	s1,24(sp)
    80002454:	01013903          	ld	s2,16(sp)
    80002458:	00813983          	ld	s3,8(sp)
    8000245c:	03010113          	addi	sp,sp,48
    80002460:	00008067          	ret

0000000080002464 <_Z5test3v>:

void test3(){
    80002464:	fe010113          	addi	sp,sp,-32
    80002468:	00113c23          	sd	ra,24(sp)
    8000246c:	00813823          	sd	s0,16(sp)
    80002470:	00913423          	sd	s1,8(sp)
    80002474:	01213023          	sd	s2,0(sp)
    80002478:	02010413          	addi	s0,sp,32
    int n = 10;
    char* niz = (char*)mem_alloc(10*sizeof(char));
    8000247c:	00a00513          	li	a0,10
    80002480:	fffff097          	auipc	ra,0xfffff
    80002484:	cc4080e7          	jalr	-828(ra) # 80001144 <mem_alloc>
    80002488:	00050913          	mv	s2,a0
    if(niz == nullptr) {
    8000248c:	02050263          	beqz	a0,800024b0 <_Z5test3v+0x4c>
void test3(){
    80002490:	00000793          	li	a5,0
        __putc('?');
    }

    for(int i = 0; i < n; i++) {
    80002494:	00900713          	li	a4,9
    80002498:	02f74463          	blt	a4,a5,800024c0 <_Z5test3v+0x5c>
        niz[i] = 'k';
    8000249c:	00f90733          	add	a4,s2,a5
    800024a0:	06b00693          	li	a3,107
    800024a4:	00d70023          	sb	a3,0(a4)
    for(int i = 0; i < n; i++) {
    800024a8:	0017879b          	addiw	a5,a5,1
    800024ac:	fe9ff06f          	j	80002494 <_Z5test3v+0x30>
        __putc('?');
    800024b0:	03f00513          	li	a0,63
    800024b4:	00003097          	auipc	ra,0x3
    800024b8:	fc8080e7          	jalr	-56(ra) # 8000547c <__putc>
    800024bc:	fd5ff06f          	j	80002490 <_Z5test3v+0x2c>
    }

    for(int i = 0; i < n; i++) {
    800024c0:	00000493          	li	s1,0
    800024c4:	00900793          	li	a5,9
    800024c8:	0297c463          	blt	a5,s1,800024f0 <_Z5test3v+0x8c>
        __putc(niz[i]);
    800024cc:	009907b3          	add	a5,s2,s1
    800024d0:	0007c503          	lbu	a0,0(a5)
    800024d4:	00003097          	auipc	ra,0x3
    800024d8:	fa8080e7          	jalr	-88(ra) # 8000547c <__putc>
        __putc(' ');
    800024dc:	02000513          	li	a0,32
    800024e0:	00003097          	auipc	ra,0x3
    800024e4:	f9c080e7          	jalr	-100(ra) # 8000547c <__putc>
    for(int i = 0; i < n; i++) {
    800024e8:	0014849b          	addiw	s1,s1,1
    800024ec:	fd9ff06f          	j	800024c4 <_Z5test3v+0x60>
    }

    int status = mem_free(niz);
    800024f0:	00090513          	mv	a0,s2
    800024f4:	fffff097          	auipc	ra,0xfffff
    800024f8:	c94080e7          	jalr	-876(ra) # 80001188 <mem_free>
    if(status != 0) {
    800024fc:	00051e63          	bnez	a0,80002518 <_Z5test3v+0xb4>
        __putc('?');
    }
}
    80002500:	01813083          	ld	ra,24(sp)
    80002504:	01013403          	ld	s0,16(sp)
    80002508:	00813483          	ld	s1,8(sp)
    8000250c:	00013903          	ld	s2,0(sp)
    80002510:	02010113          	addi	sp,sp,32
    80002514:	00008067          	ret
        __putc('?');
    80002518:	03f00513          	li	a0,63
    8000251c:	00003097          	auipc	ra,0x3
    80002520:	f60080e7          	jalr	-160(ra) # 8000547c <__putc>
}
    80002524:	fddff06f          	j	80002500 <_Z5test3v+0x9c>

0000000080002528 <_Z5test4v>:

void test4(){
    80002528:	fe010113          	addi	sp,sp,-32
    8000252c:	00113c23          	sd	ra,24(sp)
    80002530:	00813823          	sd	s0,16(sp)
    80002534:	00913423          	sd	s1,8(sp)
    80002538:	02010413          	addi	s0,sp,32
    int velicinaZaglavlja = 64; // meni je ovoliko

    const size_t maxMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    8000253c:	00005797          	auipc	a5,0x5
    80002540:	de47b783          	ld	a5,-540(a5) # 80007320 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002544:	0007b503          	ld	a0,0(a5)
    80002548:	00005797          	auipc	a5,0x5
    8000254c:	db07b783          	ld	a5,-592(a5) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002550:	0007b783          	ld	a5,0(a5)
    80002554:	40f50533          	sub	a0,a0,a5
    80002558:	fc050513          	addi	a0,a0,-64
    8000255c:	00655513          	srli	a0,a0,0x6
    80002560:	fff50513          	addi	a0,a0,-1
    char* niz = (char*)mem_alloc(maxMemorija); // celokupan prostor
    80002564:	00651513          	slli	a0,a0,0x6
    80002568:	fffff097          	auipc	ra,0xfffff
    8000256c:	bdc080e7          	jalr	-1060(ra) # 80001144 <mem_alloc>
    80002570:	00050493          	mv	s1,a0
    if(niz == nullptr) {
    80002574:	04050463          	beqz	a0,800025bc <_Z5test4v+0x94>
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    80002578:	00a00513          	li	a0,10
    8000257c:	fffff097          	auipc	ra,0xfffff
    80002580:	bc8080e7          	jalr	-1080(ra) # 80001144 <mem_alloc>
    if(niz2 == nullptr) {
    80002584:	04050463          	beqz	a0,800025cc <_Z5test4v+0xa4>
        __putc('k');
    }

    int status = mem_free(niz);
    80002588:	00048513          	mv	a0,s1
    8000258c:	fffff097          	auipc	ra,0xfffff
    80002590:	bfc080e7          	jalr	-1028(ra) # 80001188 <mem_free>
    if(status) {
    80002594:	04051463          	bnez	a0,800025dc <_Z5test4v+0xb4>
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    80002598:	00a00513          	li	a0,10
    8000259c:	fffff097          	auipc	ra,0xfffff
    800025a0:	ba8080e7          	jalr	-1112(ra) # 80001144 <mem_alloc>
    if(niz2 == nullptr) {
    800025a4:	04050463          	beqz	a0,800025ec <_Z5test4v+0xc4>
        __putc('?');
    }

}
    800025a8:	01813083          	ld	ra,24(sp)
    800025ac:	01013403          	ld	s0,16(sp)
    800025b0:	00813483          	ld	s1,8(sp)
    800025b4:	02010113          	addi	sp,sp,32
    800025b8:	00008067          	ret
        __putc('?');
    800025bc:	03f00513          	li	a0,63
    800025c0:	00003097          	auipc	ra,0x3
    800025c4:	ebc080e7          	jalr	-324(ra) # 8000547c <__putc>
    800025c8:	fb1ff06f          	j	80002578 <_Z5test4v+0x50>
        __putc('k');
    800025cc:	06b00513          	li	a0,107
    800025d0:	00003097          	auipc	ra,0x3
    800025d4:	eac080e7          	jalr	-340(ra) # 8000547c <__putc>
    800025d8:	fb1ff06f          	j	80002588 <_Z5test4v+0x60>
        __putc('?');
    800025dc:	03f00513          	li	a0,63
    800025e0:	00003097          	auipc	ra,0x3
    800025e4:	e9c080e7          	jalr	-356(ra) # 8000547c <__putc>
    800025e8:	fb1ff06f          	j	80002598 <_Z5test4v+0x70>
        __putc('?');
    800025ec:	03f00513          	li	a0,63
    800025f0:	00003097          	auipc	ra,0x3
    800025f4:	e8c080e7          	jalr	-372(ra) # 8000547c <__putc>
}
    800025f8:	fb1ff06f          	j	800025a8 <_Z5test4v+0x80>

00000000800025fc <_Z5test5v>:

void test5(){
    800025fc:	fd010113          	addi	sp,sp,-48
    80002600:	02113423          	sd	ra,40(sp)
    80002604:	02813023          	sd	s0,32(sp)
    80002608:	00913c23          	sd	s1,24(sp)
    8000260c:	01213823          	sd	s2,16(sp)
    80002610:	01313423          	sd	s3,8(sp)
    80002614:	03010413          	addi	s0,sp,48
    int n = 16;
    char** matrix = (char**)mem_alloc(n*sizeof(char*));
    80002618:	08000513          	li	a0,128
    8000261c:	fffff097          	auipc	ra,0xfffff
    80002620:	b28080e7          	jalr	-1240(ra) # 80001144 <mem_alloc>
    80002624:	00050913          	mv	s2,a0
    checkNullptr(matrix);
    80002628:	00000097          	auipc	ra,0x0
    8000262c:	c44080e7          	jalr	-956(ra) # 8000226c <_Z12checkNullptrPv>
    for(int i = 0; i < n; i++) {
    80002630:	00000493          	li	s1,0
    80002634:	00f00793          	li	a5,15
    80002638:	0297c663          	blt	a5,s1,80002664 <_Z5test5v+0x68>
        matrix[i] = (char *) mem_alloc(n * sizeof(char));
    8000263c:	00349993          	slli	s3,s1,0x3
    80002640:	013909b3          	add	s3,s2,s3
    80002644:	01000513          	li	a0,16
    80002648:	fffff097          	auipc	ra,0xfffff
    8000264c:	afc080e7          	jalr	-1284(ra) # 80001144 <mem_alloc>
    80002650:	00a9b023          	sd	a0,0(s3)
        checkNullptr(matrix[i]);
    80002654:	00000097          	auipc	ra,0x0
    80002658:	c18080e7          	jalr	-1000(ra) # 8000226c <_Z12checkNullptrPv>
    for(int i = 0; i < n; i++) {
    8000265c:	0014849b          	addiw	s1,s1,1
    80002660:	fd5ff06f          	j	80002634 <_Z5test5v+0x38>
    }

    for(int i = 0; i < n; i++) {
    80002664:	00000613          	li	a2,0
    80002668:	0080006f          	j	80002670 <_Z5test5v+0x74>
    8000266c:	0016061b          	addiw	a2,a2,1
    80002670:	00f00793          	li	a5,15
    80002674:	02c7c863          	blt	a5,a2,800026a4 <_Z5test5v+0xa8>
        for(int j = 0; j < n; j++) {
    80002678:	00000793          	li	a5,0
    8000267c:	00f00713          	li	a4,15
    80002680:	fef746e3          	blt	a4,a5,8000266c <_Z5test5v+0x70>
            matrix[i][j] = 'k';
    80002684:	00361713          	slli	a4,a2,0x3
    80002688:	00e90733          	add	a4,s2,a4
    8000268c:	00073703          	ld	a4,0(a4)
    80002690:	00f70733          	add	a4,a4,a5
    80002694:	06b00693          	li	a3,107
    80002698:	00d70023          	sb	a3,0(a4)
        for(int j = 0; j < n; j++) {
    8000269c:	0017879b          	addiw	a5,a5,1
    800026a0:	fddff06f          	j	8000267c <_Z5test5v+0x80>
        }
    }

    for(int i = 0; i < n; i++) {
    800026a4:	00000993          	li	s3,0
    800026a8:	0140006f          	j	800026bc <_Z5test5v+0xc0>
        for(int j = 0; j < n; j++) {
            __putc(matrix[i][j]);
            __putc(' ');
        }
        __putc('\n');
    800026ac:	00a00513          	li	a0,10
    800026b0:	00003097          	auipc	ra,0x3
    800026b4:	dcc080e7          	jalr	-564(ra) # 8000547c <__putc>
    for(int i = 0; i < n; i++) {
    800026b8:	0019899b          	addiw	s3,s3,1
    800026bc:	00f00793          	li	a5,15
    800026c0:	0537c063          	blt	a5,s3,80002700 <_Z5test5v+0x104>
        for(int j = 0; j < n; j++) {
    800026c4:	00000493          	li	s1,0
    800026c8:	00f00793          	li	a5,15
    800026cc:	fe97c0e3          	blt	a5,s1,800026ac <_Z5test5v+0xb0>
            __putc(matrix[i][j]);
    800026d0:	00399793          	slli	a5,s3,0x3
    800026d4:	00f907b3          	add	a5,s2,a5
    800026d8:	0007b783          	ld	a5,0(a5)
    800026dc:	009787b3          	add	a5,a5,s1
    800026e0:	0007c503          	lbu	a0,0(a5)
    800026e4:	00003097          	auipc	ra,0x3
    800026e8:	d98080e7          	jalr	-616(ra) # 8000547c <__putc>
            __putc(' ');
    800026ec:	02000513          	li	a0,32
    800026f0:	00003097          	auipc	ra,0x3
    800026f4:	d8c080e7          	jalr	-628(ra) # 8000547c <__putc>
        for(int j = 0; j < n; j++) {
    800026f8:	0014849b          	addiw	s1,s1,1
    800026fc:	fcdff06f          	j	800026c8 <_Z5test5v+0xcc>
    }


    for(int i = 0; i < n; i++) {
    80002700:	00000493          	li	s1,0
    80002704:	00f00793          	li	a5,15
    80002708:	0297c463          	blt	a5,s1,80002730 <_Z5test5v+0x134>
        int status = mem_free(matrix[i]);
    8000270c:	00349793          	slli	a5,s1,0x3
    80002710:	00f907b3          	add	a5,s2,a5
    80002714:	0007b503          	ld	a0,0(a5)
    80002718:	fffff097          	auipc	ra,0xfffff
    8000271c:	a70080e7          	jalr	-1424(ra) # 80001188 <mem_free>
        checkStatus(status);
    80002720:	00000097          	auipc	ra,0x0
    80002724:	bc0080e7          	jalr	-1088(ra) # 800022e0 <_Z11checkStatusi>
    for(int i = 0; i < n; i++) {
    80002728:	0014849b          	addiw	s1,s1,1
    8000272c:	fd9ff06f          	j	80002704 <_Z5test5v+0x108>
    }
    int status = mem_free(matrix);
    80002730:	00090513          	mv	a0,s2
    80002734:	fffff097          	auipc	ra,0xfffff
    80002738:	a54080e7          	jalr	-1452(ra) # 80001188 <mem_free>
    checkStatus(status);
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	ba4080e7          	jalr	-1116(ra) # 800022e0 <_Z11checkStatusi>
}
    80002744:	02813083          	ld	ra,40(sp)
    80002748:	02013403          	ld	s0,32(sp)
    8000274c:	01813483          	ld	s1,24(sp)
    80002750:	01013903          	ld	s2,16(sp)
    80002754:	00813983          	ld	s3,8(sp)
    80002758:	03010113          	addi	sp,sp,48
    8000275c:	00008067          	ret

0000000080002760 <main>:

void main()
{
    80002760:	ff010113          	addi	sp,sp,-16
    80002764:	00113423          	sd	ra,8(sp)
    80002768:	00813023          	sd	s0,0(sp)
    8000276c:	01010413          	addi	s0,sp,16
    MemAllocator::memoryInit();
    80002770:	00001097          	auipc	ra,0x1
    80002774:	8f8080e7          	jalr	-1800(ra) # 80003068 <_ZN12MemAllocator10memoryInitEv>
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
    80002778:	00005797          	auipc	a5,0x5
    8000277c:	b887b783          	ld	a5,-1144(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80002780:	10579073          	csrw	stvec,a5
    user_mode();
    80002784:	fffff097          	auipc	ra,0xfffff
    80002788:	bac080e7          	jalr	-1108(ra) # 80001330 <user_mode>
    //test5();
    TCB::main=TCB::running=TCB::createThread(nullptr, nullptr, nullptr);
    8000278c:	00000613          	li	a2,0
    80002790:	00000593          	li	a1,0
    80002794:	00000513          	li	a0,0
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	038080e7          	jalr	56(ra) # 800027d0 <_ZN3TCB12createThreadEPFvPvES0_S0_>
    800027a0:	00005797          	auipc	a5,0x5
    800027a4:	b787b783          	ld	a5,-1160(a5) # 80007318 <_GLOBAL_OFFSET_TABLE_+0x28>
    800027a8:	00a7b023          	sd	a0,0(a5)
    800027ac:	00005797          	auipc	a5,0x5
    800027b0:	b647b783          	ld	a5,-1180(a5) # 80007310 <_GLOBAL_OFFSET_TABLE_+0x20>
    800027b4:	00a7b023          	sd	a0,0(a5)
    userMain();
    800027b8:	fffff097          	auipc	ra,0xfffff
    800027bc:	5e0080e7          	jalr	1504(ra) # 80001d98 <_Z8userMainv>

}
    800027c0:	00813083          	ld	ra,8(sp)
    800027c4:	00013403          	ld	s0,0(sp)
    800027c8:	01010113          	addi	sp,sp,16
    800027cc:	00008067          	ret

00000000800027d0 <_ZN3TCB12createThreadEPFvPvES0_S0_>:
TCB *TCB::main;
int TCB::ID = 1;


TCB* TCB::createThread(Body body, void* arg, void* stack)
{
    800027d0:	fd010113          	addi	sp,sp,-48
    800027d4:	02113423          	sd	ra,40(sp)
    800027d8:	02813023          	sd	s0,32(sp)
    800027dc:	00913c23          	sd	s1,24(sp)
    800027e0:	01213823          	sd	s2,16(sp)
    800027e4:	01313423          	sd	s3,8(sp)
    800027e8:	03010413          	addi	s0,sp,48
    800027ec:	00050913          	mv	s2,a0
    800027f0:	00058993          	mv	s3,a1
    return new TCB(body, arg, (uint64*)stack);
    800027f4:	03000513          	li	a0,48
    800027f8:	00000097          	auipc	ra,0x0
    800027fc:	2a0080e7          	jalr	672(ra) # 80002a98 <_Znwm>
    80002800:	00050493          	mv	s1,a0
    // konstruktor
private:
    explicit TCB(Body body, void* arg, uint64* stackS):
            body(body),
            arg(arg),
            finished(false)
    80002804:	01253023          	sd	s2,0(a0)
    80002808:	01353423          	sd	s3,8(a0)
    8000280c:	00050c23          	sb	zero,24(a0)
    {
        //stack = body != nullptr ? (uint64*)mem_alloc(sizeof(uint64[STACK_SIZE])) : nullptr;
        if (body != nullptr)
    80002810:	04090263          	beqz	s2,80002854 <_ZN3TCB12createThreadEPFvPvES0_S0_+0x84>
        {
            stack = (uint64*)mem_alloc(STACK_SIZE * sizeof(uint64*));
    80002814:	00002537          	lui	a0,0x2
    80002818:	fffff097          	auipc	ra,0xfffff
    8000281c:	92c080e7          	jalr	-1748(ra) # 80001144 <mem_alloc>
    80002820:	00a4b823          	sd	a0,16(s1)
            context = {(uint64) &threadWrapper,
                       (uint64) &stack[DEFAULT_STACK_SIZE]};
    80002824:	0104b783          	ld	a5,16(s1)
    80002828:	00008737          	lui	a4,0x8
    8000282c:	00e787b3          	add	a5,a5,a4
            context = {(uint64) &threadWrapper,
    80002830:	00000717          	auipc	a4,0x0
    80002834:	1e470713          	addi	a4,a4,484 # 80002a14 <_ZN3TCB13threadWrapperEv>
    80002838:	02e4b023          	sd	a4,32(s1)
    8000283c:	02f4b423          	sd	a5,40(s1)
        else
        {
            stack = nullptr;
            context = {0, 0};
        }
        if (body != nullptr) { Scheduler::put(this); }
    80002840:	04090063          	beqz	s2,80002880 <_ZN3TCB12createThreadEPFvPvES0_S0_+0xb0>
    80002844:	00048513          	mv	a0,s1
    80002848:	00000097          	auipc	ra,0x0
    8000284c:	780080e7          	jalr	1920(ra) # 80002fc8 <_ZN9Scheduler3putEP3TCB>
    80002850:	0300006f          	j	80002880 <_ZN3TCB12createThreadEPFvPvES0_S0_+0xb0>
            stack = nullptr;
    80002854:	00053823          	sd	zero,16(a0) # 2010 <_entry-0x7fffdff0>
            context = {0, 0};
    80002858:	02053023          	sd	zero,32(a0)
    8000285c:	02053423          	sd	zero,40(a0)
    80002860:	fe1ff06f          	j	80002840 <_ZN3TCB12createThreadEPFvPvES0_S0_+0x70>
    80002864:	00050913          	mv	s2,a0
    80002868:	00048513          	mv	a0,s1
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	27c080e7          	jalr	636(ra) # 80002ae8 <_ZdlPv>
    80002874:	00090513          	mv	a0,s2
    80002878:	00006097          	auipc	ra,0x6
    8000287c:	c30080e7          	jalr	-976(ra) # 800084a8 <_Unwind_Resume>
        pid = ID++;
    80002880:	00005717          	auipc	a4,0x5
    80002884:	a3870713          	addi	a4,a4,-1480 # 800072b8 <_ZN3TCB2IDE>
    80002888:	00072783          	lw	a5,0(a4)
    8000288c:	0017869b          	addiw	a3,a5,1
    80002890:	00d72023          	sw	a3,0(a4)
    80002894:	00f4ae23          	sw	a5,28(s1)
}
    80002898:	00048513          	mv	a0,s1
    8000289c:	02813083          	ld	ra,40(sp)
    800028a0:	02013403          	ld	s0,32(sp)
    800028a4:	01813483          	ld	s1,24(sp)
    800028a8:	01013903          	ld	s2,16(sp)
    800028ac:	00813983          	ld	s3,8(sp)
    800028b0:	03010113          	addi	sp,sp,48
    800028b4:	00008067          	ret

00000000800028b8 <_ZN3TCB5yieldEv>:

void TCB::yield()
{
    800028b8:	ff010113          	addi	sp,sp,-16
    800028bc:	00813423          	sd	s0,8(sp)
    800028c0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("ecall");
    800028c4:	00000073          	ecall
}
    800028c8:	00813403          	ld	s0,8(sp)
    800028cc:	01010113          	addi	sp,sp,16
    800028d0:	00008067          	ret

00000000800028d4 <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    800028d4:	fe010113          	addi	sp,sp,-32
    800028d8:	00113c23          	sd	ra,24(sp)
    800028dc:	00813823          	sd	s0,16(sp)
    800028e0:	00913423          	sd	s1,8(sp)
    800028e4:	02010413          	addi	s0,sp,32
    TCB *old = running;
    800028e8:	00005497          	auipc	s1,0x5
    800028ec:	ac04b483          	ld	s1,-1344(s1) # 800073a8 <_ZN3TCB7runningE>
    if (old!= nullptr && !old->isFinished()) { Scheduler::put(old); }
    800028f0:	00048663          	beqz	s1,800028fc <_ZN3TCB8dispatchEv+0x28>
    bool isFinished() const { return finished; }
    800028f4:	0184c783          	lbu	a5,24(s1)
    800028f8:	02078c63          	beqz	a5,80002930 <_ZN3TCB8dispatchEv+0x5c>
    TCB *newT = running = Scheduler::get();
    800028fc:	00000097          	auipc	ra,0x0
    80002900:	664080e7          	jalr	1636(ra) # 80002f60 <_ZN9Scheduler3getEv>
    80002904:	00005797          	auipc	a5,0x5
    80002908:	aaa7b223          	sd	a0,-1372(a5) # 800073a8 <_ZN3TCB7runningE>


    TCB::contextSwitch(&old->context, &newT->context);
    8000290c:	02050593          	addi	a1,a0,32
    80002910:	02048513          	addi	a0,s1,32
    80002914:	fffff097          	auipc	ra,0xfffff
    80002918:	81c080e7          	jalr	-2020(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000291c:	01813083          	ld	ra,24(sp)
    80002920:	01013403          	ld	s0,16(sp)
    80002924:	00813483          	ld	s1,8(sp)
    80002928:	02010113          	addi	sp,sp,32
    8000292c:	00008067          	ret
    if (old!= nullptr && !old->isFinished()) { Scheduler::put(old); }
    80002930:	00048513          	mv	a0,s1
    80002934:	00000097          	auipc	ra,0x0
    80002938:	694080e7          	jalr	1684(ra) # 80002fc8 <_ZN9Scheduler3putEP3TCB>
    8000293c:	fc1ff06f          	j	800028fc <_ZN3TCB8dispatchEv+0x28>

0000000080002940 <_ZN3TCB4exitEv>:
    running->setFinished();
    TCB::dispatch();
}

int TCB::exit() {
    if (running == main) return -1;
    80002940:	00005797          	auipc	a5,0x5
    80002944:	a6878793          	addi	a5,a5,-1432 # 800073a8 <_ZN3TCB7runningE>
    80002948:	0007b703          	ld	a4,0(a5)
    8000294c:	0087b783          	ld	a5,8(a5)
    80002950:	06f70063          	beq	a4,a5,800029b0 <_ZN3TCB4exitEv+0x70>
int TCB::exit() {
    80002954:	fe010113          	addi	sp,sp,-32
    80002958:	00113c23          	sd	ra,24(sp)
    8000295c:	00813823          	sd	s0,16(sp)
    80002960:	00913423          	sd	s1,8(sp)
    80002964:	02010413          	addi	s0,sp,32
    TCB *newThr = Scheduler::get();
    80002968:	00000097          	auipc	ra,0x0
    8000296c:	5f8080e7          	jalr	1528(ra) # 80002f60 <_ZN9Scheduler3getEv>
    if(newThr) {
    80002970:	04050463          	beqz	a0,800029b8 <_ZN3TCB4exitEv+0x78>
        TCB* old=running;
    80002974:	00005497          	auipc	s1,0x5
    80002978:	a344b483          	ld	s1,-1484(s1) # 800073a8 <_ZN3TCB7runningE>
        //old->setFinished(true);
        TCB::contextSwitch(&old->context, &newThr->context);
    8000297c:	02050593          	addi	a1,a0,32
    80002980:	02048513          	addi	a0,s1,32
    80002984:	ffffe097          	auipc	ra,0xffffe
    80002988:	7ac080e7          	jalr	1964(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
        mem_free(old->stack); //da li ce se ikad vratiti ovde
    8000298c:	0104b503          	ld	a0,16(s1)
    80002990:	ffffe097          	auipc	ra,0xffffe
    80002994:	7f8080e7          	jalr	2040(ra) # 80001188 <mem_free>
    }
    return 0;
    80002998:	00000513          	li	a0,0
}
    8000299c:	01813083          	ld	ra,24(sp)
    800029a0:	01013403          	ld	s0,16(sp)
    800029a4:	00813483          	ld	s1,8(sp)
    800029a8:	02010113          	addi	sp,sp,32
    800029ac:	00008067          	ret
    if (running == main) return -1;
    800029b0:	fff00513          	li	a0,-1
}
    800029b4:	00008067          	ret
    return 0;
    800029b8:	00000513          	li	a0,0
    800029bc:	fe1ff06f          	j	8000299c <_ZN3TCB4exitEv+0x5c>

00000000800029c0 <_ZNK3TCB6getPidEv>:

int TCB::getPid() const {
    800029c0:	ff010113          	addi	sp,sp,-16
    800029c4:	00813423          	sd	s0,8(sp)
    800029c8:	01010413          	addi	s0,sp,16
    return pid;
}
    800029cc:	01c52503          	lw	a0,28(a0)
    800029d0:	00813403          	ld	s0,8(sp)
    800029d4:	01010113          	addi	sp,sp,16
    800029d8:	00008067          	ret

00000000800029dc <_ZN3TCB6setPidEi>:

void TCB::setPid(int pid) {
    800029dc:	ff010113          	addi	sp,sp,-16
    800029e0:	00813423          	sd	s0,8(sp)
    800029e4:	01010413          	addi	s0,sp,16
    TCB::pid = pid;
    800029e8:	00b52e23          	sw	a1,28(a0)
}
    800029ec:	00813403          	ld	s0,8(sp)
    800029f0:	01010113          	addi	sp,sp,16
    800029f4:	00008067          	ret

00000000800029f8 <_ZNK3TCB6getArgEv>:

void *TCB::getArg() const {
    800029f8:	ff010113          	addi	sp,sp,-16
    800029fc:	00813423          	sd	s0,8(sp)
    80002a00:	01010413          	addi	s0,sp,16
    return arg;
}
    80002a04:	00853503          	ld	a0,8(a0)
    80002a08:	00813403          	ld	s0,8(sp)
    80002a0c:	01010113          	addi	sp,sp,16
    80002a10:	00008067          	ret

0000000080002a14 <_ZN3TCB13threadWrapperEv>:
{
    80002a14:	fe010113          	addi	sp,sp,-32
    80002a18:	00113c23          	sd	ra,24(sp)
    80002a1c:	00813823          	sd	s0,16(sp)
    80002a20:	00913423          	sd	s1,8(sp)
    80002a24:	01213023          	sd	s2,0(sp)
    80002a28:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80002a2c:	00000097          	auipc	ra,0x0
    80002a30:	2f4080e7          	jalr	756(ra) # 80002d20 <_ZN5Riscv10popSppSpieEv>
    running->body(running->getArg());
    80002a34:	00005497          	auipc	s1,0x5
    80002a38:	97448493          	addi	s1,s1,-1676 # 800073a8 <_ZN3TCB7runningE>
    80002a3c:	0004b503          	ld	a0,0(s1)
    80002a40:	00053903          	ld	s2,0(a0)
    80002a44:	00000097          	auipc	ra,0x0
    80002a48:	fb4080e7          	jalr	-76(ra) # 800029f8 <_ZNK3TCB6getArgEv>
    80002a4c:	000900e7          	jalr	s2
    running->setFinished();
    80002a50:	0004b783          	ld	a5,0(s1)
    void setFinished() {finished = true;}
    80002a54:	00100713          	li	a4,1
    80002a58:	00e78c23          	sb	a4,24(a5)
    TCB::dispatch();
    80002a5c:	00000097          	auipc	ra,0x0
    80002a60:	e78080e7          	jalr	-392(ra) # 800028d4 <_ZN3TCB8dispatchEv>
}
    80002a64:	01813083          	ld	ra,24(sp)
    80002a68:	01013403          	ld	s0,16(sp)
    80002a6c:	00813483          	ld	s1,8(sp)
    80002a70:	00013903          	ld	s2,0(sp)
    80002a74:	02010113          	addi	sp,sp,32
    80002a78:	00008067          	ret

0000000080002a7c <_ZN3TCB6setArgEPv>:

void TCB::setArg(void *arg) {
    80002a7c:	ff010113          	addi	sp,sp,-16
    80002a80:	00813423          	sd	s0,8(sp)
    80002a84:	01010413          	addi	s0,sp,16
    TCB::arg = arg;
    80002a88:	00b53423          	sd	a1,8(a0)
}
    80002a8c:	00813403          	ld	s0,8(sp)
    80002a90:	01010113          	addi	sp,sp,16
    80002a94:	00008067          	ret

0000000080002a98 <_Znwm>:
#include "../h/memAllocator.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/tcb.hpp"
#include "../h/printing.hpp"

void *operator new(size_t size) {
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00113423          	sd	ra,8(sp)
    80002aa0:	00813023          	sd	s0,0(sp)
    80002aa4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002aa8:	ffffe097          	auipc	ra,0xffffe
    80002aac:	69c080e7          	jalr	1692(ra) # 80001144 <mem_alloc>
}
    80002ab0:	00813083          	ld	ra,8(sp)
    80002ab4:	00013403          	ld	s0,0(sp)
    80002ab8:	01010113          	addi	sp,sp,16
    80002abc:	00008067          	ret

0000000080002ac0 <_Znam>:

void *operator new[](size_t size) {
    80002ac0:	ff010113          	addi	sp,sp,-16
    80002ac4:	00113423          	sd	ra,8(sp)
    80002ac8:	00813023          	sd	s0,0(sp)
    80002acc:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002ad0:	ffffe097          	auipc	ra,0xffffe
    80002ad4:	674080e7          	jalr	1652(ra) # 80001144 <mem_alloc>
}
    80002ad8:	00813083          	ld	ra,8(sp)
    80002adc:	00013403          	ld	s0,0(sp)
    80002ae0:	01010113          	addi	sp,sp,16
    80002ae4:	00008067          	ret

0000000080002ae8 <_ZdlPv>:

void operator delete(void *tmp) {
    80002ae8:	ff010113          	addi	sp,sp,-16
    80002aec:	00113423          	sd	ra,8(sp)
    80002af0:	00813023          	sd	s0,0(sp)
    80002af4:	01010413          	addi	s0,sp,16
    mem_free(tmp);
    80002af8:	ffffe097          	auipc	ra,0xffffe
    80002afc:	690080e7          	jalr	1680(ra) # 80001188 <mem_free>
}
    80002b00:	00813083          	ld	ra,8(sp)
    80002b04:	00013403          	ld	s0,0(sp)
    80002b08:	01010113          	addi	sp,sp,16
    80002b0c:	00008067          	ret

0000000080002b10 <_ZN6ThreadD1Ev>:

int Thread::sleep(time_t) {
    return 0;
}

Thread::~Thread() {
    80002b10:	fe010113          	addi	sp,sp,-32
    80002b14:	00113c23          	sd	ra,24(sp)
    80002b18:	00813823          	sd	s0,16(sp)
    80002b1c:	00913423          	sd	s1,8(sp)
    80002b20:	02010413          	addi	s0,sp,32
    80002b24:	00004797          	auipc	a5,0x4
    80002b28:	7b478793          	addi	a5,a5,1972 # 800072d8 <_ZTV6Thread+0x10>
    80002b2c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002b30:	00853483          	ld	s1,8(a0)
    80002b34:	00048e63          	beqz	s1,80002b50 <_ZN6ThreadD1Ev+0x40>
    ~TCB() { mem_free(stack); }
    80002b38:	0104b503          	ld	a0,16(s1)
    80002b3c:	ffffe097          	auipc	ra,0xffffe
    80002b40:	64c080e7          	jalr	1612(ra) # 80001188 <mem_free>
    80002b44:	00048513          	mv	a0,s1
    80002b48:	00000097          	auipc	ra,0x0
    80002b4c:	fa0080e7          	jalr	-96(ra) # 80002ae8 <_ZdlPv>
}
    80002b50:	01813083          	ld	ra,24(sp)
    80002b54:	01013403          	ld	s0,16(sp)
    80002b58:	00813483          	ld	s1,8(sp)
    80002b5c:	02010113          	addi	sp,sp,32
    80002b60:	00008067          	ret

0000000080002b64 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002b64:	fe010113          	addi	sp,sp,-32
    80002b68:	00113c23          	sd	ra,24(sp)
    80002b6c:	00813823          	sd	s0,16(sp)
    80002b70:	00913423          	sd	s1,8(sp)
    80002b74:	02010413          	addi	s0,sp,32
    80002b78:	00050493          	mv	s1,a0
}
    80002b7c:	00000097          	auipc	ra,0x0
    80002b80:	f94080e7          	jalr	-108(ra) # 80002b10 <_ZN6ThreadD1Ev>
    80002b84:	00048513          	mv	a0,s1
    80002b88:	00000097          	auipc	ra,0x0
    80002b8c:	f60080e7          	jalr	-160(ra) # 80002ae8 <_ZdlPv>
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	00813483          	ld	s1,8(sp)
    80002b9c:	02010113          	addi	sp,sp,32
    80002ba0:	00008067          	ret

0000000080002ba4 <_ZdaPv>:
void operator delete[](void *tmp) {
    80002ba4:	ff010113          	addi	sp,sp,-16
    80002ba8:	00113423          	sd	ra,8(sp)
    80002bac:	00813023          	sd	s0,0(sp)
    80002bb0:	01010413          	addi	s0,sp,16
    mem_free(tmp);
    80002bb4:	ffffe097          	auipc	ra,0xffffe
    80002bb8:	5d4080e7          	jalr	1492(ra) # 80001188 <mem_free>
}
    80002bbc:	00813083          	ld	ra,8(sp)
    80002bc0:	00013403          	ld	s0,0(sp)
    80002bc4:	01010113          	addi	sp,sp,16
    80002bc8:	00008067          	ret

0000000080002bcc <_ZN6Thread5startEv>:
int Thread::start() {
    80002bcc:	ff010113          	addi	sp,sp,-16
    80002bd0:	00113423          	sd	ra,8(sp)
    80002bd4:	00813023          	sd	s0,0(sp)
    80002bd8:	01010413          	addi	s0,sp,16
    80002bdc:	00050613          	mv	a2,a0
    if(myHandle) return myHandle->getPid();
    80002be0:	00853503          	ld	a0,8(a0)
    80002be4:	00050e63          	beqz	a0,80002c00 <_ZN6Thread5startEv+0x34>
    80002be8:	00000097          	auipc	ra,0x0
    80002bec:	dd8080e7          	jalr	-552(ra) # 800029c0 <_ZNK3TCB6getPidEv>
}
    80002bf0:	00813083          	ld	ra,8(sp)
    80002bf4:	00013403          	ld	s0,0(sp)
    80002bf8:	01010113          	addi	sp,sp,16
    80002bfc:	00008067          	ret
        return thread_create(&myHandle, &wrapper, this);
    80002c00:	00000597          	auipc	a1,0x0
    80002c04:	0ec58593          	addi	a1,a1,236 # 80002cec <_ZN6Thread7wrapperEPv>
    80002c08:	00860513          	addi	a0,a2,8
    80002c0c:	ffffe097          	auipc	ra,0xffffe
    80002c10:	5e8080e7          	jalr	1512(ra) # 800011f4 <thread_create>
    80002c14:	fddff06f          	j	80002bf0 <_ZN6Thread5startEv+0x24>

0000000080002c18 <_Z11initThreadsv>:
void initThreads(){
    80002c18:	ff010113          	addi	sp,sp,-16
    80002c1c:	00113423          	sd	ra,8(sp)
    80002c20:	00813023          	sd	s0,0(sp)
    80002c24:	01010413          	addi	s0,sp,16
    TCB::main=TCB::running=TCB::createThread(nullptr, nullptr, nullptr);
    80002c28:	00000613          	li	a2,0
    80002c2c:	00000593          	li	a1,0
    80002c30:	00000513          	li	a0,0
    80002c34:	00000097          	auipc	ra,0x0
    80002c38:	b9c080e7          	jalr	-1124(ra) # 800027d0 <_ZN3TCB12createThreadEPFvPvES0_S0_>
    80002c3c:	00004797          	auipc	a5,0x4
    80002c40:	6dc7b783          	ld	a5,1756(a5) # 80007318 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002c44:	00a7b023          	sd	a0,0(a5)
    80002c48:	00004797          	auipc	a5,0x4
    80002c4c:	6c87b783          	ld	a5,1736(a5) # 80007310 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002c50:	00a7b023          	sd	a0,0(a5)
}
    80002c54:	00813083          	ld	ra,8(sp)
    80002c58:	00013403          	ld	s0,0(sp)
    80002c5c:	01010113          	addi	sp,sp,16
    80002c60:	00008067          	ret

0000000080002c64 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002c64:	ff010113          	addi	sp,sp,-16
    80002c68:	00113423          	sd	ra,8(sp)
    80002c6c:	00813023          	sd	s0,0(sp)
    80002c70:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002c74:	ffffe097          	auipc	ra,0xffffe
    80002c78:	644080e7          	jalr	1604(ra) # 800012b8 <thread_dispatch>
}
    80002c7c:	00813083          	ld	ra,8(sp)
    80002c80:	00013403          	ld	s0,0(sp)
    80002c84:	01010113          	addi	sp,sp,16
    80002c88:	00008067          	ret

0000000080002c8c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t) {
    80002c8c:	ff010113          	addi	sp,sp,-16
    80002c90:	00813423          	sd	s0,8(sp)
    80002c94:	01010413          	addi	s0,sp,16
}
    80002c98:	00000513          	li	a0,0
    80002c9c:	00813403          	ld	s0,8(sp)
    80002ca0:	01010113          	addi	sp,sp,16
    80002ca4:	00008067          	ret

0000000080002ca8 <_ZN6Thread4joinEv>:

void Thread::join() {
    80002ca8:	ff010113          	addi	sp,sp,-16
    80002cac:	00113423          	sd	ra,8(sp)
    80002cb0:	00813023          	sd	s0,0(sp)
    80002cb4:	01010413          	addi	s0,sp,16
    thread_join(&this->myHandle);
    80002cb8:	00850513          	addi	a0,a0,8
    80002cbc:	ffffe097          	auipc	ra,0xffffe
    80002cc0:	6a0080e7          	jalr	1696(ra) # 8000135c <thread_join>
}
    80002cc4:	00813083          	ld	ra,8(sp)
    80002cc8:	00013403          	ld	s0,0(sp)
    80002ccc:	01010113          	addi	sp,sp,16
    80002cd0:	00008067          	ret

0000000080002cd4 <_ZN6Thread3runEv>:
    virtual void run () {}
    80002cd4:	ff010113          	addi	sp,sp,-16
    80002cd8:	00813423          	sd	s0,8(sp)
    80002cdc:	01010413          	addi	s0,sp,16
    80002ce0:	00813403          	ld	s0,8(sp)
    80002ce4:	01010113          	addi	sp,sp,16
    80002ce8:	00008067          	ret

0000000080002cec <_ZN6Thread7wrapperEPv>:
private:
    thread_t myHandle;
    static void wrapper(void* thr){ if(thr) ((Thread*)thr)->run(); }
    80002cec:	02050863          	beqz	a0,80002d1c <_ZN6Thread7wrapperEPv+0x30>
    80002cf0:	ff010113          	addi	sp,sp,-16
    80002cf4:	00113423          	sd	ra,8(sp)
    80002cf8:	00813023          	sd	s0,0(sp)
    80002cfc:	01010413          	addi	s0,sp,16
    80002d00:	00053783          	ld	a5,0(a0)
    80002d04:	0107b783          	ld	a5,16(a5)
    80002d08:	000780e7          	jalr	a5
    80002d0c:	00813083          	ld	ra,8(sp)
    80002d10:	00013403          	ld	s0,0(sp)
    80002d14:	01010113          	addi	sp,sp,16
    80002d18:	00008067          	ret
    80002d1c:	00008067          	ret

0000000080002d20 <_ZN5Riscv10popSppSpieEv>:
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"

void Riscv::popSppSpie()
{
    80002d20:	ff010113          	addi	sp,sp,-16
    80002d24:	00813423          	sd	s0,8(sp)
    80002d28:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80002d2c:	14109073          	csrw	sepc,ra
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002d30:	10000793          	li	a5,256
    80002d34:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("sret");
    80002d38:	10200073          	sret
}
    80002d3c:	00813403          	ld	s0,8(sp)
    80002d40:	01010113          	addi	sp,sp,16
    80002d44:	00008067          	ret

0000000080002d48 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap()
{
    80002d48:	f8010113          	addi	sp,sp,-128
    80002d4c:	06113c23          	sd	ra,120(sp)
    80002d50:	06813823          	sd	s0,112(sp)
    80002d54:	06913423          	sd	s1,104(sp)
    80002d58:	08010413          	addi	s0,sp,128
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002d5c:	14202773          	csrr	a4,scause
    uint64 scause = r_scause();
    uint64 arg[5];
    __asm__ volatile ("mv %0, a0" : "=r" (arg[0]));
    80002d60:	00050793          	mv	a5,a0
    80002d64:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("mv %0, a1" : "=r" (arg[1]));
    80002d68:	00058793          	mv	a5,a1
    80002d6c:	fcf43023          	sd	a5,-64(s0)
    __asm__ volatile ("mv %0, a2" : "=r" (arg[2]));
    80002d70:	00060793          	mv	a5,a2
    80002d74:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("mv %0, a3" : "=r" (arg[3]));
    80002d78:	00068793          	mv	a5,a3
    80002d7c:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("mv %0, a4" : "=r" (arg[4]));
    80002d80:	00070793          	mv	a5,a4
    80002d84:	fcf43c23          	sd	a5,-40(s0)

    //promenjljiva u kojoj se cuva povratna vrednost
    uint64 ret = 0;
    TCB* t;
    //ecall iz korisnickog rezima ili iz privilegovanog
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL )
    80002d88:	ff870693          	addi	a3,a4,-8
    80002d8c:	00100793          	li	a5,1
    80002d90:	00d7fe63          	bgeu	a5,a3,80002dac <_ZN5Riscv20handleSupervisorTrapEv+0x64>
        }
        uint64  volatile sepc = r_sepc();
        w_sepc(sepc+4);
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000001UL)
    80002d94:	fff00793          	li	a5,-1
    80002d98:	03f79793          	slli	a5,a5,0x3f
    80002d9c:	00178793          	addi	a5,a5,1
    80002da0:	16f70c63          	beq	a4,a5,80002f18 <_ZN5Riscv20handleSupervisorTrapEv+0x1d0>
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        __asm __volatile("csrc sip, 0x02");
    }
    else
    {
        __asm __volatile("csrc sip, 0x02");
    80002da4:	14417073          	csrci	sip,2
    80002da8:	0600006f          	j	80002e08 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
        switch(arg[0]){
    80002dac:	fb843783          	ld	a5,-72(s0)
    80002db0:	04400713          	li	a4,68
    80002db4:	02f76863          	bltu	a4,a5,80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
    80002db8:	00279793          	slli	a5,a5,0x2
    80002dbc:	00003717          	auipc	a4,0x3
    80002dc0:	3d470713          	addi	a4,a4,980 # 80006190 <CONSOLE_STATUS+0x180>
    80002dc4:	00e787b3          	add	a5,a5,a4
    80002dc8:	0007a783          	lw	a5,0(a5)
    80002dcc:	00e787b3          	add	a5,a5,a4
    80002dd0:	00078067          	jr	a5
                ret = (uint64)MemAllocator::alloc((uint64)arg[1]);
    80002dd4:	fc043503          	ld	a0,-64(s0)
    80002dd8:	00000097          	auipc	ra,0x0
    80002ddc:	2d8080e7          	jalr	728(ra) # 800030b0 <_ZN12MemAllocator5allocEm>
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
    80002de0:	00050513          	mv	a0,a0
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002de4:	141027f3          	csrr	a5,sepc
    80002de8:	faf43823          	sd	a5,-80(s0)
    return sepc;
    80002dec:	fb043783          	ld	a5,-80(s0)
        uint64  volatile sepc = r_sepc();
    80002df0:	faf43423          	sd	a5,-88(s0)
        w_sepc(sepc+4);
    80002df4:	fa843783          	ld	a5,-88(s0)
    80002df8:	00478793          	addi	a5,a5,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002dfc:	14179073          	csrw	sepc,a5
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80002e00:	00200793          	li	a5,2
    80002e04:	1447b073          	csrc	sip,a5
    }
    console_handler();
    80002e08:	00002097          	auipc	ra,0x2
    80002e0c:	6e8080e7          	jalr	1768(ra) # 800054f0 <console_handler>
    80002e10:	07813083          	ld	ra,120(sp)
    80002e14:	07013403          	ld	s0,112(sp)
    80002e18:	06813483          	ld	s1,104(sp)
    80002e1c:	08010113          	addi	sp,sp,128
    80002e20:	00008067          	ret
                ret = (uint64)MemAllocator::freeMem((void*)arg[1]);
    80002e24:	fc043503          	ld	a0,-64(s0)
    80002e28:	00000097          	auipc	ra,0x0
    80002e2c:	39c080e7          	jalr	924(ra) # 800031c4 <_ZN12MemAllocator7freeMemEPv>
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
    80002e30:	00050513          	mv	a0,a0
                break;
    80002e34:	fb1ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                ret = (uint64)TCB::exit();
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	b08080e7          	jalr	-1272(ra) # 80002940 <_ZN3TCB4exitEv>
                __asm__ volatile ("mv a0, %0" : : "r" (ret));
    80002e40:	00050513          	mv	a0,a0
                break;
    80002e44:	fa1ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002e48:	141027f3          	csrr	a5,sepc
    80002e4c:	f8f43423          	sd	a5,-120(s0)
                __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002e50:	100027f3          	csrr	a5,sstatus
    80002e54:	f8f43823          	sd	a5,-112(s0)
                TCB::dispatch();
    80002e58:	00000097          	auipc	ra,0x0
    80002e5c:	a7c080e7          	jalr	-1412(ra) # 800028d4 <_ZN3TCB8dispatchEv>
                __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002e60:	f9043783          	ld	a5,-112(s0)
    80002e64:	10079073          	csrw	sstatus,a5
                __asm__ volatile ("csrw  sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002e68:	f8843783          	ld	a5,-120(s0)
    80002e6c:	14179073          	csrw	sepc,a5
                break;
    80002e70:	f75ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                arg[0]=(uint64)__getc();
    80002e74:	00002097          	auipc	ra,0x2
    80002e78:	644080e7          	jalr	1604(ra) # 800054b8 <__getc>
                __asm__ volatile ("mv a0, %[ime]" : : [ime] "r"(arg[0]));
    80002e7c:	00050513          	mv	a0,a0
                break;
    80002e80:	f65ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                __putc((char)arg[1]);
    80002e84:	fc044503          	lbu	a0,-64(s0)
    80002e88:	00002097          	auipc	ra,0x2
    80002e8c:	5f4080e7          	jalr	1524(ra) # 8000547c <__putc>
    80002e90:	f55ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(1UL << 8));
    80002e94:	10000793          	li	a5,256
    80002e98:	1007b073          	csrc	sstatus,a5
                break;
    80002e9c:	f49ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                t = (TCB*)arg[1];
    80002ea0:	fc043783          	ld	a5,-64(s0)
                t = (TCB*)t->body;
    80002ea4:	0007b483          	ld	s1,0(a5)
                while(!t->finished){
    80002ea8:	0184c783          	lbu	a5,24(s1)
    80002eac:	f2079ce3          	bnez	a5,80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc3));
    80002eb0:	141027f3          	csrr	a5,sepc
    80002eb4:	f8f43c23          	sd	a5,-104(s0)
                    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus3));
    80002eb8:	100027f3          	csrr	a5,sstatus
    80002ebc:	faf43023          	sd	a5,-96(s0)
                    TCB::dispatch();
    80002ec0:	00000097          	auipc	ra,0x0
    80002ec4:	a14080e7          	jalr	-1516(ra) # 800028d4 <_ZN3TCB8dispatchEv>
                    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus3));
    80002ec8:	fa043783          	ld	a5,-96(s0)
    80002ecc:	10079073          	csrw	sstatus,a5
                    __asm__ volatile ("csrw  sepc, %[sepc]" : : [sepc] "r"(sepc3));
    80002ed0:	f9843783          	ld	a5,-104(s0)
    80002ed4:	14179073          	csrw	sepc,a5
                while(!t->finished){
    80002ed8:	fd1ff06f          	j	80002ea8 <_ZN5Riscv20handleSupervisorTrapEv+0x160>
                __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc2));
    80002edc:	141024f3          	csrr	s1,sepc
                TCB* ret2 = TCB::createThread((void(*)(void*))arg[2],(void*)arg[3],(void*)arg[4]);
    80002ee0:	fd843603          	ld	a2,-40(s0)
    80002ee4:	fd043583          	ld	a1,-48(s0)
    80002ee8:	fc843503          	ld	a0,-56(s0)
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	8e4080e7          	jalr	-1820(ra) # 800027d0 <_ZN3TCB12createThreadEPFvPvES0_S0_>
                __asm__ volatile ("csrw sepc, %[ime]" : : [ime] "r"(sepc2));
    80002ef4:	14149073          	csrw	sepc,s1
                thread_t* tmp = (thread_t*)arg[1];
    80002ef8:	fc043783          	ld	a5,-64(s0)
                *tmp = ret2;
    80002efc:	00a7b023          	sd	a0,0(a5)
                if(ret2){
    80002f00:	00050663          	beqz	a0,80002f0c <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
                    __asm__ volatile ("mv a0, %0" : : "r" (ret2));
    80002f04:	00050513          	mv	a0,a0
    80002f08:	eddff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                    __asm__ volatile ("mv a0, %0" : : "r" (0));
    80002f0c:	00000793          	li	a5,0
    80002f10:	00078513          	mv	a0,a5
    80002f14:	ed1ff06f          	j	80002de4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
        __asm __volatile("csrc sip, 0x02");
    80002f18:	14417073          	csrci	sip,2
    80002f1c:	eedff06f          	j	80002e08 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>

0000000080002f20 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(TCB *ccb)
{
    readyThreadQueue.addLast(ccb);
    80002f20:	ff010113          	addi	sp,sp,-16
    80002f24:	00813423          	sd	s0,8(sp)
    80002f28:	01010413          	addi	s0,sp,16
    80002f2c:	00100793          	li	a5,1
    80002f30:	00f50863          	beq	a0,a5,80002f40 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002f34:	00813403          	ld	s0,8(sp)
    80002f38:	01010113          	addi	sp,sp,16
    80002f3c:	00008067          	ret
    80002f40:	000107b7          	lui	a5,0x10
    80002f44:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002f48:	fef596e3          	bne	a1,a5,80002f34 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80002f4c:	00004797          	auipc	a5,0x4
    80002f50:	46c78793          	addi	a5,a5,1132 # 800073b8 <_ZN9Scheduler16readyThreadQueueE>
    80002f54:	0007b023          	sd	zero,0(a5)
    80002f58:	0007b423          	sd	zero,8(a5)
    80002f5c:	fd9ff06f          	j	80002f34 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002f60 <_ZN9Scheduler3getEv>:
{
    80002f60:	fe010113          	addi	sp,sp,-32
    80002f64:	00113c23          	sd	ra,24(sp)
    80002f68:	00813823          	sd	s0,16(sp)
    80002f6c:	00913423          	sd	s1,8(sp)
    80002f70:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80002f74:	00004517          	auipc	a0,0x4
    80002f78:	44453503          	ld	a0,1092(a0) # 800073b8 <_ZN9Scheduler16readyThreadQueueE>
    80002f7c:	04050263          	beqz	a0,80002fc0 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80002f80:	00853783          	ld	a5,8(a0)
    80002f84:	00004717          	auipc	a4,0x4
    80002f88:	42f73a23          	sd	a5,1076(a4) # 800073b8 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80002f8c:	02078463          	beqz	a5,80002fb4 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80002f90:	00053483          	ld	s1,0(a0)
        delete elem;
    80002f94:	00000097          	auipc	ra,0x0
    80002f98:	b54080e7          	jalr	-1196(ra) # 80002ae8 <_ZdlPv>
}
    80002f9c:	00048513          	mv	a0,s1
    80002fa0:	01813083          	ld	ra,24(sp)
    80002fa4:	01013403          	ld	s0,16(sp)
    80002fa8:	00813483          	ld	s1,8(sp)
    80002fac:	02010113          	addi	sp,sp,32
    80002fb0:	00008067          	ret
        if (!head) { tail = 0; }
    80002fb4:	00004797          	auipc	a5,0x4
    80002fb8:	4007b623          	sd	zero,1036(a5) # 800073c0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002fbc:	fd5ff06f          	j	80002f90 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80002fc0:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80002fc4:	fd9ff06f          	j	80002f9c <_ZN9Scheduler3getEv+0x3c>

0000000080002fc8 <_ZN9Scheduler3putEP3TCB>:
{
    80002fc8:	fe010113          	addi	sp,sp,-32
    80002fcc:	00113c23          	sd	ra,24(sp)
    80002fd0:	00813823          	sd	s0,16(sp)
    80002fd4:	00913423          	sd	s1,8(sp)
    80002fd8:	02010413          	addi	s0,sp,32
    80002fdc:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80002fe0:	01000513          	li	a0,16
    80002fe4:	00000097          	auipc	ra,0x0
    80002fe8:	ab4080e7          	jalr	-1356(ra) # 80002a98 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002fec:	00953023          	sd	s1,0(a0)
    80002ff0:	00053423          	sd	zero,8(a0)
        if (tail)
    80002ff4:	00004797          	auipc	a5,0x4
    80002ff8:	3cc7b783          	ld	a5,972(a5) # 800073c0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002ffc:	02078263          	beqz	a5,80003020 <_ZN9Scheduler3putEP3TCB+0x58>
            tail->next = elem;
    80003000:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80003004:	00004797          	auipc	a5,0x4
    80003008:	3aa7be23          	sd	a0,956(a5) # 800073c0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    8000300c:	01813083          	ld	ra,24(sp)
    80003010:	01013403          	ld	s0,16(sp)
    80003014:	00813483          	ld	s1,8(sp)
    80003018:	02010113          	addi	sp,sp,32
    8000301c:	00008067          	ret
            head = tail = elem;
    80003020:	00004797          	auipc	a5,0x4
    80003024:	39878793          	addi	a5,a5,920 # 800073b8 <_ZN9Scheduler16readyThreadQueueE>
    80003028:	00a7b423          	sd	a0,8(a5)
    8000302c:	00a7b023          	sd	a0,0(a5)
    80003030:	fddff06f          	j	8000300c <_ZN9Scheduler3putEP3TCB+0x44>

0000000080003034 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80003034:	ff010113          	addi	sp,sp,-16
    80003038:	00113423          	sd	ra,8(sp)
    8000303c:	00813023          	sd	s0,0(sp)
    80003040:	01010413          	addi	s0,sp,16
    80003044:	000105b7          	lui	a1,0x10
    80003048:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000304c:	00100513          	li	a0,1
    80003050:	00000097          	auipc	ra,0x0
    80003054:	ed0080e7          	jalr	-304(ra) # 80002f20 <_Z41__static_initialization_and_destruction_0ii>
    80003058:	00813083          	ld	ra,8(sp)
    8000305c:	00013403          	ld	s0,0(sp)
    80003060:	01010113          	addi	sp,sp,16
    80003064:	00008067          	ret

0000000080003068 <_ZN12MemAllocator10memoryInitEv>:

MemoryDesc *MemAllocator::freeSpace = nullptr;

MemoryDesc *MemAllocator::usedSpace = nullptr;

void MemAllocator::memoryInit() {
    80003068:	ff010113          	addi	sp,sp,-16
    8000306c:	00813423          	sd	s0,8(sp)
    80003070:	01010413          	addi	s0,sp,16
    //pokazivac se inicijalizuje na pocetak heap-a
    freeSpace = (MemoryDesc *) HEAP_START_ADDR;
    80003074:	00004797          	auipc	a5,0x4
    80003078:	2847b783          	ld	a5,644(a5) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000307c:	0007b703          	ld	a4,0(a5)
    80003080:	00004797          	auipc	a5,0x4
    80003084:	34e7b423          	sd	a4,840(a5) # 800073c8 <_ZN12MemAllocator9freeSpaceE>
    MemoryDesc *tmp = freeSpace;

    //dodeljivanje celog memorijskog prostora
    tmp->size = (size_t) ((char *) HEAP_END_ADDR - (char *) HEAP_START_ADDR - MEM_BLOCK_SIZE);
    80003088:	00004797          	auipc	a5,0x4
    8000308c:	2987b783          	ld	a5,664(a5) # 80007320 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003090:	0007b783          	ld	a5,0(a5)
    80003094:	40e787b3          	sub	a5,a5,a4
    80003098:	fc078793          	addi	a5,a5,-64
    8000309c:	00f73023          	sd	a5,0(a4)
    tmp->next = nullptr;
    800030a0:	00073423          	sd	zero,8(a4)
}
    800030a4:	00813403          	ld	s0,8(sp)
    800030a8:	01010113          	addi	sp,sp,16
    800030ac:	00008067          	ret

00000000800030b0 <_ZN12MemAllocator5allocEm>:

void *MemAllocator::alloc(size_t alSize) {
    800030b0:	fd010113          	addi	sp,sp,-48
    800030b4:	02113423          	sd	ra,40(sp)
    800030b8:	02813023          	sd	s0,32(sp)
    800030bc:	00913c23          	sd	s1,24(sp)
    800030c0:	01213823          	sd	s2,16(sp)
    800030c4:	01313423          	sd	s3,8(sp)
    800030c8:	01413023          	sd	s4,0(sp)
    800030cc:	03010413          	addi	s0,sp,48
    800030d0:	00050993          	mv	s3,a0
    alSize = (alSize % MEM_BLOCK_SIZE == 0) ? alSize : (alSize / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;
    800030d4:	03f57793          	andi	a5,a0,63
    800030d8:	00078863          	beqz	a5,800030e8 <_ZN12MemAllocator5allocEm+0x38>
    800030dc:	00655993          	srli	s3,a0,0x6
    800030e0:	00198993          	addi	s3,s3,1
    800030e4:	00699993          	slli	s3,s3,0x6

    MemoryDesc *tmp = freeSpace;
    800030e8:	00004517          	auipc	a0,0x4
    800030ec:	2e053503          	ld	a0,736(a0) # 800073c8 <_ZN12MemAllocator9freeSpaceE>
    800030f0:	00050493          	mv	s1,a0
    800030f4:	05c0006f          	j	80003150 <_ZN12MemAllocator5allocEm+0xa0>
    while (tmp) {
        if (tmp->size == alSize + MEM_BLOCK_SIZE) {
            freeSpace= remove(freeSpace, tmp);
    800030f8:	00048593          	mv	a1,s1
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	1b8080e7          	jalr	440(ra) # 800032b4 <_Z6removeP10MemoryDescS0_>
    80003104:	00004917          	auipc	s2,0x4
    80003108:	2c490913          	addi	s2,s2,708 # 800073c8 <_ZN12MemAllocator9freeSpaceE>
    8000310c:	00a93023          	sd	a0,0(s2)
            usedSpace = insert(usedSpace, tmp);
    80003110:	00048593          	mv	a1,s1
    80003114:	00893503          	ld	a0,8(s2)
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	130080e7          	jalr	304(ra) # 80003248 <_Z6insertP10MemoryDescS0_>
    80003120:	00a93423          	sd	a0,8(s2)
            return (void *) ((char *) (tmp) + MEM_BLOCK_SIZE);
    80003124:	04048493          	addi	s1,s1,64
        tmp = tmp->next;
    }

    // nema segmenta, alokacija nije moguca
    return nullptr;
}
    80003128:	00048513          	mv	a0,s1
    8000312c:	02813083          	ld	ra,40(sp)
    80003130:	02013403          	ld	s0,32(sp)
    80003134:	01813483          	ld	s1,24(sp)
    80003138:	01013903          	ld	s2,16(sp)
    8000313c:	00813983          	ld	s3,8(sp)
    80003140:	00013a03          	ld	s4,0(sp)
    80003144:	03010113          	addi	sp,sp,48
    80003148:	00008067          	ret
        tmp = tmp->next;
    8000314c:	0084b483          	ld	s1,8(s1)
    while (tmp) {
    80003150:	fc048ce3          	beqz	s1,80003128 <_ZN12MemAllocator5allocEm+0x78>
        if (tmp->size == alSize + MEM_BLOCK_SIZE) {
    80003154:	0004b783          	ld	a5,0(s1)
    80003158:	04098913          	addi	s2,s3,64
    8000315c:	f9278ee3          	beq	a5,s2,800030f8 <_ZN12MemAllocator5allocEm+0x48>
        } else if (tmp->size > alSize + MEM_BLOCK_SIZE) { // ako ima previse radi se kracenje
    80003160:	fef976e3          	bgeu	s2,a5,8000314c <_ZN12MemAllocator5allocEm+0x9c>
            freeSpace = remove(freeSpace, tmp);
    80003164:	00048593          	mv	a1,s1
    80003168:	00000097          	auipc	ra,0x0
    8000316c:	14c080e7          	jalr	332(ra) # 800032b4 <_Z6removeP10MemoryDescS0_>
    80003170:	00004a17          	auipc	s4,0x4
    80003174:	258a0a13          	addi	s4,s4,600 # 800073c8 <_ZN12MemAllocator9freeSpaceE>
    80003178:	00aa3023          	sd	a0,0(s4)
            MemoryDesc *unusedSpace = (MemoryDesc *) ((char *) tmp + MEM_BLOCK_SIZE + alSize);
    8000317c:	012485b3          	add	a1,s1,s2
            unusedSpace->size = (tmp->size - alSize - MEM_BLOCK_SIZE);
    80003180:	0004b783          	ld	a5,0(s1)
    80003184:	413789b3          	sub	s3,a5,s3
    80003188:	fc098993          	addi	s3,s3,-64
    8000318c:	0135b023          	sd	s3,0(a1)
            unusedSpace->next = nullptr;
    80003190:	0005b423          	sd	zero,8(a1)
            tmp->size = alSize + MEM_BLOCK_SIZE;
    80003194:	0124b023          	sd	s2,0(s1)
            freeSpace = insert(freeSpace, unusedSpace);
    80003198:	000a3503          	ld	a0,0(s4)
    8000319c:	00000097          	auipc	ra,0x0
    800031a0:	0ac080e7          	jalr	172(ra) # 80003248 <_Z6insertP10MemoryDescS0_>
    800031a4:	00aa3023          	sd	a0,0(s4)
            usedSpace = insert(usedSpace, tmp);
    800031a8:	00048593          	mv	a1,s1
    800031ac:	008a3503          	ld	a0,8(s4)
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	098080e7          	jalr	152(ra) # 80003248 <_Z6insertP10MemoryDescS0_>
    800031b8:	00aa3423          	sd	a0,8(s4)
            return (void *) ((char *) (tmp) + MEM_BLOCK_SIZE);
    800031bc:	04048493          	addi	s1,s1,64
    800031c0:	f69ff06f          	j	80003128 <_ZN12MemAllocator5allocEm+0x78>

00000000800031c4 <_ZN12MemAllocator7freeMemEPv>:


int MemAllocator::freeMem(void *toFree) {
    if (!toFree)return -1;
    800031c4:	06050e63          	beqz	a0,80003240 <_ZN12MemAllocator7freeMemEPv+0x7c>
int MemAllocator::freeMem(void *toFree) {
    800031c8:	fe010113          	addi	sp,sp,-32
    800031cc:	00113c23          	sd	ra,24(sp)
    800031d0:	00813823          	sd	s0,16(sp)
    800031d4:	00913423          	sd	s1,8(sp)
    800031d8:	01213023          	sd	s2,0(sp)
    800031dc:	02010413          	addi	s0,sp,32

    MemoryDesc *tmp = (MemoryDesc*)((char*)(toFree) - MEM_BLOCK_SIZE);
    800031e0:	fc050493          	addi	s1,a0,-64

    // skloni segment iz okupiranih, ubaci u slobodne i squash-uj
    usedSpace = remove(usedSpace, tmp);
    800031e4:	00004917          	auipc	s2,0x4
    800031e8:	1e490913          	addi	s2,s2,484 # 800073c8 <_ZN12MemAllocator9freeSpaceE>
    800031ec:	00048593          	mv	a1,s1
    800031f0:	00893503          	ld	a0,8(s2)
    800031f4:	00000097          	auipc	ra,0x0
    800031f8:	0c0080e7          	jalr	192(ra) # 800032b4 <_Z6removeP10MemoryDescS0_>
    800031fc:	00a93423          	sd	a0,8(s2)
    freeSpace = insert(freeSpace, tmp);
    80003200:	00048593          	mv	a1,s1
    80003204:	00093503          	ld	a0,0(s2)
    80003208:	00000097          	auipc	ra,0x0
    8000320c:	040080e7          	jalr	64(ra) # 80003248 <_Z6insertP10MemoryDescS0_>
    80003210:	00a93023          	sd	a0,0(s2)
    freeSpace = connect(freeSpace,tmp);
    80003214:	00048593          	mv	a1,s1
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	0f4080e7          	jalr	244(ra) # 8000330c <_Z7connectP10MemoryDescS0_>
    80003220:	00a93023          	sd	a0,0(s2)

    return 0;
    80003224:	00000513          	li	a0,0
}
    80003228:	01813083          	ld	ra,24(sp)
    8000322c:	01013403          	ld	s0,16(sp)
    80003230:	00813483          	ld	s1,8(sp)
    80003234:	00013903          	ld	s2,0(sp)
    80003238:	02010113          	addi	sp,sp,32
    8000323c:	00008067          	ret
    if (!toFree)return -1;
    80003240:	fff00513          	li	a0,-1
}
    80003244:	00008067          	ret

0000000080003248 <_Z6insertP10MemoryDescS0_>:
//

#include "../h/memoryDesc.hpp"


MemoryDesc* insert(MemoryDesc *head, MemoryDesc *elem) {
    80003248:	ff010113          	addi	sp,sp,-16
    8000324c:	00813423          	sd	s0,8(sp)
    80003250:	01010413          	addi	s0,sp,16
    //ako je elem null izlazi
    if (!elem)return nullptr;
    80003254:	04058c63          	beqz	a1,800032ac <_Z6insertP10MemoryDescS0_+0x64>

    //ako nema head-a
    if (!(head)) {
    80003258:	02050463          	beqz	a0,80003280 <_Z6insertP10MemoryDescS0_+0x38>

        return head;
    }

    //ako elem dolazi na prvo mesto
    if (elem < head) {
    8000325c:	02a5e863          	bltu	a1,a0,8000328c <_Z6insertP10MemoryDescS0_+0x44>
        head = elem;
        return head;
    }

    //ako elem dolazi na mesto u sredini
    MemoryDesc *tmp = head;
    80003260:	00050793          	mv	a5,a0
    while (tmp->next) {
    80003264:	00078713          	mv	a4,a5
    80003268:	0087b783          	ld	a5,8(a5)
    8000326c:	02078a63          	beqz	a5,800032a0 <_Z6insertP10MemoryDescS0_+0x58>
        if (tmp->next > elem) {
    80003270:	fef5fae3          	bgeu	a1,a5,80003264 <_Z6insertP10MemoryDescS0_+0x1c>
            elem->next = tmp->next;
    80003274:	00f5b423          	sd	a5,8(a1)
            tmp->next = elem;
    80003278:	00b73423          	sd	a1,8(a4)
            return head;
    8000327c:	0180006f          	j	80003294 <_Z6insertP10MemoryDescS0_+0x4c>
        elem->next = nullptr;
    80003280:	0005b423          	sd	zero,8(a1)
        return head;
    80003284:	00058513          	mv	a0,a1
    80003288:	00c0006f          	j	80003294 <_Z6insertP10MemoryDescS0_+0x4c>
        elem->next = head;
    8000328c:	00a5b423          	sd	a0,8(a1)
        return head;
    80003290:	00058513          	mv	a0,a1
    tmp->next = elem;
    elem->next = nullptr;

    return head;

}
    80003294:	00813403          	ld	s0,8(sp)
    80003298:	01010113          	addi	sp,sp,16
    8000329c:	00008067          	ret
    tmp->next = elem;
    800032a0:	00b73423          	sd	a1,8(a4)
    elem->next = nullptr;
    800032a4:	0005b423          	sd	zero,8(a1)
    return head;
    800032a8:	fedff06f          	j	80003294 <_Z6insertP10MemoryDescS0_+0x4c>
    if (!elem)return nullptr;
    800032ac:	00058513          	mv	a0,a1
    800032b0:	fe5ff06f          	j	80003294 <_Z6insertP10MemoryDescS0_+0x4c>

00000000800032b4 <_Z6removeP10MemoryDescS0_>:

MemoryDesc* remove(MemoryDesc *head, MemoryDesc *elem) {
    800032b4:	ff010113          	addi	sp,sp,-16
    800032b8:	00813423          	sd	s0,8(sp)
    800032bc:	01010413          	addi	s0,sp,16
    // ako lista ili elem vrate null
    if ((!(head)) || !elem) return nullptr;
    800032c0:	02050663          	beqz	a0,800032ec <_Z6removeP10MemoryDescS0_+0x38>
    800032c4:	04058063          	beqz	a1,80003304 <_Z6removeP10MemoryDescS0_+0x50>


    // ako je elem na pocetku liste
    if (head == elem) {
    800032c8:	02b50863          	beq	a0,a1,800032f8 <_Z6removeP10MemoryDescS0_+0x44>
        elem->next = nullptr;
        return head;
    }

    // ako je na bilo kom drugom mestu
    MemoryDesc *tmp = head;
    800032cc:	00050793          	mv	a5,a0
    while (tmp->next) {
    800032d0:	00078713          	mv	a4,a5
    800032d4:	0087b783          	ld	a5,8(a5)
    800032d8:	00078a63          	beqz	a5,800032ec <_Z6removeP10MemoryDescS0_+0x38>
        if (tmp->next == elem) {
    800032dc:	feb79ae3          	bne	a5,a1,800032d0 <_Z6removeP10MemoryDescS0_+0x1c>
            tmp->next = elem->next;
    800032e0:	0085b783          	ld	a5,8(a1)
    800032e4:	00f73423          	sd	a5,8(a4)
            elem->next = nullptr;
    800032e8:	0005b423          	sd	zero,8(a1)
            return head;
        }
        tmp = tmp->next;
    }
    return head;
}
    800032ec:	00813403          	ld	s0,8(sp)
    800032f0:	01010113          	addi	sp,sp,16
    800032f4:	00008067          	ret
        head = (head)->next;
    800032f8:	00853503          	ld	a0,8(a0)
        elem->next = nullptr;
    800032fc:	0005b423          	sd	zero,8(a1)
        return head;
    80003300:	fedff06f          	j	800032ec <_Z6removeP10MemoryDescS0_+0x38>
    if ((!(head)) || !elem) return nullptr;
    80003304:	00058513          	mv	a0,a1
    80003308:	fe5ff06f          	j	800032ec <_Z6removeP10MemoryDescS0_+0x38>

000000008000330c <_Z7connectP10MemoryDescS0_>:

MemoryDesc* connect(MemoryDesc *head, MemoryDesc *elem) {
    8000330c:	ff010113          	addi	sp,sp,-16
    80003310:	00813423          	sd	s0,8(sp)
    80003314:	01010413          	addi	s0,sp,16
    //provera regularnosti head, elem
    if ((!(head)) || !elem) return nullptr;
    80003318:	08050c63          	beqz	a0,800033b0 <_Z7connectP10MemoryDescS0_+0xa4>
    8000331c:	08058863          	beqz	a1,800033ac <_Z7connectP10MemoryDescS0_+0xa0>

    //u slucaju da je element head
    if(elem == head){
    80003320:	00b50e63          	beq	a0,a1,8000333c <_Z7connectP10MemoryDescS0_+0x30>
        }
        return head;
    }

    //dovodjenje pokazivaca na element pre elem ako postoji
    MemoryDesc* tmp = head;
    80003324:	00050713          	mv	a4,a0
    while (tmp->next) {
    80003328:	00070793          	mv	a5,a4
    8000332c:	00873703          	ld	a4,8(a4)
    80003330:	04070e63          	beqz	a4,8000338c <_Z7connectP10MemoryDescS0_+0x80>
        if (tmp->next == elem) {
    80003334:	feb71ae3          	bne	a4,a1,80003328 <_Z7connectP10MemoryDescS0_+0x1c>
    80003338:	0540006f          	j	8000338c <_Z7connectP10MemoryDescS0_+0x80>
        if((head)->next && (((char*)(head) + (head)->size + MEM_BLOCK_SIZE) >= (char*)((head)->next))){
    8000333c:	00853783          	ld	a5,8(a0)
    80003340:	06078863          	beqz	a5,800033b0 <_Z7connectP10MemoryDescS0_+0xa4>
    80003344:	00053703          	ld	a4,0(a0)
    80003348:	04070693          	addi	a3,a4,64
    8000334c:	00d506b3          	add	a3,a0,a3
    80003350:	06f6e063          	bltu	a3,a5,800033b0 <_Z7connectP10MemoryDescS0_+0xa4>
            (head)->size = (head)->size + (head)->next->size + MEM_BLOCK_SIZE;
    80003354:	0007b683          	ld	a3,0(a5)
    80003358:	00d70733          	add	a4,a4,a3
    8000335c:	04070713          	addi	a4,a4,64
    80003360:	00e53023          	sd	a4,0(a0)
            (head)->next = (head)->next->next;
    80003364:	0087b783          	ld	a5,8(a5)
    80003368:	00f53423          	sd	a5,8(a0)
        return head;
    8000336c:	0440006f          	j	800033b0 <_Z7connectP10MemoryDescS0_+0xa4>
    }

    //pokazivac na mestu pre pokusava da se spoji sa elem, a zatim elem sa narednim ako postoji
    while(tmp->next){
        if (tmp->next && (((char *) tmp + tmp->size + MEM_BLOCK_SIZE) >= (char *) (tmp->next))) {
            tmp->size = tmp->size + tmp->next->size + MEM_BLOCK_SIZE;
    80003370:	0007b683          	ld	a3,0(a5)
    80003374:	00d60633          	add	a2,a2,a3
    80003378:	04060613          	addi	a2,a2,64
    8000337c:	00c73023          	sd	a2,0(a4)
            tmp->next = tmp->next->next;
    80003380:	0087b783          	ld	a5,8(a5)
    80003384:	00f73423          	sd	a5,8(a4)
            continue;
    80003388:	00070793          	mv	a5,a4
    while(tmp->next){
    8000338c:	00078713          	mv	a4,a5
    80003390:	0087b783          	ld	a5,8(a5)
    80003394:	00078e63          	beqz	a5,800033b0 <_Z7connectP10MemoryDescS0_+0xa4>
        if (tmp->next && (((char *) tmp + tmp->size + MEM_BLOCK_SIZE) >= (char *) (tmp->next))) {
    80003398:	00073603          	ld	a2,0(a4)
    8000339c:	04060693          	addi	a3,a2,64
    800033a0:	00d706b3          	add	a3,a4,a3
    800033a4:	fef6e4e3          	bltu	a3,a5,8000338c <_Z7connectP10MemoryDescS0_+0x80>
    800033a8:	fc9ff06f          	j	80003370 <_Z7connectP10MemoryDescS0_+0x64>
    if ((!(head)) || !elem) return nullptr;
    800033ac:	00058513          	mv	a0,a1
        }
        tmp = tmp->next;
        if(!tmp) break;
    }
    return head;
}
    800033b0:	00813403          	ld	s0,8(sp)
    800033b4:	01010113          	addi	sp,sp,16
    800033b8:	00008067          	ret

00000000800033bc <start>:
    800033bc:	ff010113          	addi	sp,sp,-16
    800033c0:	00813423          	sd	s0,8(sp)
    800033c4:	01010413          	addi	s0,sp,16
    800033c8:	300027f3          	csrr	a5,mstatus
    800033cc:	ffffe737          	lui	a4,0xffffe
    800033d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff61bf>
    800033d4:	00e7f7b3          	and	a5,a5,a4
    800033d8:	00001737          	lui	a4,0x1
    800033dc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800033e0:	00e7e7b3          	or	a5,a5,a4
    800033e4:	30079073          	csrw	mstatus,a5
    800033e8:	00000797          	auipc	a5,0x0
    800033ec:	16078793          	addi	a5,a5,352 # 80003548 <system_main>
    800033f0:	34179073          	csrw	mepc,a5
    800033f4:	00000793          	li	a5,0
    800033f8:	18079073          	csrw	satp,a5
    800033fc:	000107b7          	lui	a5,0x10
    80003400:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003404:	30279073          	csrw	medeleg,a5
    80003408:	30379073          	csrw	mideleg,a5
    8000340c:	104027f3          	csrr	a5,sie
    80003410:	2227e793          	ori	a5,a5,546
    80003414:	10479073          	csrw	sie,a5
    80003418:	fff00793          	li	a5,-1
    8000341c:	00a7d793          	srli	a5,a5,0xa
    80003420:	3b079073          	csrw	pmpaddr0,a5
    80003424:	00f00793          	li	a5,15
    80003428:	3a079073          	csrw	pmpcfg0,a5
    8000342c:	f14027f3          	csrr	a5,mhartid
    80003430:	0200c737          	lui	a4,0x200c
    80003434:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003438:	0007869b          	sext.w	a3,a5
    8000343c:	00269713          	slli	a4,a3,0x2
    80003440:	000f4637          	lui	a2,0xf4
    80003444:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003448:	00d70733          	add	a4,a4,a3
    8000344c:	0037979b          	slliw	a5,a5,0x3
    80003450:	020046b7          	lui	a3,0x2004
    80003454:	00d787b3          	add	a5,a5,a3
    80003458:	00c585b3          	add	a1,a1,a2
    8000345c:	00371693          	slli	a3,a4,0x3
    80003460:	00004717          	auipc	a4,0x4
    80003464:	f8070713          	addi	a4,a4,-128 # 800073e0 <timer_scratch>
    80003468:	00b7b023          	sd	a1,0(a5)
    8000346c:	00d70733          	add	a4,a4,a3
    80003470:	00f73c23          	sd	a5,24(a4)
    80003474:	02c73023          	sd	a2,32(a4)
    80003478:	34071073          	csrw	mscratch,a4
    8000347c:	00000797          	auipc	a5,0x0
    80003480:	6e478793          	addi	a5,a5,1764 # 80003b60 <timervec>
    80003484:	30579073          	csrw	mtvec,a5
    80003488:	300027f3          	csrr	a5,mstatus
    8000348c:	0087e793          	ori	a5,a5,8
    80003490:	30079073          	csrw	mstatus,a5
    80003494:	304027f3          	csrr	a5,mie
    80003498:	0807e793          	ori	a5,a5,128
    8000349c:	30479073          	csrw	mie,a5
    800034a0:	f14027f3          	csrr	a5,mhartid
    800034a4:	0007879b          	sext.w	a5,a5
    800034a8:	00078213          	mv	tp,a5
    800034ac:	30200073          	mret
    800034b0:	00813403          	ld	s0,8(sp)
    800034b4:	01010113          	addi	sp,sp,16
    800034b8:	00008067          	ret

00000000800034bc <timerinit>:
    800034bc:	ff010113          	addi	sp,sp,-16
    800034c0:	00813423          	sd	s0,8(sp)
    800034c4:	01010413          	addi	s0,sp,16
    800034c8:	f14027f3          	csrr	a5,mhartid
    800034cc:	0200c737          	lui	a4,0x200c
    800034d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800034d4:	0007869b          	sext.w	a3,a5
    800034d8:	00269713          	slli	a4,a3,0x2
    800034dc:	000f4637          	lui	a2,0xf4
    800034e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800034e4:	00d70733          	add	a4,a4,a3
    800034e8:	0037979b          	slliw	a5,a5,0x3
    800034ec:	020046b7          	lui	a3,0x2004
    800034f0:	00d787b3          	add	a5,a5,a3
    800034f4:	00c585b3          	add	a1,a1,a2
    800034f8:	00371693          	slli	a3,a4,0x3
    800034fc:	00004717          	auipc	a4,0x4
    80003500:	ee470713          	addi	a4,a4,-284 # 800073e0 <timer_scratch>
    80003504:	00b7b023          	sd	a1,0(a5)
    80003508:	00d70733          	add	a4,a4,a3
    8000350c:	00f73c23          	sd	a5,24(a4)
    80003510:	02c73023          	sd	a2,32(a4)
    80003514:	34071073          	csrw	mscratch,a4
    80003518:	00000797          	auipc	a5,0x0
    8000351c:	64878793          	addi	a5,a5,1608 # 80003b60 <timervec>
    80003520:	30579073          	csrw	mtvec,a5
    80003524:	300027f3          	csrr	a5,mstatus
    80003528:	0087e793          	ori	a5,a5,8
    8000352c:	30079073          	csrw	mstatus,a5
    80003530:	304027f3          	csrr	a5,mie
    80003534:	0807e793          	ori	a5,a5,128
    80003538:	30479073          	csrw	mie,a5
    8000353c:	00813403          	ld	s0,8(sp)
    80003540:	01010113          	addi	sp,sp,16
    80003544:	00008067          	ret

0000000080003548 <system_main>:
    80003548:	fe010113          	addi	sp,sp,-32
    8000354c:	00813823          	sd	s0,16(sp)
    80003550:	00913423          	sd	s1,8(sp)
    80003554:	00113c23          	sd	ra,24(sp)
    80003558:	02010413          	addi	s0,sp,32
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	0c4080e7          	jalr	196(ra) # 80003620 <cpuid>
    80003564:	00004497          	auipc	s1,0x4
    80003568:	ddc48493          	addi	s1,s1,-548 # 80007340 <started>
    8000356c:	02050263          	beqz	a0,80003590 <system_main+0x48>
    80003570:	0004a783          	lw	a5,0(s1)
    80003574:	0007879b          	sext.w	a5,a5
    80003578:	fe078ce3          	beqz	a5,80003570 <system_main+0x28>
    8000357c:	0ff0000f          	fence
    80003580:	00003517          	auipc	a0,0x3
    80003584:	d5850513          	addi	a0,a0,-680 # 800062d8 <CONSOLE_STATUS+0x2c8>
    80003588:	00001097          	auipc	ra,0x1
    8000358c:	a74080e7          	jalr	-1420(ra) # 80003ffc <panic>
    80003590:	00001097          	auipc	ra,0x1
    80003594:	9c8080e7          	jalr	-1592(ra) # 80003f58 <consoleinit>
    80003598:	00001097          	auipc	ra,0x1
    8000359c:	154080e7          	jalr	340(ra) # 800046ec <printfinit>
    800035a0:	00003517          	auipc	a0,0x3
    800035a4:	e1850513          	addi	a0,a0,-488 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800035a8:	00001097          	auipc	ra,0x1
    800035ac:	ab0080e7          	jalr	-1360(ra) # 80004058 <__printf>
    800035b0:	00003517          	auipc	a0,0x3
    800035b4:	cf850513          	addi	a0,a0,-776 # 800062a8 <CONSOLE_STATUS+0x298>
    800035b8:	00001097          	auipc	ra,0x1
    800035bc:	aa0080e7          	jalr	-1376(ra) # 80004058 <__printf>
    800035c0:	00003517          	auipc	a0,0x3
    800035c4:	df850513          	addi	a0,a0,-520 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800035c8:	00001097          	auipc	ra,0x1
    800035cc:	a90080e7          	jalr	-1392(ra) # 80004058 <__printf>
    800035d0:	00001097          	auipc	ra,0x1
    800035d4:	4a8080e7          	jalr	1192(ra) # 80004a78 <kinit>
    800035d8:	00000097          	auipc	ra,0x0
    800035dc:	148080e7          	jalr	328(ra) # 80003720 <trapinit>
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	16c080e7          	jalr	364(ra) # 8000374c <trapinithart>
    800035e8:	00000097          	auipc	ra,0x0
    800035ec:	5b8080e7          	jalr	1464(ra) # 80003ba0 <plicinit>
    800035f0:	00000097          	auipc	ra,0x0
    800035f4:	5d8080e7          	jalr	1496(ra) # 80003bc8 <plicinithart>
    800035f8:	00000097          	auipc	ra,0x0
    800035fc:	078080e7          	jalr	120(ra) # 80003670 <userinit>
    80003600:	0ff0000f          	fence
    80003604:	00100793          	li	a5,1
    80003608:	00003517          	auipc	a0,0x3
    8000360c:	cb850513          	addi	a0,a0,-840 # 800062c0 <CONSOLE_STATUS+0x2b0>
    80003610:	00f4a023          	sw	a5,0(s1)
    80003614:	00001097          	auipc	ra,0x1
    80003618:	a44080e7          	jalr	-1468(ra) # 80004058 <__printf>
    8000361c:	0000006f          	j	8000361c <system_main+0xd4>

0000000080003620 <cpuid>:
    80003620:	ff010113          	addi	sp,sp,-16
    80003624:	00813423          	sd	s0,8(sp)
    80003628:	01010413          	addi	s0,sp,16
    8000362c:	00020513          	mv	a0,tp
    80003630:	00813403          	ld	s0,8(sp)
    80003634:	0005051b          	sext.w	a0,a0
    80003638:	01010113          	addi	sp,sp,16
    8000363c:	00008067          	ret

0000000080003640 <mycpu>:
    80003640:	ff010113          	addi	sp,sp,-16
    80003644:	00813423          	sd	s0,8(sp)
    80003648:	01010413          	addi	s0,sp,16
    8000364c:	00020793          	mv	a5,tp
    80003650:	00813403          	ld	s0,8(sp)
    80003654:	0007879b          	sext.w	a5,a5
    80003658:	00779793          	slli	a5,a5,0x7
    8000365c:	00005517          	auipc	a0,0x5
    80003660:	db450513          	addi	a0,a0,-588 # 80008410 <cpus>
    80003664:	00f50533          	add	a0,a0,a5
    80003668:	01010113          	addi	sp,sp,16
    8000366c:	00008067          	ret

0000000080003670 <userinit>:
    80003670:	ff010113          	addi	sp,sp,-16
    80003674:	00813423          	sd	s0,8(sp)
    80003678:	01010413          	addi	s0,sp,16
    8000367c:	00813403          	ld	s0,8(sp)
    80003680:	01010113          	addi	sp,sp,16
    80003684:	fffff317          	auipc	t1,0xfffff
    80003688:	0dc30067          	jr	220(t1) # 80002760 <main>

000000008000368c <either_copyout>:
    8000368c:	ff010113          	addi	sp,sp,-16
    80003690:	00813023          	sd	s0,0(sp)
    80003694:	00113423          	sd	ra,8(sp)
    80003698:	01010413          	addi	s0,sp,16
    8000369c:	02051663          	bnez	a0,800036c8 <either_copyout+0x3c>
    800036a0:	00058513          	mv	a0,a1
    800036a4:	00060593          	mv	a1,a2
    800036a8:	0006861b          	sext.w	a2,a3
    800036ac:	00002097          	auipc	ra,0x2
    800036b0:	c58080e7          	jalr	-936(ra) # 80005304 <__memmove>
    800036b4:	00813083          	ld	ra,8(sp)
    800036b8:	00013403          	ld	s0,0(sp)
    800036bc:	00000513          	li	a0,0
    800036c0:	01010113          	addi	sp,sp,16
    800036c4:	00008067          	ret
    800036c8:	00003517          	auipc	a0,0x3
    800036cc:	c3850513          	addi	a0,a0,-968 # 80006300 <CONSOLE_STATUS+0x2f0>
    800036d0:	00001097          	auipc	ra,0x1
    800036d4:	92c080e7          	jalr	-1748(ra) # 80003ffc <panic>

00000000800036d8 <either_copyin>:
    800036d8:	ff010113          	addi	sp,sp,-16
    800036dc:	00813023          	sd	s0,0(sp)
    800036e0:	00113423          	sd	ra,8(sp)
    800036e4:	01010413          	addi	s0,sp,16
    800036e8:	02059463          	bnez	a1,80003710 <either_copyin+0x38>
    800036ec:	00060593          	mv	a1,a2
    800036f0:	0006861b          	sext.w	a2,a3
    800036f4:	00002097          	auipc	ra,0x2
    800036f8:	c10080e7          	jalr	-1008(ra) # 80005304 <__memmove>
    800036fc:	00813083          	ld	ra,8(sp)
    80003700:	00013403          	ld	s0,0(sp)
    80003704:	00000513          	li	a0,0
    80003708:	01010113          	addi	sp,sp,16
    8000370c:	00008067          	ret
    80003710:	00003517          	auipc	a0,0x3
    80003714:	c1850513          	addi	a0,a0,-1000 # 80006328 <CONSOLE_STATUS+0x318>
    80003718:	00001097          	auipc	ra,0x1
    8000371c:	8e4080e7          	jalr	-1820(ra) # 80003ffc <panic>

0000000080003720 <trapinit>:
    80003720:	ff010113          	addi	sp,sp,-16
    80003724:	00813423          	sd	s0,8(sp)
    80003728:	01010413          	addi	s0,sp,16
    8000372c:	00813403          	ld	s0,8(sp)
    80003730:	00003597          	auipc	a1,0x3
    80003734:	c2058593          	addi	a1,a1,-992 # 80006350 <CONSOLE_STATUS+0x340>
    80003738:	00005517          	auipc	a0,0x5
    8000373c:	d5850513          	addi	a0,a0,-680 # 80008490 <tickslock>
    80003740:	01010113          	addi	sp,sp,16
    80003744:	00001317          	auipc	t1,0x1
    80003748:	5c430067          	jr	1476(t1) # 80004d08 <initlock>

000000008000374c <trapinithart>:
    8000374c:	ff010113          	addi	sp,sp,-16
    80003750:	00813423          	sd	s0,8(sp)
    80003754:	01010413          	addi	s0,sp,16
    80003758:	00000797          	auipc	a5,0x0
    8000375c:	2f878793          	addi	a5,a5,760 # 80003a50 <kernelvec>
    80003760:	10579073          	csrw	stvec,a5
    80003764:	00813403          	ld	s0,8(sp)
    80003768:	01010113          	addi	sp,sp,16
    8000376c:	00008067          	ret

0000000080003770 <usertrap>:
    80003770:	ff010113          	addi	sp,sp,-16
    80003774:	00813423          	sd	s0,8(sp)
    80003778:	01010413          	addi	s0,sp,16
    8000377c:	00813403          	ld	s0,8(sp)
    80003780:	01010113          	addi	sp,sp,16
    80003784:	00008067          	ret

0000000080003788 <usertrapret>:
    80003788:	ff010113          	addi	sp,sp,-16
    8000378c:	00813423          	sd	s0,8(sp)
    80003790:	01010413          	addi	s0,sp,16
    80003794:	00813403          	ld	s0,8(sp)
    80003798:	01010113          	addi	sp,sp,16
    8000379c:	00008067          	ret

00000000800037a0 <kerneltrap>:
    800037a0:	fe010113          	addi	sp,sp,-32
    800037a4:	00813823          	sd	s0,16(sp)
    800037a8:	00113c23          	sd	ra,24(sp)
    800037ac:	00913423          	sd	s1,8(sp)
    800037b0:	02010413          	addi	s0,sp,32
    800037b4:	142025f3          	csrr	a1,scause
    800037b8:	100027f3          	csrr	a5,sstatus
    800037bc:	0027f793          	andi	a5,a5,2
    800037c0:	10079c63          	bnez	a5,800038d8 <kerneltrap+0x138>
    800037c4:	142027f3          	csrr	a5,scause
    800037c8:	0207ce63          	bltz	a5,80003804 <kerneltrap+0x64>
    800037cc:	00003517          	auipc	a0,0x3
    800037d0:	bcc50513          	addi	a0,a0,-1076 # 80006398 <CONSOLE_STATUS+0x388>
    800037d4:	00001097          	auipc	ra,0x1
    800037d8:	884080e7          	jalr	-1916(ra) # 80004058 <__printf>
    800037dc:	141025f3          	csrr	a1,sepc
    800037e0:	14302673          	csrr	a2,stval
    800037e4:	00003517          	auipc	a0,0x3
    800037e8:	bc450513          	addi	a0,a0,-1084 # 800063a8 <CONSOLE_STATUS+0x398>
    800037ec:	00001097          	auipc	ra,0x1
    800037f0:	86c080e7          	jalr	-1940(ra) # 80004058 <__printf>
    800037f4:	00003517          	auipc	a0,0x3
    800037f8:	bcc50513          	addi	a0,a0,-1076 # 800063c0 <CONSOLE_STATUS+0x3b0>
    800037fc:	00001097          	auipc	ra,0x1
    80003800:	800080e7          	jalr	-2048(ra) # 80003ffc <panic>
    80003804:	0ff7f713          	andi	a4,a5,255
    80003808:	00900693          	li	a3,9
    8000380c:	04d70063          	beq	a4,a3,8000384c <kerneltrap+0xac>
    80003810:	fff00713          	li	a4,-1
    80003814:	03f71713          	slli	a4,a4,0x3f
    80003818:	00170713          	addi	a4,a4,1
    8000381c:	fae798e3          	bne	a5,a4,800037cc <kerneltrap+0x2c>
    80003820:	00000097          	auipc	ra,0x0
    80003824:	e00080e7          	jalr	-512(ra) # 80003620 <cpuid>
    80003828:	06050663          	beqz	a0,80003894 <kerneltrap+0xf4>
    8000382c:	144027f3          	csrr	a5,sip
    80003830:	ffd7f793          	andi	a5,a5,-3
    80003834:	14479073          	csrw	sip,a5
    80003838:	01813083          	ld	ra,24(sp)
    8000383c:	01013403          	ld	s0,16(sp)
    80003840:	00813483          	ld	s1,8(sp)
    80003844:	02010113          	addi	sp,sp,32
    80003848:	00008067          	ret
    8000384c:	00000097          	auipc	ra,0x0
    80003850:	3c8080e7          	jalr	968(ra) # 80003c14 <plic_claim>
    80003854:	00a00793          	li	a5,10
    80003858:	00050493          	mv	s1,a0
    8000385c:	06f50863          	beq	a0,a5,800038cc <kerneltrap+0x12c>
    80003860:	fc050ce3          	beqz	a0,80003838 <kerneltrap+0x98>
    80003864:	00050593          	mv	a1,a0
    80003868:	00003517          	auipc	a0,0x3
    8000386c:	b1050513          	addi	a0,a0,-1264 # 80006378 <CONSOLE_STATUS+0x368>
    80003870:	00000097          	auipc	ra,0x0
    80003874:	7e8080e7          	jalr	2024(ra) # 80004058 <__printf>
    80003878:	01013403          	ld	s0,16(sp)
    8000387c:	01813083          	ld	ra,24(sp)
    80003880:	00048513          	mv	a0,s1
    80003884:	00813483          	ld	s1,8(sp)
    80003888:	02010113          	addi	sp,sp,32
    8000388c:	00000317          	auipc	t1,0x0
    80003890:	3c030067          	jr	960(t1) # 80003c4c <plic_complete>
    80003894:	00005517          	auipc	a0,0x5
    80003898:	bfc50513          	addi	a0,a0,-1028 # 80008490 <tickslock>
    8000389c:	00001097          	auipc	ra,0x1
    800038a0:	490080e7          	jalr	1168(ra) # 80004d2c <acquire>
    800038a4:	00004717          	auipc	a4,0x4
    800038a8:	aa070713          	addi	a4,a4,-1376 # 80007344 <ticks>
    800038ac:	00072783          	lw	a5,0(a4)
    800038b0:	00005517          	auipc	a0,0x5
    800038b4:	be050513          	addi	a0,a0,-1056 # 80008490 <tickslock>
    800038b8:	0017879b          	addiw	a5,a5,1
    800038bc:	00f72023          	sw	a5,0(a4)
    800038c0:	00001097          	auipc	ra,0x1
    800038c4:	538080e7          	jalr	1336(ra) # 80004df8 <release>
    800038c8:	f65ff06f          	j	8000382c <kerneltrap+0x8c>
    800038cc:	00001097          	auipc	ra,0x1
    800038d0:	094080e7          	jalr	148(ra) # 80004960 <uartintr>
    800038d4:	fa5ff06f          	j	80003878 <kerneltrap+0xd8>
    800038d8:	00003517          	auipc	a0,0x3
    800038dc:	a8050513          	addi	a0,a0,-1408 # 80006358 <CONSOLE_STATUS+0x348>
    800038e0:	00000097          	auipc	ra,0x0
    800038e4:	71c080e7          	jalr	1820(ra) # 80003ffc <panic>

00000000800038e8 <clockintr>:
    800038e8:	fe010113          	addi	sp,sp,-32
    800038ec:	00813823          	sd	s0,16(sp)
    800038f0:	00913423          	sd	s1,8(sp)
    800038f4:	00113c23          	sd	ra,24(sp)
    800038f8:	02010413          	addi	s0,sp,32
    800038fc:	00005497          	auipc	s1,0x5
    80003900:	b9448493          	addi	s1,s1,-1132 # 80008490 <tickslock>
    80003904:	00048513          	mv	a0,s1
    80003908:	00001097          	auipc	ra,0x1
    8000390c:	424080e7          	jalr	1060(ra) # 80004d2c <acquire>
    80003910:	00004717          	auipc	a4,0x4
    80003914:	a3470713          	addi	a4,a4,-1484 # 80007344 <ticks>
    80003918:	00072783          	lw	a5,0(a4)
    8000391c:	01013403          	ld	s0,16(sp)
    80003920:	01813083          	ld	ra,24(sp)
    80003924:	00048513          	mv	a0,s1
    80003928:	0017879b          	addiw	a5,a5,1
    8000392c:	00813483          	ld	s1,8(sp)
    80003930:	00f72023          	sw	a5,0(a4)
    80003934:	02010113          	addi	sp,sp,32
    80003938:	00001317          	auipc	t1,0x1
    8000393c:	4c030067          	jr	1216(t1) # 80004df8 <release>

0000000080003940 <devintr>:
    80003940:	142027f3          	csrr	a5,scause
    80003944:	00000513          	li	a0,0
    80003948:	0007c463          	bltz	a5,80003950 <devintr+0x10>
    8000394c:	00008067          	ret
    80003950:	fe010113          	addi	sp,sp,-32
    80003954:	00813823          	sd	s0,16(sp)
    80003958:	00113c23          	sd	ra,24(sp)
    8000395c:	00913423          	sd	s1,8(sp)
    80003960:	02010413          	addi	s0,sp,32
    80003964:	0ff7f713          	andi	a4,a5,255
    80003968:	00900693          	li	a3,9
    8000396c:	04d70c63          	beq	a4,a3,800039c4 <devintr+0x84>
    80003970:	fff00713          	li	a4,-1
    80003974:	03f71713          	slli	a4,a4,0x3f
    80003978:	00170713          	addi	a4,a4,1
    8000397c:	00e78c63          	beq	a5,a4,80003994 <devintr+0x54>
    80003980:	01813083          	ld	ra,24(sp)
    80003984:	01013403          	ld	s0,16(sp)
    80003988:	00813483          	ld	s1,8(sp)
    8000398c:	02010113          	addi	sp,sp,32
    80003990:	00008067          	ret
    80003994:	00000097          	auipc	ra,0x0
    80003998:	c8c080e7          	jalr	-884(ra) # 80003620 <cpuid>
    8000399c:	06050663          	beqz	a0,80003a08 <devintr+0xc8>
    800039a0:	144027f3          	csrr	a5,sip
    800039a4:	ffd7f793          	andi	a5,a5,-3
    800039a8:	14479073          	csrw	sip,a5
    800039ac:	01813083          	ld	ra,24(sp)
    800039b0:	01013403          	ld	s0,16(sp)
    800039b4:	00813483          	ld	s1,8(sp)
    800039b8:	00200513          	li	a0,2
    800039bc:	02010113          	addi	sp,sp,32
    800039c0:	00008067          	ret
    800039c4:	00000097          	auipc	ra,0x0
    800039c8:	250080e7          	jalr	592(ra) # 80003c14 <plic_claim>
    800039cc:	00a00793          	li	a5,10
    800039d0:	00050493          	mv	s1,a0
    800039d4:	06f50663          	beq	a0,a5,80003a40 <devintr+0x100>
    800039d8:	00100513          	li	a0,1
    800039dc:	fa0482e3          	beqz	s1,80003980 <devintr+0x40>
    800039e0:	00048593          	mv	a1,s1
    800039e4:	00003517          	auipc	a0,0x3
    800039e8:	99450513          	addi	a0,a0,-1644 # 80006378 <CONSOLE_STATUS+0x368>
    800039ec:	00000097          	auipc	ra,0x0
    800039f0:	66c080e7          	jalr	1644(ra) # 80004058 <__printf>
    800039f4:	00048513          	mv	a0,s1
    800039f8:	00000097          	auipc	ra,0x0
    800039fc:	254080e7          	jalr	596(ra) # 80003c4c <plic_complete>
    80003a00:	00100513          	li	a0,1
    80003a04:	f7dff06f          	j	80003980 <devintr+0x40>
    80003a08:	00005517          	auipc	a0,0x5
    80003a0c:	a8850513          	addi	a0,a0,-1400 # 80008490 <tickslock>
    80003a10:	00001097          	auipc	ra,0x1
    80003a14:	31c080e7          	jalr	796(ra) # 80004d2c <acquire>
    80003a18:	00004717          	auipc	a4,0x4
    80003a1c:	92c70713          	addi	a4,a4,-1748 # 80007344 <ticks>
    80003a20:	00072783          	lw	a5,0(a4)
    80003a24:	00005517          	auipc	a0,0x5
    80003a28:	a6c50513          	addi	a0,a0,-1428 # 80008490 <tickslock>
    80003a2c:	0017879b          	addiw	a5,a5,1
    80003a30:	00f72023          	sw	a5,0(a4)
    80003a34:	00001097          	auipc	ra,0x1
    80003a38:	3c4080e7          	jalr	964(ra) # 80004df8 <release>
    80003a3c:	f65ff06f          	j	800039a0 <devintr+0x60>
    80003a40:	00001097          	auipc	ra,0x1
    80003a44:	f20080e7          	jalr	-224(ra) # 80004960 <uartintr>
    80003a48:	fadff06f          	j	800039f4 <devintr+0xb4>
    80003a4c:	0000                	unimp
	...

0000000080003a50 <kernelvec>:
    80003a50:	f0010113          	addi	sp,sp,-256
    80003a54:	00113023          	sd	ra,0(sp)
    80003a58:	00213423          	sd	sp,8(sp)
    80003a5c:	00313823          	sd	gp,16(sp)
    80003a60:	00413c23          	sd	tp,24(sp)
    80003a64:	02513023          	sd	t0,32(sp)
    80003a68:	02613423          	sd	t1,40(sp)
    80003a6c:	02713823          	sd	t2,48(sp)
    80003a70:	02813c23          	sd	s0,56(sp)
    80003a74:	04913023          	sd	s1,64(sp)
    80003a78:	04a13423          	sd	a0,72(sp)
    80003a7c:	04b13823          	sd	a1,80(sp)
    80003a80:	04c13c23          	sd	a2,88(sp)
    80003a84:	06d13023          	sd	a3,96(sp)
    80003a88:	06e13423          	sd	a4,104(sp)
    80003a8c:	06f13823          	sd	a5,112(sp)
    80003a90:	07013c23          	sd	a6,120(sp)
    80003a94:	09113023          	sd	a7,128(sp)
    80003a98:	09213423          	sd	s2,136(sp)
    80003a9c:	09313823          	sd	s3,144(sp)
    80003aa0:	09413c23          	sd	s4,152(sp)
    80003aa4:	0b513023          	sd	s5,160(sp)
    80003aa8:	0b613423          	sd	s6,168(sp)
    80003aac:	0b713823          	sd	s7,176(sp)
    80003ab0:	0b813c23          	sd	s8,184(sp)
    80003ab4:	0d913023          	sd	s9,192(sp)
    80003ab8:	0da13423          	sd	s10,200(sp)
    80003abc:	0db13823          	sd	s11,208(sp)
    80003ac0:	0dc13c23          	sd	t3,216(sp)
    80003ac4:	0fd13023          	sd	t4,224(sp)
    80003ac8:	0fe13423          	sd	t5,232(sp)
    80003acc:	0ff13823          	sd	t6,240(sp)
    80003ad0:	cd1ff0ef          	jal	ra,800037a0 <kerneltrap>
    80003ad4:	00013083          	ld	ra,0(sp)
    80003ad8:	00813103          	ld	sp,8(sp)
    80003adc:	01013183          	ld	gp,16(sp)
    80003ae0:	02013283          	ld	t0,32(sp)
    80003ae4:	02813303          	ld	t1,40(sp)
    80003ae8:	03013383          	ld	t2,48(sp)
    80003aec:	03813403          	ld	s0,56(sp)
    80003af0:	04013483          	ld	s1,64(sp)
    80003af4:	04813503          	ld	a0,72(sp)
    80003af8:	05013583          	ld	a1,80(sp)
    80003afc:	05813603          	ld	a2,88(sp)
    80003b00:	06013683          	ld	a3,96(sp)
    80003b04:	06813703          	ld	a4,104(sp)
    80003b08:	07013783          	ld	a5,112(sp)
    80003b0c:	07813803          	ld	a6,120(sp)
    80003b10:	08013883          	ld	a7,128(sp)
    80003b14:	08813903          	ld	s2,136(sp)
    80003b18:	09013983          	ld	s3,144(sp)
    80003b1c:	09813a03          	ld	s4,152(sp)
    80003b20:	0a013a83          	ld	s5,160(sp)
    80003b24:	0a813b03          	ld	s6,168(sp)
    80003b28:	0b013b83          	ld	s7,176(sp)
    80003b2c:	0b813c03          	ld	s8,184(sp)
    80003b30:	0c013c83          	ld	s9,192(sp)
    80003b34:	0c813d03          	ld	s10,200(sp)
    80003b38:	0d013d83          	ld	s11,208(sp)
    80003b3c:	0d813e03          	ld	t3,216(sp)
    80003b40:	0e013e83          	ld	t4,224(sp)
    80003b44:	0e813f03          	ld	t5,232(sp)
    80003b48:	0f013f83          	ld	t6,240(sp)
    80003b4c:	10010113          	addi	sp,sp,256
    80003b50:	10200073          	sret
    80003b54:	00000013          	nop
    80003b58:	00000013          	nop
    80003b5c:	00000013          	nop

0000000080003b60 <timervec>:
    80003b60:	34051573          	csrrw	a0,mscratch,a0
    80003b64:	00b53023          	sd	a1,0(a0)
    80003b68:	00c53423          	sd	a2,8(a0)
    80003b6c:	00d53823          	sd	a3,16(a0)
    80003b70:	01853583          	ld	a1,24(a0)
    80003b74:	02053603          	ld	a2,32(a0)
    80003b78:	0005b683          	ld	a3,0(a1)
    80003b7c:	00c686b3          	add	a3,a3,a2
    80003b80:	00d5b023          	sd	a3,0(a1)
    80003b84:	00200593          	li	a1,2
    80003b88:	14459073          	csrw	sip,a1
    80003b8c:	01053683          	ld	a3,16(a0)
    80003b90:	00853603          	ld	a2,8(a0)
    80003b94:	00053583          	ld	a1,0(a0)
    80003b98:	34051573          	csrrw	a0,mscratch,a0
    80003b9c:	30200073          	mret

0000000080003ba0 <plicinit>:
    80003ba0:	ff010113          	addi	sp,sp,-16
    80003ba4:	00813423          	sd	s0,8(sp)
    80003ba8:	01010413          	addi	s0,sp,16
    80003bac:	00813403          	ld	s0,8(sp)
    80003bb0:	0c0007b7          	lui	a5,0xc000
    80003bb4:	00100713          	li	a4,1
    80003bb8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003bbc:	00e7a223          	sw	a4,4(a5)
    80003bc0:	01010113          	addi	sp,sp,16
    80003bc4:	00008067          	ret

0000000080003bc8 <plicinithart>:
    80003bc8:	ff010113          	addi	sp,sp,-16
    80003bcc:	00813023          	sd	s0,0(sp)
    80003bd0:	00113423          	sd	ra,8(sp)
    80003bd4:	01010413          	addi	s0,sp,16
    80003bd8:	00000097          	auipc	ra,0x0
    80003bdc:	a48080e7          	jalr	-1464(ra) # 80003620 <cpuid>
    80003be0:	0085171b          	slliw	a4,a0,0x8
    80003be4:	0c0027b7          	lui	a5,0xc002
    80003be8:	00e787b3          	add	a5,a5,a4
    80003bec:	40200713          	li	a4,1026
    80003bf0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003bf4:	00813083          	ld	ra,8(sp)
    80003bf8:	00013403          	ld	s0,0(sp)
    80003bfc:	00d5151b          	slliw	a0,a0,0xd
    80003c00:	0c2017b7          	lui	a5,0xc201
    80003c04:	00a78533          	add	a0,a5,a0
    80003c08:	00052023          	sw	zero,0(a0)
    80003c0c:	01010113          	addi	sp,sp,16
    80003c10:	00008067          	ret

0000000080003c14 <plic_claim>:
    80003c14:	ff010113          	addi	sp,sp,-16
    80003c18:	00813023          	sd	s0,0(sp)
    80003c1c:	00113423          	sd	ra,8(sp)
    80003c20:	01010413          	addi	s0,sp,16
    80003c24:	00000097          	auipc	ra,0x0
    80003c28:	9fc080e7          	jalr	-1540(ra) # 80003620 <cpuid>
    80003c2c:	00813083          	ld	ra,8(sp)
    80003c30:	00013403          	ld	s0,0(sp)
    80003c34:	00d5151b          	slliw	a0,a0,0xd
    80003c38:	0c2017b7          	lui	a5,0xc201
    80003c3c:	00a78533          	add	a0,a5,a0
    80003c40:	00452503          	lw	a0,4(a0)
    80003c44:	01010113          	addi	sp,sp,16
    80003c48:	00008067          	ret

0000000080003c4c <plic_complete>:
    80003c4c:	fe010113          	addi	sp,sp,-32
    80003c50:	00813823          	sd	s0,16(sp)
    80003c54:	00913423          	sd	s1,8(sp)
    80003c58:	00113c23          	sd	ra,24(sp)
    80003c5c:	02010413          	addi	s0,sp,32
    80003c60:	00050493          	mv	s1,a0
    80003c64:	00000097          	auipc	ra,0x0
    80003c68:	9bc080e7          	jalr	-1604(ra) # 80003620 <cpuid>
    80003c6c:	01813083          	ld	ra,24(sp)
    80003c70:	01013403          	ld	s0,16(sp)
    80003c74:	00d5179b          	slliw	a5,a0,0xd
    80003c78:	0c201737          	lui	a4,0xc201
    80003c7c:	00f707b3          	add	a5,a4,a5
    80003c80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003c84:	00813483          	ld	s1,8(sp)
    80003c88:	02010113          	addi	sp,sp,32
    80003c8c:	00008067          	ret

0000000080003c90 <consolewrite>:
    80003c90:	fb010113          	addi	sp,sp,-80
    80003c94:	04813023          	sd	s0,64(sp)
    80003c98:	04113423          	sd	ra,72(sp)
    80003c9c:	02913c23          	sd	s1,56(sp)
    80003ca0:	03213823          	sd	s2,48(sp)
    80003ca4:	03313423          	sd	s3,40(sp)
    80003ca8:	03413023          	sd	s4,32(sp)
    80003cac:	01513c23          	sd	s5,24(sp)
    80003cb0:	05010413          	addi	s0,sp,80
    80003cb4:	06c05c63          	blez	a2,80003d2c <consolewrite+0x9c>
    80003cb8:	00060993          	mv	s3,a2
    80003cbc:	00050a13          	mv	s4,a0
    80003cc0:	00058493          	mv	s1,a1
    80003cc4:	00000913          	li	s2,0
    80003cc8:	fff00a93          	li	s5,-1
    80003ccc:	01c0006f          	j	80003ce8 <consolewrite+0x58>
    80003cd0:	fbf44503          	lbu	a0,-65(s0)
    80003cd4:	0019091b          	addiw	s2,s2,1
    80003cd8:	00148493          	addi	s1,s1,1
    80003cdc:	00001097          	auipc	ra,0x1
    80003ce0:	a9c080e7          	jalr	-1380(ra) # 80004778 <uartputc>
    80003ce4:	03298063          	beq	s3,s2,80003d04 <consolewrite+0x74>
    80003ce8:	00048613          	mv	a2,s1
    80003cec:	00100693          	li	a3,1
    80003cf0:	000a0593          	mv	a1,s4
    80003cf4:	fbf40513          	addi	a0,s0,-65
    80003cf8:	00000097          	auipc	ra,0x0
    80003cfc:	9e0080e7          	jalr	-1568(ra) # 800036d8 <either_copyin>
    80003d00:	fd5518e3          	bne	a0,s5,80003cd0 <consolewrite+0x40>
    80003d04:	04813083          	ld	ra,72(sp)
    80003d08:	04013403          	ld	s0,64(sp)
    80003d0c:	03813483          	ld	s1,56(sp)
    80003d10:	02813983          	ld	s3,40(sp)
    80003d14:	02013a03          	ld	s4,32(sp)
    80003d18:	01813a83          	ld	s5,24(sp)
    80003d1c:	00090513          	mv	a0,s2
    80003d20:	03013903          	ld	s2,48(sp)
    80003d24:	05010113          	addi	sp,sp,80
    80003d28:	00008067          	ret
    80003d2c:	00000913          	li	s2,0
    80003d30:	fd5ff06f          	j	80003d04 <consolewrite+0x74>

0000000080003d34 <consoleread>:
    80003d34:	f9010113          	addi	sp,sp,-112
    80003d38:	06813023          	sd	s0,96(sp)
    80003d3c:	04913c23          	sd	s1,88(sp)
    80003d40:	05213823          	sd	s2,80(sp)
    80003d44:	05313423          	sd	s3,72(sp)
    80003d48:	05413023          	sd	s4,64(sp)
    80003d4c:	03513c23          	sd	s5,56(sp)
    80003d50:	03613823          	sd	s6,48(sp)
    80003d54:	03713423          	sd	s7,40(sp)
    80003d58:	03813023          	sd	s8,32(sp)
    80003d5c:	06113423          	sd	ra,104(sp)
    80003d60:	01913c23          	sd	s9,24(sp)
    80003d64:	07010413          	addi	s0,sp,112
    80003d68:	00060b93          	mv	s7,a2
    80003d6c:	00050913          	mv	s2,a0
    80003d70:	00058c13          	mv	s8,a1
    80003d74:	00060b1b          	sext.w	s6,a2
    80003d78:	00004497          	auipc	s1,0x4
    80003d7c:	74048493          	addi	s1,s1,1856 # 800084b8 <cons>
    80003d80:	00400993          	li	s3,4
    80003d84:	fff00a13          	li	s4,-1
    80003d88:	00a00a93          	li	s5,10
    80003d8c:	05705e63          	blez	s7,80003de8 <consoleread+0xb4>
    80003d90:	09c4a703          	lw	a4,156(s1)
    80003d94:	0984a783          	lw	a5,152(s1)
    80003d98:	0007071b          	sext.w	a4,a4
    80003d9c:	08e78463          	beq	a5,a4,80003e24 <consoleread+0xf0>
    80003da0:	07f7f713          	andi	a4,a5,127
    80003da4:	00e48733          	add	a4,s1,a4
    80003da8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003dac:	0017869b          	addiw	a3,a5,1
    80003db0:	08d4ac23          	sw	a3,152(s1)
    80003db4:	00070c9b          	sext.w	s9,a4
    80003db8:	0b370663          	beq	a4,s3,80003e64 <consoleread+0x130>
    80003dbc:	00100693          	li	a3,1
    80003dc0:	f9f40613          	addi	a2,s0,-97
    80003dc4:	000c0593          	mv	a1,s8
    80003dc8:	00090513          	mv	a0,s2
    80003dcc:	f8e40fa3          	sb	a4,-97(s0)
    80003dd0:	00000097          	auipc	ra,0x0
    80003dd4:	8bc080e7          	jalr	-1860(ra) # 8000368c <either_copyout>
    80003dd8:	01450863          	beq	a0,s4,80003de8 <consoleread+0xb4>
    80003ddc:	001c0c13          	addi	s8,s8,1
    80003de0:	fffb8b9b          	addiw	s7,s7,-1
    80003de4:	fb5c94e3          	bne	s9,s5,80003d8c <consoleread+0x58>
    80003de8:	000b851b          	sext.w	a0,s7
    80003dec:	06813083          	ld	ra,104(sp)
    80003df0:	06013403          	ld	s0,96(sp)
    80003df4:	05813483          	ld	s1,88(sp)
    80003df8:	05013903          	ld	s2,80(sp)
    80003dfc:	04813983          	ld	s3,72(sp)
    80003e00:	04013a03          	ld	s4,64(sp)
    80003e04:	03813a83          	ld	s5,56(sp)
    80003e08:	02813b83          	ld	s7,40(sp)
    80003e0c:	02013c03          	ld	s8,32(sp)
    80003e10:	01813c83          	ld	s9,24(sp)
    80003e14:	40ab053b          	subw	a0,s6,a0
    80003e18:	03013b03          	ld	s6,48(sp)
    80003e1c:	07010113          	addi	sp,sp,112
    80003e20:	00008067          	ret
    80003e24:	00001097          	auipc	ra,0x1
    80003e28:	1d8080e7          	jalr	472(ra) # 80004ffc <push_on>
    80003e2c:	0984a703          	lw	a4,152(s1)
    80003e30:	09c4a783          	lw	a5,156(s1)
    80003e34:	0007879b          	sext.w	a5,a5
    80003e38:	fef70ce3          	beq	a4,a5,80003e30 <consoleread+0xfc>
    80003e3c:	00001097          	auipc	ra,0x1
    80003e40:	234080e7          	jalr	564(ra) # 80005070 <pop_on>
    80003e44:	0984a783          	lw	a5,152(s1)
    80003e48:	07f7f713          	andi	a4,a5,127
    80003e4c:	00e48733          	add	a4,s1,a4
    80003e50:	01874703          	lbu	a4,24(a4)
    80003e54:	0017869b          	addiw	a3,a5,1
    80003e58:	08d4ac23          	sw	a3,152(s1)
    80003e5c:	00070c9b          	sext.w	s9,a4
    80003e60:	f5371ee3          	bne	a4,s3,80003dbc <consoleread+0x88>
    80003e64:	000b851b          	sext.w	a0,s7
    80003e68:	f96bf2e3          	bgeu	s7,s6,80003dec <consoleread+0xb8>
    80003e6c:	08f4ac23          	sw	a5,152(s1)
    80003e70:	f7dff06f          	j	80003dec <consoleread+0xb8>

0000000080003e74 <consputc>:
    80003e74:	10000793          	li	a5,256
    80003e78:	00f50663          	beq	a0,a5,80003e84 <consputc+0x10>
    80003e7c:	00001317          	auipc	t1,0x1
    80003e80:	9f430067          	jr	-1548(t1) # 80004870 <uartputc_sync>
    80003e84:	ff010113          	addi	sp,sp,-16
    80003e88:	00113423          	sd	ra,8(sp)
    80003e8c:	00813023          	sd	s0,0(sp)
    80003e90:	01010413          	addi	s0,sp,16
    80003e94:	00800513          	li	a0,8
    80003e98:	00001097          	auipc	ra,0x1
    80003e9c:	9d8080e7          	jalr	-1576(ra) # 80004870 <uartputc_sync>
    80003ea0:	02000513          	li	a0,32
    80003ea4:	00001097          	auipc	ra,0x1
    80003ea8:	9cc080e7          	jalr	-1588(ra) # 80004870 <uartputc_sync>
    80003eac:	00013403          	ld	s0,0(sp)
    80003eb0:	00813083          	ld	ra,8(sp)
    80003eb4:	00800513          	li	a0,8
    80003eb8:	01010113          	addi	sp,sp,16
    80003ebc:	00001317          	auipc	t1,0x1
    80003ec0:	9b430067          	jr	-1612(t1) # 80004870 <uartputc_sync>

0000000080003ec4 <consoleintr>:
    80003ec4:	fe010113          	addi	sp,sp,-32
    80003ec8:	00813823          	sd	s0,16(sp)
    80003ecc:	00913423          	sd	s1,8(sp)
    80003ed0:	01213023          	sd	s2,0(sp)
    80003ed4:	00113c23          	sd	ra,24(sp)
    80003ed8:	02010413          	addi	s0,sp,32
    80003edc:	00004917          	auipc	s2,0x4
    80003ee0:	5dc90913          	addi	s2,s2,1500 # 800084b8 <cons>
    80003ee4:	00050493          	mv	s1,a0
    80003ee8:	00090513          	mv	a0,s2
    80003eec:	00001097          	auipc	ra,0x1
    80003ef0:	e40080e7          	jalr	-448(ra) # 80004d2c <acquire>
    80003ef4:	02048c63          	beqz	s1,80003f2c <consoleintr+0x68>
    80003ef8:	0a092783          	lw	a5,160(s2)
    80003efc:	09892703          	lw	a4,152(s2)
    80003f00:	07f00693          	li	a3,127
    80003f04:	40e7873b          	subw	a4,a5,a4
    80003f08:	02e6e263          	bltu	a3,a4,80003f2c <consoleintr+0x68>
    80003f0c:	00d00713          	li	a4,13
    80003f10:	04e48063          	beq	s1,a4,80003f50 <consoleintr+0x8c>
    80003f14:	07f7f713          	andi	a4,a5,127
    80003f18:	00e90733          	add	a4,s2,a4
    80003f1c:	0017879b          	addiw	a5,a5,1
    80003f20:	0af92023          	sw	a5,160(s2)
    80003f24:	00970c23          	sb	s1,24(a4)
    80003f28:	08f92e23          	sw	a5,156(s2)
    80003f2c:	01013403          	ld	s0,16(sp)
    80003f30:	01813083          	ld	ra,24(sp)
    80003f34:	00813483          	ld	s1,8(sp)
    80003f38:	00013903          	ld	s2,0(sp)
    80003f3c:	00004517          	auipc	a0,0x4
    80003f40:	57c50513          	addi	a0,a0,1404 # 800084b8 <cons>
    80003f44:	02010113          	addi	sp,sp,32
    80003f48:	00001317          	auipc	t1,0x1
    80003f4c:	eb030067          	jr	-336(t1) # 80004df8 <release>
    80003f50:	00a00493          	li	s1,10
    80003f54:	fc1ff06f          	j	80003f14 <consoleintr+0x50>

0000000080003f58 <consoleinit>:
    80003f58:	fe010113          	addi	sp,sp,-32
    80003f5c:	00113c23          	sd	ra,24(sp)
    80003f60:	00813823          	sd	s0,16(sp)
    80003f64:	00913423          	sd	s1,8(sp)
    80003f68:	02010413          	addi	s0,sp,32
    80003f6c:	00004497          	auipc	s1,0x4
    80003f70:	54c48493          	addi	s1,s1,1356 # 800084b8 <cons>
    80003f74:	00048513          	mv	a0,s1
    80003f78:	00002597          	auipc	a1,0x2
    80003f7c:	45858593          	addi	a1,a1,1112 # 800063d0 <CONSOLE_STATUS+0x3c0>
    80003f80:	00001097          	auipc	ra,0x1
    80003f84:	d88080e7          	jalr	-632(ra) # 80004d08 <initlock>
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	7ac080e7          	jalr	1964(ra) # 80004734 <uartinit>
    80003f90:	01813083          	ld	ra,24(sp)
    80003f94:	01013403          	ld	s0,16(sp)
    80003f98:	00000797          	auipc	a5,0x0
    80003f9c:	d9c78793          	addi	a5,a5,-612 # 80003d34 <consoleread>
    80003fa0:	0af4bc23          	sd	a5,184(s1)
    80003fa4:	00000797          	auipc	a5,0x0
    80003fa8:	cec78793          	addi	a5,a5,-788 # 80003c90 <consolewrite>
    80003fac:	0cf4b023          	sd	a5,192(s1)
    80003fb0:	00813483          	ld	s1,8(sp)
    80003fb4:	02010113          	addi	sp,sp,32
    80003fb8:	00008067          	ret

0000000080003fbc <console_read>:
    80003fbc:	ff010113          	addi	sp,sp,-16
    80003fc0:	00813423          	sd	s0,8(sp)
    80003fc4:	01010413          	addi	s0,sp,16
    80003fc8:	00813403          	ld	s0,8(sp)
    80003fcc:	00004317          	auipc	t1,0x4
    80003fd0:	5a433303          	ld	t1,1444(t1) # 80008570 <devsw+0x10>
    80003fd4:	01010113          	addi	sp,sp,16
    80003fd8:	00030067          	jr	t1

0000000080003fdc <console_write>:
    80003fdc:	ff010113          	addi	sp,sp,-16
    80003fe0:	00813423          	sd	s0,8(sp)
    80003fe4:	01010413          	addi	s0,sp,16
    80003fe8:	00813403          	ld	s0,8(sp)
    80003fec:	00004317          	auipc	t1,0x4
    80003ff0:	58c33303          	ld	t1,1420(t1) # 80008578 <devsw+0x18>
    80003ff4:	01010113          	addi	sp,sp,16
    80003ff8:	00030067          	jr	t1

0000000080003ffc <panic>:
    80003ffc:	fe010113          	addi	sp,sp,-32
    80004000:	00113c23          	sd	ra,24(sp)
    80004004:	00813823          	sd	s0,16(sp)
    80004008:	00913423          	sd	s1,8(sp)
    8000400c:	02010413          	addi	s0,sp,32
    80004010:	00050493          	mv	s1,a0
    80004014:	00002517          	auipc	a0,0x2
    80004018:	3c450513          	addi	a0,a0,964 # 800063d8 <CONSOLE_STATUS+0x3c8>
    8000401c:	00004797          	auipc	a5,0x4
    80004020:	5e07ae23          	sw	zero,1532(a5) # 80008618 <pr+0x18>
    80004024:	00000097          	auipc	ra,0x0
    80004028:	034080e7          	jalr	52(ra) # 80004058 <__printf>
    8000402c:	00048513          	mv	a0,s1
    80004030:	00000097          	auipc	ra,0x0
    80004034:	028080e7          	jalr	40(ra) # 80004058 <__printf>
    80004038:	00002517          	auipc	a0,0x2
    8000403c:	38050513          	addi	a0,a0,896 # 800063b8 <CONSOLE_STATUS+0x3a8>
    80004040:	00000097          	auipc	ra,0x0
    80004044:	018080e7          	jalr	24(ra) # 80004058 <__printf>
    80004048:	00100793          	li	a5,1
    8000404c:	00003717          	auipc	a4,0x3
    80004050:	2ef72e23          	sw	a5,764(a4) # 80007348 <panicked>
    80004054:	0000006f          	j	80004054 <panic+0x58>

0000000080004058 <__printf>:
    80004058:	f3010113          	addi	sp,sp,-208
    8000405c:	08813023          	sd	s0,128(sp)
    80004060:	07313423          	sd	s3,104(sp)
    80004064:	09010413          	addi	s0,sp,144
    80004068:	05813023          	sd	s8,64(sp)
    8000406c:	08113423          	sd	ra,136(sp)
    80004070:	06913c23          	sd	s1,120(sp)
    80004074:	07213823          	sd	s2,112(sp)
    80004078:	07413023          	sd	s4,96(sp)
    8000407c:	05513c23          	sd	s5,88(sp)
    80004080:	05613823          	sd	s6,80(sp)
    80004084:	05713423          	sd	s7,72(sp)
    80004088:	03913c23          	sd	s9,56(sp)
    8000408c:	03a13823          	sd	s10,48(sp)
    80004090:	03b13423          	sd	s11,40(sp)
    80004094:	00004317          	auipc	t1,0x4
    80004098:	56c30313          	addi	t1,t1,1388 # 80008600 <pr>
    8000409c:	01832c03          	lw	s8,24(t1)
    800040a0:	00b43423          	sd	a1,8(s0)
    800040a4:	00c43823          	sd	a2,16(s0)
    800040a8:	00d43c23          	sd	a3,24(s0)
    800040ac:	02e43023          	sd	a4,32(s0)
    800040b0:	02f43423          	sd	a5,40(s0)
    800040b4:	03043823          	sd	a6,48(s0)
    800040b8:	03143c23          	sd	a7,56(s0)
    800040bc:	00050993          	mv	s3,a0
    800040c0:	4a0c1663          	bnez	s8,8000456c <__printf+0x514>
    800040c4:	60098c63          	beqz	s3,800046dc <__printf+0x684>
    800040c8:	0009c503          	lbu	a0,0(s3)
    800040cc:	00840793          	addi	a5,s0,8
    800040d0:	f6f43c23          	sd	a5,-136(s0)
    800040d4:	00000493          	li	s1,0
    800040d8:	22050063          	beqz	a0,800042f8 <__printf+0x2a0>
    800040dc:	00002a37          	lui	s4,0x2
    800040e0:	00018ab7          	lui	s5,0x18
    800040e4:	000f4b37          	lui	s6,0xf4
    800040e8:	00989bb7          	lui	s7,0x989
    800040ec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800040f0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800040f4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800040f8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800040fc:	00148c9b          	addiw	s9,s1,1
    80004100:	02500793          	li	a5,37
    80004104:	01998933          	add	s2,s3,s9
    80004108:	38f51263          	bne	a0,a5,8000448c <__printf+0x434>
    8000410c:	00094783          	lbu	a5,0(s2)
    80004110:	00078c9b          	sext.w	s9,a5
    80004114:	1e078263          	beqz	a5,800042f8 <__printf+0x2a0>
    80004118:	0024849b          	addiw	s1,s1,2
    8000411c:	07000713          	li	a4,112
    80004120:	00998933          	add	s2,s3,s1
    80004124:	38e78a63          	beq	a5,a4,800044b8 <__printf+0x460>
    80004128:	20f76863          	bltu	a4,a5,80004338 <__printf+0x2e0>
    8000412c:	42a78863          	beq	a5,a0,8000455c <__printf+0x504>
    80004130:	06400713          	li	a4,100
    80004134:	40e79663          	bne	a5,a4,80004540 <__printf+0x4e8>
    80004138:	f7843783          	ld	a5,-136(s0)
    8000413c:	0007a603          	lw	a2,0(a5)
    80004140:	00878793          	addi	a5,a5,8
    80004144:	f6f43c23          	sd	a5,-136(s0)
    80004148:	42064a63          	bltz	a2,8000457c <__printf+0x524>
    8000414c:	00a00713          	li	a4,10
    80004150:	02e677bb          	remuw	a5,a2,a4
    80004154:	00002d97          	auipc	s11,0x2
    80004158:	2acd8d93          	addi	s11,s11,684 # 80006400 <digits>
    8000415c:	00900593          	li	a1,9
    80004160:	0006051b          	sext.w	a0,a2
    80004164:	00000c93          	li	s9,0
    80004168:	02079793          	slli	a5,a5,0x20
    8000416c:	0207d793          	srli	a5,a5,0x20
    80004170:	00fd87b3          	add	a5,s11,a5
    80004174:	0007c783          	lbu	a5,0(a5)
    80004178:	02e656bb          	divuw	a3,a2,a4
    8000417c:	f8f40023          	sb	a5,-128(s0)
    80004180:	14c5d863          	bge	a1,a2,800042d0 <__printf+0x278>
    80004184:	06300593          	li	a1,99
    80004188:	00100c93          	li	s9,1
    8000418c:	02e6f7bb          	remuw	a5,a3,a4
    80004190:	02079793          	slli	a5,a5,0x20
    80004194:	0207d793          	srli	a5,a5,0x20
    80004198:	00fd87b3          	add	a5,s11,a5
    8000419c:	0007c783          	lbu	a5,0(a5)
    800041a0:	02e6d73b          	divuw	a4,a3,a4
    800041a4:	f8f400a3          	sb	a5,-127(s0)
    800041a8:	12a5f463          	bgeu	a1,a0,800042d0 <__printf+0x278>
    800041ac:	00a00693          	li	a3,10
    800041b0:	00900593          	li	a1,9
    800041b4:	02d777bb          	remuw	a5,a4,a3
    800041b8:	02079793          	slli	a5,a5,0x20
    800041bc:	0207d793          	srli	a5,a5,0x20
    800041c0:	00fd87b3          	add	a5,s11,a5
    800041c4:	0007c503          	lbu	a0,0(a5)
    800041c8:	02d757bb          	divuw	a5,a4,a3
    800041cc:	f8a40123          	sb	a0,-126(s0)
    800041d0:	48e5f263          	bgeu	a1,a4,80004654 <__printf+0x5fc>
    800041d4:	06300513          	li	a0,99
    800041d8:	02d7f5bb          	remuw	a1,a5,a3
    800041dc:	02059593          	slli	a1,a1,0x20
    800041e0:	0205d593          	srli	a1,a1,0x20
    800041e4:	00bd85b3          	add	a1,s11,a1
    800041e8:	0005c583          	lbu	a1,0(a1)
    800041ec:	02d7d7bb          	divuw	a5,a5,a3
    800041f0:	f8b401a3          	sb	a1,-125(s0)
    800041f4:	48e57263          	bgeu	a0,a4,80004678 <__printf+0x620>
    800041f8:	3e700513          	li	a0,999
    800041fc:	02d7f5bb          	remuw	a1,a5,a3
    80004200:	02059593          	slli	a1,a1,0x20
    80004204:	0205d593          	srli	a1,a1,0x20
    80004208:	00bd85b3          	add	a1,s11,a1
    8000420c:	0005c583          	lbu	a1,0(a1)
    80004210:	02d7d7bb          	divuw	a5,a5,a3
    80004214:	f8b40223          	sb	a1,-124(s0)
    80004218:	46e57663          	bgeu	a0,a4,80004684 <__printf+0x62c>
    8000421c:	02d7f5bb          	remuw	a1,a5,a3
    80004220:	02059593          	slli	a1,a1,0x20
    80004224:	0205d593          	srli	a1,a1,0x20
    80004228:	00bd85b3          	add	a1,s11,a1
    8000422c:	0005c583          	lbu	a1,0(a1)
    80004230:	02d7d7bb          	divuw	a5,a5,a3
    80004234:	f8b402a3          	sb	a1,-123(s0)
    80004238:	46ea7863          	bgeu	s4,a4,800046a8 <__printf+0x650>
    8000423c:	02d7f5bb          	remuw	a1,a5,a3
    80004240:	02059593          	slli	a1,a1,0x20
    80004244:	0205d593          	srli	a1,a1,0x20
    80004248:	00bd85b3          	add	a1,s11,a1
    8000424c:	0005c583          	lbu	a1,0(a1)
    80004250:	02d7d7bb          	divuw	a5,a5,a3
    80004254:	f8b40323          	sb	a1,-122(s0)
    80004258:	3eeaf863          	bgeu	s5,a4,80004648 <__printf+0x5f0>
    8000425c:	02d7f5bb          	remuw	a1,a5,a3
    80004260:	02059593          	slli	a1,a1,0x20
    80004264:	0205d593          	srli	a1,a1,0x20
    80004268:	00bd85b3          	add	a1,s11,a1
    8000426c:	0005c583          	lbu	a1,0(a1)
    80004270:	02d7d7bb          	divuw	a5,a5,a3
    80004274:	f8b403a3          	sb	a1,-121(s0)
    80004278:	42eb7e63          	bgeu	s6,a4,800046b4 <__printf+0x65c>
    8000427c:	02d7f5bb          	remuw	a1,a5,a3
    80004280:	02059593          	slli	a1,a1,0x20
    80004284:	0205d593          	srli	a1,a1,0x20
    80004288:	00bd85b3          	add	a1,s11,a1
    8000428c:	0005c583          	lbu	a1,0(a1)
    80004290:	02d7d7bb          	divuw	a5,a5,a3
    80004294:	f8b40423          	sb	a1,-120(s0)
    80004298:	42ebfc63          	bgeu	s7,a4,800046d0 <__printf+0x678>
    8000429c:	02079793          	slli	a5,a5,0x20
    800042a0:	0207d793          	srli	a5,a5,0x20
    800042a4:	00fd8db3          	add	s11,s11,a5
    800042a8:	000dc703          	lbu	a4,0(s11)
    800042ac:	00a00793          	li	a5,10
    800042b0:	00900c93          	li	s9,9
    800042b4:	f8e404a3          	sb	a4,-119(s0)
    800042b8:	00065c63          	bgez	a2,800042d0 <__printf+0x278>
    800042bc:	f9040713          	addi	a4,s0,-112
    800042c0:	00f70733          	add	a4,a4,a5
    800042c4:	02d00693          	li	a3,45
    800042c8:	fed70823          	sb	a3,-16(a4)
    800042cc:	00078c93          	mv	s9,a5
    800042d0:	f8040793          	addi	a5,s0,-128
    800042d4:	01978cb3          	add	s9,a5,s9
    800042d8:	f7f40d13          	addi	s10,s0,-129
    800042dc:	000cc503          	lbu	a0,0(s9)
    800042e0:	fffc8c93          	addi	s9,s9,-1
    800042e4:	00000097          	auipc	ra,0x0
    800042e8:	b90080e7          	jalr	-1136(ra) # 80003e74 <consputc>
    800042ec:	ffac98e3          	bne	s9,s10,800042dc <__printf+0x284>
    800042f0:	00094503          	lbu	a0,0(s2)
    800042f4:	e00514e3          	bnez	a0,800040fc <__printf+0xa4>
    800042f8:	1a0c1663          	bnez	s8,800044a4 <__printf+0x44c>
    800042fc:	08813083          	ld	ra,136(sp)
    80004300:	08013403          	ld	s0,128(sp)
    80004304:	07813483          	ld	s1,120(sp)
    80004308:	07013903          	ld	s2,112(sp)
    8000430c:	06813983          	ld	s3,104(sp)
    80004310:	06013a03          	ld	s4,96(sp)
    80004314:	05813a83          	ld	s5,88(sp)
    80004318:	05013b03          	ld	s6,80(sp)
    8000431c:	04813b83          	ld	s7,72(sp)
    80004320:	04013c03          	ld	s8,64(sp)
    80004324:	03813c83          	ld	s9,56(sp)
    80004328:	03013d03          	ld	s10,48(sp)
    8000432c:	02813d83          	ld	s11,40(sp)
    80004330:	0d010113          	addi	sp,sp,208
    80004334:	00008067          	ret
    80004338:	07300713          	li	a4,115
    8000433c:	1ce78a63          	beq	a5,a4,80004510 <__printf+0x4b8>
    80004340:	07800713          	li	a4,120
    80004344:	1ee79e63          	bne	a5,a4,80004540 <__printf+0x4e8>
    80004348:	f7843783          	ld	a5,-136(s0)
    8000434c:	0007a703          	lw	a4,0(a5)
    80004350:	00878793          	addi	a5,a5,8
    80004354:	f6f43c23          	sd	a5,-136(s0)
    80004358:	28074263          	bltz	a4,800045dc <__printf+0x584>
    8000435c:	00002d97          	auipc	s11,0x2
    80004360:	0a4d8d93          	addi	s11,s11,164 # 80006400 <digits>
    80004364:	00f77793          	andi	a5,a4,15
    80004368:	00fd87b3          	add	a5,s11,a5
    8000436c:	0007c683          	lbu	a3,0(a5)
    80004370:	00f00613          	li	a2,15
    80004374:	0007079b          	sext.w	a5,a4
    80004378:	f8d40023          	sb	a3,-128(s0)
    8000437c:	0047559b          	srliw	a1,a4,0x4
    80004380:	0047569b          	srliw	a3,a4,0x4
    80004384:	00000c93          	li	s9,0
    80004388:	0ee65063          	bge	a2,a4,80004468 <__printf+0x410>
    8000438c:	00f6f693          	andi	a3,a3,15
    80004390:	00dd86b3          	add	a3,s11,a3
    80004394:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004398:	0087d79b          	srliw	a5,a5,0x8
    8000439c:	00100c93          	li	s9,1
    800043a0:	f8d400a3          	sb	a3,-127(s0)
    800043a4:	0cb67263          	bgeu	a2,a1,80004468 <__printf+0x410>
    800043a8:	00f7f693          	andi	a3,a5,15
    800043ac:	00dd86b3          	add	a3,s11,a3
    800043b0:	0006c583          	lbu	a1,0(a3)
    800043b4:	00f00613          	li	a2,15
    800043b8:	0047d69b          	srliw	a3,a5,0x4
    800043bc:	f8b40123          	sb	a1,-126(s0)
    800043c0:	0047d593          	srli	a1,a5,0x4
    800043c4:	28f67e63          	bgeu	a2,a5,80004660 <__printf+0x608>
    800043c8:	00f6f693          	andi	a3,a3,15
    800043cc:	00dd86b3          	add	a3,s11,a3
    800043d0:	0006c503          	lbu	a0,0(a3)
    800043d4:	0087d813          	srli	a6,a5,0x8
    800043d8:	0087d69b          	srliw	a3,a5,0x8
    800043dc:	f8a401a3          	sb	a0,-125(s0)
    800043e0:	28b67663          	bgeu	a2,a1,8000466c <__printf+0x614>
    800043e4:	00f6f693          	andi	a3,a3,15
    800043e8:	00dd86b3          	add	a3,s11,a3
    800043ec:	0006c583          	lbu	a1,0(a3)
    800043f0:	00c7d513          	srli	a0,a5,0xc
    800043f4:	00c7d69b          	srliw	a3,a5,0xc
    800043f8:	f8b40223          	sb	a1,-124(s0)
    800043fc:	29067a63          	bgeu	a2,a6,80004690 <__printf+0x638>
    80004400:	00f6f693          	andi	a3,a3,15
    80004404:	00dd86b3          	add	a3,s11,a3
    80004408:	0006c583          	lbu	a1,0(a3)
    8000440c:	0107d813          	srli	a6,a5,0x10
    80004410:	0107d69b          	srliw	a3,a5,0x10
    80004414:	f8b402a3          	sb	a1,-123(s0)
    80004418:	28a67263          	bgeu	a2,a0,8000469c <__printf+0x644>
    8000441c:	00f6f693          	andi	a3,a3,15
    80004420:	00dd86b3          	add	a3,s11,a3
    80004424:	0006c683          	lbu	a3,0(a3)
    80004428:	0147d79b          	srliw	a5,a5,0x14
    8000442c:	f8d40323          	sb	a3,-122(s0)
    80004430:	21067663          	bgeu	a2,a6,8000463c <__printf+0x5e4>
    80004434:	02079793          	slli	a5,a5,0x20
    80004438:	0207d793          	srli	a5,a5,0x20
    8000443c:	00fd8db3          	add	s11,s11,a5
    80004440:	000dc683          	lbu	a3,0(s11)
    80004444:	00800793          	li	a5,8
    80004448:	00700c93          	li	s9,7
    8000444c:	f8d403a3          	sb	a3,-121(s0)
    80004450:	00075c63          	bgez	a4,80004468 <__printf+0x410>
    80004454:	f9040713          	addi	a4,s0,-112
    80004458:	00f70733          	add	a4,a4,a5
    8000445c:	02d00693          	li	a3,45
    80004460:	fed70823          	sb	a3,-16(a4)
    80004464:	00078c93          	mv	s9,a5
    80004468:	f8040793          	addi	a5,s0,-128
    8000446c:	01978cb3          	add	s9,a5,s9
    80004470:	f7f40d13          	addi	s10,s0,-129
    80004474:	000cc503          	lbu	a0,0(s9)
    80004478:	fffc8c93          	addi	s9,s9,-1
    8000447c:	00000097          	auipc	ra,0x0
    80004480:	9f8080e7          	jalr	-1544(ra) # 80003e74 <consputc>
    80004484:	ff9d18e3          	bne	s10,s9,80004474 <__printf+0x41c>
    80004488:	0100006f          	j	80004498 <__printf+0x440>
    8000448c:	00000097          	auipc	ra,0x0
    80004490:	9e8080e7          	jalr	-1560(ra) # 80003e74 <consputc>
    80004494:	000c8493          	mv	s1,s9
    80004498:	00094503          	lbu	a0,0(s2)
    8000449c:	c60510e3          	bnez	a0,800040fc <__printf+0xa4>
    800044a0:	e40c0ee3          	beqz	s8,800042fc <__printf+0x2a4>
    800044a4:	00004517          	auipc	a0,0x4
    800044a8:	15c50513          	addi	a0,a0,348 # 80008600 <pr>
    800044ac:	00001097          	auipc	ra,0x1
    800044b0:	94c080e7          	jalr	-1716(ra) # 80004df8 <release>
    800044b4:	e49ff06f          	j	800042fc <__printf+0x2a4>
    800044b8:	f7843783          	ld	a5,-136(s0)
    800044bc:	03000513          	li	a0,48
    800044c0:	01000d13          	li	s10,16
    800044c4:	00878713          	addi	a4,a5,8
    800044c8:	0007bc83          	ld	s9,0(a5)
    800044cc:	f6e43c23          	sd	a4,-136(s0)
    800044d0:	00000097          	auipc	ra,0x0
    800044d4:	9a4080e7          	jalr	-1628(ra) # 80003e74 <consputc>
    800044d8:	07800513          	li	a0,120
    800044dc:	00000097          	auipc	ra,0x0
    800044e0:	998080e7          	jalr	-1640(ra) # 80003e74 <consputc>
    800044e4:	00002d97          	auipc	s11,0x2
    800044e8:	f1cd8d93          	addi	s11,s11,-228 # 80006400 <digits>
    800044ec:	03ccd793          	srli	a5,s9,0x3c
    800044f0:	00fd87b3          	add	a5,s11,a5
    800044f4:	0007c503          	lbu	a0,0(a5)
    800044f8:	fffd0d1b          	addiw	s10,s10,-1
    800044fc:	004c9c93          	slli	s9,s9,0x4
    80004500:	00000097          	auipc	ra,0x0
    80004504:	974080e7          	jalr	-1676(ra) # 80003e74 <consputc>
    80004508:	fe0d12e3          	bnez	s10,800044ec <__printf+0x494>
    8000450c:	f8dff06f          	j	80004498 <__printf+0x440>
    80004510:	f7843783          	ld	a5,-136(s0)
    80004514:	0007bc83          	ld	s9,0(a5)
    80004518:	00878793          	addi	a5,a5,8
    8000451c:	f6f43c23          	sd	a5,-136(s0)
    80004520:	000c9a63          	bnez	s9,80004534 <__printf+0x4dc>
    80004524:	1080006f          	j	8000462c <__printf+0x5d4>
    80004528:	001c8c93          	addi	s9,s9,1
    8000452c:	00000097          	auipc	ra,0x0
    80004530:	948080e7          	jalr	-1720(ra) # 80003e74 <consputc>
    80004534:	000cc503          	lbu	a0,0(s9)
    80004538:	fe0518e3          	bnez	a0,80004528 <__printf+0x4d0>
    8000453c:	f5dff06f          	j	80004498 <__printf+0x440>
    80004540:	02500513          	li	a0,37
    80004544:	00000097          	auipc	ra,0x0
    80004548:	930080e7          	jalr	-1744(ra) # 80003e74 <consputc>
    8000454c:	000c8513          	mv	a0,s9
    80004550:	00000097          	auipc	ra,0x0
    80004554:	924080e7          	jalr	-1756(ra) # 80003e74 <consputc>
    80004558:	f41ff06f          	j	80004498 <__printf+0x440>
    8000455c:	02500513          	li	a0,37
    80004560:	00000097          	auipc	ra,0x0
    80004564:	914080e7          	jalr	-1772(ra) # 80003e74 <consputc>
    80004568:	f31ff06f          	j	80004498 <__printf+0x440>
    8000456c:	00030513          	mv	a0,t1
    80004570:	00000097          	auipc	ra,0x0
    80004574:	7bc080e7          	jalr	1980(ra) # 80004d2c <acquire>
    80004578:	b4dff06f          	j	800040c4 <__printf+0x6c>
    8000457c:	40c0053b          	negw	a0,a2
    80004580:	00a00713          	li	a4,10
    80004584:	02e576bb          	remuw	a3,a0,a4
    80004588:	00002d97          	auipc	s11,0x2
    8000458c:	e78d8d93          	addi	s11,s11,-392 # 80006400 <digits>
    80004590:	ff700593          	li	a1,-9
    80004594:	02069693          	slli	a3,a3,0x20
    80004598:	0206d693          	srli	a3,a3,0x20
    8000459c:	00dd86b3          	add	a3,s11,a3
    800045a0:	0006c683          	lbu	a3,0(a3)
    800045a4:	02e557bb          	divuw	a5,a0,a4
    800045a8:	f8d40023          	sb	a3,-128(s0)
    800045ac:	10b65e63          	bge	a2,a1,800046c8 <__printf+0x670>
    800045b0:	06300593          	li	a1,99
    800045b4:	02e7f6bb          	remuw	a3,a5,a4
    800045b8:	02069693          	slli	a3,a3,0x20
    800045bc:	0206d693          	srli	a3,a3,0x20
    800045c0:	00dd86b3          	add	a3,s11,a3
    800045c4:	0006c683          	lbu	a3,0(a3)
    800045c8:	02e7d73b          	divuw	a4,a5,a4
    800045cc:	00200793          	li	a5,2
    800045d0:	f8d400a3          	sb	a3,-127(s0)
    800045d4:	bca5ece3          	bltu	a1,a0,800041ac <__printf+0x154>
    800045d8:	ce5ff06f          	j	800042bc <__printf+0x264>
    800045dc:	40e007bb          	negw	a5,a4
    800045e0:	00002d97          	auipc	s11,0x2
    800045e4:	e20d8d93          	addi	s11,s11,-480 # 80006400 <digits>
    800045e8:	00f7f693          	andi	a3,a5,15
    800045ec:	00dd86b3          	add	a3,s11,a3
    800045f0:	0006c583          	lbu	a1,0(a3)
    800045f4:	ff100613          	li	a2,-15
    800045f8:	0047d69b          	srliw	a3,a5,0x4
    800045fc:	f8b40023          	sb	a1,-128(s0)
    80004600:	0047d59b          	srliw	a1,a5,0x4
    80004604:	0ac75e63          	bge	a4,a2,800046c0 <__printf+0x668>
    80004608:	00f6f693          	andi	a3,a3,15
    8000460c:	00dd86b3          	add	a3,s11,a3
    80004610:	0006c603          	lbu	a2,0(a3)
    80004614:	00f00693          	li	a3,15
    80004618:	0087d79b          	srliw	a5,a5,0x8
    8000461c:	f8c400a3          	sb	a2,-127(s0)
    80004620:	d8b6e4e3          	bltu	a3,a1,800043a8 <__printf+0x350>
    80004624:	00200793          	li	a5,2
    80004628:	e2dff06f          	j	80004454 <__printf+0x3fc>
    8000462c:	00002c97          	auipc	s9,0x2
    80004630:	db4c8c93          	addi	s9,s9,-588 # 800063e0 <CONSOLE_STATUS+0x3d0>
    80004634:	02800513          	li	a0,40
    80004638:	ef1ff06f          	j	80004528 <__printf+0x4d0>
    8000463c:	00700793          	li	a5,7
    80004640:	00600c93          	li	s9,6
    80004644:	e0dff06f          	j	80004450 <__printf+0x3f8>
    80004648:	00700793          	li	a5,7
    8000464c:	00600c93          	li	s9,6
    80004650:	c69ff06f          	j	800042b8 <__printf+0x260>
    80004654:	00300793          	li	a5,3
    80004658:	00200c93          	li	s9,2
    8000465c:	c5dff06f          	j	800042b8 <__printf+0x260>
    80004660:	00300793          	li	a5,3
    80004664:	00200c93          	li	s9,2
    80004668:	de9ff06f          	j	80004450 <__printf+0x3f8>
    8000466c:	00400793          	li	a5,4
    80004670:	00300c93          	li	s9,3
    80004674:	dddff06f          	j	80004450 <__printf+0x3f8>
    80004678:	00400793          	li	a5,4
    8000467c:	00300c93          	li	s9,3
    80004680:	c39ff06f          	j	800042b8 <__printf+0x260>
    80004684:	00500793          	li	a5,5
    80004688:	00400c93          	li	s9,4
    8000468c:	c2dff06f          	j	800042b8 <__printf+0x260>
    80004690:	00500793          	li	a5,5
    80004694:	00400c93          	li	s9,4
    80004698:	db9ff06f          	j	80004450 <__printf+0x3f8>
    8000469c:	00600793          	li	a5,6
    800046a0:	00500c93          	li	s9,5
    800046a4:	dadff06f          	j	80004450 <__printf+0x3f8>
    800046a8:	00600793          	li	a5,6
    800046ac:	00500c93          	li	s9,5
    800046b0:	c09ff06f          	j	800042b8 <__printf+0x260>
    800046b4:	00800793          	li	a5,8
    800046b8:	00700c93          	li	s9,7
    800046bc:	bfdff06f          	j	800042b8 <__printf+0x260>
    800046c0:	00100793          	li	a5,1
    800046c4:	d91ff06f          	j	80004454 <__printf+0x3fc>
    800046c8:	00100793          	li	a5,1
    800046cc:	bf1ff06f          	j	800042bc <__printf+0x264>
    800046d0:	00900793          	li	a5,9
    800046d4:	00800c93          	li	s9,8
    800046d8:	be1ff06f          	j	800042b8 <__printf+0x260>
    800046dc:	00002517          	auipc	a0,0x2
    800046e0:	d0c50513          	addi	a0,a0,-756 # 800063e8 <CONSOLE_STATUS+0x3d8>
    800046e4:	00000097          	auipc	ra,0x0
    800046e8:	918080e7          	jalr	-1768(ra) # 80003ffc <panic>

00000000800046ec <printfinit>:
    800046ec:	fe010113          	addi	sp,sp,-32
    800046f0:	00813823          	sd	s0,16(sp)
    800046f4:	00913423          	sd	s1,8(sp)
    800046f8:	00113c23          	sd	ra,24(sp)
    800046fc:	02010413          	addi	s0,sp,32
    80004700:	00004497          	auipc	s1,0x4
    80004704:	f0048493          	addi	s1,s1,-256 # 80008600 <pr>
    80004708:	00048513          	mv	a0,s1
    8000470c:	00002597          	auipc	a1,0x2
    80004710:	cec58593          	addi	a1,a1,-788 # 800063f8 <CONSOLE_STATUS+0x3e8>
    80004714:	00000097          	auipc	ra,0x0
    80004718:	5f4080e7          	jalr	1524(ra) # 80004d08 <initlock>
    8000471c:	01813083          	ld	ra,24(sp)
    80004720:	01013403          	ld	s0,16(sp)
    80004724:	0004ac23          	sw	zero,24(s1)
    80004728:	00813483          	ld	s1,8(sp)
    8000472c:	02010113          	addi	sp,sp,32
    80004730:	00008067          	ret

0000000080004734 <uartinit>:
    80004734:	ff010113          	addi	sp,sp,-16
    80004738:	00813423          	sd	s0,8(sp)
    8000473c:	01010413          	addi	s0,sp,16
    80004740:	100007b7          	lui	a5,0x10000
    80004744:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004748:	f8000713          	li	a4,-128
    8000474c:	00e781a3          	sb	a4,3(a5)
    80004750:	00300713          	li	a4,3
    80004754:	00e78023          	sb	a4,0(a5)
    80004758:	000780a3          	sb	zero,1(a5)
    8000475c:	00e781a3          	sb	a4,3(a5)
    80004760:	00700693          	li	a3,7
    80004764:	00d78123          	sb	a3,2(a5)
    80004768:	00e780a3          	sb	a4,1(a5)
    8000476c:	00813403          	ld	s0,8(sp)
    80004770:	01010113          	addi	sp,sp,16
    80004774:	00008067          	ret

0000000080004778 <uartputc>:
    80004778:	00003797          	auipc	a5,0x3
    8000477c:	bd07a783          	lw	a5,-1072(a5) # 80007348 <panicked>
    80004780:	00078463          	beqz	a5,80004788 <uartputc+0x10>
    80004784:	0000006f          	j	80004784 <uartputc+0xc>
    80004788:	fd010113          	addi	sp,sp,-48
    8000478c:	02813023          	sd	s0,32(sp)
    80004790:	00913c23          	sd	s1,24(sp)
    80004794:	01213823          	sd	s2,16(sp)
    80004798:	01313423          	sd	s3,8(sp)
    8000479c:	02113423          	sd	ra,40(sp)
    800047a0:	03010413          	addi	s0,sp,48
    800047a4:	00003917          	auipc	s2,0x3
    800047a8:	bac90913          	addi	s2,s2,-1108 # 80007350 <uart_tx_r>
    800047ac:	00093783          	ld	a5,0(s2)
    800047b0:	00003497          	auipc	s1,0x3
    800047b4:	ba848493          	addi	s1,s1,-1112 # 80007358 <uart_tx_w>
    800047b8:	0004b703          	ld	a4,0(s1)
    800047bc:	02078693          	addi	a3,a5,32
    800047c0:	00050993          	mv	s3,a0
    800047c4:	02e69c63          	bne	a3,a4,800047fc <uartputc+0x84>
    800047c8:	00001097          	auipc	ra,0x1
    800047cc:	834080e7          	jalr	-1996(ra) # 80004ffc <push_on>
    800047d0:	00093783          	ld	a5,0(s2)
    800047d4:	0004b703          	ld	a4,0(s1)
    800047d8:	02078793          	addi	a5,a5,32
    800047dc:	00e79463          	bne	a5,a4,800047e4 <uartputc+0x6c>
    800047e0:	0000006f          	j	800047e0 <uartputc+0x68>
    800047e4:	00001097          	auipc	ra,0x1
    800047e8:	88c080e7          	jalr	-1908(ra) # 80005070 <pop_on>
    800047ec:	00093783          	ld	a5,0(s2)
    800047f0:	0004b703          	ld	a4,0(s1)
    800047f4:	02078693          	addi	a3,a5,32
    800047f8:	fce688e3          	beq	a3,a4,800047c8 <uartputc+0x50>
    800047fc:	01f77693          	andi	a3,a4,31
    80004800:	00004597          	auipc	a1,0x4
    80004804:	e2058593          	addi	a1,a1,-480 # 80008620 <uart_tx_buf>
    80004808:	00d586b3          	add	a3,a1,a3
    8000480c:	00170713          	addi	a4,a4,1
    80004810:	01368023          	sb	s3,0(a3)
    80004814:	00e4b023          	sd	a4,0(s1)
    80004818:	10000637          	lui	a2,0x10000
    8000481c:	02f71063          	bne	a4,a5,8000483c <uartputc+0xc4>
    80004820:	0340006f          	j	80004854 <uartputc+0xdc>
    80004824:	00074703          	lbu	a4,0(a4)
    80004828:	00f93023          	sd	a5,0(s2)
    8000482c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004830:	00093783          	ld	a5,0(s2)
    80004834:	0004b703          	ld	a4,0(s1)
    80004838:	00f70e63          	beq	a4,a5,80004854 <uartputc+0xdc>
    8000483c:	00564683          	lbu	a3,5(a2)
    80004840:	01f7f713          	andi	a4,a5,31
    80004844:	00e58733          	add	a4,a1,a4
    80004848:	0206f693          	andi	a3,a3,32
    8000484c:	00178793          	addi	a5,a5,1
    80004850:	fc069ae3          	bnez	a3,80004824 <uartputc+0xac>
    80004854:	02813083          	ld	ra,40(sp)
    80004858:	02013403          	ld	s0,32(sp)
    8000485c:	01813483          	ld	s1,24(sp)
    80004860:	01013903          	ld	s2,16(sp)
    80004864:	00813983          	ld	s3,8(sp)
    80004868:	03010113          	addi	sp,sp,48
    8000486c:	00008067          	ret

0000000080004870 <uartputc_sync>:
    80004870:	ff010113          	addi	sp,sp,-16
    80004874:	00813423          	sd	s0,8(sp)
    80004878:	01010413          	addi	s0,sp,16
    8000487c:	00003717          	auipc	a4,0x3
    80004880:	acc72703          	lw	a4,-1332(a4) # 80007348 <panicked>
    80004884:	02071663          	bnez	a4,800048b0 <uartputc_sync+0x40>
    80004888:	00050793          	mv	a5,a0
    8000488c:	100006b7          	lui	a3,0x10000
    80004890:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004894:	02077713          	andi	a4,a4,32
    80004898:	fe070ce3          	beqz	a4,80004890 <uartputc_sync+0x20>
    8000489c:	0ff7f793          	andi	a5,a5,255
    800048a0:	00f68023          	sb	a5,0(a3)
    800048a4:	00813403          	ld	s0,8(sp)
    800048a8:	01010113          	addi	sp,sp,16
    800048ac:	00008067          	ret
    800048b0:	0000006f          	j	800048b0 <uartputc_sync+0x40>

00000000800048b4 <uartstart>:
    800048b4:	ff010113          	addi	sp,sp,-16
    800048b8:	00813423          	sd	s0,8(sp)
    800048bc:	01010413          	addi	s0,sp,16
    800048c0:	00003617          	auipc	a2,0x3
    800048c4:	a9060613          	addi	a2,a2,-1392 # 80007350 <uart_tx_r>
    800048c8:	00003517          	auipc	a0,0x3
    800048cc:	a9050513          	addi	a0,a0,-1392 # 80007358 <uart_tx_w>
    800048d0:	00063783          	ld	a5,0(a2)
    800048d4:	00053703          	ld	a4,0(a0)
    800048d8:	04f70263          	beq	a4,a5,8000491c <uartstart+0x68>
    800048dc:	100005b7          	lui	a1,0x10000
    800048e0:	00004817          	auipc	a6,0x4
    800048e4:	d4080813          	addi	a6,a6,-704 # 80008620 <uart_tx_buf>
    800048e8:	01c0006f          	j	80004904 <uartstart+0x50>
    800048ec:	0006c703          	lbu	a4,0(a3)
    800048f0:	00f63023          	sd	a5,0(a2)
    800048f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800048f8:	00063783          	ld	a5,0(a2)
    800048fc:	00053703          	ld	a4,0(a0)
    80004900:	00f70e63          	beq	a4,a5,8000491c <uartstart+0x68>
    80004904:	01f7f713          	andi	a4,a5,31
    80004908:	00e806b3          	add	a3,a6,a4
    8000490c:	0055c703          	lbu	a4,5(a1)
    80004910:	00178793          	addi	a5,a5,1
    80004914:	02077713          	andi	a4,a4,32
    80004918:	fc071ae3          	bnez	a4,800048ec <uartstart+0x38>
    8000491c:	00813403          	ld	s0,8(sp)
    80004920:	01010113          	addi	sp,sp,16
    80004924:	00008067          	ret

0000000080004928 <uartgetc>:
    80004928:	ff010113          	addi	sp,sp,-16
    8000492c:	00813423          	sd	s0,8(sp)
    80004930:	01010413          	addi	s0,sp,16
    80004934:	10000737          	lui	a4,0x10000
    80004938:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000493c:	0017f793          	andi	a5,a5,1
    80004940:	00078c63          	beqz	a5,80004958 <uartgetc+0x30>
    80004944:	00074503          	lbu	a0,0(a4)
    80004948:	0ff57513          	andi	a0,a0,255
    8000494c:	00813403          	ld	s0,8(sp)
    80004950:	01010113          	addi	sp,sp,16
    80004954:	00008067          	ret
    80004958:	fff00513          	li	a0,-1
    8000495c:	ff1ff06f          	j	8000494c <uartgetc+0x24>

0000000080004960 <uartintr>:
    80004960:	100007b7          	lui	a5,0x10000
    80004964:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004968:	0017f793          	andi	a5,a5,1
    8000496c:	0a078463          	beqz	a5,80004a14 <uartintr+0xb4>
    80004970:	fe010113          	addi	sp,sp,-32
    80004974:	00813823          	sd	s0,16(sp)
    80004978:	00913423          	sd	s1,8(sp)
    8000497c:	00113c23          	sd	ra,24(sp)
    80004980:	02010413          	addi	s0,sp,32
    80004984:	100004b7          	lui	s1,0x10000
    80004988:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000498c:	0ff57513          	andi	a0,a0,255
    80004990:	fffff097          	auipc	ra,0xfffff
    80004994:	534080e7          	jalr	1332(ra) # 80003ec4 <consoleintr>
    80004998:	0054c783          	lbu	a5,5(s1)
    8000499c:	0017f793          	andi	a5,a5,1
    800049a0:	fe0794e3          	bnez	a5,80004988 <uartintr+0x28>
    800049a4:	00003617          	auipc	a2,0x3
    800049a8:	9ac60613          	addi	a2,a2,-1620 # 80007350 <uart_tx_r>
    800049ac:	00003517          	auipc	a0,0x3
    800049b0:	9ac50513          	addi	a0,a0,-1620 # 80007358 <uart_tx_w>
    800049b4:	00063783          	ld	a5,0(a2)
    800049b8:	00053703          	ld	a4,0(a0)
    800049bc:	04f70263          	beq	a4,a5,80004a00 <uartintr+0xa0>
    800049c0:	100005b7          	lui	a1,0x10000
    800049c4:	00004817          	auipc	a6,0x4
    800049c8:	c5c80813          	addi	a6,a6,-932 # 80008620 <uart_tx_buf>
    800049cc:	01c0006f          	j	800049e8 <uartintr+0x88>
    800049d0:	0006c703          	lbu	a4,0(a3)
    800049d4:	00f63023          	sd	a5,0(a2)
    800049d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800049dc:	00063783          	ld	a5,0(a2)
    800049e0:	00053703          	ld	a4,0(a0)
    800049e4:	00f70e63          	beq	a4,a5,80004a00 <uartintr+0xa0>
    800049e8:	01f7f713          	andi	a4,a5,31
    800049ec:	00e806b3          	add	a3,a6,a4
    800049f0:	0055c703          	lbu	a4,5(a1)
    800049f4:	00178793          	addi	a5,a5,1
    800049f8:	02077713          	andi	a4,a4,32
    800049fc:	fc071ae3          	bnez	a4,800049d0 <uartintr+0x70>
    80004a00:	01813083          	ld	ra,24(sp)
    80004a04:	01013403          	ld	s0,16(sp)
    80004a08:	00813483          	ld	s1,8(sp)
    80004a0c:	02010113          	addi	sp,sp,32
    80004a10:	00008067          	ret
    80004a14:	00003617          	auipc	a2,0x3
    80004a18:	93c60613          	addi	a2,a2,-1732 # 80007350 <uart_tx_r>
    80004a1c:	00003517          	auipc	a0,0x3
    80004a20:	93c50513          	addi	a0,a0,-1732 # 80007358 <uart_tx_w>
    80004a24:	00063783          	ld	a5,0(a2)
    80004a28:	00053703          	ld	a4,0(a0)
    80004a2c:	04f70263          	beq	a4,a5,80004a70 <uartintr+0x110>
    80004a30:	100005b7          	lui	a1,0x10000
    80004a34:	00004817          	auipc	a6,0x4
    80004a38:	bec80813          	addi	a6,a6,-1044 # 80008620 <uart_tx_buf>
    80004a3c:	01c0006f          	j	80004a58 <uartintr+0xf8>
    80004a40:	0006c703          	lbu	a4,0(a3)
    80004a44:	00f63023          	sd	a5,0(a2)
    80004a48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004a4c:	00063783          	ld	a5,0(a2)
    80004a50:	00053703          	ld	a4,0(a0)
    80004a54:	02f70063          	beq	a4,a5,80004a74 <uartintr+0x114>
    80004a58:	01f7f713          	andi	a4,a5,31
    80004a5c:	00e806b3          	add	a3,a6,a4
    80004a60:	0055c703          	lbu	a4,5(a1)
    80004a64:	00178793          	addi	a5,a5,1
    80004a68:	02077713          	andi	a4,a4,32
    80004a6c:	fc071ae3          	bnez	a4,80004a40 <uartintr+0xe0>
    80004a70:	00008067          	ret
    80004a74:	00008067          	ret

0000000080004a78 <kinit>:
    80004a78:	fc010113          	addi	sp,sp,-64
    80004a7c:	02913423          	sd	s1,40(sp)
    80004a80:	fffff7b7          	lui	a5,0xfffff
    80004a84:	00005497          	auipc	s1,0x5
    80004a88:	bbb48493          	addi	s1,s1,-1093 # 8000963f <end+0xfff>
    80004a8c:	02813823          	sd	s0,48(sp)
    80004a90:	01313c23          	sd	s3,24(sp)
    80004a94:	00f4f4b3          	and	s1,s1,a5
    80004a98:	02113c23          	sd	ra,56(sp)
    80004a9c:	03213023          	sd	s2,32(sp)
    80004aa0:	01413823          	sd	s4,16(sp)
    80004aa4:	01513423          	sd	s5,8(sp)
    80004aa8:	04010413          	addi	s0,sp,64
    80004aac:	000017b7          	lui	a5,0x1
    80004ab0:	01100993          	li	s3,17
    80004ab4:	00f487b3          	add	a5,s1,a5
    80004ab8:	01b99993          	slli	s3,s3,0x1b
    80004abc:	06f9e063          	bltu	s3,a5,80004b1c <kinit+0xa4>
    80004ac0:	00004a97          	auipc	s5,0x4
    80004ac4:	b80a8a93          	addi	s5,s5,-1152 # 80008640 <end>
    80004ac8:	0754ec63          	bltu	s1,s5,80004b40 <kinit+0xc8>
    80004acc:	0734fa63          	bgeu	s1,s3,80004b40 <kinit+0xc8>
    80004ad0:	00088a37          	lui	s4,0x88
    80004ad4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004ad8:	00003917          	auipc	s2,0x3
    80004adc:	88890913          	addi	s2,s2,-1912 # 80007360 <kmem>
    80004ae0:	00ca1a13          	slli	s4,s4,0xc
    80004ae4:	0140006f          	j	80004af8 <kinit+0x80>
    80004ae8:	000017b7          	lui	a5,0x1
    80004aec:	00f484b3          	add	s1,s1,a5
    80004af0:	0554e863          	bltu	s1,s5,80004b40 <kinit+0xc8>
    80004af4:	0534f663          	bgeu	s1,s3,80004b40 <kinit+0xc8>
    80004af8:	00001637          	lui	a2,0x1
    80004afc:	00100593          	li	a1,1
    80004b00:	00048513          	mv	a0,s1
    80004b04:	00000097          	auipc	ra,0x0
    80004b08:	5e4080e7          	jalr	1508(ra) # 800050e8 <__memset>
    80004b0c:	00093783          	ld	a5,0(s2)
    80004b10:	00f4b023          	sd	a5,0(s1)
    80004b14:	00993023          	sd	s1,0(s2)
    80004b18:	fd4498e3          	bne	s1,s4,80004ae8 <kinit+0x70>
    80004b1c:	03813083          	ld	ra,56(sp)
    80004b20:	03013403          	ld	s0,48(sp)
    80004b24:	02813483          	ld	s1,40(sp)
    80004b28:	02013903          	ld	s2,32(sp)
    80004b2c:	01813983          	ld	s3,24(sp)
    80004b30:	01013a03          	ld	s4,16(sp)
    80004b34:	00813a83          	ld	s5,8(sp)
    80004b38:	04010113          	addi	sp,sp,64
    80004b3c:	00008067          	ret
    80004b40:	00002517          	auipc	a0,0x2
    80004b44:	8d850513          	addi	a0,a0,-1832 # 80006418 <digits+0x18>
    80004b48:	fffff097          	auipc	ra,0xfffff
    80004b4c:	4b4080e7          	jalr	1204(ra) # 80003ffc <panic>

0000000080004b50 <freerange>:
    80004b50:	fc010113          	addi	sp,sp,-64
    80004b54:	000017b7          	lui	a5,0x1
    80004b58:	02913423          	sd	s1,40(sp)
    80004b5c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004b60:	009504b3          	add	s1,a0,s1
    80004b64:	fffff537          	lui	a0,0xfffff
    80004b68:	02813823          	sd	s0,48(sp)
    80004b6c:	02113c23          	sd	ra,56(sp)
    80004b70:	03213023          	sd	s2,32(sp)
    80004b74:	01313c23          	sd	s3,24(sp)
    80004b78:	01413823          	sd	s4,16(sp)
    80004b7c:	01513423          	sd	s5,8(sp)
    80004b80:	01613023          	sd	s6,0(sp)
    80004b84:	04010413          	addi	s0,sp,64
    80004b88:	00a4f4b3          	and	s1,s1,a0
    80004b8c:	00f487b3          	add	a5,s1,a5
    80004b90:	06f5e463          	bltu	a1,a5,80004bf8 <freerange+0xa8>
    80004b94:	00004a97          	auipc	s5,0x4
    80004b98:	aaca8a93          	addi	s5,s5,-1364 # 80008640 <end>
    80004b9c:	0954e263          	bltu	s1,s5,80004c20 <freerange+0xd0>
    80004ba0:	01100993          	li	s3,17
    80004ba4:	01b99993          	slli	s3,s3,0x1b
    80004ba8:	0734fc63          	bgeu	s1,s3,80004c20 <freerange+0xd0>
    80004bac:	00058a13          	mv	s4,a1
    80004bb0:	00002917          	auipc	s2,0x2
    80004bb4:	7b090913          	addi	s2,s2,1968 # 80007360 <kmem>
    80004bb8:	00002b37          	lui	s6,0x2
    80004bbc:	0140006f          	j	80004bd0 <freerange+0x80>
    80004bc0:	000017b7          	lui	a5,0x1
    80004bc4:	00f484b3          	add	s1,s1,a5
    80004bc8:	0554ec63          	bltu	s1,s5,80004c20 <freerange+0xd0>
    80004bcc:	0534fa63          	bgeu	s1,s3,80004c20 <freerange+0xd0>
    80004bd0:	00001637          	lui	a2,0x1
    80004bd4:	00100593          	li	a1,1
    80004bd8:	00048513          	mv	a0,s1
    80004bdc:	00000097          	auipc	ra,0x0
    80004be0:	50c080e7          	jalr	1292(ra) # 800050e8 <__memset>
    80004be4:	00093703          	ld	a4,0(s2)
    80004be8:	016487b3          	add	a5,s1,s6
    80004bec:	00e4b023          	sd	a4,0(s1)
    80004bf0:	00993023          	sd	s1,0(s2)
    80004bf4:	fcfa76e3          	bgeu	s4,a5,80004bc0 <freerange+0x70>
    80004bf8:	03813083          	ld	ra,56(sp)
    80004bfc:	03013403          	ld	s0,48(sp)
    80004c00:	02813483          	ld	s1,40(sp)
    80004c04:	02013903          	ld	s2,32(sp)
    80004c08:	01813983          	ld	s3,24(sp)
    80004c0c:	01013a03          	ld	s4,16(sp)
    80004c10:	00813a83          	ld	s5,8(sp)
    80004c14:	00013b03          	ld	s6,0(sp)
    80004c18:	04010113          	addi	sp,sp,64
    80004c1c:	00008067          	ret
    80004c20:	00001517          	auipc	a0,0x1
    80004c24:	7f850513          	addi	a0,a0,2040 # 80006418 <digits+0x18>
    80004c28:	fffff097          	auipc	ra,0xfffff
    80004c2c:	3d4080e7          	jalr	980(ra) # 80003ffc <panic>

0000000080004c30 <kfree>:
    80004c30:	fe010113          	addi	sp,sp,-32
    80004c34:	00813823          	sd	s0,16(sp)
    80004c38:	00113c23          	sd	ra,24(sp)
    80004c3c:	00913423          	sd	s1,8(sp)
    80004c40:	02010413          	addi	s0,sp,32
    80004c44:	03451793          	slli	a5,a0,0x34
    80004c48:	04079c63          	bnez	a5,80004ca0 <kfree+0x70>
    80004c4c:	00004797          	auipc	a5,0x4
    80004c50:	9f478793          	addi	a5,a5,-1548 # 80008640 <end>
    80004c54:	00050493          	mv	s1,a0
    80004c58:	04f56463          	bltu	a0,a5,80004ca0 <kfree+0x70>
    80004c5c:	01100793          	li	a5,17
    80004c60:	01b79793          	slli	a5,a5,0x1b
    80004c64:	02f57e63          	bgeu	a0,a5,80004ca0 <kfree+0x70>
    80004c68:	00001637          	lui	a2,0x1
    80004c6c:	00100593          	li	a1,1
    80004c70:	00000097          	auipc	ra,0x0
    80004c74:	478080e7          	jalr	1144(ra) # 800050e8 <__memset>
    80004c78:	00002797          	auipc	a5,0x2
    80004c7c:	6e878793          	addi	a5,a5,1768 # 80007360 <kmem>
    80004c80:	0007b703          	ld	a4,0(a5)
    80004c84:	01813083          	ld	ra,24(sp)
    80004c88:	01013403          	ld	s0,16(sp)
    80004c8c:	00e4b023          	sd	a4,0(s1)
    80004c90:	0097b023          	sd	s1,0(a5)
    80004c94:	00813483          	ld	s1,8(sp)
    80004c98:	02010113          	addi	sp,sp,32
    80004c9c:	00008067          	ret
    80004ca0:	00001517          	auipc	a0,0x1
    80004ca4:	77850513          	addi	a0,a0,1912 # 80006418 <digits+0x18>
    80004ca8:	fffff097          	auipc	ra,0xfffff
    80004cac:	354080e7          	jalr	852(ra) # 80003ffc <panic>

0000000080004cb0 <kalloc>:
    80004cb0:	fe010113          	addi	sp,sp,-32
    80004cb4:	00813823          	sd	s0,16(sp)
    80004cb8:	00913423          	sd	s1,8(sp)
    80004cbc:	00113c23          	sd	ra,24(sp)
    80004cc0:	02010413          	addi	s0,sp,32
    80004cc4:	00002797          	auipc	a5,0x2
    80004cc8:	69c78793          	addi	a5,a5,1692 # 80007360 <kmem>
    80004ccc:	0007b483          	ld	s1,0(a5)
    80004cd0:	02048063          	beqz	s1,80004cf0 <kalloc+0x40>
    80004cd4:	0004b703          	ld	a4,0(s1)
    80004cd8:	00001637          	lui	a2,0x1
    80004cdc:	00500593          	li	a1,5
    80004ce0:	00048513          	mv	a0,s1
    80004ce4:	00e7b023          	sd	a4,0(a5)
    80004ce8:	00000097          	auipc	ra,0x0
    80004cec:	400080e7          	jalr	1024(ra) # 800050e8 <__memset>
    80004cf0:	01813083          	ld	ra,24(sp)
    80004cf4:	01013403          	ld	s0,16(sp)
    80004cf8:	00048513          	mv	a0,s1
    80004cfc:	00813483          	ld	s1,8(sp)
    80004d00:	02010113          	addi	sp,sp,32
    80004d04:	00008067          	ret

0000000080004d08 <initlock>:
    80004d08:	ff010113          	addi	sp,sp,-16
    80004d0c:	00813423          	sd	s0,8(sp)
    80004d10:	01010413          	addi	s0,sp,16
    80004d14:	00813403          	ld	s0,8(sp)
    80004d18:	00b53423          	sd	a1,8(a0)
    80004d1c:	00052023          	sw	zero,0(a0)
    80004d20:	00053823          	sd	zero,16(a0)
    80004d24:	01010113          	addi	sp,sp,16
    80004d28:	00008067          	ret

0000000080004d2c <acquire>:
    80004d2c:	fe010113          	addi	sp,sp,-32
    80004d30:	00813823          	sd	s0,16(sp)
    80004d34:	00913423          	sd	s1,8(sp)
    80004d38:	00113c23          	sd	ra,24(sp)
    80004d3c:	01213023          	sd	s2,0(sp)
    80004d40:	02010413          	addi	s0,sp,32
    80004d44:	00050493          	mv	s1,a0
    80004d48:	10002973          	csrr	s2,sstatus
    80004d4c:	100027f3          	csrr	a5,sstatus
    80004d50:	ffd7f793          	andi	a5,a5,-3
    80004d54:	10079073          	csrw	sstatus,a5
    80004d58:	fffff097          	auipc	ra,0xfffff
    80004d5c:	8e8080e7          	jalr	-1816(ra) # 80003640 <mycpu>
    80004d60:	07852783          	lw	a5,120(a0)
    80004d64:	06078e63          	beqz	a5,80004de0 <acquire+0xb4>
    80004d68:	fffff097          	auipc	ra,0xfffff
    80004d6c:	8d8080e7          	jalr	-1832(ra) # 80003640 <mycpu>
    80004d70:	07852783          	lw	a5,120(a0)
    80004d74:	0004a703          	lw	a4,0(s1)
    80004d78:	0017879b          	addiw	a5,a5,1
    80004d7c:	06f52c23          	sw	a5,120(a0)
    80004d80:	04071063          	bnez	a4,80004dc0 <acquire+0x94>
    80004d84:	00100713          	li	a4,1
    80004d88:	00070793          	mv	a5,a4
    80004d8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004d90:	0007879b          	sext.w	a5,a5
    80004d94:	fe079ae3          	bnez	a5,80004d88 <acquire+0x5c>
    80004d98:	0ff0000f          	fence
    80004d9c:	fffff097          	auipc	ra,0xfffff
    80004da0:	8a4080e7          	jalr	-1884(ra) # 80003640 <mycpu>
    80004da4:	01813083          	ld	ra,24(sp)
    80004da8:	01013403          	ld	s0,16(sp)
    80004dac:	00a4b823          	sd	a0,16(s1)
    80004db0:	00013903          	ld	s2,0(sp)
    80004db4:	00813483          	ld	s1,8(sp)
    80004db8:	02010113          	addi	sp,sp,32
    80004dbc:	00008067          	ret
    80004dc0:	0104b903          	ld	s2,16(s1)
    80004dc4:	fffff097          	auipc	ra,0xfffff
    80004dc8:	87c080e7          	jalr	-1924(ra) # 80003640 <mycpu>
    80004dcc:	faa91ce3          	bne	s2,a0,80004d84 <acquire+0x58>
    80004dd0:	00001517          	auipc	a0,0x1
    80004dd4:	65050513          	addi	a0,a0,1616 # 80006420 <digits+0x20>
    80004dd8:	fffff097          	auipc	ra,0xfffff
    80004ddc:	224080e7          	jalr	548(ra) # 80003ffc <panic>
    80004de0:	00195913          	srli	s2,s2,0x1
    80004de4:	fffff097          	auipc	ra,0xfffff
    80004de8:	85c080e7          	jalr	-1956(ra) # 80003640 <mycpu>
    80004dec:	00197913          	andi	s2,s2,1
    80004df0:	07252e23          	sw	s2,124(a0)
    80004df4:	f75ff06f          	j	80004d68 <acquire+0x3c>

0000000080004df8 <release>:
    80004df8:	fe010113          	addi	sp,sp,-32
    80004dfc:	00813823          	sd	s0,16(sp)
    80004e00:	00113c23          	sd	ra,24(sp)
    80004e04:	00913423          	sd	s1,8(sp)
    80004e08:	01213023          	sd	s2,0(sp)
    80004e0c:	02010413          	addi	s0,sp,32
    80004e10:	00052783          	lw	a5,0(a0)
    80004e14:	00079a63          	bnez	a5,80004e28 <release+0x30>
    80004e18:	00001517          	auipc	a0,0x1
    80004e1c:	61050513          	addi	a0,a0,1552 # 80006428 <digits+0x28>
    80004e20:	fffff097          	auipc	ra,0xfffff
    80004e24:	1dc080e7          	jalr	476(ra) # 80003ffc <panic>
    80004e28:	01053903          	ld	s2,16(a0)
    80004e2c:	00050493          	mv	s1,a0
    80004e30:	fffff097          	auipc	ra,0xfffff
    80004e34:	810080e7          	jalr	-2032(ra) # 80003640 <mycpu>
    80004e38:	fea910e3          	bne	s2,a0,80004e18 <release+0x20>
    80004e3c:	0004b823          	sd	zero,16(s1)
    80004e40:	0ff0000f          	fence
    80004e44:	0f50000f          	fence	iorw,ow
    80004e48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004e4c:	ffffe097          	auipc	ra,0xffffe
    80004e50:	7f4080e7          	jalr	2036(ra) # 80003640 <mycpu>
    80004e54:	100027f3          	csrr	a5,sstatus
    80004e58:	0027f793          	andi	a5,a5,2
    80004e5c:	04079a63          	bnez	a5,80004eb0 <release+0xb8>
    80004e60:	07852783          	lw	a5,120(a0)
    80004e64:	02f05e63          	blez	a5,80004ea0 <release+0xa8>
    80004e68:	fff7871b          	addiw	a4,a5,-1
    80004e6c:	06e52c23          	sw	a4,120(a0)
    80004e70:	00071c63          	bnez	a4,80004e88 <release+0x90>
    80004e74:	07c52783          	lw	a5,124(a0)
    80004e78:	00078863          	beqz	a5,80004e88 <release+0x90>
    80004e7c:	100027f3          	csrr	a5,sstatus
    80004e80:	0027e793          	ori	a5,a5,2
    80004e84:	10079073          	csrw	sstatus,a5
    80004e88:	01813083          	ld	ra,24(sp)
    80004e8c:	01013403          	ld	s0,16(sp)
    80004e90:	00813483          	ld	s1,8(sp)
    80004e94:	00013903          	ld	s2,0(sp)
    80004e98:	02010113          	addi	sp,sp,32
    80004e9c:	00008067          	ret
    80004ea0:	00001517          	auipc	a0,0x1
    80004ea4:	5a850513          	addi	a0,a0,1448 # 80006448 <digits+0x48>
    80004ea8:	fffff097          	auipc	ra,0xfffff
    80004eac:	154080e7          	jalr	340(ra) # 80003ffc <panic>
    80004eb0:	00001517          	auipc	a0,0x1
    80004eb4:	58050513          	addi	a0,a0,1408 # 80006430 <digits+0x30>
    80004eb8:	fffff097          	auipc	ra,0xfffff
    80004ebc:	144080e7          	jalr	324(ra) # 80003ffc <panic>

0000000080004ec0 <holding>:
    80004ec0:	00052783          	lw	a5,0(a0)
    80004ec4:	00079663          	bnez	a5,80004ed0 <holding+0x10>
    80004ec8:	00000513          	li	a0,0
    80004ecc:	00008067          	ret
    80004ed0:	fe010113          	addi	sp,sp,-32
    80004ed4:	00813823          	sd	s0,16(sp)
    80004ed8:	00913423          	sd	s1,8(sp)
    80004edc:	00113c23          	sd	ra,24(sp)
    80004ee0:	02010413          	addi	s0,sp,32
    80004ee4:	01053483          	ld	s1,16(a0)
    80004ee8:	ffffe097          	auipc	ra,0xffffe
    80004eec:	758080e7          	jalr	1880(ra) # 80003640 <mycpu>
    80004ef0:	01813083          	ld	ra,24(sp)
    80004ef4:	01013403          	ld	s0,16(sp)
    80004ef8:	40a48533          	sub	a0,s1,a0
    80004efc:	00153513          	seqz	a0,a0
    80004f00:	00813483          	ld	s1,8(sp)
    80004f04:	02010113          	addi	sp,sp,32
    80004f08:	00008067          	ret

0000000080004f0c <push_off>:
    80004f0c:	fe010113          	addi	sp,sp,-32
    80004f10:	00813823          	sd	s0,16(sp)
    80004f14:	00113c23          	sd	ra,24(sp)
    80004f18:	00913423          	sd	s1,8(sp)
    80004f1c:	02010413          	addi	s0,sp,32
    80004f20:	100024f3          	csrr	s1,sstatus
    80004f24:	100027f3          	csrr	a5,sstatus
    80004f28:	ffd7f793          	andi	a5,a5,-3
    80004f2c:	10079073          	csrw	sstatus,a5
    80004f30:	ffffe097          	auipc	ra,0xffffe
    80004f34:	710080e7          	jalr	1808(ra) # 80003640 <mycpu>
    80004f38:	07852783          	lw	a5,120(a0)
    80004f3c:	02078663          	beqz	a5,80004f68 <push_off+0x5c>
    80004f40:	ffffe097          	auipc	ra,0xffffe
    80004f44:	700080e7          	jalr	1792(ra) # 80003640 <mycpu>
    80004f48:	07852783          	lw	a5,120(a0)
    80004f4c:	01813083          	ld	ra,24(sp)
    80004f50:	01013403          	ld	s0,16(sp)
    80004f54:	0017879b          	addiw	a5,a5,1
    80004f58:	06f52c23          	sw	a5,120(a0)
    80004f5c:	00813483          	ld	s1,8(sp)
    80004f60:	02010113          	addi	sp,sp,32
    80004f64:	00008067          	ret
    80004f68:	0014d493          	srli	s1,s1,0x1
    80004f6c:	ffffe097          	auipc	ra,0xffffe
    80004f70:	6d4080e7          	jalr	1748(ra) # 80003640 <mycpu>
    80004f74:	0014f493          	andi	s1,s1,1
    80004f78:	06952e23          	sw	s1,124(a0)
    80004f7c:	fc5ff06f          	j	80004f40 <push_off+0x34>

0000000080004f80 <pop_off>:
    80004f80:	ff010113          	addi	sp,sp,-16
    80004f84:	00813023          	sd	s0,0(sp)
    80004f88:	00113423          	sd	ra,8(sp)
    80004f8c:	01010413          	addi	s0,sp,16
    80004f90:	ffffe097          	auipc	ra,0xffffe
    80004f94:	6b0080e7          	jalr	1712(ra) # 80003640 <mycpu>
    80004f98:	100027f3          	csrr	a5,sstatus
    80004f9c:	0027f793          	andi	a5,a5,2
    80004fa0:	04079663          	bnez	a5,80004fec <pop_off+0x6c>
    80004fa4:	07852783          	lw	a5,120(a0)
    80004fa8:	02f05a63          	blez	a5,80004fdc <pop_off+0x5c>
    80004fac:	fff7871b          	addiw	a4,a5,-1
    80004fb0:	06e52c23          	sw	a4,120(a0)
    80004fb4:	00071c63          	bnez	a4,80004fcc <pop_off+0x4c>
    80004fb8:	07c52783          	lw	a5,124(a0)
    80004fbc:	00078863          	beqz	a5,80004fcc <pop_off+0x4c>
    80004fc0:	100027f3          	csrr	a5,sstatus
    80004fc4:	0027e793          	ori	a5,a5,2
    80004fc8:	10079073          	csrw	sstatus,a5
    80004fcc:	00813083          	ld	ra,8(sp)
    80004fd0:	00013403          	ld	s0,0(sp)
    80004fd4:	01010113          	addi	sp,sp,16
    80004fd8:	00008067          	ret
    80004fdc:	00001517          	auipc	a0,0x1
    80004fe0:	46c50513          	addi	a0,a0,1132 # 80006448 <digits+0x48>
    80004fe4:	fffff097          	auipc	ra,0xfffff
    80004fe8:	018080e7          	jalr	24(ra) # 80003ffc <panic>
    80004fec:	00001517          	auipc	a0,0x1
    80004ff0:	44450513          	addi	a0,a0,1092 # 80006430 <digits+0x30>
    80004ff4:	fffff097          	auipc	ra,0xfffff
    80004ff8:	008080e7          	jalr	8(ra) # 80003ffc <panic>

0000000080004ffc <push_on>:
    80004ffc:	fe010113          	addi	sp,sp,-32
    80005000:	00813823          	sd	s0,16(sp)
    80005004:	00113c23          	sd	ra,24(sp)
    80005008:	00913423          	sd	s1,8(sp)
    8000500c:	02010413          	addi	s0,sp,32
    80005010:	100024f3          	csrr	s1,sstatus
    80005014:	100027f3          	csrr	a5,sstatus
    80005018:	0027e793          	ori	a5,a5,2
    8000501c:	10079073          	csrw	sstatus,a5
    80005020:	ffffe097          	auipc	ra,0xffffe
    80005024:	620080e7          	jalr	1568(ra) # 80003640 <mycpu>
    80005028:	07852783          	lw	a5,120(a0)
    8000502c:	02078663          	beqz	a5,80005058 <push_on+0x5c>
    80005030:	ffffe097          	auipc	ra,0xffffe
    80005034:	610080e7          	jalr	1552(ra) # 80003640 <mycpu>
    80005038:	07852783          	lw	a5,120(a0)
    8000503c:	01813083          	ld	ra,24(sp)
    80005040:	01013403          	ld	s0,16(sp)
    80005044:	0017879b          	addiw	a5,a5,1
    80005048:	06f52c23          	sw	a5,120(a0)
    8000504c:	00813483          	ld	s1,8(sp)
    80005050:	02010113          	addi	sp,sp,32
    80005054:	00008067          	ret
    80005058:	0014d493          	srli	s1,s1,0x1
    8000505c:	ffffe097          	auipc	ra,0xffffe
    80005060:	5e4080e7          	jalr	1508(ra) # 80003640 <mycpu>
    80005064:	0014f493          	andi	s1,s1,1
    80005068:	06952e23          	sw	s1,124(a0)
    8000506c:	fc5ff06f          	j	80005030 <push_on+0x34>

0000000080005070 <pop_on>:
    80005070:	ff010113          	addi	sp,sp,-16
    80005074:	00813023          	sd	s0,0(sp)
    80005078:	00113423          	sd	ra,8(sp)
    8000507c:	01010413          	addi	s0,sp,16
    80005080:	ffffe097          	auipc	ra,0xffffe
    80005084:	5c0080e7          	jalr	1472(ra) # 80003640 <mycpu>
    80005088:	100027f3          	csrr	a5,sstatus
    8000508c:	0027f793          	andi	a5,a5,2
    80005090:	04078463          	beqz	a5,800050d8 <pop_on+0x68>
    80005094:	07852783          	lw	a5,120(a0)
    80005098:	02f05863          	blez	a5,800050c8 <pop_on+0x58>
    8000509c:	fff7879b          	addiw	a5,a5,-1
    800050a0:	06f52c23          	sw	a5,120(a0)
    800050a4:	07853783          	ld	a5,120(a0)
    800050a8:	00079863          	bnez	a5,800050b8 <pop_on+0x48>
    800050ac:	100027f3          	csrr	a5,sstatus
    800050b0:	ffd7f793          	andi	a5,a5,-3
    800050b4:	10079073          	csrw	sstatus,a5
    800050b8:	00813083          	ld	ra,8(sp)
    800050bc:	00013403          	ld	s0,0(sp)
    800050c0:	01010113          	addi	sp,sp,16
    800050c4:	00008067          	ret
    800050c8:	00001517          	auipc	a0,0x1
    800050cc:	3a850513          	addi	a0,a0,936 # 80006470 <digits+0x70>
    800050d0:	fffff097          	auipc	ra,0xfffff
    800050d4:	f2c080e7          	jalr	-212(ra) # 80003ffc <panic>
    800050d8:	00001517          	auipc	a0,0x1
    800050dc:	37850513          	addi	a0,a0,888 # 80006450 <digits+0x50>
    800050e0:	fffff097          	auipc	ra,0xfffff
    800050e4:	f1c080e7          	jalr	-228(ra) # 80003ffc <panic>

00000000800050e8 <__memset>:
    800050e8:	ff010113          	addi	sp,sp,-16
    800050ec:	00813423          	sd	s0,8(sp)
    800050f0:	01010413          	addi	s0,sp,16
    800050f4:	1a060e63          	beqz	a2,800052b0 <__memset+0x1c8>
    800050f8:	40a007b3          	neg	a5,a0
    800050fc:	0077f793          	andi	a5,a5,7
    80005100:	00778693          	addi	a3,a5,7
    80005104:	00b00813          	li	a6,11
    80005108:	0ff5f593          	andi	a1,a1,255
    8000510c:	fff6071b          	addiw	a4,a2,-1
    80005110:	1b06e663          	bltu	a3,a6,800052bc <__memset+0x1d4>
    80005114:	1cd76463          	bltu	a4,a3,800052dc <__memset+0x1f4>
    80005118:	1a078e63          	beqz	a5,800052d4 <__memset+0x1ec>
    8000511c:	00b50023          	sb	a1,0(a0)
    80005120:	00100713          	li	a4,1
    80005124:	1ae78463          	beq	a5,a4,800052cc <__memset+0x1e4>
    80005128:	00b500a3          	sb	a1,1(a0)
    8000512c:	00200713          	li	a4,2
    80005130:	1ae78a63          	beq	a5,a4,800052e4 <__memset+0x1fc>
    80005134:	00b50123          	sb	a1,2(a0)
    80005138:	00300713          	li	a4,3
    8000513c:	18e78463          	beq	a5,a4,800052c4 <__memset+0x1dc>
    80005140:	00b501a3          	sb	a1,3(a0)
    80005144:	00400713          	li	a4,4
    80005148:	1ae78263          	beq	a5,a4,800052ec <__memset+0x204>
    8000514c:	00b50223          	sb	a1,4(a0)
    80005150:	00500713          	li	a4,5
    80005154:	1ae78063          	beq	a5,a4,800052f4 <__memset+0x20c>
    80005158:	00b502a3          	sb	a1,5(a0)
    8000515c:	00700713          	li	a4,7
    80005160:	18e79e63          	bne	a5,a4,800052fc <__memset+0x214>
    80005164:	00b50323          	sb	a1,6(a0)
    80005168:	00700e93          	li	t4,7
    8000516c:	00859713          	slli	a4,a1,0x8
    80005170:	00e5e733          	or	a4,a1,a4
    80005174:	01059e13          	slli	t3,a1,0x10
    80005178:	01c76e33          	or	t3,a4,t3
    8000517c:	01859313          	slli	t1,a1,0x18
    80005180:	006e6333          	or	t1,t3,t1
    80005184:	02059893          	slli	a7,a1,0x20
    80005188:	40f60e3b          	subw	t3,a2,a5
    8000518c:	011368b3          	or	a7,t1,a7
    80005190:	02859813          	slli	a6,a1,0x28
    80005194:	0108e833          	or	a6,a7,a6
    80005198:	03059693          	slli	a3,a1,0x30
    8000519c:	003e589b          	srliw	a7,t3,0x3
    800051a0:	00d866b3          	or	a3,a6,a3
    800051a4:	03859713          	slli	a4,a1,0x38
    800051a8:	00389813          	slli	a6,a7,0x3
    800051ac:	00f507b3          	add	a5,a0,a5
    800051b0:	00e6e733          	or	a4,a3,a4
    800051b4:	000e089b          	sext.w	a7,t3
    800051b8:	00f806b3          	add	a3,a6,a5
    800051bc:	00e7b023          	sd	a4,0(a5)
    800051c0:	00878793          	addi	a5,a5,8
    800051c4:	fed79ce3          	bne	a5,a3,800051bc <__memset+0xd4>
    800051c8:	ff8e7793          	andi	a5,t3,-8
    800051cc:	0007871b          	sext.w	a4,a5
    800051d0:	01d787bb          	addw	a5,a5,t4
    800051d4:	0ce88e63          	beq	a7,a4,800052b0 <__memset+0x1c8>
    800051d8:	00f50733          	add	a4,a0,a5
    800051dc:	00b70023          	sb	a1,0(a4)
    800051e0:	0017871b          	addiw	a4,a5,1
    800051e4:	0cc77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    800051e8:	00e50733          	add	a4,a0,a4
    800051ec:	00b70023          	sb	a1,0(a4)
    800051f0:	0027871b          	addiw	a4,a5,2
    800051f4:	0ac77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    800051f8:	00e50733          	add	a4,a0,a4
    800051fc:	00b70023          	sb	a1,0(a4)
    80005200:	0037871b          	addiw	a4,a5,3
    80005204:	0ac77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005208:	00e50733          	add	a4,a0,a4
    8000520c:	00b70023          	sb	a1,0(a4)
    80005210:	0047871b          	addiw	a4,a5,4
    80005214:	08c77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005218:	00e50733          	add	a4,a0,a4
    8000521c:	00b70023          	sb	a1,0(a4)
    80005220:	0057871b          	addiw	a4,a5,5
    80005224:	08c77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005228:	00e50733          	add	a4,a0,a4
    8000522c:	00b70023          	sb	a1,0(a4)
    80005230:	0067871b          	addiw	a4,a5,6
    80005234:	06c77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005238:	00e50733          	add	a4,a0,a4
    8000523c:	00b70023          	sb	a1,0(a4)
    80005240:	0077871b          	addiw	a4,a5,7
    80005244:	06c77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005248:	00e50733          	add	a4,a0,a4
    8000524c:	00b70023          	sb	a1,0(a4)
    80005250:	0087871b          	addiw	a4,a5,8
    80005254:	04c77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005258:	00e50733          	add	a4,a0,a4
    8000525c:	00b70023          	sb	a1,0(a4)
    80005260:	0097871b          	addiw	a4,a5,9
    80005264:	04c77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005268:	00e50733          	add	a4,a0,a4
    8000526c:	00b70023          	sb	a1,0(a4)
    80005270:	00a7871b          	addiw	a4,a5,10
    80005274:	02c77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005278:	00e50733          	add	a4,a0,a4
    8000527c:	00b70023          	sb	a1,0(a4)
    80005280:	00b7871b          	addiw	a4,a5,11
    80005284:	02c77663          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005288:	00e50733          	add	a4,a0,a4
    8000528c:	00b70023          	sb	a1,0(a4)
    80005290:	00c7871b          	addiw	a4,a5,12
    80005294:	00c77e63          	bgeu	a4,a2,800052b0 <__memset+0x1c8>
    80005298:	00e50733          	add	a4,a0,a4
    8000529c:	00b70023          	sb	a1,0(a4)
    800052a0:	00d7879b          	addiw	a5,a5,13
    800052a4:	00c7f663          	bgeu	a5,a2,800052b0 <__memset+0x1c8>
    800052a8:	00f507b3          	add	a5,a0,a5
    800052ac:	00b78023          	sb	a1,0(a5)
    800052b0:	00813403          	ld	s0,8(sp)
    800052b4:	01010113          	addi	sp,sp,16
    800052b8:	00008067          	ret
    800052bc:	00b00693          	li	a3,11
    800052c0:	e55ff06f          	j	80005114 <__memset+0x2c>
    800052c4:	00300e93          	li	t4,3
    800052c8:	ea5ff06f          	j	8000516c <__memset+0x84>
    800052cc:	00100e93          	li	t4,1
    800052d0:	e9dff06f          	j	8000516c <__memset+0x84>
    800052d4:	00000e93          	li	t4,0
    800052d8:	e95ff06f          	j	8000516c <__memset+0x84>
    800052dc:	00000793          	li	a5,0
    800052e0:	ef9ff06f          	j	800051d8 <__memset+0xf0>
    800052e4:	00200e93          	li	t4,2
    800052e8:	e85ff06f          	j	8000516c <__memset+0x84>
    800052ec:	00400e93          	li	t4,4
    800052f0:	e7dff06f          	j	8000516c <__memset+0x84>
    800052f4:	00500e93          	li	t4,5
    800052f8:	e75ff06f          	j	8000516c <__memset+0x84>
    800052fc:	00600e93          	li	t4,6
    80005300:	e6dff06f          	j	8000516c <__memset+0x84>

0000000080005304 <__memmove>:
    80005304:	ff010113          	addi	sp,sp,-16
    80005308:	00813423          	sd	s0,8(sp)
    8000530c:	01010413          	addi	s0,sp,16
    80005310:	0e060863          	beqz	a2,80005400 <__memmove+0xfc>
    80005314:	fff6069b          	addiw	a3,a2,-1
    80005318:	0006881b          	sext.w	a6,a3
    8000531c:	0ea5e863          	bltu	a1,a0,8000540c <__memmove+0x108>
    80005320:	00758713          	addi	a4,a1,7
    80005324:	00a5e7b3          	or	a5,a1,a0
    80005328:	40a70733          	sub	a4,a4,a0
    8000532c:	0077f793          	andi	a5,a5,7
    80005330:	00f73713          	sltiu	a4,a4,15
    80005334:	00174713          	xori	a4,a4,1
    80005338:	0017b793          	seqz	a5,a5
    8000533c:	00e7f7b3          	and	a5,a5,a4
    80005340:	10078863          	beqz	a5,80005450 <__memmove+0x14c>
    80005344:	00900793          	li	a5,9
    80005348:	1107f463          	bgeu	a5,a6,80005450 <__memmove+0x14c>
    8000534c:	0036581b          	srliw	a6,a2,0x3
    80005350:	fff8081b          	addiw	a6,a6,-1
    80005354:	02081813          	slli	a6,a6,0x20
    80005358:	01d85893          	srli	a7,a6,0x1d
    8000535c:	00858813          	addi	a6,a1,8
    80005360:	00058793          	mv	a5,a1
    80005364:	00050713          	mv	a4,a0
    80005368:	01088833          	add	a6,a7,a6
    8000536c:	0007b883          	ld	a7,0(a5)
    80005370:	00878793          	addi	a5,a5,8
    80005374:	00870713          	addi	a4,a4,8
    80005378:	ff173c23          	sd	a7,-8(a4)
    8000537c:	ff0798e3          	bne	a5,a6,8000536c <__memmove+0x68>
    80005380:	ff867713          	andi	a4,a2,-8
    80005384:	02071793          	slli	a5,a4,0x20
    80005388:	0207d793          	srli	a5,a5,0x20
    8000538c:	00f585b3          	add	a1,a1,a5
    80005390:	40e686bb          	subw	a3,a3,a4
    80005394:	00f507b3          	add	a5,a0,a5
    80005398:	06e60463          	beq	a2,a4,80005400 <__memmove+0xfc>
    8000539c:	0005c703          	lbu	a4,0(a1)
    800053a0:	00e78023          	sb	a4,0(a5)
    800053a4:	04068e63          	beqz	a3,80005400 <__memmove+0xfc>
    800053a8:	0015c603          	lbu	a2,1(a1)
    800053ac:	00100713          	li	a4,1
    800053b0:	00c780a3          	sb	a2,1(a5)
    800053b4:	04e68663          	beq	a3,a4,80005400 <__memmove+0xfc>
    800053b8:	0025c603          	lbu	a2,2(a1)
    800053bc:	00200713          	li	a4,2
    800053c0:	00c78123          	sb	a2,2(a5)
    800053c4:	02e68e63          	beq	a3,a4,80005400 <__memmove+0xfc>
    800053c8:	0035c603          	lbu	a2,3(a1)
    800053cc:	00300713          	li	a4,3
    800053d0:	00c781a3          	sb	a2,3(a5)
    800053d4:	02e68663          	beq	a3,a4,80005400 <__memmove+0xfc>
    800053d8:	0045c603          	lbu	a2,4(a1)
    800053dc:	00400713          	li	a4,4
    800053e0:	00c78223          	sb	a2,4(a5)
    800053e4:	00e68e63          	beq	a3,a4,80005400 <__memmove+0xfc>
    800053e8:	0055c603          	lbu	a2,5(a1)
    800053ec:	00500713          	li	a4,5
    800053f0:	00c782a3          	sb	a2,5(a5)
    800053f4:	00e68663          	beq	a3,a4,80005400 <__memmove+0xfc>
    800053f8:	0065c703          	lbu	a4,6(a1)
    800053fc:	00e78323          	sb	a4,6(a5)
    80005400:	00813403          	ld	s0,8(sp)
    80005404:	01010113          	addi	sp,sp,16
    80005408:	00008067          	ret
    8000540c:	02061713          	slli	a4,a2,0x20
    80005410:	02075713          	srli	a4,a4,0x20
    80005414:	00e587b3          	add	a5,a1,a4
    80005418:	f0f574e3          	bgeu	a0,a5,80005320 <__memmove+0x1c>
    8000541c:	02069613          	slli	a2,a3,0x20
    80005420:	02065613          	srli	a2,a2,0x20
    80005424:	fff64613          	not	a2,a2
    80005428:	00e50733          	add	a4,a0,a4
    8000542c:	00c78633          	add	a2,a5,a2
    80005430:	fff7c683          	lbu	a3,-1(a5)
    80005434:	fff78793          	addi	a5,a5,-1
    80005438:	fff70713          	addi	a4,a4,-1
    8000543c:	00d70023          	sb	a3,0(a4)
    80005440:	fec798e3          	bne	a5,a2,80005430 <__memmove+0x12c>
    80005444:	00813403          	ld	s0,8(sp)
    80005448:	01010113          	addi	sp,sp,16
    8000544c:	00008067          	ret
    80005450:	02069713          	slli	a4,a3,0x20
    80005454:	02075713          	srli	a4,a4,0x20
    80005458:	00170713          	addi	a4,a4,1
    8000545c:	00e50733          	add	a4,a0,a4
    80005460:	00050793          	mv	a5,a0
    80005464:	0005c683          	lbu	a3,0(a1)
    80005468:	00178793          	addi	a5,a5,1
    8000546c:	00158593          	addi	a1,a1,1
    80005470:	fed78fa3          	sb	a3,-1(a5)
    80005474:	fee798e3          	bne	a5,a4,80005464 <__memmove+0x160>
    80005478:	f89ff06f          	j	80005400 <__memmove+0xfc>

000000008000547c <__putc>:
    8000547c:	fe010113          	addi	sp,sp,-32
    80005480:	00813823          	sd	s0,16(sp)
    80005484:	00113c23          	sd	ra,24(sp)
    80005488:	02010413          	addi	s0,sp,32
    8000548c:	00050793          	mv	a5,a0
    80005490:	fef40593          	addi	a1,s0,-17
    80005494:	00100613          	li	a2,1
    80005498:	00000513          	li	a0,0
    8000549c:	fef407a3          	sb	a5,-17(s0)
    800054a0:	fffff097          	auipc	ra,0xfffff
    800054a4:	b3c080e7          	jalr	-1220(ra) # 80003fdc <console_write>
    800054a8:	01813083          	ld	ra,24(sp)
    800054ac:	01013403          	ld	s0,16(sp)
    800054b0:	02010113          	addi	sp,sp,32
    800054b4:	00008067          	ret

00000000800054b8 <__getc>:
    800054b8:	fe010113          	addi	sp,sp,-32
    800054bc:	00813823          	sd	s0,16(sp)
    800054c0:	00113c23          	sd	ra,24(sp)
    800054c4:	02010413          	addi	s0,sp,32
    800054c8:	fe840593          	addi	a1,s0,-24
    800054cc:	00100613          	li	a2,1
    800054d0:	00000513          	li	a0,0
    800054d4:	fffff097          	auipc	ra,0xfffff
    800054d8:	ae8080e7          	jalr	-1304(ra) # 80003fbc <console_read>
    800054dc:	fe844503          	lbu	a0,-24(s0)
    800054e0:	01813083          	ld	ra,24(sp)
    800054e4:	01013403          	ld	s0,16(sp)
    800054e8:	02010113          	addi	sp,sp,32
    800054ec:	00008067          	ret

00000000800054f0 <console_handler>:
    800054f0:	fe010113          	addi	sp,sp,-32
    800054f4:	00813823          	sd	s0,16(sp)
    800054f8:	00113c23          	sd	ra,24(sp)
    800054fc:	00913423          	sd	s1,8(sp)
    80005500:	02010413          	addi	s0,sp,32
    80005504:	14202773          	csrr	a4,scause
    80005508:	100027f3          	csrr	a5,sstatus
    8000550c:	0027f793          	andi	a5,a5,2
    80005510:	06079e63          	bnez	a5,8000558c <console_handler+0x9c>
    80005514:	00074c63          	bltz	a4,8000552c <console_handler+0x3c>
    80005518:	01813083          	ld	ra,24(sp)
    8000551c:	01013403          	ld	s0,16(sp)
    80005520:	00813483          	ld	s1,8(sp)
    80005524:	02010113          	addi	sp,sp,32
    80005528:	00008067          	ret
    8000552c:	0ff77713          	andi	a4,a4,255
    80005530:	00900793          	li	a5,9
    80005534:	fef712e3          	bne	a4,a5,80005518 <console_handler+0x28>
    80005538:	ffffe097          	auipc	ra,0xffffe
    8000553c:	6dc080e7          	jalr	1756(ra) # 80003c14 <plic_claim>
    80005540:	00a00793          	li	a5,10
    80005544:	00050493          	mv	s1,a0
    80005548:	02f50c63          	beq	a0,a5,80005580 <console_handler+0x90>
    8000554c:	fc0506e3          	beqz	a0,80005518 <console_handler+0x28>
    80005550:	00050593          	mv	a1,a0
    80005554:	00001517          	auipc	a0,0x1
    80005558:	e2450513          	addi	a0,a0,-476 # 80006378 <CONSOLE_STATUS+0x368>
    8000555c:	fffff097          	auipc	ra,0xfffff
    80005560:	afc080e7          	jalr	-1284(ra) # 80004058 <__printf>
    80005564:	01013403          	ld	s0,16(sp)
    80005568:	01813083          	ld	ra,24(sp)
    8000556c:	00048513          	mv	a0,s1
    80005570:	00813483          	ld	s1,8(sp)
    80005574:	02010113          	addi	sp,sp,32
    80005578:	ffffe317          	auipc	t1,0xffffe
    8000557c:	6d430067          	jr	1748(t1) # 80003c4c <plic_complete>
    80005580:	fffff097          	auipc	ra,0xfffff
    80005584:	3e0080e7          	jalr	992(ra) # 80004960 <uartintr>
    80005588:	fddff06f          	j	80005564 <console_handler+0x74>
    8000558c:	00001517          	auipc	a0,0x1
    80005590:	eec50513          	addi	a0,a0,-276 # 80006478 <digits+0x78>
    80005594:	fffff097          	auipc	ra,0xfffff
    80005598:	a68080e7          	jalr	-1432(ra) # 80003ffc <panic>
	...
