--                                                                      --
--            miniMIPS Processor : Address calculation stage            --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

entity pps_pf is
port (
    clock       : in bus1;
    reset       : in bus1;
    stop_all    : in bus1;   			-- Unconditionnal locking of the pipeline stage

    -- Asynchronous inputs
    --bra_cmd     : in bus1;   			-- Branch
    bra_cmd_pr  : in bus1;        -- Branch which have a priority on stop_pf (bad prediction branch)
    bra_adr     : in bus32;       -- Address to load when an effective branch -- Endereço do desvio
    exch_cmd    : in bus1;   			-- Exception branch
    exch_adr    : in bus32;       -- Exception vector
    stop_pf     : in bus1;   			-- Lock the stage

    -- Synchronous output to EI stage
    PF_pc       : out bus32       -- PC value
);
end pps_pf;

architecture rtl of pps_pf is

    signal suivant : bus32;       -- Preparation of the future pc
    signal pc_interne : bus32;    -- Value of the pc output, needed for an internal reading
    signal lock : bus1;       		-- Specify the authorization of the pc evolution

begin

    -- Connexion the pc to the internal pc
    PF_pc <= pc_interne;

    -- Elaboration of an potential future pc
    suivant <= exch_adr when exch_cmd='1'   else
               bra_adr  when bra_cmd_pr='1' else
              -- bra_adr  when bra_cmd='1'    else
               bus32(unsigned(pc_interne) + 4);

    lock <= '1' when stop_all='1' else -- Lock this stage when all the pipeline is locked
            '0' when exch_cmd='1' else -- Exception
            '0' when bra_cmd_pr='1' else -- Bad prediction restoration
            '1' when stop_pf='1'  else -- Wait for the data hazard
          --  '0' when bra_cmd='1'  else -- Branch
            '0';                       -- Normal evolution

    -- Synchronous evolution of the pc
    process(clock)
    begin
        if clock='1' and clock'event then
            if reset='1' then
                -- PC reinitialisation with the boot address
                pc_interne <= ADR_INIT;
            elsif lock='0' then
                -- PC not locked
                pc_interne <= suivant;
            else
                pc_interne <= pc_interne;
            end if;
        end if;
    end process;

end rtl;
