library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
--------------------------------------------------------------------------------
entity regfile is
    generic (
        WIDTH     : natural;
        DEPTH     : natural
    );
    port (
        clkIn           : in    std_logic;                          -- System Clock
        rstIn           : in    std_logic;                          -- System Reset
        regWrEnIn       : in    std_logic;                          -- Write Enable
        reg1RdAddrIn    : in    std_logic_vector;                   -- Read Address for Port 1
        reg2RdAddrIn    : in    std_logic_vector;                   -- Read Address for Port 2
        regWrAddrIn     : in    std_logic_vector;                   -- Write Address
        regWrDataIn     : in    std_logic_vector(WIDTH-1 downto 0); -- Write Data
        reg1RdDataOut   :   out std_logic_vector(WIDTH-1 downto 0); -- Read Data for Port 1
        reg2RdDataOut   :   out std_logic_vector(WIDTH-1 downto 0)  -- Read Data for Port 2
    );
end regfile;
--------------------------------------------------------------------------------
architecture behav of regfile is
    -- TYPES -------------------------------------------------------------------
    type reg_array is array (0 to DEPTH)
        of std_logic_vector (WIDTH-1 downto 0);
    -- CONSTANTS ---------------------------------------------------------------
    -- SIGNALS -----------------------------------------------------------------
    signal reg_s : reg_array;
    signal clkN  : std_logic;
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    clkN <= not clkIn;

    -- Read Process ------------------------------------------------------------
    -- On the rising_edge of the clock, outputs the register values for
    -- the input addresses
    ----------------------------------------------------------------------------
    readProc : process(clkIn, rstIn)
    begin
        reg_s(0) <= (others => '0');
        if rstIn = '1' then
            reg_s <= (others => (others => '0'));
        elsif rising_edge(clkIn) then
            reg1RdDataOut <= reg_s(to_integer(unsigned(reg1RdAddrIn)));
            reg2RdDataOut <= reg_s(to_integer(unsigned(reg2RdAddrIn)));
        end if;
    end process;

    -- Write Process -----------------------------------------------------------
    -- On the rising_edge of the clkN (falling edge), writes the register
    -- value for the selected address, if the wrEn is high.
    ----------------------------------------------------------------------------
    writeProc : process(clkN)
    begin
        if rising_edge(clkN) then
            if (regWrEnIn = '1') then
                reg_s(to_integer(unsigned(regWrAddrIn))) <= regWrDataIn;
            end if;
        end if;
    end process;
end behav;