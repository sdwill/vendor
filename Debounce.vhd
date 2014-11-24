----------------------------------------------------------------------------------
-- Company: University at Buffalo
-- Engineer: Kyle Thompson
-- 
-- Create Date:    10:01:26 11/24/2014 
-- Design Name: 
-- Module Name:    Debounce - Behavioral 
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

entity Debounce is
	port (Button, CLK : in std_logic;
		  De_Button : out std_logic);
end Debounce;

architecture Behavioral of Debounce is

component DFF is
	port (D, clk : in std_logic;
		   Q : out std_logic);
end component;

--DEBOUNCE #1
--signal Q0, Q1, Q2 : std_logic;
--begin
--
--DFF0 : DFF port map (Button, CLK, Q0);
--DFF1 : DFF port map (Q0, CLK, Q1);
--DFF2 : DFF port map (Q1, CLK, Q2);
--De_Button <= Q0 and Q1 and not Q2;

--DEBOUNCE #2 (state machine that detects three 1s in a row)
signal A,B,Anext,Bnext, X : std_logic;
begin
X <= Button;
Anext <= B and X;
Bnext <= (not A) and (not B) and X;
DFFA : DFF port map (Anext, CLK, A);
DFFB : DFF port map (Bnext, CLK, B);
De_Button <= A and X;
end Behavioral;

