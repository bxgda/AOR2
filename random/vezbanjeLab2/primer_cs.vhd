library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd is
    port(
        ce, wr, clk : in std_logic;
        din : in std_logic_vector (11 downto 0);
        y : out std_logic_vector(11 downto 0)
    );
end entity bcd;

architecture a_bcd of bcd is
begin

    process (clk)
    variable cs : std_logic_vector(3 downto 0);
    variable cd : std_logic_vector(3 downto 0);
    variable cj : std_logic_vector(3 downto 0);
    variable cs_int : integer;
    variable cd_int : integer;
    variable cj_int : integer;
    variable brojac : integer := 999;
    begin


        if (clk'event and clk = '1') then

            if (wr = '1') then
                cs := din(11 downto 8);
                cd := din(7 downto 4);
                cj := din(3 downto 0);
                cs_int := to_integer(unsigned(cs));
                cd_int := to_integer(unsigned(cd));
                cj_int := to_integer(unsigned(cj));
                brojac := (cs_int * 100) + (cd_int * 10) + cj_int;

            elsif ce = '1' and brojac /= 0 then
                    brojac := brojac - 1;
            end if; 

        end if;

        
        cj_int := brojac mod 10;
        cd_int := (brojac / 10) mod 10;
        cs_int := (brojac / 100);

        cj := std_logic_vector(to_unsigned(cj_int, 4));
        cd := std_logic_vector(to_unsigned(cd_int, 4));
        cs := std_logic_vector(to_unsigned(cs_int, 4));

        y <= cs & cd & cj;

    end process;
end architecture a_bcd;

----------------------------------------------------------

entity tb_bcd is
end tb_bcd ;

architecture tb_bcd_a of tb_bcd is
    signal ce, wr, clk : std_logic;
    signal y, din : std_logic_vector (11 downto 0);
begin

    dut: entity work.bcd(a_bcd)
    port map(ce, wr, clk, din, y);

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    process
    begin
        ce <= '1';
        wr <= '1';
        din <= "000100100011";
        wait for 10 ns;
        wr <= '0';
        wait for 500 ns;
    end process;

end architecture ; -- tb_bcd_a

