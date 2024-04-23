
-- Na VHDL-u, korišćenjem konkurentnih klauzula dodele vrednosti signalu, opisati D flipflop sa
-- asinhronim resetom, i koji se okida prednjom ivicom. Portovi treba da su tipa bit. Kreirati
-- testbenč sa talasnim oblicima ulaza koji demonstriraju sve osobine kola - željene i nepoželjne. 


library IEEE;
use IEEE.std_logic_1164.all;

entity dff is
    port (
        d, clk, rst : in bit;
        q : out bit;
    );
end entity dff;

architecture a_dff of dff is
begin

   q <=
        '0' when clk'event and clk = '1' and rst = '1' else
        d when clk'event and clk = '1';
        
end architecture a_dff;

----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dff_tb is
end entity dff_tb;

architecture a_dff_tb of dff_tb is
    signal d, clk, rst, q : bit;
begin

    uut: entity work.dff(a_dff)
        port map (d, clk, rst, q);

    clock : process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
     end process;

    process
    begin
        rst <= '0';
        d <= '1';
        wait for 7 ns;
        d <= '0';
        wait for 5 ns;
        d <= '1';
        wait for 20 ns;
        rst <= '1';
        wait for 15 ns;

    end process;

end architecture a_dff_tb;
