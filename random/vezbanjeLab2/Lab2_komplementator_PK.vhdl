-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity komplement_PK is
    port(
        cin : in std_logic_vector(3 downto 0);
        clk : in bit;
        cout : out std_logic_vector(3 downto 0)
    );
end entity;

architecture komplement_PK_arch of komplement_PK is
    begin
        funk : process(cin, clk)
        begin
            if clk'event and clk = '1' then
                if cin(3) = '1' then
                    cout <= std_logic_vector(unsigned(not cin) + 1);
                else
                    cout <= cin;
                end if;
            end if;
        end process;
end architecture;

entity komplement_PK_tb is
end entity;

architecture komplement_PK_tb of komplement_PK_tb is
    signal c_in : std_logic_vector(3 downto 0);
    signal clk : bit;
    signal c_out : std_logic_vector(3 downto 0);
    begin
        dut : entity work.komplement_PK(komplement_PK_arch)
        port map(
            cin => c_in,
            clk => clk,
            cout => c_out
        );

        clock : process
        begin
            clk <= '1';
            wait for 5 ns;

            clk <= '0';
            wait for 5 ns;
        end process;

        stimuli : process
        begin
            c_in <= "0011";
            wait for 8 ns;

            c_in <= "1010";
            wait for 8 ns;

            c_in <= "1000";
            wait for 8 ns;

            c_in <= "0101";
            wait for 8 ns;
        end process;
end architecture;
            