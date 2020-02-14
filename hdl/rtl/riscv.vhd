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
    signal instrAddress : std_logic_vector(WIDTH-1 downto 0);
    signal dataAddress  : std_logic_vector(WIDTH-1 downto 0);
    signal instruction  : std_logic_vector(WIDTH-1 downto 0);
    signal regWrEn      : std_logic;
    signal regWrData    : std_logic_vector(WIDTH-1 downto 0);
    signal reg1RdData   : std_logic_vector(WIDTH-1 downto 0);
    signal reg2RdData   : std_logic_vector(WIDTH-1 downto 0);
    signal wrData       : std_logic_vector(WIDTH-1 downto 0);
    signal rdData       : std_logic_vector(WIDTH-1 downto 0);
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
            addressOut      => instrAddress                 -- Address Output
        );

    -- INSTRUCTION MEMORY ------------------------------------------------------
    instr_mem_ent : entity work.mem(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            wrIn            => wrIn,                        -- System Reset
            addressIn       => instrAddress,                -- Address
            dataIn          => dataIn,                      -- Write Data
            dataOut         => instruction                  -- Read Data
        );

    -- REGISTERS ---------------------------------------------------------------
    reg_ent : entity work.regfile(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            rstIn           => rstIn,                       -- System Reset
            regWrEnIn       => regWrEn,                     -- Write Enable
            reg1RdAddrIn    => instruction(19 downto 15),   -- Read Address for Port 1
            reg2RdAddrIn    => instruction(24 downto 20),   -- Read Address for Port 2
            regWrAddrIn     => instruction(11 downto 7),    -- Write Address
            regWrDataIn     => regWrData,                   -- Write Data
            reg1RdDataOut   => reg1RdData,                  -- Read Data for Port 1
            reg2RdDataOut   => reg2RdData                   -- Read Data for Port 2
        );
    -- ALU ---------------------------------------------------------------------

    -- DATA MEM ----------------------------------------------------------------
    data_mem_ent : entity work.mem(behav)
        generic map (
            WIDTH           => WIDTH
        )
        port map (
            clkIn           => clkIn,                       -- System Clock
            wrIn            => wrIn,                        -- System Reset
            addressIn       => dataAddress,                 -- Address
            dataIn          => wrData,                      -- Write Data
            dataOut         => rdData                       -- Read Data
        );
end behav;