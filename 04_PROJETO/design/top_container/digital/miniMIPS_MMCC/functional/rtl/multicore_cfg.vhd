-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  multicore_cfg.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 12/nov/2008
-- 
-- Information      :  Synthesis : -x-x-x-x-
--                     Simulator : ModelSim
-- 
-- ---------------------------------------------------------------------------------
-- >>>  Proprietary Information                                                  <<<
-- =================================================================================

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

library work;
   use work.utils_pkg.all;

package multicore_cfg is

   -- Number of CPU's
   constant CPU_NUM           : integer := 2;                  -- Number of processors

   -- Data cache
   constant DCACHE_SIZE       : integer := 2048;               -- Size of cache - in bytes 
   constant DCACHE_LINE_SIZE  : integer := 32;                 -- Line size - in bytes
   constant DCACHE_DATA_WIDTH : integer := 32;                 -- Read data widht - in bits
   constant DCACHE_ADDR_WIDTH : integer := 32;                 -- Number of cached memory address bits

   -- Data mmu
   constant DMMU_PAGE_SIZE    : integer  := 2**12;             -- Size of data mmu page
   constant DMMU_TLB_NUM      : integer  := 8;                 -- TLB number
                                                               -- Initial data mmu setup

   -- First register (even = 0, 2, 4, ...)
   ----------------------
   --| Virtual addr tag |
   ----------------------

   -- Second register (odd = 1, 3, 5, ...)
   ----------------------------------------------------------
   --| VALID | WR_EN | RD_EN | EX_EN | CACHE_EN | Real addr |
   ----------------------------------------------------------

   constant DTLB_INIT : slv32vec := (
     -- Core #0 TLB_INIT:
     X"E8000010", X"00000010", X"E8000011", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #1 TLB_INIT:
     X"E8000012", X"00000010", X"E8000013", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #2 TLB_INIT:
     X"E8000014", X"00000010", X"E8000015", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #3 TLB_INIT:
     X"E8000016", X"00000010", X"E8000017", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #4 TLB_INIT:
     X"E8000018", X"00000010", X"E8000019", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #5 TLB_INIT:
     X"E800001A", X"00000010", X"E800001B", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #6 TLB_INIT:
     X"E800001C", X"00000010", X"E800001D", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #7 TLB_INIT:     
     X"E800001E", X"00000010", X"E800001F", X"00000011",
     X"E0000030", X"00000030", X"E8000020", X"00000014",
     X"E8000021", X"00000015", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000"
   );
   
   -- Instruction cache
   constant ICACHE_SIZE       : integer := 2048;               -- Size of cache - in bytes 
   constant ICACHE_LINE_SIZE  : integer := 32;                 -- Line size - in bytes
   constant ICACHE_DATA_WIDTH : integer := 32;                 -- Read data widht - in bits
   constant ICACHE_ADDR_WIDTH : integer := 32;                 -- Number of cached memory address bits

   -- Instruction mmu
   constant IMMU_PAGE_SIZE    : integer  := 2**16;             -- Size of instruction mmu page
   constant IMMU_TLB_NUM      : integer  := 4;                 -- TLB number
                                                               -- Initial instuction mmu setup
   constant ITLB_INIT         : slv32vec := (
     -- Core #0 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #1 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #2 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #3 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #4 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #5 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #6 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000",
     -- Core #7 TLB_INIT
     X"98000000", X"00000000", X"00000000", X"00000000",
     X"00000000", X"00000000", X"00000000", X"00000000"
   );
   
   -- Memory controllers
   constant SRAM_BASE_ADDRESS : integer := 16#00010000#;       -- Base address
   constant SRAM_MEM_SIZE     : integer := 16#00012000#;       -- Memory size
   constant SRAM_IF_NUM       : integer := 16#00000000#;       -- Number of interfaces
   constant SRAM_WAIT_STATES  : integer range 0 to 255 := 2;   -- Wait states
   constant SRAM_DATA_WIDTH   : integer := 32;                 -- Data width - in bits
   constant SRAM_ADDR_WIDTH   : integer := 32;                 -- Address width - in bits

   constant ROM_BASE_ADDRESS  : integer := 16#00000000#;       -- Base address
   constant ROM_MEM_SIZE      : integer := 16#00010000#;       -- Memory size
   constant ROM_IF_NUM        : integer := 16#00000000#;       -- Number of interfaces
   constant ROM_WAIT_STATES   : integer range 0 to 255 := 2;   -- Wait states
   constant ROM_DATA_WIDTH    : integer := 32;                 -- Data width - in bits
   constant ROM_ADDR_WIDTH    : integer := 32;                 -- Address width - in bits

   constant PER_BASE_ADDRESS  : integer := 16#00030000#;       -- Base address
   constant PER_MEM_SIZE      : integer := 16#00002000#;       -- Memory size
   constant PER_IF_NUM        : integer := 16#00000000#;       -- Number of interfaces
   constant PER_WAIT_STATES   : integer range 0 to 255 := 2;   -- Wait states
   constant PER_DATA_WIDTH    : integer := 32;                 -- Data width - in bits
   constant PER_ADDR_WIDTH    : integer := 32;                 -- Address width - in bits

end;

--package body multicore_cfg is

--end;
