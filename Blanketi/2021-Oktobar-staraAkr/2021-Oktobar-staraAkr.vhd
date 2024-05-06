
-- ovo radi ali brojac je morao da se implementira na svaku drugu ivicu takta
-- da bi delitelj cifara stigao da obradi obe cifre i validno prosledi c1 i c10 displejevima
-- (vidi sliku)


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity dekoder7 is
  port (
    en : in std_logic ;
    ulaz : in integer range 0 to 9 ;
    izlaz : out std_logic_vector(6 downto 0) ;
  ) ;
end dekoder7 ; 

architecture a_dekoder7 of dekoder7 is
begin                           
    process (en, ulaz)
    begin
        if en = '1' then
            case ulaz is         --"abcdefg"
                when 0 => izlaz <= "1111110" ;
                when 1 => izlaz <= "1100000" ;
                when 2 => izlaz <= "1101101" ;
                when 3 => izlaz <= "1111001" ;
                when 4 => izlaz <= "0110011" ;
                when 5 => izlaz <= "1011011" ;
                when 6 => izlaz <= "1011111" ;
                when 7 => izlaz <= "1110000" ;
                when 8 => izlaz <= "1111111" ;
                when 9 => izlaz <= "1111011" ;
                when others => izlaz <= "0000000" ;
            end case ;
        end if ;
    end process ;
end architecture ;
------------------------------------------------- end dekoder7


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity brojac is
  port (
    clk : in std_logic ;
    rst : in std_logic ;
    en : in std_logic ;
    izlaz : out integer range 0 to 99 ;
  ) ;
end brojac ; 

architecture a_brojac of brojac is    
    signal cq : std_logic := '0';
begin
    process (clk)
        variable cnt : integer range 0 to 99 ;
    begin
        if clk'event and clk = '1' then             
            cq <= not cq;
            if cq = '1' then
                if rst = '1' then
                    cnt := 0 ;
                    cq <= '0';
                elsif en = '1' then
                    cnt := (cnt + 1) mod 100 ;
                end if ;
            end if;
        end if ;
        izlaz <= cnt ;
    end process ;
end architecture ;
------------------------------------------------- end brojac

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity deliteljCifara is
  port (
    clk : in std_logic ;
    ulazni_broj : in integer range 0 to 99 ;
    cifra_za_prikaz : out integer range 0 to 9 ;
    indikator_c1 : out std_logic ;
    indikator_c10 : out std_logic ;
  ) ;
end deliteljCifara ; 

architecture a_deliteljCifara of deliteljCifara is
begin
    
    process (clk)
    begin
        if clk'event and clk = '0' then
            if indikator_c1 = '0' then
                cifra_za_prikaz <= ulazni_broj mod 10;
                indikator_c1 <= '1';
                indikator_c10 <= '0';
            else
                cifra_za_prikaz <= (ulazni_broj / 10);
                indikator_c1 <= '0';
                indikator_c10 <= '1';
            end if ;
        end if;
    end process ;

end architecture ;
------------------------------------------------------- end deliteljCifara

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
  port (
    clk : in std_logic ;
    en : in std_logic ;
    rst : in std_logic ;
    izlazJ : out std_logic_vector(6 downto 0) ;
    izlazD : out std_logic_vector(6 downto 0) ;
  ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal brojac_izlaz : integer range 0 to 99 ;
    signal cifra_za_prikaz_int : integer range 0 to 9 ;
    signal indikator_c1_int : std_logic ;
    signal indikator_c10_int : std_logic ;
begin

    brojac: entity work.brojac(a_brojac)
        port map (clk, rst, en, brojac_izlaz) ;

    delitelj: entity work.deliteljCifara(a_deliteljCifara)
        port map (clk, brojac_izlaz, cifra_za_prikaz_int, indikator_c1_int, indikator_c10_int) ;

    s_j: entity work.dekoder7(a_dekoder7)
        port map (indikator_c1_int, cifra_za_prikaz_int, izlazJ) ;

    s_d: entity work.dekoder7(a_dekoder7)
        port map (indikator_c10_int, cifra_za_prikaz_int, izlazD) ;

end architecture ;
----------------------------------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
end tb ; 

architecture a_tb of tb is
    signal clk, en, rst : std_logic ;
    signal izlazJ, izlazD : std_logic_vector(6 downto 0) ;

begin
    dut : entity work.kolo(a_kolo)
        port map (clk, en, rst, izlazJ, izlazD) ;
    
    klok : process
    begin
        clk <= '0' ;
        wait for 10 ns ;
        clk <= '1' ;
        wait for 10 ns ;
    end process ;

    stimuli : process
    begin
        rst <= '1' ;
        en <= '0' ;
        wait for 100 ns ;
        rst <= '0' ;
        en <= '1' ;
        wait for 1000 ns ;
        en <= '0' ;
        wait for 20 ns;
    end process ;

end architecture ;