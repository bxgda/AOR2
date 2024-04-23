library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity orGate is
  port (
    a, b : in std_logic;
    y : out std_logic;
  ) ;
end orGate ; 

architecture a_orGate of orGate is
begin
  y <= a or b;
end architecture ;

-------------------------------------- end orGate

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity xorGate is
  port (
    a, b : in std_logic;
    y : out std_logic;
  ) ;
end xorGate ; 

architecture a_xorGate of xorGate is
begin
  y <= a xor b;
end architecture ;

--------------------------------------- end xorGate

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity kolo is
  generic (n : integer := 4);
  port (
    a, b : in std_logic_vector(n-1 downto 0);
    c : in std_logic;
    d : out std_logic_vector(n-1 downto 0);
  ) ;
end kolo ; 

architecture a_kolo of kolo is
begin

  generisi: for i in 0 to n-1 generate
    signal yXor : std_logic;        -- lokalan medju promenljiva koju daje xor na njegov izlaz
  begin
    
    uslovi: if i = 0 generate
    begin
        nultiXor: entity work.xorGate(a_xorGate)
          port map (a(i), b(i), yXor);
        nultiOr: entity work.orGate(a_orGate)
          port map (yXor, c, d(i));
    else generate
        itiXor : entity work.xorGate(a_xorGate)
          port map(a(i), b(i), yXor);
        itiOr : entity work.orGate(a_orGate)
          port map(yXor, d(i-1), d(i));

    end generate uslovi;
  end generate generisi;
  
end architecture ;

------------------------------------------------- end kolo

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
  signal a, b, d : std_logic_vector(n-1 downto 0);
  signal c : std_logic;
begin

  dut : entity work.kolo(a_kolo)
    port map (a, b, c, d);

  stimuli : process
  begin
    a <= "0011";
    b <= "1100";
    c <= '1';
    wait for 50 ns;
  end process stimuli;

end architecture ;