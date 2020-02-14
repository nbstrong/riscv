-- A 32-bit RISC-V Processor
-- Nicholas Strong
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--------------------------------------------------------------------------------
entity riscv is
    generic (
        WIDTH : natural := 32
    );
    port (
        clkIn  : in    std_logic;
        rstIn  : in    std_logic;
        wrIn   : in    std_logic;
        dataIn : in    std_logic_vector(WIDTH-1 downto 0)
    );
end riscv;
--------------------------------------------------------------------------------
architecture behav of riscv is
    -- CONSTANTS ---------------------------------------------------------------
    -- SIGNALS -----------------------------------------------------------------
    signal address      : std_logic_vector(WIDTH-1 downto 0);
    signal instruction  : std_logic_vector(WIDTH-1 downto 0);
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    -- PROGRAM COUNTER ---------------------------------------------------------
    p_counter_ent : entity work.pcounter(behav)
        generic map (
            WIDTH       => WIDTH
        )
        port map (
            clkIn       => clkIn,
            rstIn       => rstIn,
            addressOut  => address
        );

    -- INSTRUCTION MEMORY ------------------------------------------------------
    instr_mem_ent : entity work.imem(behav)
        generic map (
            WIDTH       => WIDTH
        )
        port map (
            clkIn       => clkIn,
            wrIn        => wrIn,
            addressIn   => addressIn,
            dataIn      => dataIn,
            instrOut    => instruction
        );

    -- REGISTERS ---------------------------------------------------------------
    -- ALU ---------------------------------------------------------------------
    -- DATA MEM ----------------------------------------------------------------
end behav;