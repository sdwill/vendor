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
<<<<<<< HEAD
			LED : in STD_LOGIC_VECTOR(7 DOWNTO 0);
			c25, c50, c100 : in STD_LOGIC; -- 3 pushbuttons for 25, 50, and 100 cents
=======
			LEDS : in STD_LOGIC_VECTOR(7 DOWNTO 0);
			c25, c50, c100 : in STD_LOGIC; -- 3 pushbuttons for 25, 50, and 100 dollars
>>>>>>> origin/master
end main;

-- some bullshit

architecture Behavioral of main is

-- Create a new datatype called state_type whose legal values are any dollar value
-- between $0.00 and $2.00 (states d0-d8), or any change value between $0.00 and
-- $1.75 (states c1-c7)
type state_type is (d0, d1, d2, d3, d4, d5, d6, d7, d8, c0, c1, c2, c3, c4, c5, c6, c7);

-- Create an internal signal of the state_type type
signal state: state_type;

-- NOTE: The resetpin signal needs to be port mapped before this will work. It is a
-- placeholder.
-- Create a 'machine' clocked process with asynchronous reset
machine: process(clk, resetpin)

-- Dollar amounts encoded as three-bit vector (because we will presumably use three buttons
-- on the board?):
--	 	$0.25 <==> 001
-- 	$0.50 <==> 010
-- 	$1.00 <==> 100

-- The item selection will be encoded as a three-bit vector (because there are four
-- possible items to purchase plus the "no purchase" option)
-- 	A ($0.25) <==> 000
--		B ($0.50) <==> 001
--		C ($0.75) <==> 010
--		D ($1.00) <==> 011
--		None <==> 100
begin
	if rising_edge(clk) then
		-- Need to set up the 'input' signal as well
		case state is
			when d1 =>
				if input = "001100" then
					state <= d1;
				elsif input = "010100" then
					state <= d2;
				elsif input = "100100" then
					state <= d4;
				end if;
			
		end case;
	end if;
end process


end Behavioral;

