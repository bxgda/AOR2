-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_BCD is
    port(
        clk, ce, wr : in bit;
        Din : in bit_vector(2 downto 0);
        q : out bit_vector(2 downto 0)
    );
end entity;

architecture counter_BCD_arch of counter_BCD is
    begin
        funk : process(clk, ce, wr)
            variable q_int : bit_vector(2 downto 0);
            variable cq : bit;
        begin
            if ce'event then
                cq := ce;
            end if;

            if clk'event and clk = '1' then
                if cq = '1' and wr = '0' then
                    case q_int is
                        when "111" => q_int := "110";
                        when "110" => q_int := "101";
                        when "101" => q_int := "100";
                        when "100" => q_int := "011";
                        when "011" => q_int := "010";
                        when "010" => q_int := "001";
                        when "001" => q_int := "000";
                        when "000" => q_int := Din;
                    end case;
                elsif cq = '0' then
                    q <= q_int;
                elsif wr = '1' then
                    q_int := Din;
                    cq := '0';
                end if;
            end if;
            q <= q_int;
        end process;
end architecture;
                        


-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity counter_BCD_tb is
end entity;

architecture counter_BCD_tb of counter_BCD_tb is
    signal clk, ce, wr : bit;
    signal D_in, q_int : bit_vector(2 downto 0);
    begin
        dut : entity work.counter_BCD(counter_BCD_arch)
        port map(
            clk => clk,
            ce => ce,
            wr => wr,
            Din => D_in,
            q => q_int
        );

        clock : process
        begin
            clk <= '1';
            wait for 5 ns;

            clk <= '0';
            wait for 5 ns;
        end process;

        stimuli : process
        begin
        
            D_in <="101";
      	  	ce <= '1';
          	wr <= '0';
          	WAIT FOR 8 ns;
	
          	wr <= '0';
         	WAIT FOR 8 ns;
         	 
          	wr <= '0';
          	WAIT FOR 8 ns;
          
          	wr <= '1';
          	--WAIT FOR 8 ns;
          
          	--D_in <="101";
          	wait for 8 ns;
          	ce<='0';
          	wr <= '0';
          	wait for 8 ns;
          	ce<='1';
          	wait for 8 ns;
            
        end process;
end architecture;