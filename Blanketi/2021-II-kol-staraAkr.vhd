-- 2021 II kol stara akridetacija

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity dff is
  port (
    clk, d : in std_logic;
    q : out std_logic;
  ) ;
end dff ; 

architecture a_dff of dff is
  
begin
    q <= d when (clk'event and clk = '0') else q;
    
end architecture ;

------------------------------------------- end dff

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity brojac is
  generic (n : integer := 4);
  port (
    clk, rst : in std_logic;
    d_in : in std_logic_vector(n-1 downto 0);
    d_out : out std_logic_vector(n-1 downto 0);
  ) ;
end brojac ; 

architecture a_brojac of brojac is

begin
  process (clk)
    variable brojac_int : integer range 0 to (2**n - 1);
    variable goreDole : std_logic;      --1 gore 0 dole

  begin
    if clk'event and clk = '1' then
      if rst = '1' then
        brojac_int := to_integer(unsigned(d_in));
        goreDole := '1';
      elsif goreDole = '1' then
        if brojac_int = (2**n - 1) then
          goreDole := '0';
          brojac_int := brojac_int - 1;
        else
          brojac_int := brojac_int + 1;
        end if;
      else 
        if brojac_int = 0 then
          goreDole := '1';
          brojac_int := brojac_int + 1;
        else
          brojac_int := brojac_int - 1;
        end if;
      end if;
    end if;
    
    d_out <= std_logic_vector(to_unsigned(brojac_int, n));
    
  end process;
end architecture ;

---------------------------------------------- end brojac

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity kolo is
  generic (n : integer := 4);
  port (
    clk, rst : in std_logic;
    d_in : in std_logic_vector (n-1 downto 0);
    d_out : out std_logic_vector (n-1 downto 0);
  ) ;
end kolo ; 

architecture a_kolo of kolo is
  signal izlaz_brojaca : std_logic_vector(n-1 downto 0);
  signal izlaz_dff : std_logic;
begin

  instanca_brojac: entity work.brojac(a_brojac)
                generic map (n)
                port map (clk, rst, d_in, izlaz_brojaca);

  instanca_dff: entity work.dff(a_dff)
              port map (clk, izlaz_brojaca(n-1), izlaz_dff);

  d_out <= izlaz_dff & izlaz_brojaca(n-2 downto 0); -- konkatenacija ???

end architecture ;

---------------------------------------- end kolo

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity tb is
  generic(n : integer := 4);
end tb ; 

architecture a_tb of tb is
  signal clk, rst : std_logic;
  signal d_in, d_out : std_logic_vector(n-1 downto 0);

begin
  dut : entity work.kolo(a_kolo)
    port map(clk, rst, d_in, d_out);

  klok: process
  begin 
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process klok;

  process
  begin
    rst <= '1';
    d_in <= "0110";
    wait for 10 ns;
    rst <= '0';
    wait for 500 ns;
  end process;

end architecture ;


