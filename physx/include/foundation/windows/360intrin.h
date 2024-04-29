#pragma once

#ifdef PURPL_XBOX360
#define _BitScanReverse(result, value) \
    __asm { \
        cntlzw result, value \
        subi result, result, 32 \
        li 3, 31 \
1:      \
        beq 2fh \
        slwi 0, 1, 5 \
        and. 0, 0, value \
        beq 2fh \
        mr result, 3 \
2:      \
        bdnz 1bh \
    }

#define _BitScanForward(result, value) \
    __asm { \
        cntlzw result, value \
        subi result, result, 32 \
        li 3, 0 \
1:      \
        beq 2fh \
        slwi 0, 1, 5 \
        and. 0, 0, value \
        beq 2fh \
        mr result, 3 \
2:      \
        bdz 1bh \
    }

#define _mm_prefetch(address, hint) \
    __asm { \
        nop \
    }
#endif
