library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity kolo is
    generic(n: integer := 4);
    port(
        a, b: in std_logic_vector(n-1 downto 0);
        c: in std_logic;
        y: out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture a_kolo of kolo is
    signal yAnd : std_logic_vector(n-1 downto 0);

begin
    generisi: for i in 0 to n-1 generate
    begin
        uslovi: if i = 0 generate
            yAnd(i) <= a(i) and b(i);
            y(i) <= yAnd(i) or c;
       else generate
            yAnd(i) <= a(i) and b(i);
            y(i) <= yAnd(i) or y(i-1);
        end generate;
    end generate;
end architecture;
------------------------------------------------------- end kolo

library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity tb is
    generic (n: integer := 4);
end entity;

architecture a_tb of tb is
    signal a,b,y: std_logic_vector(n-1 downto 0);
    signal c: std_logic;

begin
	dut: entity work.kolo(a_kolo)
    		port map(a,b,c,y);

    stimuli: process 
    begin
        a<="1100";
        b<="1110";
        c<='0';
        wait for 100ns;
        a<="0101";
        b<="0110";
        c<='1';
        wait for 100ns;
    end process;

end architecture;