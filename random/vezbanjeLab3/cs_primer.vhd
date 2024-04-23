
-- Primer od cs-a za lab3

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity saSlike is
  port (
    a, b, cin : in std_logic;
    cout : out std_logic
  ) ;
end saSlike ; 

architecture a_saSlike of saSlike is
begin

    cout <= (cin xor a) or b;

end architecture ;

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity celo is
    generic (n : integer := 4); 
    port (
        a, b : in std_logic_vector(0 to n-1);
        cin : in std_logic;
        izlaz : out std_logic_vector(0 to n-1);
    );
end celo ; 

architecture a_celo of celo is
begin

    generisi: for i in 0 to n-1 generate
    begin
        
        uslovi: if i = 0 generate
        begin
            kadJePrvi: entity work.saSlike(a_saSlike)
            port map (a(i), b(i), cin, izlaz(i));

        else generate
            uSredini: entity work.saSlike(a_saSlike)
            port map (a(i), b(i), izlaz(i-1), izlaz(i));

        end generate uslovi;
    end generate generisi;
end architecture ;

------------------------------------------------------

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic (n : integer := 3);
end tb ; 

architecture atb of tb is
    signal a, b, izlaz : std_logic_vector(0 to n-1);
    signal cin : std_logic;

begin
    dut : entity work.celo(a_celo)
    generic map(n)
    port map (a, b, cin, izlaz);

    stimuli: process
    begin
        a <= "001"
        b <= "010"
        cin <= '0'
        wait for 50 ns;
    end process stimuli;

end architecture ;