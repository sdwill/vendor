----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:59:26 11/29/2014 
-- Design Name: 
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
			c25, c50, c100 : in STD_LOGIC; -- 3 pushbuttons for 25, 50, and 100 cents
			item           : in STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4 switches for the different items
			reset  			: in STD_LOGIC;
			clk_100MHz	   : IN STD_LOGIC);
end main;
architecture Behavioral of main is

-- Create a new datatype called state_type whose legal values are any dollar value
-- between $0.00 and $2.00 (states d0-d8), or any change value between $0.00 and
-- $1.75 (states c1-c7)

-- Inputs are 5 bits (we have 5 buttons available)
-- Outputs are 8 bits (we have 8 LEDs available)
type state_type is (d0, d1, d2, d3, d4, d5, d6, d7, d8, c0, c1, c2, c3, c4, c5, c6, c7);

-- Create an internal signal of the state_type type
signal state: state_type;

-- NOTE: The resetpin signal needs to be port mapped before this will work. It is a
-- placeholder.
-- Create a 'machine' clocked process with asynchronous reset
machine: process(clk, resetpin)

-- We have three possible money inputs, so they will be encoded as a three-bit vector on the buttons
--		$0.25 <==> 001
--		$0.50 <==> 010
--		$1.00 <==> 100
--		RESET <==> 111 (top button on pad)

-- We have five possible vending inputs (A, B, C, D, nothing), so they will be encoded as a four-bit vector on the
-- the switches
--		Nothing <==> 0000
--		A <==> 0001
--		B <==> 0010
--		C <==> 0100
--		D <==> 1000

-- All inputs are 7-bit vectors structured as xxx|xxxx where the left three bits are the money input and the right four
-- are the item selection


-- input = ..?
begin
	if rising_edge(clk) then
		-- Need to set up the 'input' signal as well
		case state is
			-- $0.00 dollar state
			when d0 =>
				-- All possible inputs and no item selected
				if input(3 downto 0) = "0000" then
					-- $0.00 -> $0.25
					if input(6 downto 4) = "001" then
						state <= d1;

					-- $0.00 -> $0.50
					elsif input(6 downto 4) = "010" then
						state <= d2;

					-- $0.00 -> $1.00
					elsif input(6 downto 4) = "100" then
						state <= d4;
					end if;

				-- If we selected some item to be purchased, then stay in the current state because we don't have any
				-- money to purchase things
				else
					state <= d0;
				end if;

			-- $0.25 dollar state
			when d1 =>
				if input(3 downto 0) = "0000" then
					-- $0.25 -> $0.50
					if input(6 downto 4) = "001" then
						state <= d1;

					-- $0.25 -> $0.75
					elsif input(6 downto 4) = "010" then
						state <= d2;

					-- $0.25 -> $1.25
					elsif input(6 downto 4) = "100" then
						state <= d4;
					end if;

				elsif input(3 downto 0) = "0001" then
				else
				end if;


			-- $0.50 dollar state
			when d2 =>

			-- $0.75 dollar state
			when d3 =>

			-- $1.00 dollar state
			when d4 =>

			-- $1.25 dollar state
			when d5 =>

			-- $1.50 dollar state
			when d6 =>

			-- $1.75 dollar state
			when d7 =>

			-- $2.00 dollar state
			when d8 =>

			-- $0.00 change state
			when c0 =>

			-- $0.25 change state
			when c1 =>

			-- $0.50 change state
			when c2 =>

			-- $0.75 change state
			when c3 =>

			-- $1.00 change state
			when c4 =>

			-- $1.25 change state
			when c5 =>

			-- $1.50 change state
			when c6 =>

			-- $1.75 change state
			when c7 =>
		end case;
	end if;
end process


end Behavioral;

