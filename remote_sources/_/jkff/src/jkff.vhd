	library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jkff is
    Port ( J : in std_logic;
	K : in std_logic;
	RESET : in std_logic;
           CLK : in std_logic;
           Q : inout std_logic;
           QN : inout std_logic);
end jkff;
architecture My_behavioral of jkff is
signal temp : std_logic; 
begin
            process(CLK,J,K,RESET)
            begin
				if (CLK='1' and CLK'event) then
					if RESET='1' then
						temp <= '0'	;
                        elsif(J='0' and K='0') then
                                      temp<=temp;
                        elsif(J='0' and K='1') then
                                   temp<='0';
                        elsif(J='1' and K='0') then
                                       temp<='1';
                        elsif(J='1' and K='1') then
                                       temp<= not(temp);
                        
                        end if;	 
						end if;
            end process; 
			Q <=temp;
			QN <=not(temp);
end My_behavioral;