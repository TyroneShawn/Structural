library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX8 is
port(
	  ctl : in std_logic;
	  in1 : in std_logic_vector(7 downto 0);
	  in2 : in std_logic_vector(7 downto 0);
	  out1 : out std_logic_vector(7 downto 0)
	  );
end MUX8;

architecture MUXbehav of MUX8 is
	begin
	out1 <= in1 when ctl = '0' else
			  in2;
	
	end MUXbehav;