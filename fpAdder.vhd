library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpAdder is
	port(
		CLOCK_50: in std_logic;
		--GReset: in std_logic;
		KEY   : in std_logic_vector(3 downto 0); --KEY(0)=>RST and --KEY(1)=>EN

		SignA: in std_logic;
		MantissaA: in std_logic_vector(7 downto 0);
		ExponentA: in std_logic_vector(6 downto 0);
		
		SignB: in std_logic;
		MantissaB: in std_logic_vector(7 downto 0);
		ExponentB: in std_logic_vector(6 downto 0);
		
		
		SignOut: out std_logic;
		MantissaOut: out std_logic_vector(7 downto 0);
		ExponentOut: out std_logic_vector(6 downto 0);
		Overflow: out std_logic;


		LEDR	      : out std_logic_vector(17 downto 0);
		SW         : in std_logic_vector(17 downto 0)

		);
	end fpAdder;
	
	architecture structural of fpAdder is
	
	component reg1bit 
	port(d,clk, reset: in std_logic;
	  q : out std_logic
	  );
	end component;

	component reg8bit 
	port(clk, reset: in std_logic;
	  d : in std_logic_vector(7 downto 0);
	  q : out std_logic_vector(7 downto 0)
	  );
	end component;

	component reg7bit 
	port(clk, reset: in std_logic;
	  d : in std_logic_vector(6 downto 0);
	  q : out std_logic_vector(6 downto 0)
	  );
	end component;

	component reg9bit
	port(clk, reset: in std_logic;
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
	end component;

	component 7bitAdder 
	port(a,breal : in std_logic_vector(6 downto 0); 
	  sum : out std_logic_vector(7 downto 0);
	  cout : out std_logic
	  );
	end component;

	component MUX9 
	port(
		  ctl : in std_logic;
		  in1 : in std_logic_vector(8 downto 0);
		  in2 : in std_logic_vector(8 downto 0);
		  out1 : out std_logic_vector(8 downto 0)
		  );
	end component;


	component MUX7 
	port(
	  ctl : in std_logic;
	  in1 : in std_logic_vector(6 downto 0);
	  in2 : in std_logic_vector(6 downto 0);
	  out1 : out std_logic_vector(6 downto 0)
	  );
	end component;

	component 9bitAdder 
	port(a,b : in std_logic_vector(8 downto 0);
	  cin : in std_logic;
	  sum : out std_logic_vector(8 downto 0);
	  cout : out std_logic
	  );
	end component;

	component shiftright 
	port(
	 ctl : in std_logic_vector(3 downto 0);
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
	end component;


	component incdecre 
	port(
	 ctl : in std_logic_vector(1 downto 0);
	  d : in std_logic_vector(6 downto 0);
	  q : out std_logic_vector(6 downto 0)
	  );
	end component;

	component shiftleftright 
	port(
	 ctl : in std_logic_vector(1 downto 0);
	  d : in std_logic_vector(8 downto 0);
	  q : out std_logic_vector(8 downto 0)
	  );
	end component;

	

	component FSMctrl 
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
	   -- 01 = inc riht 00 =nothing 10 = dec left. 11= nothing;
 	);
	end component;

	----- REGISTER OUTPUTS.
	signal sA,sB :std_logic;
	signal eA,eB :std_logic_vector(6 downto 0);
	signal mA,mB :std_logic_vector(7 downto 0);


	-----SMALL ALU OUTPUTS
	signal smallALUsum : std_logic_vector(7 downto 0);
	signal smallALUcarry : std_logic;

	----EXPONETIAL DIFFERENCE OUTPUT
	signal expd : std_logic_vector(7 downto 0);

	----ROW OF 3 MUX OUTPUTS
	signal bigexp : std_logic_vector(6 downto 0);
	signal bigman : std_logic_vector(8 downto 0);
	signal smallman : std_logic_vector(8 downto 0);

	---- SHIFT RIGHT OUT PUT
	signal shiftedright : std_logic_vector(8 downto 0);
 
 	----- BIGALU OUTPUT
 	signal bigALUcarryout : std_logic;
 	signal BigALUsum : std_logic_vector(8 downto 0);

 	----- MUX OUTPUTS(OUT OF  ALU AND MUX)
 	signal tobeshifted: std_logic_vector(8 downto 0);
 	signal tobeincordec: std_logic_vector(6 downto 0);


 	----- INCREMENT AND DECREMENT OUTPUT AND SHIFT LEFT OR RIGHT OUTPUT

 	signal incordec_out_put: std_logic_vector(6 downto 0); 
 	signal shifter_out_put: std_logic_vector(8 downto 0);

 	----- ROUND HARDWARE OUTPUTS  

 	signal backoutput_exp, value_exp : std_logic_vector(6 downto 0);
 	signal backoutput_sig : std_logic_vector(8 downto 0);
 	signal value_sig : std_logic_vector(7 downto 0);

 	----- FSM OUT PUT SIGNALS
 	signal is_greater, is_greaterii, doornot:  std_logic; ---changes
 	signal shift_amount:  std_logic_vector(3 downto 0); ---changes
 	signal to_be_shifted:  std_logic;  ---changes
 	signal shift_l_or_r, i_or_d:  std_logic; ---chages
 	signal inc_or_dec_and_left_or_right:  std_logic_vector(1 downto 0); --changes


 	----Mantisa and 1
 	signal MantissaA1 : std_logic_vector(8 downto 0); --changes
 	signal MantissaB1 : std_logic_vector(8 downto 0); --changes

 	
	begin
   MantissaB1 <= "1" & MantissaB; --changes
 	MantissaA1 <= "1" & MantissaA; --changes
	
	
	---- FIRST NUMBER(A)
	signAs : reg1bit port map(SignA,CLOCK_50,KEY(0),sA);
	exponentAs: reg7bit port map(CLOCK_50,KEY(0),ExponentA,eA);
	mantisaA: reg8bit port map(CLOCK_50,KEY(0),MantissaA,mA);

	---- SECOND NUMBER(B)
	signBs : reg1bit port map(SignB,CLOCK_50,KEY(0),sB);
	exponentBs: reg7bit port map(CLOCK_50,KEY(0),ExponentB,eB);
	mantisaB: reg8bit port map(CLOCK_50,KEY(0),MantissaB,mB);

	----- SMALL ALU
	small_ALU : 7bitAdder port map(eA,eB,smallALUsum,smallALUcarry);


	----- EXPONETIAL DIFFERNCE
	exponent_difference : reg8bit port map(CLOCK_50,KEY(0),smallALUsum,expd);


	------ 3 ROW MUX
	biggerexponent : MUX7 port map(is_greater,ExponentA,ExponentB,bigexp); 
	biggermantisa : MUX9 port map(is_greaterii,MantissaA1,MantissaB1,bigman); --chANGES 
	smallmantisa : MUX9 port map(to_be_shifted,MantissaA1,MantissaB1,smallman); --CHANGES 


	------- SHIFT RIGHT
	shiftrights : shiftright port map(shift_amount,smallman,shiftedright); 


	------- BIG ALU
	bigALu : 9bitAdder port map(shiftedright,bigman,'0',BigALUsum,bigALUcarryout);


	------ 2 ROW MUX
	shiftleftorrightMUX : MUX9 port map(shift_l_or_r,BigALUsum,backoutput_sig,tobeshifted); 
	ncrementordecrementMUX : MUX7 port map(i_or_d,bigexp,backoutput_exp,tobeincordec); 


	------ INCREMENTER AND DECREMENTER AND SHIFT LEFT OR RIGHT 
	ncrementordecrement: incdecre port map(inc_or_dec_and_left_or_right,tobeincordec,incordec_out_put);
	shiftleftorright : shiftleftright port map(inc_or_dec_and_left_or_right,tobeshifted,shifter_out_put);

	------- ROUNDING HARDWARE
	--roundingHWexp : round_exp port map(doornot,incordec_out_put,value_exp,backoutput_exp); 
	--roundingHWsig : round_sig port map(doornot,shifter_out_put,value_sig,backoutput_sig); 


	------- SOULTION OUTPUT
	signsol : reg1bit port map( not is_greater,CLOCK_50,KEY(0),SignOut); --change
	exponentsol: reg7bit port map(CLOCK_50,KEY(0),incordec_out_put,ExponentOut);
	mantisasol: reg8bit port map(CLOCK_50,KEY(0),shifter_out_put(8 downto 1),MantissaOut);


	------FSMCONTROLLER
	FSMcontroller : FSMctrl port map(CLOCK_50,KEY(0),BigALUsum,expd,backoutput_sig,is_greater,is_greaterii,shift_amount,to_be_shifted,shift_l_or_r,i_or_d,inc_or_dec_and_left_or_right);

	end structural;