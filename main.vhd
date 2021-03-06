----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 	    Scott Will (50003395)
--					Kyle Thompson (36870784)
-- 
-- Create Date:    21:59:26 11/29/2014 
-- Design Name: 	 EE478 Vending Machine
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
	Port (
			LED            : out STD_LOGIC_VECTOR(7 DOWNTO 0);
			button 			: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- 3 pushbuttons for 25, 50, and 100 cents
			item           : in STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4 switches for the different items
			clk_100MHz	   : IN STD_LOGIC
			);
end main;

architecture Behavioral of main is

-- Create a new datatype called state_type whose legal values are any dollar value
-- between $0.00 and $1.00 (states d0-d4) and overflow return value (r4)

-- Inputs are 8 bits
-- Outputs are 8 bits
type state_type is (d0, d1, d2, d3, d4, r4);

-- Create an internal signal of the state_type type
signal state: state_type;

-- Create an internal signal to hold the signal from the money
signal money: STD_LOGIC_VECTOR(3 downto 0);

-- Signal for 1Hz clock
signal clk_1Hz : STD_LOGIC;

component ck_divider is
    Port ( CK_IN : in  STD_LOGIC;
           CK_OUT : out  STD_LOGIC);
end component;

begin

-- Divides the clock to 1Hz
divide : ck_divider port map (clk_100MHz, clk_1Hz);
machine: process

-- We have three possible money inputs, so they will be encoded as a four-bit vector on the buttons
--		$0.25 <==> 0001
--		$0.50 <==> 0010
--		$1.00 <==> 0100
--		RESET <==> 1000 (top button on pad)

-- We have five possible vending inputs (A, B, C, D, nothing), so they will be encoded as a four-bit vector on the
-- the switches
--		� <==> 0000
--		A <==> 0001
--		B <==> 0010
--		C <==> 0100
--		D <==> 1000

-- All inputs are 8-bit vectors structured as xxxx|xxxx where the left four bits are the money input and the right four
-- are the item selection

begin
	if rising_edge(clk_1Hz) then
		case state is
			-- $0.00 dollar state
			when d0 =>
				LED <= "00000000";
				-- All possible inputs and no item selected
				if item = "0000" then
					-- $0.00 -> $0.25
					if button = "0001" then
						state <= d1;
						LED <= "00000001";

					-- $0.00 -> $0.50
					elsif button = "0010" then
						state <= d2;
						LED <= "00000010";
						
					-- $0.00 -> $1.00
					elsif button = "0100" then
						state <= d4;
						LED <= "00000100";
					end if;

				-- If we selected some item to be purchased, then stay in the current state because we don't have any
				-- money to purchase things.  For THIS STATE ONLY, the reset case (input = 1000-0000) is included, since
				-- there's no change to refund when the reset signal comes in
				else
					state <= d0;
					LED <= "00000000";
				end if;

			-- $0.25 dollar state
			when d1 =>
				-- No purchase
				if item = "0000" then
					-- $0.25 -> $0.50
					if button = "0001" then
						state <= d2;
						LED <= "00000010";

					-- $0.25 -> $0.75
					elsif button = "0010" then
						state <= d3;
						LED <= "00000011";

					-- $0.25 -> $1.25
					elsif button = "0100" then
						state <= r4;
						LED <= "00000001";
					
					-- RESET
					elsif button = "1000" then
						state <= d0;
						LED <= "00000001";
					end if;

				-- $0.25 purchase
				elsif item = "0001" then
					state <= d0;
					LED <= "00010000";
					
				-- No input, or purchase of something that is too expensive
				else
					state <= d1;
					LED <= "00000001";
				end if;


			-- $0.50 dollar state
			when d2 =>
				-- No purchase
				if item = "0000" then
					-- $0.50 -> $0.75
					if button = "0001" then
						state <= d3;
						LED <= "00000011";

					-- $0.50 -> $1.00
					elsif button = "0010" then
						state <= d4;
						LED <= "00000100";

					-- $.50 -> $1.50
					elsif button = "0100" then
						state <= r4;
						LED <= "00000010";

					-- RESET
					elsif button = "1000" then
						state <= d0;
						LED <= "00000010";
					end if;

				-- $0.25 purchase
				elsif item = "0001" then
					state <= d0;
					LED <= "00010001";
					
				-- $0.50 purchase
				elsif item = "0010" then
					state <= d0;
					LED <= "00100000";
				-- No input, or purchase of something that is too expensive
				else
					state <= d2;
					LED <= "00000010";
				end if;

			-- $0.75 dollar state
			when d3 =>
				-- No purchase
				if item = "0000" then
					-- $0.75 -> $1.00
					if button = "0001" then
						state <= d4;
						LED <= "00000100";

					-- $0.75 -> $1.25
					elsif button = "0010" then
						state <= r4;
						LED <= "00000001";

					-- $0.75 -> $1.75
					elsif button = "0100" then
						state <= r4;
						LED <= "00000011";
					
					-- RESET
					elsif button = "1000" then
						state <= d0;
						LED <= "00000011";
					end if;

				-- $0.25 purchase
				elsif item = "0001" then
					state <= d0;
					LED <= "00010010";
				
				-- $0.50 purchase
				elsif item = "0010" then
					state <= d0;
					LED <= "00100001";
					
				-- $0.75 purchase	
				elsif item = "0100" then
					state <= d0;
					LED <= "01000000";
				
				-- No input, or purchase of something that is too expensive
				else
					state <= d3;
					LED <= "00000011";
					end if;
				
			-- $1.00 dollar state
			when d4 =>
				-- No purchase
				if item = "0000" then
					-- $1.00 -> $1.25
					if button = "0001" then
						state <= r4;
						LED <= "00000001";

					-- $1.00 -> $1.50
					elsif button = "0010" then
						state <= r4;
						LED <= "00000010";

					-- $1.00 -> $2.00
					elsif button = "0100" then
						state <= r4;
						LED <= "00000100";
					
					-- RESET
					elsif button = "1000" then
						state <= d0;
						LED <= "00000000";
					end if;

				-- $0.25 purchase
				elsif item = "0001" then
					state <= d0;
					LED <= "00010011";
				
				-- $0.50 purchase
				elsif item = "0010" then
					state <= d0;
					LED <= "00100010";					
				-- $0.75 purchase	
				elsif item = "0100" then
					state <= d0;
					LED <= "01000001";
				-- $1.00 purchase	
				elsif item = "1000" then
					state <= d0;
					LED <= "10000000";
				-- No input
				else
					state <= d4;
				end if;
			
			-- Excess return state
			when r4 =>
				state <= d4;
				LED <= "00000100";
				
		end case;
	end if;
end process;


end Behavioral;

