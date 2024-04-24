library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity xorq is
  port (
    a, b : in std_logic;
    c : out std_logic;
  ) ;
end xorq ; 

architecture axorq of xorq is

begin
    c <= a xor b;

end architecture ;

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity orq is
  port (
    a, b : in std_logic;
    c : out std_logic;
  ) ;
end orq ; 

architecture aorq of orq is

begin
    c <= a or b;

end architecture ;

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic(n : integer := 7);
  port (
    ulaz1 : in std_logic;
    a, b : in std_logic_vector(0 to n-1);
    c : out std_logic_vector(0 to n-1);
  );
end kolo ; 

architecture akolo of kolo is
    signal medju0 : std_logic;

begin
    nultixor : entity work.xorq(axorq)
        port map(ulaz1, a(0), medju0);

    nultior : entity work.orq(aorq)
        port map(medju0, b(0), c(0));

    generisi : for i in 1 to n-1 generate
        signal medju : std_logic;
    begin
        itixor : entity work.xorq(axorq)
            port map(c(i-1), a(i), medju);
            
        itior : entity work.orq(aorq)
            port map(medju, b(i), c(i));

    end generate generisi;
end architecture ;

---------------------------------testbench

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic(n : integer := 7);
end tb ; 

architecture atb of tb is
    signal ulaz1 : std_logic;
    signal a, b, c : std_logic_vector(0 to n-1);

begin
    dut : entity work.kolo(akolo)
        port map(ulaz1, a, b, c);

    stimuli : process
    begin
        ulaz1 <= '1';
        a <= "0000000";
        b <= "0000000";
        wait for 50 ns;
        
    end process stimuli;
end architecture ;