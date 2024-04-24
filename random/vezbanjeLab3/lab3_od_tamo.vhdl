library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity org is
  port (
    a, b : in std_logic;
    c : out std_logic;
  ) ;
end org ; 

architecture aorg of org   is

begin
    c <= a or b;

end architecture ;

---------------------------------------------- end org

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity andg is
  port (
    a, b : in std_logic;
    c : out std_logic;
  ) ;
end andg ; 

architecture aandg of andg is

begin
    c <= a and b;

end architecture ;

----------------------------------------------- end andg

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic(n:integer := 4);
  port (
    a, b : in std_logic_vector(n-1 downto 0);
    ulaz1 : in std_logic;
    c : out std_logic_vector(n-1 downto 0);
  ) ;
end kolo ; 

architecture akolo of kolo is
    signal medjunula : std_logic;

begin
    nultiand : entity work.andg(aandg)
        port map(a(0), b(0), medjunula);
    nultior : entity work.org(aorg)
        port map(medjunula, ulaz1, c(0));
    
    generisi : for i in 1 to n-1 generate
        signal medju : std_logic;

    begin
        itiand : entity work.andg(aandg)
            port map (a(i), b(i), medju);
        itior : entity work.org(aorg)
            port map (medju, c(i-1), c(i));

    end generate;
end architecture ;

----------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic(n:integer := 4);
end tb ; 

architecture atb of tb is
    signal ulaz1 : std_logic;
    signal a, b, c : std_logic_vector(n-1 downto 0);

begin
    dut : entity work.kolo(akolo)
        port map(a,b,ulaz1,c);

    stimuli : process

    begin
        a <= "0101";
        b <= "1010";
        ulaz1 <= '1';
        wait for 50 ns;

    end process;
end architecture ;

--------------------------------------------- end tb