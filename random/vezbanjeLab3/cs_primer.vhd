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

---------------------------------------- end xorGate

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

----------------------------------------- end orGate

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic (n : integer := 4);
    port (
        ulaz1 : in std_logic;
        a, b : in std_logic_vector(0 to n-1);
        y : out std_logic_vector(0 to n-1);
    ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal medju : std_logic_vector(0 to n-1);

begin
  -- generisi: for i in a'range generate .... (opseg preko atributa)
  -- generisi: for i in range (a'left to a'right) generate ...
  
    nultiXor : entity work.xorGate(a_xorGate)
        port map (ulaz1, a(0), medju(0));
    nultiOr : entity work.orGate(a_orGate)
        port map (medju(0), b(0), y(0));
    
    generisi : for i in 1 to n-1 generate
    -- ovde bi piso lokalne signale
    begin
        itiXor : entity work.xorGate(a_xorGate)
            port map (y(i-1), a(i), medju(i));
        itiOr : entity work.orGate(a_orGate)
            port map (medju(i), b(i), y(i));

    end generate generisi;
end architecture ;

----------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
    signal a, b, y : std_logic_vector(0 to n-1);
    signal ulaz1 : std_logic;

begin
    dut : entity work.kolo(a_kolo);
        port map(ulaz1, a, b, y);

    stimuli : process
    begin
        ulaz1 <= '1';
        a <= "0011";
        b <= "1100";
    end process;
end architecture ;