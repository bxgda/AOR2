library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dff is
  port (
    clk, d : in std_logic;
    q : out std_logic;
  ) ;
end dff ;

architecture a_dff of dff is
begin
    q <= d when clk'event and clk = '1';
end architecture ; -- a_dff

------------------------------------------------------- end dff

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity three_state_buffer is
  port (
    a, en : in std_logic;
    y : out std_logic;
  ) ;
end three_state_buffer ;

architecture a_three_state_buffer of three_state_buffer is
begin
    y <= a when en = '1' else 'Z';
end architecture ; -- a_three_state_buffer

-------------------------------------------------------- end three_state_buffer

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity reg is
  generic (width : positive);
  port (
    clk, out_enable : in std_logic;
    data_in : in std_logic_vector(0 to width-1);
    data_out : out std_logic_vector(0 to width-1);
  ) ;
end reg ; 

architecture a_register of reg is
begin

  cell_array: for bit_index in 0 to width-1 generate
    signal data_unbuffered : std_logic;
  begin
  
    cell_storage: entity work.dff(a_dff)
      port map (
        clk, data_in(bit_index), data_unbuffered
      );
    
    cell_buffer: entity work.three_state_buffer(a_three_state_buffer)
      port map (
        data_unbuffered, out_enable, data_out(bit_index)
      );

  end generate;
    
end architecture ;

---------------------------------------------------------- end register


-- Testbench

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity tb is
  generic (n : positive := 8);
end tb ; 

architecture a_tb of tb is
  signal clk, out_enable : std_logic;
  signal data_in, data_out : std_logic_vector(0 to n-1);
begin

  dut: entity work.reg(a_register)
	generic map (n)
	port map (clk, out_enable, data_in, data_out);

  process
  begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
  end process;

  stimuli: process
  begin
    out_enable <= '0';
    data_in <= "11101011";
    wait for 10 ns;
    out_enable <= '1';
    wait for 50 ns;
    data_in <= "00011111";
    wait for 20 ns;
  end process;

end architecture ;