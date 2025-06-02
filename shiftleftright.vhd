library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shiftleftright is
port(
	 ctl : in std_logic_vector(1 downto 0);
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
end shiftleftright;

architecture behaviour of shiftleftright is
begin
	
	q <= "0"&d( 8 downto 1) when ctl = "01" else
		 d( 7 downto 0)&"0" when ctl = "10" else
		 d;	
end behaviour;