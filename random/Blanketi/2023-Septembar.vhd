
-- 2023 Septembar

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity brojac is
    generic ( 
        n : positive := 8;
    );
    port (
        clk, rst : in std_logic;
        izlaz : out std_logic_vector(0 to n-1);
    ) ;
end brojac ; 

architecture a_brojac of brojac is
begin

    process (clk, rst)
    variable brTr : positive;
    begin
        
        if clk'event and clk = '1' then
            if rst = '1' or brTr = n then
                izlaz <= ('1', others => '0');
                brTr := 1;
            else 
                for index in 0 to brTr loop
                    izlaz(index) <= '1';
                end loop;
                brTr := brTr + 1;
            end if;
        end if;

    end process;

end architecture ;


--------------------------------------------------------------------

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : positive := 8);
end tb ; 

architecture a_tb of tb is
    signal clk, rst : std_logic;
    signal izlaz : std_logic_vector(0 to n-1);
begin

    dut: entity work.brojac(a_brojac)
        generic map (n)
        port map (clk, rst, izlaz);
    
    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 2000 ns;

    end process;

end architecture ;