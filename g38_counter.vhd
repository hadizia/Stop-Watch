library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.NUMERIC_STD.ALL ;
entity g38_counter is
Port (enable : in std_logic ;
reset : in std_logic ;
clk : in std_logic ;
count : out std_logic_vector (3 downto 0));
end g38_counter ;

architecture arch_g38_counter of g38_counter is
signal count_temp : integer range 0 to 15 :=0;
begin
process(clk,reset)
begin
if reset='0' then 
count_temp<=0;
else
if (clk'EVENT and clk='1') then
if enable='1' then
if count_temp=15 then
count_temp<=0;
else
count_temp<=count_temp + 1;
end if;
else
count_temp<=count_temp;
end if;
end if;
end if;
end process;

with count_temp select count <= 
"0000" when 0,
"0001" when 1,
"0010" when 2,
"0011" when 3,
"0100" when 4,
"0101" when 5,
"0110" when 6,
"0111" when 7,
"1000" when 8,
"1001" when 9,
"1010" when 10,
"1011" when 11,
"1100" when 12,
"1101" when 13,
"1110" when 14,
"1111" when 15,
"0000" when others;

end arch_g38_counter;
