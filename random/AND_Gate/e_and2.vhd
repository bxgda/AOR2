library IEEE;
use ieee.std_logic_1164.all;

entity e_and2 is
    port(
        a, b: in std_logic;
        y: out std_logic
    );
end entity e_and2;

architecture a of e_and2 is
begin
    y <= a and b;
end architecture a;

-- test bench
library IEEE;
use IEEE.std_logic_1164.all;

entity e_and2_tb is
end entity e_and2_tb;

architecture a of e_and2_tb is
    signal a, b, y: std_logic;
begin
    uut: entity work.e_and2
        port map(
            a => a,
            b => b,
            y => y
        );
    
    process
    begin
        a <= '0';
        b <= '0';
        wait for 10 ns;
        assert y = '0' report "a = 0, b = 0, y = 0" severity failure;
        
        a <= '0';
        b <= '1';
        wait for 10 ns;
        assert y = '0' report "a = 0, b = 1, y = 0" severity failure;
        
        a <= '1';
        b <= '0';
        wait for 10 ns;
        assert y = '0' report "a = 1, b = 0, y = 0" severity failure;
        
        a <= '1';
        b <= '1';
        wait for 10 ns;
        assert y = '1' report "a = 1, b = 1, y = 1" severity failure;
        
        wait;
    end process;
end architecture a;