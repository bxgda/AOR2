
-- e sad ovde kaze n-ulazno kolo
-- prvo sam ga logicno protumacio da prima jedan std_logic_vector i odradi operaciju nad svim bitovima
-- ali to mi posle za celo kolo nema smisla niti vidim kako bi ga iskoristio
-- ovako prvima dva n-bitna podatka i odradi operaciju
-- da bi posle u glavno kolo mogo da "maskiram" ulazni podatak sa nekom opracijom
-- ako smislite nesto pametnije javljate

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity andOrXor is
    generic (n : integer := 4);
    port (
        a, b : in std_logic_vector(n-1 downto 0);
        op : in std_logic_vector(1 downto 0);
        y : out std_Logic_vector(n-1 downto 0);
    ) ;
end andOrXor ; 

architecture a_andOrXor of andOrXor is
begin

    process(a, b, op)
    begin
        case op is
            when "00" => -- AND
                y <= a and b;
            when "01" => -- OR
                y <= a or b;
            when "10" => -- XOR
                y <= a xor b;
            when others => -- default
                y <= (others => '0');
        end case;
    end process;

end architecture ;
----------------------------------------- end andOrXor

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kolo is
    generic (n : integer := 4);
    port (
        clk, mask_in : in std_logic;
        op : in std_logic_vector(1 downto 0);
        d_in : in std_logic_vector(n-1 downto 0);
        d_out : out std_logic_vector(n-1 downto 0);
    ) ;
end kolo ; 

architecture a_kolo of kolo is
    signal maska : std_logic_vector(n-1 downto 0);
    signal op_interni : std_logic_vector(1 downto 0);
    signal tmp : std_logic_vector(n-1 downto 0);

begin

    and_or_xor: entity work.andOrXor(a_andOrXor)
        generic map (n)
        port map (d_in, maska, op_interni, tmp);

    process (clk)
    begin
        if clk'event and clk = '1' then     -- na aktivnu ivicu kloka
            if mask_in = '1' then           -- zapamti masku i operaciju
                maska <= d_in;
                op_interni <= op;
                d_out <= (others => 'Z');   -- na izlaz visoka impedansa
            else
                d_out <= tmp;               -- inace na izlaz iz andOrXor kola maskiran podatak
            end if;
        end if;
    end process;

end architecture ;
------------------------------------------------------ end kolo

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
    generic (n : integer := 4);
end tb ; 

architecture a_tb of tb is
    signal clk, mask_in : std_logic;
    signal op : std_logic_vector(1 downto 0);
    signal d_in, d_out : std_logic_vector(n-1 downto 0);

begin

    dut: entity work.kolo(a_kolo)
        generic map (n)
        port map (clk, mask_in, op, d_in, d_out);

    -- treba poluperioda da je 100 ns al to je isto sve...
    clk_generator: process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    stimuli: process
    begin
        mask_in <= '1';
        op <= "00"; -- AND operacija
        d_in <= "1001";
        wait for 10 ns;
        mask_in <= '0';
        d_in <= "0111"; -- ocekuje se na izlaz 0001
        wait for 20 ns;
        mask_in <= '1';
        d_in <= "1100";
        op <= "01"; -- OR operacija
        wait for 10 ns;
        mask_in <= '0';
        d_in <= "0010"; -- ocekuje se na izlaz 1110
        wait for 20 ns;
    end process;

end architecture ;