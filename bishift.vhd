library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bishift is
port( clk : in std_logic;
		d : in std_logic_vector(7 downto 0); 
		LEFT_RIGHT : in std_logic;
      res : out std_logic_vector(7 downto 0)); 
end bishift; 
architecture archi of biShift is 
  signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin 
        if (clk'event and clk='1') then 
          if (LEFT_RIGHT='0') then 
            tmp <= d(6 downto 0) & "0"; 
          else 
            tmp <= "0" & d(7 downto 1); 
          end if; 
        end if; 
    end process; 
    res <= tmp; 
end archi;
	