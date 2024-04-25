-- 2021 II kol stara akridetacija

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity dff is
  port (
    clk, d : in std_logic;
    q : out std_logic;
  ) ;
end dff ; 

architecture a_dff of dff is
begin
    q <= d when (clk'event and clk = '0') else q;
end architecture ;
------------------------------------------- end dff

