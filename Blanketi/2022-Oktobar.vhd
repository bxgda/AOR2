
-- PROVERITI!!!

-- nesto mi se ne svidja kako radi, preskace nesto
-- mozda pa to tako i treba nmg ga provalim ima li neka kasnjenja kao pa da ga flip flopovi ujebu
-- baciti pogled u EDA, jedan lose odradi pa nastavi lepo, i tako na neki kriticni brojevi (zavisi od bitova)

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity brojac is
    generic (n : integer := 4) ;
    port (
        clk, rst, dir : in std_logic;
        izlaz : out std_logic_vector(n-1 downto 0);
    ) ;
end brojac ; 

architecture a_brojac of brojac is
begin

    process (clk)
        variable stanje_brojaca : integer range 0 to (2**n - 1);
    begin

        if clk'event and clk = '1' then
            if rst = '1' then
                if dir = '1' then
                    stanje_brojaca := 0;
                else
                    stanje_brojaca := (2**n - 1);
                end if;
            else
                if dir = '1' then
                    if stanje_brojaca = (2**n - 1) then stanje_brojaca := 0;
                    else stanje_brojaca := stanje_brojaca + 1;
                    end if;
                else
                    if stanje_brojaca = 0 then stanje_brojaca := (2**n - 1);
                    else stanje_brojaca := stanje_brojaca - 1;
                    end if;
                end if;
            end if;
        end if;

        izlaz <= std_logic_vector(to_unsigned(stanje_brojaca, n));

    end process;

end architecture ;
------------------------------------------------------------------ end brojac

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
    q <= d when (clk'event and clk = '1') else q;
end architecture ;
---------------------------------------------------------------- end dff

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic (n : integer := 4);
    port (
        clk, rst, dir : in std_logic;
        izlaz : out std_logic_vector(n-1 downto 0);
    ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal medju : std_logic_vector(n-1 downto 0);
begin

    brojac: entity work.brojac(a_brojac)
        generic map (n)
        port map (clk, rst, dir, medju);

    generisi: for i in 0 to n-1 generate
    begin
        uslovi: if i < (n / 2) generate
            -- sad jebem li ga ovde treba li ovako posto pise konkurentne klauzule
            -- ili da instanciram dff a u njegovoj arhitekturi da su konkurente
            -- (iskr tako mi deluje logicnije jer je celo kolo strukturalni opis)

            -- dff: entity work.dff(a_dff)
            --     port map (clk, medju(i), izlaz(i));

            izlaz(i) <= medju(i) when (clk'event and clk = '1') else izlaz(i);
        else generate
            izlaz(i) <= medju(i);
        end generate ;
    end generate ;

end architecture ;
----------------------------------------------------- end kolo


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
    signal clk, rst, dir : std_logic;
    signal izlaz : std_logic_vector(n-1 downto 0);
begin

    dut: entity work.kolo(a_kolo)
        generic map (n)
        port map (clk, rst, dir, izlaz);

    clock_generator: process
    begin
        clk <= '0'; wait for 25 ns;
        clk <= '1'; wait for 25 ns;
    end process ;
    
    stimuli: process
    begin
        rst <= '1';
        dir <= '1';
        wait for 30 ns;
        rst <= '0';
        wait for 1000 ns;
        dir <= '0';
        wait for 1000 ns;
    end process ;

end architecture ;