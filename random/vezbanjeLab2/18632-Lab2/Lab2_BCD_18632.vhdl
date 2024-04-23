-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity counter_BCD is
 port (
        wr: IN std_logic;
        clk: IN std_logic;
        Din: IN std_logic_vector(11 downto 0);
        q: OUT std_logic_vector(11 downto 0)
        );
end entity;

architecture counter_BCD_arch of counter_BCD is
begin
    process
        variable jed: std_logic_vector(3 downto 0);
        variable des: std_logic_vector(3 downto 0);
        variable sto: std_logic_vector(3 downto 0);
    begin
         if clk'event and clk = '1' then
          if wr='1' then
                jed := Din(3 downto 0);
                des := Din(7 downto 4);
                sto := Din(11 downto 8);
            else 
                case jed is
                    when "0000" => jed := "0001";
                    when "0001" => jed := "0010";
                    when "0010" => jed := "0011";
                    when "0011" => jed := "0100";
                    when "0100" => jed := "0101";
                    when "0101" => jed := "0110";
                    when "0110" => jed := "0111";
                    when "0111" => jed := "1000";
                    when "1000" => jed := "1001";
                    when "1001" => jed := "0000";
                    when others => jed := "1001";
                 end case;
                 
                 if (jed = "0000") then
                  case des is
                        when "0000" => des := "0001";
                        when "0001" => des := "0010";
                        when "0010" => des := "0011";
                        when "0011" => des := "0100";
                        when "0100" => des := "0101";
                        when "0101" => des := "0110";
                        when "0110" => des := "0111";
                        when "0111" => des := "1000";
                        when "1000" => des := "1001";
                        when "1001" => des := "0000";
                        when others => des := "1001";
                  end case;
                    
                    if (des = "0000") then
                      case sto is
                        when "0000" => sto := "0001";
                        when "0001" => sto := "0010";
                        when "0010" => sto := "0011";
                        when "0011" => sto := "0100";
                        when "0100" => sto := "0101";
                        when "0101" => sto := "0110";
                        when "0110" => sto := "0111";
                        when "0111" => sto := "1000";
                        when "1000" => sto := "1001";
                        when "1001" => sto := "0000";
                        when others => sto := "1001";
                      end case;
                     end if;
                 end if;
            
            
            end if;
            q(3 downto 0) <= jed;
            q(7 downto 4) <= des;
            q(11 downto 8) <= sto;
         
         end if;
        
         wait on clk;
    end process;
end architecture;



-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity counter_tb is
    end entity;

architecture counter_tb of counter_tb is
    signal wr, clk: std_logic;
    signal d_in, q: std_logic_vector(11 downto 0);
    begin
        dut: entity work.counter_BCD(counter_BCD_arch)
            port map(
                    wr => wr,
                    clk => clk,
                    Din => d_in,
                    q => q
                );

        clock: process
        begin
            clk<='1';
            wait for 5 ps;
            clk<='0';
            wait for 5 ps;
        end process;

        stimulus: process
        begin
        
            wr<='1';
            d_in<="010101010100";
            wait for 32 ps;
            
            wr<='0';
            wait for 500 ps;
            
        end process;
end architecture;