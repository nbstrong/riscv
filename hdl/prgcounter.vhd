library IEEE;
use IEEE.std_logic_1164.all;
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
    signal address : std_logic_vector(63 downto 0);
begin
    process(clkIn)
    begin
        if rstIn = '1' then
            address <= (others => '0');
        elsif rising_edge(clkIn) then
            address <= (address + 1);
        end if;
    end process;
    
    addressOut <= address;
end behav;