
library IEEE;
use IEEE.std_logic_1164.all;

-- D flip-flop - entity
entity dff is
    port (
        d, rst, clk : in std_logic;
        q : out std_logic
    );
end entity dff;

-- D flip-flop with asynchronous clear - architecture
architecture asyncCLR of dff is
begin

    state_change: process (clk, rst)
    begin 
        if rst = '1' then
            q <= '0' after 2 ns;
        elsif clk'EVENT and clk = '1' then
            q <= d after 2 ns;
        end if;
    end process state_change;


end architecture asyncCLR;


-- D flip-flop with synchronous clear - architecture
architecture syncCLR of dff is
begin

    state_change: process (clk)
    begin 
        if clk'EVENT and clk = '1' then
            if rst = '1' then
                q <= '0' after 2 ns;
            else
                q <= d after 2 ns;
            end if;
        end if;
    end process state_change;

end architecture syncCLR;