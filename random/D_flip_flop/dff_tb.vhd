
library IEEE;
use IEEE.std_logic_1164.all;

entity dff_tb is
end dff_tb;

architecture sim of dff_tb is
    signal d, rst, q : std_logic;
    signal clk : std_logic := '0';
begin

    uut: entity work.dff(asyncCLR)
        port map (d, rst, clk, q);

    -- Clock process definitions
    clk_process : process
    begin
        clk <= not clk;
        wait for 10 ns;
    end process clk_process;

    -- Stimulus process
    stim_proc: process
    begin
        d <= '0';
        rst <= '0';
        wait for 20 ns;

        d <= '1';
        wait for 20 ns;

        d <= '0';
        wait for 20 ns;

    end process stim_proc;


end architecture sim;