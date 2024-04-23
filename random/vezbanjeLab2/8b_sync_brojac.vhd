
-- Треба реализовати 8b кружни бројач са асинхроним ресетом, 
-- паралелним уписом, дозволом уписа, дозволом бројања и избором смера бројања.


library IEEE;
use IEEE.std_logic_1164.all;

entity counter8 is
  port (
    clk, rst, wr, ce, dir : in std_logic;
    din : in integer range 0 to 255;
    dout : out integer range 0 to 255;
  ) ;
end counter8 ;

architecture a_counter8 of counter8 is
begin

    process (clk, rst)
    variable counter : integer range 0 to 255;
    begin
        if rst = '1' then
            counter := 0;
        elsif clk'event and clk = '1' then
            if wr = '1' then
                counter := din;
            else
                if ce = '1' then
                    if dir = '1' then
                        if counter = 255 then counter := 0;
                        else counter := counter + 1;
                        end if;
                    else
                        if counter = 0 then counter := 255;
                        else counter := counter - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;

        dout <= counter;
    end process;


end architecture ; -- a_counter8

----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity counter8_tb is
end counter8_tb ;

architecture a_counter8_tb of counter8_tb is
    signal clk, rst, wr, ce, dir : std_logic;
    signal din, dout : integer range 0 to 255;
begin

    dut: entity work.counter8(a_counter8)
        port map(clk, rst, wr, ce, dir, din, dout);

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    stimuli: process
    begin
        rst <= '0';
        wr <= '1';
        ce <= '1';
        dir <= '1';
        din <= 104;
        wait for 7 ns;
        wr <= '0';
        wait for 200 ns;
		wr <= '1';
        dir <= '0';
        din <= 44;
        wait for 12 ns;
        wr <= '0';
        wait for 200 ns;
        ce <= '0';
        wait for 20 ns;
        ce <= '1';
        wait for 100 ns;
    end process stimuli;


end architecture ; -- a_counter8_tb