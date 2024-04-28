
-- proveriti obavezno da l' treba sa for generate ili ima neka druga fora!


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity xorGate is
  port (
    a, b: in std_logic;
    y : out std_logic;
  ) ;
end xorGate ; 

architecture a_xorGate of xorGate is
begin
    y <= a xor b;
end architecture ;
-------------------------------------- end xorGateGate

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity generator is
    generic (n : integer := 4);
    port (
        clk : in std_logic;
        d_in : in std_logic_vector(n-1 downto 0);
        d_out : out std_logic_vector(n downto 0);
    ) ;
end generator ; 

architecture a_generator of generator is
    signal izlaz_xorGate : std_logic_vector(n-1 downto 1);

begin

    nulti: entity work.xorGate(a_xorGate)
        port map(d_in(0), d_in(1), izlaz_xorGate(1));

    generisi: for i in 2 to n-1 generate
    begin
        i_ti: entity work.xorGate(a_xorGate)
            port map (d_in(i), izlaz_xorGate(i-1), izlaz_xorGate(i));
    end generate ;

    process (clk)
    begin
        if clk'event and clk = '1' then
            d_out <= izlaz_xorGate(n-1) & d_in(n-1 downto 0);
        end if;
    end process;

end architecture ;
------------------------------------------------------------- end generator

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
    signal d_in : std_logic_vector(n-1 downto 0);
    signal d_out : std_logic_vector(n downto 0);
    signal clk : std_logic;
begin

    dut: entity work.generator(a_generator)
        generic map (n)
        port map (clk, d_in, d_out);

    clock: process
    begin
        clk <= '0'; wait for 100 ns;
        clk <= '1'; wait for 100 ns;
    end process;

    stimuli: process
    begin
        d_in <= "1011";
        wait for 200 ns;
        d_in <= "1001";
        wait for 200 ns;
        d_in <= "0100";
        wait for 200 ns;
    end process;

end architecture ;