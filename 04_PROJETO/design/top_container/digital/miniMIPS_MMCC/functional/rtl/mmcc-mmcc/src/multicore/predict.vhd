------------------------------------------------------------------------------------
--                                                                                --
--    Copyright (c) 2004, Hangouet Samuel                                         --
--                  , Jan Sebastien                                               --
--                  , Mouton Louis-Marie                                          --
--                  , Schneider Olivier     all rights reserved                   --
--                                                                                --
--    This file is part of miniMIPS.                                              --
--                                                                                --
--    miniMIPS is free software; you can redistribute it and/or modify            --
--    it under the terms of the GNU Lesser General Public License as published by --
--    the Free Software Foundation; either version 2.1 of the License, or         --
--    (at your option) any later version.                                         --
--                                                                                --
--    miniMIPS is distributed in the hope that it will be useful,                 --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of              --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               --
--    GNU Lesser General Public License for more details.                         --
--                                                                                --
--    You should have received a copy of the GNU Lesser General Public License    --
--    along with miniMIPS; if not, write to the Free Software                     --
--    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   --
--                                                                                --
------------------------------------------------------------------------------------


-- If you encountered any problem, please contact :
--
--   lmouton@enserg.fr
--   oschneid@enserg.fr
--   shangoue@enserg.fr
--



--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
--                miniMIPS Processor : Branch prediction                --
--                                                                      --
--                                                                      --
--                                                                      --
-- Author  : Olivier Schneider                                          --
--                                                                      --
--                                                          june 2004   --
--------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;


entity predict is
generic (
    nb_record : integer := 3
);
port (

    clock : in std_logic;
    reset : in std_logic;

    -- Datas from PF pipeline stage
    PF_pc  : in std_logic_vector(31 downto 0);      -- PC of the current instruction extracted

    -- Datas from DI pipeline stage
    DI_bra : in std_logic;                          -- Branch detected
    DI_adr : in std_logic_vector(31 downto 0);      -- Address of the branch

    -- Datas from EX pipeline stage
    EX_bra_confirm : in std_logic;                  -- Confirm if the branch test is ok
    EX_adr : in std_logic_vector(31 downto 0);      -- Address of the branch
    EX_adresse : in std_logic_vector(31 downto 0);  -- Result of the branch
    EX_uncleared : in std_logic;                    -- Define if the EX stage is cleared               

    -- Outputs to PF pipeline stage
    PR_bra_cmd : out std_logic;                     -- Defined a branch
    PR_bra_bad : out std_logic;                     -- Defined a branch to restore from a bad prediction
    PR_bra_adr : out std_logic_vector(31 downto 0); -- New PC

    -- Clear the three pipeline stage : EI, DI, EX
    PR_clear : out std_logic
);
end entity;


architecture rtl of predict is

begin

   -- Clear the pipeline and branch to the new instruction
   PR_bra_bad  <= EX_bra_confirm;
   PR_bra_adr  <= EX_adresse when EX_bra_confirm = '1' else (others => '0');
   PR_clear    <= EX_bra_confirm;
   PR_bra_cmd  <= '0';

end rtl;

