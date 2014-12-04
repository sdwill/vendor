-- fourbit_counter.vhd
-- This is a simple 4-bit (Ripple) binary counter made up
-- of four T flip-flops. It also includes a clock divider
-- to bring down the input CK signal from 100 MHz to about 1 Hz.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fourbit_counter is
    Port ( CK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
			  clockbutton : in STD_LOGIC;
			  direction : in STD_LOGIC;
			  RESET : in STD_LOGIC);
end fourbit_counter;

architecture Structural of fourbit_counter is

component jkff is
    Port ( J : in std_logic;
			  K : in std_logic;
			  RESET : in std_logic;
           CLK : in std_logic;
           Q : inout std_logic;
           QN : inout std_logic);
end component;

component ck_divider is
    Port ( CK_IN : in  STD_LOGIC;
           CK_OUT : out  STD_LOGIC);
end component;

component DFF is
	port (D, clk : in std_logic;
		   Q : out std_logic);
end component;


component Debounce IS
  PORT(
    Button     : IN  STD_LOGIC;  --input clock
    clk : IN  STD_LOGIC;  --input signal to be debounced
    De_Button  : OUT STD_LOGIC); --debounced signal
END component;

signal all_T, S0, S1, S2, S3, q0, q1, q2, q3, r1, r2, r3, result: STD_LOGIC;
begin


changedirection: process (direction)
begin
if (direction = '1') then
	r1 <= Q0;
	r2 <= Q1 and Q0;
	r3 <= Q2 and Q1 and Q0;
elsif (direction ='0') then
	r1 <= not Q0;
	r2 <= not Q1 and not Q0;
	r3 <= not Q2 and not Q1 and not Q0;
end if;
end process changedirection;

	  --jkff port map (J, K, RESET, CLK, Q, QN);
DB: debounce port map (clockbutton, CK, result);
JKFF0: jkff port map ('1', '1',RESET, result,Q0,S0);
JKFF1: jkff port map (r1, r1,RESET, result,Q1,S1);
JKFF2: jkff port map (r2, r2,RESET, result,Q2,S2);
JKFF3: jkff port map (r3,r3,RESET, result,Q3,S3);

Q(0) <= Q0;
Q(1) <= Q1;
Q(2) <= Q2;
Q(3) <= Q3;

end Structural;

