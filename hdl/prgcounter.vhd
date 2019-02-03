library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--------------------------------------------------------------------------------
entity prgcounter is
    port (
        clkIn       : in    std_logic;
        rstIn       : in    std_logic;
        addressOut  :   out std_logic_vector(63 downto 0)
    );
end prgcounter;
--------------------------------------------------------------------------------
architecture behav of prgcounter is
    -- CONSTANTS ---------------------------------------------------------------
    -- SIGNALS -----------------------------------------------------------------
    signal address : unsigned(63 downto 0);
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    process(clkIn, rstIn)
    begin
        if rstIn = '1' then
            address <= (others => '0');
        elsif rising_edge(clkIn) then
            address <= address + 1;
        end if;
    end process;
    
    addressOut <= std_logic_vector(address);
end behav;