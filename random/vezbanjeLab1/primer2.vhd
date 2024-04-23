--mux 4-1 ulazi signed selekcioni int konkurentna klauzula

LIBRARY ieee;
USE ieee.std_logic_arith.ALL; 

entity mux4to1 is
    port(
        x0, x1, x2, x3 : in signed(5 downto 0);
        sel : in integer;
        y : out signed(5 downto 0);
    );
end entity mux4to1;

architecture a_mux4to1 of mux4to1 is
begin
    with sel select y <=
    	x0 when 0,
       	x1 when 1,
        x2 when 2,
        x3 when others;
end architecture a_mux4to1;
----------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_arith.ALL; 

entity mux4to1_tb is
end entity;

architecture a_mux4to1_tb of mux4to1_tb is
    signal x0, x1, x2, x3, y : signed(5 downto 0);
    signal sel : integer;
begin
    dut : entity work.mux4to1(a_mux4to1) port map(
        x0, x1, x2, x3, sel, y
    );
    process
    begin
        x0 <= "100011";
        x1 <= "000001";
        x2 <= "001010";
        x3 <= "010011";
        sel <= 0;
        wait for 10 ns;
        sel <= 1;
        wait for 10 ns;
        sel <= 3;
        wait for 10 ns;
        sel <= 2;
        wait for 10 ns;
        sel <= 0;
        wait for 10 ns;
    end process;
end architecture a_mux4to1_tb;    


