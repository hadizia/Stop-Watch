library IEEE;
use IEEE.std_logic_1164.all;

entity tb_g38_clock_divider is
end tb_g38_clock_divider;

architecture arch_tb_g38_clock_divider of tb_g38_clock_divider is

-- component declaration for the unit under test (uut)
component g38_clock_divider 
	Port (enable : in std_logic ;
	reset :  in std_logic ;
	clk :  in std_logic ;
	en_out : out std_logic );
end component;

--declare inputs and initialize them to zero.
signal enable_tb,reset_tb,clk_tb : std_logic :='0';

--declare outputs
signal en_out_tb : std_logic;

-- define the period of clock here.
-- It's recommended to use CAPITAL letters to define constants.
constant CLK_PERIOD : time := 20 ns;

begin 
-- instantiate the unit under test (uut)
uut :g38_clock_divider Port map(enable => enable_tb, reset => reset_tb, clk => clk_tb, en_out => en_out_tb);

process
begin
wait for CLK_PERIOD/2;--wait for half clock cycle
clk_tb <= not clk_tb;
end process;

process
begin
enable_tb<='1';
reset_tb<='1';
wait for CLK_PERIOD;--wait for clock cycle

end process;
end arch_tb_g38_clock_divider;




