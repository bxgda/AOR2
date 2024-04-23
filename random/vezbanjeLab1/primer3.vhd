
-- rs flip flop sa asinhronim resetom i okidanjem na opadajucu ivicu takta preko procesa 


entity rs is
    port(
        r, s, rst, clk : in bit;
        q : out bit
    );
end entity rs;

architecture ars of rs is
begin
    process (clk, rst) 
    begin 
        if rst = '1' then q <= '0';
        elsif clk'event and clk = '0' then 
            if r = '0' and s = '1' then q <= '1';
            elsif r = '1' and s = '0' then q <= '0';
            elsif r = '1' and s = '1' then q <= '0';
            end if;
        end if;
    end process;
end architecture ars;

--------------------------------------------------------------

entity rstb is
end entity rstb;
    
architecture arstb of rstb is
    signal r, s, rst, clk, q : bit;
begin
    dut : entity work.rs(ars) port map(
        r, s, rst, clk, q
    );
    
    process 
    begin  
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin  
        rst <= '0';
        r <= '0';
        s <= '1';
        wait for 7 ns;
        r <= '1';
        s <= '0';
        wait for 7 ns;
        r <= '0';
        s <= '0';
        wait for 7 ns;
        s <= '1';
        wait for 14 ns;
        rst <= '1';
        wait for 2 ns;
    end process;
        
end architecture arstb;      