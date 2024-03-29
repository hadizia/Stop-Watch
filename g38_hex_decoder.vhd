library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;





--entity decleration
entity g38_hex_decoder is
Port (count : in std_logic_vector (3 downto 0);
hex : out std_logic_vector (6 downto 0));
					 
	end g38_hex_decoder;

--Architecture decleration 					 
architecture a0 of g38_hex_decoder is 

begin
process(count)
begin

case count is

			when "0000" => hex <= "1000000"; -- "0"
			when "0001" => hex <= "1111001"; -- "1"
			when "0010" => hex <= "0100100"; -- "2"
			when "0011" => hex <= "0110000"; -- "3"
			when "0100" => hex <= "0011001"; -- "4"
			when "0101" => hex <= "0010010"; -- "5"
			when "0110" => hex <= "0000010"; -- "6"
			when "0111" => hex <= "1111000"; -- "7"
			when "1000" => hex <= "0000000"; -- "8"
			when "1001" => hex <= "0010000"; -- "9"
			when "1010" => hex <= "0001000"; -- "A"
			when "1011" => hex <= "0000011"; -- "B"
			when "1100" => hex <= "1000110"; -- "C"
			when "1101" => hex <= "0100001"; -- "D"
			when "1110" => hex <= "0000110"; -- "E"
			when "1111" => hex <= "0001110"; -- "F"
			
			
			when others => hex <= "1111111"; --rest cases
			end case;
			end process;
end a0;