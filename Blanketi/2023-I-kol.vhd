
-- VALJDA JE TO POENTA JEBEM LI GA SAD

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
    clk, rst : in std_logic;
    d_out : out std_logic_vector(3 downto 0);
  ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal we_local, cq : std_logic;
    signal d_in_local : std_logic_vector(3 downto 0);
begin
    
    instanca: entity work.bcd(a_bcd)
        port map (cq, we_local, d_in_local, d_out);

    process (clk, rst)
    begin
        if rst = '1' then           -- resetuj brojac
            we_local <= '1';
            d_in_local <= "0000";
            cq <= clk;
        end if;
        
        if clk'event and clk = '1' then
            cq <= not cq;
            if cq = '1' then        -- na svaki drugi takt
                we_local <= '0';    -- samo setuje we na 0 i brojac krene da si broji
            end if;
        end if;
    end process ;

end architecture ;


---------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
end tb ; 

architecture a_tb of tb is
    signal clk, rst: std_logic;
    signal d_out : std_logic_vector (3 downto 0);
    
begin
    dut : entity work.kolo(a_kolo)
        port map(clk, rst, d_out);
    
    process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;
    
    stimuli: process
    begin
        rst <= '1';
        wait for 2 ns;
        rst <= '0';
        wait for 500 ns;

    end process stimuli;

end architecture ;