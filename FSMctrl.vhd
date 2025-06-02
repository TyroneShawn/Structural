library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FSMctrl is
port(
	  clk,rst : in std_logic;
	  --in 
	  sum : in std_logic_vector(8 downto 0);
	  
	  diff : in std_logic_vector(7 downto 0);
	  round : in std_logic_vector(8 downto 0);
	  
	  --out
	  is_greater, is_greaterii: out std_logic; --for all 1st level multiplexers

	  shift_amount: out std_logic_vector(3 downto 0);

	  to_be_shifted: out std_logic;

	  shift_l_or_r, i_or_d: out std_logic;

	  inc_or_dec_and_left_or_right: out std_logic_vector(1 downto 0)
	   -- 01 = inc riht 00 =nothing 10 = dec left. 11= nothing
 );
end FSMctrl;

architecture behaviour of FSMctrl is
	type states is(S0, S1, S2,S3,S4);
	signal CS,NS: states;
	signal diffvalue : std_logic_vector(6 downto 0); 
	begin
	diffvalue <= diff(6 downto 0);
		process(clk,rst)
		begin
			if rst='0' then
				CS <= S0;
			elsif (clk'event and clk='1') then
				CS <= NS;
				end if;
		end process;
		
			process(CS,NS,sum,diff,round)

begin
			-- default values for the output.
				case CS is
					when S0 => 
						NS <=S1;
						to_be_shifted <= not diff(7);
						is_greater <= diff(7);
						is_greaterii <= diff(7);
						shift_amount <="0000";
						shift_l_or_r <='0';
						i_or_d <= '0';
						inc_or_dec_and_left_or_right <= "00";
						
					when S1 => 
						NS <=S2;
						if(diffvalue < "0001000") then
							shift_amount <= '0' & diffvalue(2 downto 0);
							to_be_shifted <= not diff(7);
							is_greater <= diff(7);
							is_greaterii <= diff(7);
							shift_l_or_r <='0';
							i_or_d <= '0';
							inc_or_dec_and_left_or_right <= "00";
						else
							shift_amount <= "1000";
							to_be_shifted <= not diff(7);
							is_greater <= diff(7);
							is_greaterii <= diff(7);
							shift_l_or_r <='0';
							i_or_d <= '0';
							inc_or_dec_and_left_or_right <= "00";
						end if;

					when S2 =>
						NS <= S3;
						shift_l_or_r <='0';
						i_or_d <= '0';
						to_be_shifted <= not diff(7);
						is_greater <= diff(7);
						is_greaterii <= diff(7);
						inc_or_dec_and_left_or_right <= "00";
						shift_amount <="0000";

					when S3 =>
						
						if (sum(8) = '1') then
							inc_or_dec_and_left_or_right <= "10"; -- right
							shift_l_or_r <='0';
							i_or_d <= '0';
							to_be_shifted <= not diff(7);
							is_greater <= diff(7);
							is_greaterii <= diff(7);
							shift_amount <="0000";
							NS <= S0;
						else 
							if(sum(7) = '1') then
								inc_or_dec_and_left_or_right <= "10";
								shift_l_or_r <='0';
								i_or_d <= '0';
								to_be_shifted <= not diff(7);
								is_greater <= diff(7);
								is_greaterii <= diff(7);
								shift_amount <="0000";
								NS <= S4;
							else
								inc_or_dec_and_left_or_right <= "10";
								shift_l_or_r <='0';
								i_or_d <= '0';
								to_be_shifted <= not diff(7);
								is_greater <= diff(7);
								is_greaterii <= diff(7);
								shift_amount <="0000";
								NS <= S4;
							end if;
						end if;

						



					when S4 => 
						
							if(round(8) = '1') then
								inc_or_dec_and_left_or_right <= "10";
								shift_l_or_r <='1';
								i_or_d <= '1';
								to_be_shifted <= not diff(7);
								is_greater <= diff(7);
								is_greaterii <= diff(7);
								shift_amount <="0000";
								NS <= S0;
							else
								inc_or_dec_and_left_or_right <= "10";
								shift_l_or_r <='1';
								i_or_d <= '1';
								to_be_shifted <= not diff(7);
								is_greater <= diff(7);
								is_greaterii <= diff(7);
								shift_amount <="0000";
								NS <= S3;
							
						end if;
				end case;
		end process;
end behaviour;