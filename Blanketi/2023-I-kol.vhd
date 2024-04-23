-- KURCU NE VALJA... PROVERITI SVE... PRVO BROJAC


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity bcd is
  port (
    clk, we : in std_logic;
    d_in : in std_logic_vector (3 downto 0);
    y : out std_logic_vector (3 downto 0);
  ) ;

end bcd ; 

architecture a_bcd of bcd is
begin

    process( clk )
        variable brojac : integer range 0 to 9;
    begin
        if clk'event and clk = '1' then
            if we = '0' then
                brojac := (brojac + 1) mod 10;
            else
                brojac := to_integer(unsigned(d_in));
            end if;
        end if ;

        y <= std_logic_vector(to_unsigned(brojac, 4));
        
    end process ;
end architecture ;

----------------------------------------------------- end bcd

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
  port (
    clk, rst, we : in std_logic;
    d_in : in std_logic_vector(3 downto 0);
    d_out : out std_logic_vector(3 downto 0);
  ) ;
end kolo ; 

architecture a_kolo of kolo is
begin
    
    process (clk, rst)
        variable cq : std_logic; -- sluzi da broji na svaki drugi klok
        variable d_in_local, we_local : std_logic;
    begin

        if rst = '1' then           -- resetuj brojac
            we_local := '1';
            d_in_local := "0000";
        end if;
        
        if clk'event and clk = '1' then
            cq := not cq;
            if cq = '1' then
                we_local := we;
                d_in_local := d_in;
            end if;
        end if;

        we <= we_local;
        d_in <= d_in_local;
        end process ;

    instanca: entity work.bcd(a_bcd)
        port map (clk, we, d_in, d_out);
end architecture ;


---------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
end tb ; 

architecture a_tb of tb is
    signal clk, rst, we : std_logic;
    signal d_in, d_out : std_logic_vector (3 downto 0);
    
begin
    dut : entity work.kolo(a_kolo)
        port map(clk, rst, we, d_in, d_out);
    
    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    stimuli: process
    begin
        rst <= '1';
        wait for 12 ns;
        rst <= '0';
        we <= '0';
        wait for 100 ns;
        we <= '1';
        d_in <= "0011";
        wait for 100 ns;

    end process stimuli;

end architecture ;