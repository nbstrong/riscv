library IEEE;
use IEEE.STD_LOGIC_1164.all;
--------------------------------------------------------------------------------
entity top is
end top;
--------------------------------------------------------------------------------
architecture behav of top is
    -- CONSTANTS ---------------------------------------------------------------
    constant WIDTH  : natural   := 32;
    constant PERIOD : time      := 10 ps;
    -- SIGNALS -----------------------------------------------------------------
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    dut : entity work.riscv(behav)
        generic map (
            WIDTH => WIDTH
        )
        port map (
            clkIn => clk,
            rstIn => rst
        );

    clk <= not clk after PERIOD/2;
    rst <= '0' after PERIOD*5;

    process
    begin
        wait for PERIOD*100;
        std.env.stop;
    end process;

end behav;