-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterBCD is
    port(
        ce, wr, clk : in std_logic;
        Din : in integer range 0 to 999;
        q : out std_logic_vector(11 downto 0)
    );
end entity;

architecture counterBCD_arch of counterBCD is
    begin
        funk : process(clk)
        variable brojac : integer range 0 to 999;
        variable temp : integer range 0 to 999;
        variable jedinica : integer range 0 to 9;
        variable desetica : integer range 0 to 9;
        variable stotina : integer range 0 to 9;
        variable dozvola : std_logic;
        begin
            if ce'event then
                dozvola := ce;
            end if;
            
            if (clk'event and clk = '1') then
                if (ce = '1' and wr = '0' and brojac /= 0) then
                    brojac := brojac - 1;
                elsif wr = '1' then
                    dozvola := '0';
                    brojac := Din;
                elsif ce = '0' then
                    q <= std_logic_vector(to_unsigned(brojac, 12));
                end if;
            end if;

            jedinica := brojac mod 10;
            temp := brojac / 10;
            desetica := temp mod 10;
            temp := temp / 10;
            stotina := temp mod 10;

        q <= std_logic_vector(to_unsigned(stotina, 4) & to_unsigned(desetica, 4) & to_unsigned(jedinica, 4));
        end process;
end architecture;



-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end entity;

architecture counter_tb of counter_tb is
    signal clk:  std_logic;
    signal ce, wr :  std_logic;
    signal D_in :  integer range 0 to 999;
    signal q :  std_logic_vector(11 downto 0);
    begin
        dut : entity work.counterBCD(counterBCD_arch)
        port map(
            clk => clk,
            ce => ce,
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
            ce <= '1';
            wr <= '0';
            D_in <= 690;
            wait for 12 ns;
            ce <= '1';
            wr <= '1';
            D_in <= 690;
            wait for 12 ns;
            ce <= '1';
            wr <= '0';
            D_in <= 690;
            wait for 12 ns;
        end process;
end architecture;