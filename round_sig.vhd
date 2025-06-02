library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity round_sig is
port(
	  ctl : in std_logic;
	  in1 : in std_logic_vector(8 downto 0);
	  values : out std_logic_vector(7 downto 0);
	  back : out std_logic_vector(8 downto 0)
	  );
end round_sig;

architecture MUXbehav of round_sig is
	begin
	values <= in1(8 downto 1) when ctl = '0' else
			  "00000000";

	back <= in1 when ctl = '0' else
			  "000000000";
	
	end MUXbehav;