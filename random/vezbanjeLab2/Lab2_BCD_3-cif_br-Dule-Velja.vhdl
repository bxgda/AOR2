library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter is
port (clock: in std_logic;
      CE, WR : in std_logic;
      Din : in integer range 0 to 999;
      Q : out std_logic_vector(11 downto 0));
end entity;

architecture arch of bcd_counter is

begin
  process (clock)
  variable brojac : integer range 0 to 999;
	variable brojac_temp : integer range 0 to 999;
	variable jedinice : integer range 0 to 9;
	variable desetice : integer range 0 to 9;
	variable stotine : integer range 0 to 9;
  begin
    if (clock'event and clock='1') then
      if (WR='1') then
        if (brojac=0) then
        brojac := Din;
  		end if;
      else
        if (CE='1' and brojac/=0) then
             brojac := brojac - 1;
		end if;
	end if;
	end if;
	
	jedinice := brojac mod 10;
	brojac_temp := brojac / 10;
	desetice := brojac_temp mod 10;
	brojac_temp := brojac_temp/10;
	stotine := brojac_temp mod 10;
	
Q<=std_logic_vector(to_unsigned(stotine, 4) & to_unsigned(desetice, 4) & to_unsigned(jedinice,4));
	
end process;
end architecture;   


library ieee;
use ieee.std_logic_1164.all;
entity tb is
end entity tb;
architecture tb of tb is
signal clock:  std_logic;
signal CE, WR :  std_logic;
signal Din :  integer range 0 to 999;
signal Q :  std_logic_vector(11 downto 0);
BEGIN
	uut: entity work.bcd_counter(arch) 
    port map( clock, ce, wr, din, q);
    klok: process
    begin
    clock<= '0';
    wait for 10ps;
    clock<='1';
    wait for 10ps;
    end process klok;
    stimuli: process
    begin
    ce <= '1';
    wr <= '0';
    din <= 690;
    wait for 120ps;
    ce <= '1';
    wr <= '1';
    din <= 690;
    wait for 120ps;
    ce <= '1';
    wr <= '0';
    din <= 690;
    wait for 120ps;
	end process stimuli;
end tb;