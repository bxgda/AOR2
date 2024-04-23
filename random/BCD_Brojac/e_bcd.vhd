
library IEEE;
use IEEE.std_logic_1164.all;

entity e_bcd is
    port (
        clr : in bit;
        clk : in bit;
        q   : out bit_vector(3 downto 0);
    );
end entity e_bcd;

architecture a_e_bcd of e_bcd is
begin

    process (clr, clk)
        variable q_int : bit_vector(3 downto 0);
        variable cq : bit;  -- da broji svaki drugi takt
    begin

        if clr = '1' then
            q_int := "0000";
            cq := '0';

        elsif clk'EVENT and clk = '1' then
            cq := not cq;
            if cq = '1' then
                case q_int is
                    WHEN "0000" => q_int := "0001";
                    WHEN "0001" => q_int := "0010";
                    WHEN "0010" => q_int := "0011";
                    WHEN "0011" => q_int := "0100";
                    WHEN "0100" => q_int := "0101";
                    WHEN "0101" => q_int := "0110";
                    WHEN "0110" => q_int := "0111";
                    WHEN "0111" => q_int := "1000";
                    WHEN "1000" => q_int := "1001";
                    WHEN OTHERS => q_int := "0000";
                end case;
            end if;
        end if;

        q <= q_int;

    end process;

end architecture a_e_bcd;

--------------------------------------------------------------------

-- Testbench
entity e_bcd_tb is
    -- empty
end entity e_bcd_tb;

architecture a_e_bcd_tb of e_bcd_tb is
    signal clr : bit;
    signal clk : bit := '1';
    signal q : bit_vector(3 downto 0);
begin

    uut: entity work.e_bcd(a_e_bcd)
        port map (clr, clk, q);

    process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;

end architecture a_e_bcd_tb;
