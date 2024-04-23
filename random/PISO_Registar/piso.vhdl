-- PISO (parallel input serial output) registar

library IEEE;
use IEEE.std_logic_1164.all;

entity piso is
    generic (
        n : integer := 8
    );
    port (
        wr, clk : in std_logic;
        d_in : in std_logic_vector(n-1 downto 0);
        d_out : out std_logic;
    );
end entity piso;

architecture a_piso of piso is
begin

    process is
        variable int_storage: std_logic_vector(n-1 downto 0);
    begin   
        
        wait until wr = '1';                            -- upis pocinje

        int_storage := d_in;                            -- smesti se u promenljivu i d_in moze da se menja
        for i in n-1 downto 0 loop
            wait until rising_edge(clk);                -- isto kao (clk'EVENT and clk = '1');
            d_out <= int_storage(i);
        end loop;

        wait until rising_edge(clk);                    --  na sledeci klok upisuje HiZ
        d_out <= 'Z';

    end process;

end architecture a_piso;

------------------------------------------------------------------------

-- Testbench
library IEEE;
use IEEE.std_logic_1164.all;

entity piso_tb is
    generic(
        width : integer := 4;
    );
end entity piso_tb;

architecture a_piso_tb of piso_tb is
    signal wr : std_logic;
    signal d_in : std_logic_vector(width-1 downto 0);
    signal clk : std_logic := '0';
    signal d_out : std_logic;
begin

    uut: entity work.piso(a_piso)
        generic map (
            n => width
        )
        port map (
            wr => wr,
            d_in => d_in,
            clk => clk,
            d_out => d_out
        );


        clk <= not clk after 5 ns;


        stimuli: process
        begin

            d_in <= "0101";
            wr <= '1';
            wait for 5 ns;
            wr <= '0';
            wait for 60 ns;
            d_in <= "1101";
            wr <= '1';
            wait for 10 ns;
            d_in <= "0000";
            wait for 50 ns;
            wr <= '0'
            wait 5 ns;

        end process stimuli;


end architecture a_piso_tb;