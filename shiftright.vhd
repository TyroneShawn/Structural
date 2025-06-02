library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shiftright is
port(
	 ctl : in std_logic_vector(3 downto 0);
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
end shiftright;

architecture behaviour of shiftright is
begin
	with ctl select
	q <=  d( 8 downto 0) when "0000",
		 "0"&d( 8 downto 1) when "0001",
		 "00"&d( 8 downto 2) when "0010",
		 "000"&d( 8 downto 3) when "0011",
		 "0000"&d( 8 downto 4) when "0100",
		 "00000"&d( 8 downto 5) when "0101",
		 "000000"&d( 8 downto 6) when "0110",
		 "0000000"&d( 8 downto 7) when "0111",
		 "00000000"&d(8) when "1000",
		 "000000000" when others;
			  	
end behaviour;
	