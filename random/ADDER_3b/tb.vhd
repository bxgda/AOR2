-- 3b SABIRAC TEST BENCH
entity adder3b_tb is
end entity adder3b_tb;
    
architecture testbench of adder3b_tb is
    signal a, b, sum : bit_vector(2 downto 0);
    signal cin, cout : bit;
begin

    uut: entity work.adder3b(a_adder3b)
        port map (a, b, cin, sum, cout);

    stimuli: process
    begin
        a <= "101";
        b <= "001";
        cin <= '0';
        wait for 10 ns;

        a <= "001";
        b <= "011";
        cin <= '0';
        wait for 10 ns;

        a <= "001";
        b <= "001";
        cin <= '0';
        wait for 10 ns;

        a <= "001";
        b <= "111";
        cin <= '0';
        wait for 10 ns;

        wait;
    end process stimuli;

end architecture testbench;