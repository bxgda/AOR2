
-- Brojac osnove 16 sa asinhronim resetom

library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
    port (
        clk, rst : in bit;
        count : out natural
    );
end entity counter;
--------------------------------------------------------
architecture arch_counter of counter is
begin

    incrementer : process is
        variable count_value : natural := 0;
    begin

        count <= count_value;
        loop

            loop
                wait until clk = '1' or rst = '1';
                exit when rst = '1';
                count_value := (count_value + 1) mod 16;
                count <= count_value;
            end loop;

            count_value := 0;
            count <= count_value;
            wait until rst = '0';

        end loop;

    end process incrementer;

end architecture arch_counter;




-- Testbench
----------------------------------------------------
entity counter_tb is
    -- empty
end entity counter_tb;

architecture a_counter_tb of counter_tb is
    signal clk : bit := '0';
    signal rst : bit;
    signal count : natural;
begin

    uut: entity work.counter(arch_counter)
        port map (clk, rst, count);

    process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;

end architecture a_counter_tb;