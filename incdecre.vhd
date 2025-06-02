library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity incdecre is
port(
	 ctl : in std_logic_vector(1 downto 0);
	  d : in std_logic_vector(6 downto 0);
	  q : out std_logic_vector(6 downto 0)
	  );
end incdecre;

architecture behaviour of incdecre is

	signal temp1 : unsigned(6 downto 0);
	signal temp2 : unsigned(6 downto 0);
begin
	temp1 <= UNSIGNED(d) + '1';
	temp2 <= UNSIGNED(d) - '1';

	q <= std_logic_vector(temp1) when ctl = "01" else --changes
		 std_logic_vector(temp2) when ctl = "10" else --changes
		 d;	
end behaviour;