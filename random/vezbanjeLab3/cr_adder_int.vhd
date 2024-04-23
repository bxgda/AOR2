
-- n-to bitni carry ripple adder preko instanciranja komponenti

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity cra is
    port (
        a, b, cin : in std_logic;
        s, cout : out std_logic;
    ) ;
end cra ; 

architecture acra of cra is
begin

    s <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);    

end architecture ;

--------------------------------------------------------

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity nb_cra is
    generic (n : integer := 4) ;
    port (
        a, b : in std_logic_vector(n-1 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(n-1 downto 0);
        cout : out std_logic;
    ) ;
end nb_cra ; 

architecture anb_cra of nb_cra is
    signal c_int : std_logic_vector(n downto 0);
begin

    generisi: for i in 0 to n-1 generate
    begin

        uslovi: if i = 0 generate
        begin
            instanca_nultog: entity work.cra(acra)
                port map (a(i), b(i), cin, s(i), c_int(i));

        elsif i = n-1 generate
            instanca_poslednjeg: entity work.cra(acra)
                port map (a(i), b(i), c_int(i-1), s(i), cout);

        else generate
            instanca: entity work.cra(acra)
                port map (a(i), b(i), c_int(i-1), s(i), c_int(i));
                

        end generate uslovi;
    end generate generisi;
end architecture ;


-- testbench

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb ; 

architecture atb of tb is
    signal a, b, s : std_logic_vector(n-1 downto 0);
    signal cin, cout : std_logic;

begin
    dut: entity work.nb_cra(anb_cra)
        generic map (n)
        port map (a, b, cin, s, cout);
    
    stimuli: process
    begin
        a <= "0011";
        b <= "0110";
        cin <= '0';
        wait for 50 ns;
    end process stimuli;

end architecture ;