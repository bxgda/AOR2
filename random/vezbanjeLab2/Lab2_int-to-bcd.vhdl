-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity konverter_int_to_bcd is
    port(
        cin : in integer range 0 to 9;
        clk : in bit;
        cout : out std_logic_vector(3 downto 0)
    );
end entity;

architecture konverter_arch of konverter_int_to_bcd is
    begin
        funkcija : process(cin, clk)
            variable izl : std_logic_vector(3 downto 0);
        begin
            if clk'event and clk = '1' then
                if cin < 10 then
                    izl := "0000";
                for i in 1 to cin loop
                    izl := std_logic_vector(unsigned(izl) + 1);
                end loop;
                else
                    izl := "1111";
                end if;
            end if;
            cout <= izl;
        end process;
end architecture;


-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity konverter_int_to_bcd_tb is
end entity;

architecture konverter_int_to_bcd_tb of konverter_int_to_bcd_tb is
    signal c_in : integer range 0 to 9;
    signal clk : bit;
    signal c_out : std_logic_vector(3 downto 0);
    begin
    dut : entity work.konverter_int_to_bcd(konverter_arch)
        port map(
            cin => c_in,
            clk => clk,
            cout => c_out
        );

    clock : process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;

    stimuli : process
    begin
        c_in <= 9;
        wait for 8 ns;

        c_in <= 1;
        wait for 8 ns;

        c_in <= 5;
        wait for 8 ns;
    end process;
end architecture;