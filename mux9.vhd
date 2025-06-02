library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX9 is
port(
	  ctl : in std_logic;
	  in1 : in std_logic_vector(8 downto 0);
	  in2 : in std_logic_vector(8 downto 0);
	  out1 : out std_logic_vector(8 downto 0)
	  );
end MUX9;

architecture MUXbehav of MUX9 is
	begin
	out1 <= in1 when ctl = '0' else
			  in2;
	
	end MUXbehav;