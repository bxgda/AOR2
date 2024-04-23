
library IEEE;
use IEEE.std_logic_1164.all;

entity jk is
    port (
        j, k, clk : in std_logic;
        q : out std_logic := '0';
    );
end entity jk;

architecture a_jk of jk is
    signal jk : std_logic_vector (1 downto 0);
begin
    jk <= j & k;

    process (clk) is
    begin
        if clk'EVENT and clk = '1' then

            case jk is
                -- when "00" => q <= q;
                when "01" => q <= '0';
                when "10" => q <= '1';
                when "11" => q <= not q;
                when others => q <= q;
            end case;

        end if;

    end process;


end architecture a_jk;





-- TESTBENCH
library IEEE;
use IEEE.std_logic_1164.all;

entity jk_tb is
    -- empty
end entity jk_tb;

architecture a_tb of jk_tb is
    signal j, k, q : std_logic;
    signal clk : std_logic := '0';
begin

    uut : entity work.jk(a_jk)
        port map (j, k, clk, q);
    
    clk_process : process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process clk_process;

    stim_process : process
    begin
        j <= '0';
        k <= '0';
        wait for 7 ns;

        j <= '1';
        wait for 9 ns;

        j <= '0';
        wait for 8 ns;

        k <= '1';
        j <= '1';
        wait for 11 ns;

    end process stim_process;

end architecture a_tb;
