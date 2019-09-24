library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ALL;

--declariation
entity g38_stopwatch is
	
	Port (start : in std_logic;
			stop : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			HEX4 : out std_logic_vector(6 downto 0);
			HEX5 : out std_logic_vector(6 downto 0)
			);
end g38_stopwatch;

architecture a0 of g38_stopwatch is


	component g38_counter is
		Port (enable : in std_logic;
				reset : in std_logic;
				clk : in std_logic;
				count : out std_logic_vector(3 downto 0));
	end component g38_counter;
	
	component g38_clock_divider is
		Port(enable : in std_logic;
				reset : in std_logic;
				clk : in std_logic;
				en_out : out std_logic);
	end component g38_clock_divider;	
	
	
	
	component g38_hex_decoder is
		Port( count: in std_logic_vector(3 downto 0);
				hex: out std_logic_vector(6 downto 0));
	end component g38_hex_decoder;
	
	--signal for value of enable
	signal enable_stopwatch : std_logic := '0';
	
	--signal for clock divider
	signal en_out_clock_divider : std_logic := '0';
	
	--signal to store count value for each digit of HEX0 to HEX5
	signal tmp_count0 : std_logic_vector(3 downto 0) := "0000";
	signal tmp_count1 : std_logic_vector(3 downto 0) := "0000";
	signal tmp_count2 : std_logic_vector(3 downto 0) := "0000";
	signal tmp_count3 : std_logic_vector(3 downto 0) := "0000";
	signal tmp_count4 : std_logic_vector(3 downto 0) := "0000";
	signal tmp_count5 : std_logic_vector(3 downto 0) := "0000";
	
	
	
	--we need new reset signals for each counter
	signal reset_tmp0 : std_logic := '1';
	signal reset_tmp1 : std_logic := '1';
	signal reset_tmp2 : std_logic := '1';
	signal reset_tmp3 : std_logic := '1';
	signal reset_tmp4 : std_logic := '1';
	signal reset_tmp5 : std_logic := '1';
	
	--signals for each counter except counter0
	signal enable_tmp1 : std_logic := '0';
	signal enable_tmp2 : std_logic := '0';
	signal enable_tmp3 : std_logic := '0';
	signal enable_tmp4 : std_logic := '0';
	signal enable_tmp5 : std_logic := '0';
	
begin

	
	counter0 : g38_counter PORT MAP(enable => enable_stopwatch, reset => reset_tmp0,
												clk => en_out_clock_divider, count => tmp_count0);
					
	counter1 : g38_counter PORT MAP(enable => enable_tmp1, reset => reset_tmp1,
												clk => en_out_clock_divider, count => tmp_count1);
											
	counter2 : g38_counter PORT MAP(enable => enable_tmp2, reset => reset_tmp2,
												clk => en_out_clock_divider, count => tmp_count2);
											
	counter3 : g38_counter PORT MAP(enable => enable_tmp3, reset => reset_tmp3,
												clk => en_out_clock_divider, count => tmp_count3);
											
	counter4 : g38_counter PORT MAP(enable => enable_tmp4, reset => reset_tmp4,
												clk => en_out_clock_divider, count => tmp_count4);
											
	counter5 : g38_counter PORT MAP(enable => enable_tmp5, reset => reset_tmp5,
												clk => en_out_clock_divider, count => tmp_count5);
												
												
	
	clock_divider : g38_clock_divider PORT MAP(enable => enable_stopwatch,
															reset => reset, clk => clk, en_out => en_out_clock_divider);
	
	

	
	Process(clk, start, stop, reset) begin
				
		
		if(start = '0') then --we look at the start input in priority (asynchronous)
			enable_stopwatch <= '1'; 
			
		
		elsif(stop = '0') then
			enable_stopwatch <= '0'; 
		
		
		elsif(reset = '0') then --if reset is 0, the temporary resets are also set to 0
			reset_tmp0 <= '0'; 
			reset_tmp1 <= '0';
			reset_tmp2 <= '0';
			reset_tmp3 <= '0';
			reset_tmp4 <= '0';
			reset_tmp5 <= '0';
		
		--look if the clock signal is in rising edge
		elsif(rising_edge(clk)) then
		
			
			-- if any of the digits 0,1,2,and 4 is 9 then they need  to be reset to 0. if digits 3 and 5 are 5, also reset to 0
		
			if (tmp_count0 = "1001") then
				enable_tmp1 <= '1';
			elsif (tmp_count0 = "1010") then	--when digits 0 reaches 10 reset it
				reset_tmp0 <= '0';
				enable_tmp1 <= '0';
			
			else --else keep these values for reset and enable
			  reset_tmp0  <= '1';
			  enable_tmp1 <= '0';
			end if;
			
			
			if (tmp_count0 = "1001") and (tmp_count1 = "1001") then--same procedure here
				enable_tmp2 <= '1';
			elsif (tmp_count1 = "1010") then
				reset_tmp1 <= '0'; 
				enable_tmp2 <= '0';
			else
				reset_tmp1 <= '1';
				enable_tmp2 <= '0';
			end if;
			
			
			if (tmp_count0 = "1001") and (tmp_count1 = "1001") and (tmp_count2 = "1001") then -- same for digit 2
				enable_tmp3 <= '1';
			elsif (tmp_count2 = "1010") then
				reset_tmp2 <= '0'; 
				enable_tmp3 <= '0';
			else
			  reset_tmp2 <= '1';
			  enable_tmp3 <= '0';
			end if;
			
		
			if (tmp_count0 = "1001") and (tmp_count1 = "1001") and (tmp_count2 = "1001") and (tmp_count3 = "0101") then --same procedure for digit3
				enable_tmp4 <= '1';
			elsif (tmp_count3 = "0110") then
				reset_tmp3 <= '0'; 
				enable_tmp4 <= '0';
			else
				reset_tmp3 <= '1';
				enable_tmp4 <= '0';
			end if;
			

			if (tmp_count0 = "1001") and (tmp_count1 = "1001") and (tmp_count2 = "1001") and (tmp_count3 = "0101") and (tmp_count4 = "1001") then
				enable_tmp5 <= '1';
			elsif (tmp_count4 = "1010") then
				reset_tmp4 <= '0'; 
				enable_tmp5 <= '0';
			else
				reset_tmp4 <= '1';
				enable_tmp5 <= '0';
			end if;
			
		
			if tmp_count5 = "0110" then --last digit
			  reset_tmp5 <= '0'; --reset5 is set to 0
			else
			  reset_tmp5 <= '1';
			end if;
		end if;
		
	end Process;
	
	
	--decoders for all 6 counters
	decoder0: g38_hex_decoder PORT MAP(count => tmp_count0, hex => HEX0);
	decoder1: g38_hex_decoder PORT MAP(count => tmp_count1, hex => HEX1);
	decoder2: g38_hex_decoder PORT MAP(count => tmp_count2, hex => HEX2);
	decoder3: g38_hex_decoder PORT MAP(count => tmp_count3, hex => HEX3);
	decoder4: g38_hex_decoder PORT MAP(count => tmp_count4, hex => HEX4);
	decoder5: g38_hex_decoder PORT MAP(count => tmp_count5, hex => HEX5);
							
end a0;