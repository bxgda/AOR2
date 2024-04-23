
library IEEE;
use IEEE.std_logic_1164.all;

entity mux4u1 is
    port (
        x1, x2, x3, x4 : in std_logic_vector(3 downto 0);
        sel            : in std_logic_vector(1 downto 0);
        y              : out std_logic_vector(3 downto 0)
    );
end entity mux4u1;

architecture arch of mux4u1 is
begin

    with sel select
        y <= x1 when "00",
             x2 when "01",
             x3 when "10",
             x4 when others;

end architecture arch;

---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4u1_tb is
end entity mux4u1_tb;

architecture arch_tb of mux4u1_tb is
    signal x1, x2, x3, x4, y : std_logic_vector(3 downto 0);
    signal sel : std_logic_vector(2 downto 0);
begin

    uut: entity work.mux4u1(arch)
        port map (x1, x2, x3, x4, sel, y);
    
    process
    begin
        sel <= "00";
        x1 <= "0100";
        x2 <= "1010";
        x3 <= "0001";
        x4 <= "0110";
        wait for 20 ns;
        sel <= "01";
        wait for 20 ns;
        sel <= "00";
        wait for 20 ns;
        sel <= "11";
        wait for 20 ns;
        sel <= "10";
        wait for 20 ns;
    end process;

end architecture arch_tb;