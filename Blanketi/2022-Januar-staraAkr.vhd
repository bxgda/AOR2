
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic (n : positive := 4);
    port (
        ulazni : in std_logic;
        b, c : in std_logic_vector(n-1 downto 0);
        f : out std_logic_vector(n-1 downto 0);
        izlazni : out std_logic;
    ) ;
end kolo ; 

architecture a_kolo of kolo is
begin

    generisi: for i in n-1 downto 0 generate
    begin
        uslovi: if i = n-1 generate
        begin
            f(i) <= (ulazni xor b(i)) or c(i);
        else generate
            f(i) <= (f(i+1) xor b(i)) or c(i);
        end generate ;
    end generate ;

    izlazni <= f(0);

end architecture ;
-------------------------------------------------- end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : positive := 4);
end tb ; 

architecture a_tb of tb is
    signal ulazni, izlazni : std_logic;
    signal b, c, f : std_logic_vector(n-1 downto 0);

begin

    dut: entity work.kolo(a_kolo)
        generic map (n)
        port map (ulazni, b, c, f, izlazni);

    stimuli: process
    begin
        b <= "0010";
        c <= "0110";
        ulazni <= '0';
        wait for 10 ns; -- ocekuje se 0111
        b <= "1100";
        c <= "0010";
        ulazni <= '0';
        wait for 10 ns; -- ocekuje se 1011
    end process;
    

end architecture ;