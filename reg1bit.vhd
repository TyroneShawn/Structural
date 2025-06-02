library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg1bit is
port(d,clk, reset: in std_logic;
	  q : out std_logic
	  );
end reg1bit;

architecture behaviour of reg1bit is
begin
	process(clk,reset)
		begin
		if (reset ='1') then
			q <= '0';
		elsif(clk'event and clk='1') then 
			q <=d;
		end if;
	end process;	
end behaviour;
	