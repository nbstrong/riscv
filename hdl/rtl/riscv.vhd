--------------------------------------------------------------------------------
-- A 32-bit RISC-V Processor
-- Nicholas Strong
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--------------------------------------------------------------------------------
entity riscv is
    generic (
        WIDTH : natural := 32 -- Does not currently support 64-bit
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
    signal regWr        : std_logic;
    signal regWrData    : std_logic_vector(WIDTH-1 downto 0);
    signal reg1RdData   : std_logic_vector(WIDTH-1 downto 0);
    signal reg2RdData   : std_logic_vector(WIDTH-1 downto 0);
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    -- PROGRAM COUNTER ---------------------------------------------------------
    p_counter_ent : entity work.pcounter(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            rstIn           => rstIn,                       -- System Reset
            addressOut      => address                      -- Address Output
        );

    -- INSTRUCTION MEMORY ------------------------------------------------------
    instr_mem_ent : entity work.imem(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            wrIn            => wrIn,                        -- System Reset
            addressIn       => addressIn,                   -- Address from Program Counter
            dataIn          => dataIn,                      -- Write Data
            instrOut        => instruction                  -- Instruction Output
        );

    -- REGISTERS ---------------------------------------------------------------
    reg_ent : entity work.regfile(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            rstIn           => rstIn,                       -- System Reset
            regWrIn         => regWr,                       -- Write Enable
            reg1RdAddrIn    => instruction(19 downto 15),   -- Read Address for Port 1
            reg2RdAddrIn    => instruction(24 downto 20),   -- Read Address for Port 2
            regWrAddrIn     => instruction(11 downto 7),    -- Write Address
            regWrDataIn     => regWrData,                   -- Write Data
            reg1RdDataOut   => reg1RdData,                  -- Read Data for Port 1
            reg2RdDataOut   => reg2RdData                   -- Read Data for Port 2
        );
    -- ALU ---------------------------------------------------------------------
    -- DATA MEM ----------------------------------------------------------------
end behav;