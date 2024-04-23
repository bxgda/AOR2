
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity bcd is
  port (
    clk, ce, clr : in std_logic;
    overflow : out std_logic;
    dout : out std_logic_vector(3 downto 0)
  ) ;
end bcd ; 

architecture a_bcd of bcd is
begin

    process(clk, clr)
        variable q_int : std_logic_vector(3 downto 0);
    begin
        
        if clr = '1' then
            q_int := "0000";
            overflow <= '0';

        elsif clk'event and clk = '1' then
            if ce = '1' then
                case q_int is
                    when "0000" => q_int := "0001"; overflow <= '0';
                    when "0001" => q_int := "0010";
                    when "0010" => q_int := "0011";
                    when "0011" => q_int := "0100";
                    when "0100" => q_int := "0101";
                    when "0101" => q_int := "0110";
                    when "0110" => q_int := "0111";
                    when "0111" => q_int := "1000";
                    when "1000" => q_int := "1001"; overflow <= '1';
                    when others => q_int := "0000"; overflow <= '0';
                end case;
            end if;
        end if;

        dout <= q_int;

    end process;
end architecture ;

---------------------------------------------------------- end 1b bcd

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity bcd_3b is
  port (
    clk, ce_in, clr : in std_logic;
    overflow_out : out std_logic;
    dout :  out std_logic_vector(11 downto 0)
  ) ;
end bcd_3b ; 

architecture a_bcd_3b of bcd_3b is
    signal overflow12, overflow23 : std_logic;
begin

    cifraJed: entity work.bcd(a_bcd)
        port map (clk, ce_in, clr, overflow12, dout(3 downto 0));

    cifraDes: entity work.bcd(a_bcd)
        port map (clk, overflow12, clr, overflow23, dout(7 downto 4));

    cifraSto: entity work.bcd(a_bcd)
        port map (clk, (overflow12 and overflow23), clr, overflow_out, dout(11 downto 8));

end architecture ;

----------------------------------------------------------- end full kolo


-- Testbench
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
end tb ; 

architecture a_tb of tb is
    signal clk, ce_in, clr, overflow_out : std_logic;
    signal dout : std_logic_vector(11 downto 0);
begin

    dut: entity work.bcd_3b(a_bcd_3b)
        port map (clk, ce_in, clr, overflow_out, dout);
        
    process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    stimuli: process
    begin
        ce <= '1';
        clr <= '1';
        wait for 10 ns;
        clr <= '0';
        wait for 1000 ns;   -- 1000 ns je malo ako ocemo da ode do 999 pa da predje na 0
                            -- stavi nesto vise ili smanji takt na 1,2 ns...
    end process stimuli;

end architecture ;