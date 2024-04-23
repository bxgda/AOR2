
-- Memorija, sinhrona - primer od rac. vezbe

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
  port (
    clk, we: in std_logic;
    addr, data : in std_logic_vector(7 downto 0);
    q : out std_logic_vector(7 downto 0);
  ) ;
end memory ;

architecture a_memory of memory is
    type ram_mem_type is array(255 downto 0) of std_logic_vector(7 downto 0);
    signal rammem : ram_mem_type;
begin

    process(clk)
    variable addrtemp : integer range 255 downto 0;
    begin
        if clk'event and clk = '1' then
            addrtemp := to_integer(unsigned(addr));
            
            if we = '1' then
                rammem(addrtemp) <= data;
            end if;
                
            q <= rammem(addrtemp);
        end if;
    end process;

end architecture ; -- a_memory


--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory_tb is
end memory_tb ;

architecture a_memory_tb of memory_tb is
    signal clk, we : std_logic;
    signal addr, data, q : std_logic_vector(7 downto 0);
begin

    dut: entity work.memory(a_memory)
        port map (clk, we, addr, data, q);
    
    process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;
    stimuli: process
    begin
        we <= '1';
        addr <= "00000110"; -- 6 pisanje
        data <= "11110000";
        wait for 10 ns;
        addr <= "00000111"; -- 7 pisanje
        data <= "11110001";
        wait for 10 ns;
        addr <= "00001001"; -- 9 pisanje
        data <= "11010100";
        wait for 10 ns;
        we <= '0';
        addr <= "00000111"; -- 7 citanje
        wait for 20 ns;
        addr <= "00001111"; -- citanje sa adrese gde nije upisano nista
        wait for 20 ns;
        we <= '1';
        addr <= "00001001"; -- pisanje u vec upsano polje 9 (da vidim kvo ce bude na izlaz dal novoupisana ili staroupisana)
        data <= "11111111";
        wait for 20 ns;
    end process stimuli;


end architecture ; -- a_memory_tb