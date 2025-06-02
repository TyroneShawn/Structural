library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity 9bitAdder is
port(a,b : in std_logic_vector(8 downto 0);
	  cin : in std_logic;
	  sum : out std_logic_vector(8 downto 0);
	  cout : out std_logic
	  );
end 9bitAdder;

architecture behaviour of 9bitAdder is

	component onebitAdder 
	port(a,b,cin : in std_logic; 
	  s,cout : out std_logic
	  );
end component;
	signal g : std_logic_vector(8 downto 0);
	signal s : std_logic_vector(8 downto 0);
	
	begin
	L1 : onebitAdder port map(a(0),b(0),cin,s(0),g(0));
	L2 : onebitAdder port map(a(1),b(1),g(0),s(1),g(1));
	L3 : onebitAdder port map(a(2),b(2),g(1),s(2),g(2));
	L4 : onebitAdder port map(a(3),b(3),g(2),s(3),g(3));
	L5 : onebitAdder port map(a(4),b(4),g(3),s(4),g(4));
	L6 : onebitAdder port map(a(5),b(5),g(4),s(5),g(5));
	L7 : onebitAdder port map(a(6),b(6),g(5),s(6),g(6));
	L8 : onebitAdder port map(a(7),b(7),g(6),s(7),g(7));
	L9 : onebitAdder port map(a(8),b(8),g(7),s(8),g(8));
	cout <= g(8);
	sum <= s;
	end behaviour;