library IEEE;
use IEEE.std_logic_1164.all;

entity XORgate is
    port(a,b : in std_logic;
        c : out std_logic);
end entity;

architecture archX of XORgate is
    begin
        c <= a xor b;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
entity ORgate is
    port(a,b : in std_logic;
        c : out std_logic);
end entity;

architecture archO of ORgate is
    begin
        c <= a or b;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
entity komp is
    port(a1, a2, a3 : std_logic;
    cout : std_logic);
end entity;

architecture archKomp of komp is
    signal prn : std_logic;
    begin
        prva: entity work.XORgate(archX)
            port map(a=>a1, b=>a2, c=>prn);
        druga: entity work.ORgate(archO)
            port map(a=>prn, b=>a3, c=>cout);
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
entity kolo is
    generic(n : integer := 4);
    port(cin : in std_logic;
        d1, d2 : in std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0));
end entity;

architecture arch of kolo is
    signal c_int : std_logic_vector(n downto 0);
begin
    c_int(0) <= cin;
    petlja: for i in 0 to n-1 generate
    begin
        inst: entity work.komp(archKomp)
            port map(a1=>c_int(i), a2=>d1, a3=>d2, cout=>c_int(i+1));
        dout(i)<=c_int(i+1);
    end generate;
end arch;

--Testbench
entity kolo_tb is
    generic(n : integer := 4);
end entity;

architecture kolo_tb of kolo_tb is
    signal cin : std_logic;
    signal d1, d2, dout : std_logic_vector(n-1 downto 0);
begin
    inst: entity work.kolo(archKomp)
        generic map(n=>n);
        port map(cin=>cin, d1=>d1, d2=>d2, dout=>dout);

    stimuli: process is
        begin
            cin<='1';
            d1<="1010";
            d2<="1111";
            wait for 50ns;
    end process;
end architecture;
