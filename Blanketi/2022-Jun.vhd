
-- 2022 Jun

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity brojac is
    generic (n : integer := 10) ; -- osnove 10
    port (
        clk, ce, wr, smer : in std_logic;
        d_in : in integer range 0 to n-1; -- probao sam sa std_logic_vector al zajebano kad treba se prebaci jer za broj bitova se mora trazi logaritam
        -- sve u svemu nigde ne pise kakav ulaz treba da bude
        d_out: out integer range 0 to n-1;
    ) ;
end brojac ; 

architecture a_brojac of brojac is
begin

    process(clk)
        variable stanje_brojaca : integer range 0 to n-1;
    begin

        if clk'event and clk = '1' then             -- na aktivnu ivicu kloka
            if ce = '1' then                        -- ako je dozvoljeno brojanje
                if smer = '1' then
                    if wr = '1' and stanje_brojaca = (n-1) then
                        stanje_brojaca := d_in;     -- ako je do poslednjeg postavi sa ulaza poc. vr.
                    else
                        stanje_brojaca := (stanje_brojaca + 1) mod n;
                    end if;
                else
                    if wr = '1' and stanje_brojaca = 0 then
                        stanje_brojaca := d_in;
                    else
                        stanje_brojaca := (stanje_brojaca - 1) mod n;
                    end if;
                end if;
            elsif wr = '1' then                     -- ako nije dozvoljeno brojanje proveri dozvolu upisa
                stanje_brojaca := d_in;
            end if;
        end if;

        d_out <= stanje_brojaca;

    end process ;

end architecture ;
------------------------------------------------------------ end brojac


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic( n : integer := 10 );
end tb ; 

architecture a_tb of tb is
    signal clk, ce, wr, smer : std_logic;
    signal din, dout : integer;

begin

    dut: entity work.brojac(a_brojac)
        generic map (n)
        port map (clk, ce, wr, smer, din, dout);

    clk_generator: process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;

    stimuli: process
    begin
        ce <= '0';
        din <= 5;
        wr <= '1';
        smer <= '1';
        wait for 10 ns;
        ce <= '1';
        din <= 3;
        wait for 300 ns;
        smer <= '0';
        wait for 200 ns;
    end process;
end architecture ;