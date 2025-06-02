library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity round_exp is
port(
	  ctl : in std_logic;
	  in1 : in std_logic_vector(6 downto 0);
	  values : out std_logic_vector(6 downto 0);
	  back : out std_logic_vector(6 downto 0)
	  );
end round_exp;

architecture MUXbehav of round_exp is
	begin
	values <= in1 when ctl = '0' else
			  "0000000";

	back <= in1 when ctl = '0' else
			  "0000000";
	
	end MUXbehav;