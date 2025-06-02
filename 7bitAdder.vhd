library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity 7bitAdder is
port(a,breal : in std_logic_vector(6 downto 0); 
	  
	  sum : out std_logic_vector(7 downto 0);
	  cout : out std_logic
	  );
end 7bitAdder;

architecture beheigntadder of 7bitAdder is

component onebitAdder 
	port(a,b,cin : in std_logic; 
	  s,cout : out std_logic
	  );
end component;
	signal g : std_logic_vector(6 downto 0);
	signal s, s2 : std_logic_vector(6 downto 0);
	
	signal b : std_logic_vector(6 downto 0);
	
	begin
	b <= not breal;
	L1 : onebitAdder port map(a(0),b(0),'1',s(0),g(0));
	L2 : onebitAdder port map(a(1),b(1),g(0),s(1),g(1));
	L3 : onebitAdder port map(a(2),b(2),g(1),s(2),g(2));
	L4 : onebitAdder port map(a(3),b(3),g(2),s(3),g(3));
	L5 : onebitAdder port map(a(4),b(4),g(3),s(4),g(4));
	L6 : onebitAdder port map(a(5),b(5),g(4),s(5),g(5));
	L7 : onebitAdder port map(a(6),b(6),g(5),s(6),g(6));
	cout <= g(6);
	
	s2 <= not s + 1 when g(6) = '1' else
		  s;
	
	sum <= g(6) & s2;
	end beheigntadder;