library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
    generic (n : integer := 2);
    port(
        clk_in : in std_logic;
        clk_out : out std_logic := '0';
    );
end entity clock_divider;

architecture behavior of clock_divider is
    signal counter : integer range 0 to n-1 := 0;
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = n-1 then
                clk_out <= not clk_out;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
end architecture behavior;

------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity clock_divider_tb is
    generic (n : integer := 2);
end entity clock_divider_tb;

architecture behavior of clock_divider_tb is
    signal clk_in : std_logic;
    signal clk_out : std_logic;
begin

    uut : entity work.clock_divider(behavior)
    	generic map(n)
        port map (clk_in, clk_out);

    clk_process : process
    begin
        clk_in <= '0';
        wait for 5 ns;
        clk_in <= '1';
        wait for 5 ns;
    end process;

    
end architecture behavior;