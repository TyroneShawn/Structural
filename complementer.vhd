library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp is
port(clk, onn, reset: in std_logic;
	  d : in std_logic_vector(6 downto 0);
	  q : out std_logic_vector(6 downto 0)
	  );
end comp;

architecture behaviour of comp is
begin
	process(clk,reset)
		begin
		if (reset ='1') then
			q <=  (others => '0');
		
		elsif(clk'event and clk='1') then 
			q <= not d;
		end if;
	end process;	
end behaviour;
	