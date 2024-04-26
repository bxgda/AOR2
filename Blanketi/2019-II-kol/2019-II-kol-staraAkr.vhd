library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity komparator is
  port (
    a, b : in std_logic;
    y : out std_logic;
  ) ;
end komparator ; 

architecture a_komparator of komparator is

begin
    y <= not (a xor b);

end architecture ;

------------------------------------------- end 1b komparator

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity andOr is
    generic (andIliOr : std_logic);      -- 0 -> or, 1 -> and
    port (
        a, b : in std_logic;
        y : out std_logic;
    ) ;
end andOr ; 

architecture a_andOr of andOr is

begin
    y <= (a and b) when andIliOr = '1' else (a or b); 

end architecture ;

----------------------------------------------- end andOr

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic (n : integer := 4);
    port (
        s : in std_logic;
        pin : in std_logic_vector(n-1 downto 0);
        y : out std_logic;
    ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal izlazKomparator, izlazAnd, zapamcenPin : std_logic_vector(n-1 downto 0);
begin

 	zapamcenPin <= pin when s = '1';

    generisi : for i in 0 to n-1 generate
    begin
        uslovi: if i = 0 generate
        begin
            nultiKomp : entity work.komparator(a_komparator)
                port map(zapamcenPin(i), pin(i), izlazKomparator(i));
            izlazAnd(i) <= izlazKomparator(i);
        else generate
            iTiKomp : entity work.komparator(a_komparator)
                port map(zapamcenPin(i), pin(i), izlazKomparator(i));
            iTiAndOr: entity work.andOr(a_andOr)
                generic map ('1')
                port map (izlazKomparator(i), izlazAnd(i-1), izlazAnd(i));
        end generate uslovi;
        
    end generate generisi;
    
    y <= izlazAnd(n-1) when s = '0';
    
end architecture ;

----------------------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
    signal s, y : std_logic;
    signal pin : std_logic_vector(n-1 downto 0);

begin

    dut : entity work.kolo(a_kolo)
        generic map(n)
        port map(s, pin, y);

    stimuli: process
    begin
        s <= '1';
        pin <= "1011";
        wait for 10 ns;
        s <= '0';
        pin <= "1011";
        wait for 20 ns;
        s <= '1';
        pin <= "1111";
        wait for 10 ns;
        s <= '0';
        pin <= "1110";
        wait for 30 ns;
    end process;

end architecture ;