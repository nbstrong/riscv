library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
entity register is
    generic (
        WIDTH     : natural
    );
    port (
        clkIn : in    std_logic;
        rstIn : in    std_logic
    );
end register;
--------------------------------------------------------------------------------
architecture behav of register is
    -- TYPES -------------------------------------------------------------------
    type reg_array is array (0 to 63)
        of std_logic_vector (WIDTH-1 downto 0);
    -- CONSTANTS ---------------------------------------------------------------
    -- SIGNALS -----------------------------------------------------------------
    -- ALIASES -----------------------------------------------------------------
    -- ATTRIBUTES --------------------------------------------------------------
begin
    -- 32 registers of 64 bits -------------------------------------------------
end behav;