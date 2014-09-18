-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  coherence_pkg.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 21/oct/2008
-- 
-- Information      :  Synthesis : -x-x-x-x-
--                     Simulator : ModelSim
-- 
-- ---------------------------------------------------------------------------------
-- >>>  Proprietary Information                                                  <<<
-- =================================================================================

-- Libraries
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

package coherence_pkg is

   constant COHER_TAGWIDTH  : integer := 2;
   constant COHER_MODIFIED  : std_logic_vector(COHER_TAGWIDTH-1 downto 0) := "11";
   constant COHER_EXCLUSIVE : std_logic_vector(COHER_TAGWIDTH-1 downto 0) := "10";
   constant COHER_SHARED    : std_logic_vector(COHER_TAGWIDTH-1 downto 0) := "01";
   constant COHER_INVALID   : std_logic_vector(COHER_TAGWIDTH-1 downto 0) := "00";

end;

--package body coherence_pkg is
--
--end;
