
-- int to bcd (samo brojevi od 0 do 99)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity intbcd is
  port (
    clk, wr: in std_logic;
    din : in integer range 0 to 99;
    dout : out std_logic_vector(7 downto 0);
  ) ;
end intbcd ;

architecture a_intbcd of intbcd is
begin

    process (clk)
    variable cj : std_logic_vector(3 downto 0);
    variable cd : std_logic_vector(3 downto 0);
    variable cj_int : integer range 0 to 99;
    variable cd_int : integer range 0 to 99;
    begin
        if clk'event and clk = '1' then
            if wr = '1' then
                cj_int := din mod 10;
                cd_int := (din / 10) mod 10;
            end if;
        end if;

        cj := std_logic_vector(to_unsigned(cj_int, cj'length));
        cd := std_logic_vector(to_unsigned(cd_int, cd'length));
        dout <= cd & cj;

    end process;

end architecture ; -- a_intbcd

----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity intbcd_tb is
end intbcd_tb ;

architecture a_intbcd_tb of intbcd_tb is
    signal clk, wr : std_logic;
    signal din : integer range 0 to 99;
    signal dout : std_logic_vector(7 downto 0);
begin

    dut: entity work.intbcd(a_intbcd)
        port map (clk, wr, din, dout);

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    stimuli: process
    begin
        wr <= '1';
        din <= 13;
        wait for 10 ns;
        wr <= '0';
        wait for 50 ns;

    end process;


end architecture ; -- a_intbcd_tb