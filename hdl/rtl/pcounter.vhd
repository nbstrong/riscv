library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
entity pcounter is
    generic (
        WIDTH       : natural
    );
    port (
        clkIn       : in    std_logic;                          -- System Clock
        rstIn       : in    std_logic;                          -- System Reset
        addressOut  :   out std_logic_vector(WIDTH-1 downto 0)  -- Address Output
    );
end pcounter;
--------------------------------------------------------------------------------
architecture behav of pcounter is
    -- CONSTANTS ---------------------------------------------------------------
    -- SIGNALS -----------------------------------------------------------------
    signal address : unsigned(WIDTH-1 downto 0);
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    process(clkIn, rstIn)
    begin
        if rstIn = '1' then
            address <= (others => '0');
        elsif rising_edge(clkIn) then
            address <= address + (WIDTH/8);
        end if;
    end process;

    addressOut <= std_logic_vector(address);
end behav;