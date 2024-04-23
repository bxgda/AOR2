-- POTPUNI SABIRAC
entity full_adder is
    port (a, b, cin : in bit;
          sum, cout : out bit);
end entity full_adder;

architecture truth_table of full_adder is
begin

    -- fancy resenje
    process (a, b, cin) is
    begin
        sum <= a xor b xor cin;
        cout <= (a and b) or ((a xor b) and cin);

        -- with bit_vector'(a, b, cin) 
        -- select (cout, sum) <=
        --     bit_vector'("00") when "000",
        --     bit_vector'("01") when "001",
        --     bit_vector'("01") when "010",
        --     bit_vector'("10") when "011",
        --     bit_vector'("01") when "100",
        --     bit_vector'("10") when "101",
        --     bit_vector'("10") when "110",
        --     bit_vector'("11") when "111",
        --     bit_vector'("00") when others;

    end process; 
    
end architecture truth_table;