-- 3b SABIRAC
entity adder3b is
    port (a, b : in bit_vector(2 downto 0);
          cin : in bit;
          sum : out bit_vector(2 downto 0);
          cout : out bit);
end entity adder3b;

architecture a_adder3b of adder3b is
    signal c01, c12 : bit;
begin

    bit0: entity work.full_adder(truth_table)
        port map (a(0), b(0), cin, sum(0), c01);

    bit1: entity work.full_adder(truth_table)
        port map (a(1), b(1), c01, sum(1), c12);

    bit2: entity work.full_adder(truth_table)
        port map (a(2), b(2), c12, sum(2), cout);

end architecture a_adder3b;