library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg7bit is
port(clk, reset: in std_logic;
	  d : in std_logic_vector(6 downto 0);
	  q : out std_logic_vector(6 downto 0)
	  );
end reg7bit;

architecture behaviour of reg7bit is
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
	