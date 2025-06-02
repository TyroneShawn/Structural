library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg9bit is
port(clk, reset: in std_logic;
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
end reg9bit;

architecture behaviour of reg9bit is
begin
	process(clk,reset)
		begin
		if (reset ='1') then
			q <=  (others => '0');
		elsif(clk'event and clk='1') then 
			q <=d;
		end if;
	end process;	
end behaviour;