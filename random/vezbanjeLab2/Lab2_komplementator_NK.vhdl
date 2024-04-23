library IEEE;
use IEEE.std_logic_1164.all;

entity komplement_NK is
    port(
        cin : in std_logic_vector(3 downto 0);
        clk : in bit;
        cout : out std_logic_vector(3 downto 0)
    );
end entity;

architecture komplement_NK_arch of komplement_NK is
    begin
        funk : process(cin, clk)
        begin
            if clk'event and clk = '1' then
                if cin(3) = '1' then
                    cout <= not cin;
                else
                    cout <= cin;
                end if;
            end if;
        end process;
end architecture;


entity komplement_NK_tb is
end entity;

architecture komplement_NK_tb of komplement_NK_tb is
    signal c_in : std_logic_vector(3 downto 0);
    signal clk : bit;
    signal c_out : std_logic_vector(3 downto 0);
    begin
        dut : entity work.komplement_NK(komplement_NK_arch)
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
            