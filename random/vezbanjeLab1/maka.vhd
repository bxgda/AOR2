library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
    port (
        x0, x1, x2 : in bit;
        sel0 : in std_logic;
        sel1 : in std_logic;
        y : out bit;
    );
end entity mux;

architecture a_mux of mux is
begin

    process (x0, x1, x2, sel0, sel1)
    begin
        if sel1 = '0' and sel0 = '0' then
            y <= x0;
        elsif sel1 = '0' and sel0 = '1' then
            y <= x1;
        elsif sel1 = '1' and sel0 = '0' then
            y <= x2;

        -- kazes ako dodje za sel 11 onda se nista ne desava
        -- jer si ga tako napravila jer imas 3 ulaza, i 4. ti je nebitan
        
        end if;
    end process;
end architecture a_mux;


-------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mux_tb is
end entity mux_tb;

architecture a_mux_tb of mux_tb is
    signal x0, x1, x2, y : bit;
    signal sel0, sel1 : std_logic;
begin

    uut: entity work.mux(a_mux)
        port map (x0, x1, x2, sel0, sel1, y);

    process
    begin
        x0 <= '1';
        x1 <= '0';
        x2 <= '1';
        sel0 <= '0';
        sel1 <= '0';
        wait for 10 ns;
        sel0 <= '1';
        sel1 <= '0';
        wait for 10 ns;
        x0 <= '1';
        x1 <= '1';
        x2 <= '0';
		sel0 <= '0';
        sel1 <= '1';
        wait for 10 ns;
        sel0 <= '1';
        sel1 <= '1';
        wait for 10 ns;
    end process;

end architecture a_mux_tb ;