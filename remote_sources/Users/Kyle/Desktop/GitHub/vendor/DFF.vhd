----------------------------------------------------------------------------------
-- Company: University at Buffalo
-- Engineer: Kyle Thompson
-- 
-- Create Date:    10:07:43 11/24/2014
-- Design Name: 
-- Module Name:    DFF - Behavioral
-- Project Name:   Vendor
-- Target Devices: Spartan6
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

entity DFF is
	port (D, clk : in std_logic;
		   Q : out std_logic);
end DFF;

architecture Behavioral of DFF is

begin
	process
	begin
		wait until clk'event and clk='1';
		Q <= D;
	end process;

end Behavioral;

