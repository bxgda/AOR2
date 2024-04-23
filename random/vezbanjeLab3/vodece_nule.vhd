
-- Izbroj vodece nule - primer od rac. vezbe

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity leading_zeros is
    generic (n : integer := 8);
    port (
        data : in std_logic_vector(n-1 downto 0);
        zeros : out integer range 0 to n; 
    ) ;
end leading_zeros ;

architecture a_leading_zeros of leading_zeros is
begin
    
    process(data)
        variable count : integer range 0 to n;
    begin
        count := 0;

        -- data'range odradi kao sto je u deklaraciji znaci kao da pise n-1 downto 0
        for i in data'range loop
            if data(i) = '0' then
                count := count + 1;
            else 
                exit;
            end if;
        end loop;

        zeros <= count;
    end process;

end architecture ; -- a_leading_zeros


-----------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity leading_zeros_tb is
    generic (n : integer := 8);
end leading_zeros_tb ;

architecture a_leading_zeros_tb of leading_zeros_tb is
    signal data : std_logic_vector(n-1 downto 0);
    signal zeros : integer range 0 to n;
begin

    dut: entity work.leading_zeros(a_leading_zeros)
        generic map (n)
        port map (data, zeros);
    
    stimuli: process
    begin
        data <= "00000101";
        wait for 10 ns;
        data <= "00010101";
        wait for 10 ns;
        data <= "00000011";
        wait for 10 ns;
    end process stimuli;


end architecture ; -- a_leading_zeros_tb