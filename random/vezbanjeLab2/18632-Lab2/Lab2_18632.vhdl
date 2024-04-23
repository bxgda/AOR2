-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterBCD is
    port(
        wr, clk : in std_logic;
        Din : in integer range 0 to 999;
        q : out std_logic_vector(11 downto 0)
    );
end entity;

architecture counterBCD_arch of counterBCD is
    begin
        funk : process
        variable brojac : integer range 0 to 999;
        variable temp : integer range 0 to 999;
        variable jed : integer range 0 to 9;
        variable des : integer range 0 to 9;
        variable sto : integer range 0 to 9;
        begin
            
            if (clk'event and clk = '1') then
                if (wr = '0' and brojac /= 999) then
                    brojac := brojac + 1;
                elsif wr = '1' then
                    brojac := Din;
                elsif brojac = 999
                	brojac := 0;
                end if;
            end if;

            --jed := brojac mod 10;
            --temp := brojac / 10;
            --des := temp mod 10;
            --temp := temp / 10;
            --sto := temp mod 10;

        --q <= std_logic_vector(to_unsigned(sto, 4) & to_unsigned(des, 4) & to_unsigned(jed, 4));

        q <= std_logic_vector(to_unsigned(brojac, 12));
        wait on clk;

        end process;
end architecture;



-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end entity;

architecture counter_tb of counter_tb is
    signal clk:  std_logic;
    signal wr :  std_logic;
    signal D_in :  integer range 0 to 999;
    signal q :  std_logic_vector(11 downto 0);
    begin
        dut : entity work.counterBCD(counterBCD_arch)
        port map(
            clk => clk,
            wr => wr,
            Din => D_in,
            q => q
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
            wr <= '0';
            D_in <= 690;
            wait for 12 ns;
            wr <= '1';
            D_in <= 690;
            wait for 12 ns;
            wr <= '0';
            D_in <= 690;
            wait for 12 ns;
        end process;
end architecture;