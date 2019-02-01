library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
entity top is

end top;
--------------------------------------------------------------------------------
architecture behav of top is
    -- CONSTANTS ---------------------------------------------------------------
    constant  PERIOD : time := 10 ns;
    -- SIGNALS -----------------------------------------------------------------
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    dut : entity work.riscv(behav)
        port map (
            clkIn => clk,
            rstIn => rst
        );

    process
    begin
        clk <= not clk after PERIOD/2;
    end process;

    process
    begin
        rst <= '0' after PERIOD*10;
        wait for PERIOD*100;
        std.env.stop;
    end process;

end behav;