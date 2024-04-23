library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity andGate is
  port (
    a, b : in std_logic;
    y : out std_logic;
  ) ;
end andGate ; 


architecture a_andGate of andGate is
begin
    y <= a and b;
end architecture ;
---------------------------------------- end a_andGate


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
---------------------------------------- end a_orGate


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity kolo is
    generic (n : positive := 4);
    port (
        a, b : in std_logic_vector(n-1 downto 0);
        c : in std_logic;
        y : out std_logic_vector(n-1 downto 0);
    ) ;
end kolo ; 


architecture a_kolo of kolo is
    signal y_int : std_logic_vector(n-1 downto 0);
begin


    -- mora nulti iznad jer kaze iskljucivo for generate
    nulti_andKomp: entity work.andGate(a_andGate)
    port map (a(0), b(0), y_int(0));


    nulti_orKomp: entity work.orGate(a_orGate)
        port map(y_int(0), c, y(0));

    generisi: for i in 1 to n-1 generate
    begin
        andKomp: entity work.andGate(a_andGate)
            port map (a(i), b(i), y_int(i));


        orKomp: entity work.orGate(a_orGate)
            port map(y_int(i), y(i-1), y(i));
    end generate generisi;
end architecture ;


------------------------------------------- end a_kolo


-- Testbench


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity tb is
  generic (n : positive := 4);
end tb ; 


architecture a_tb of tb is
    signal a, b, y : std_logic_vector (n-1 downto 0);
    signal c : std_logic;
begin


    dut: entity work.kolo(a_kolo)
        port map (a, b, c, y);


    stimuli: process
    begin
        a <= "1101";
        b <= "1001";
        c <= '1';
        wait for 100 ns;
    end process stimuli;


end architecture ;


-------------------------------------------- end testbench