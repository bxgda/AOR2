
-- delitelj kloka svih odnosa do max_divide_ratio

library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
    generic (n : integer := 3);
    port (
        clk_in, rst : in std_logic;
        clk_out : out std_logic_vector(n-1 downto 0);
    ) ;
end clock_divider ;

architecture behavior of clock_divider is
begin

    process (clk_in, rst)
    variable counter : integer range 0 to 2**n-1 := 0;
    begin

        if (rst = '1') then
            clk_out <= (others => '0');
            counter := 0;

        elsif clk_in'event and clk_in = '1' then

            counter := counter + 1;

            for i in 0 to n-1 loop
                if counter mod 2**i = 0 then
                    clk_out(i) <= not clk_out(i);
                end if;
            end loop;
            
            if counter = 2**n-1 then
                counter := 0;  -- Resetovanje brojača kada dostigne 2^n
            end if;

        end if;

    end process;


end architecture behavior ; -- behavior

----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity clock_divider_tb is
    generic (n : integer := 3);
end entity clock_divider_tb;

architecture behavior of clock_divider_tb is
    signal clk_in, rst : std_logic;
    signal clk_out : std_logic_vector(n-1 downto 0);
begin

    uut : entity work.clock_divider(behavior)
    	generic map(n)
        port map (clk_in, rst, clk_out);

    clk_process : process
    begin
        clk_in <= '0';
        wait for 5 ns;
        clk_in <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
    	rst <= '1';
        wait for 1 ns;
        rst <= '0';
        wait for 500 ns;
    end process;

    
end architecture behavior;