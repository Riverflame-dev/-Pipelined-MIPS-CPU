
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY mipsCPUtest IS
END mipsCPUtest;

ARCHITECTURE behavior OF mipsCPUtest IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT mipsCPU
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic  
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL RST :  std_logic := '0';
        constant CLOCK_PERIOD:time:=100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: mipsCPU PORT MAP(
		CLK => CLK,
		RST => RST
	);

       CLK_PRO: PROCESS
	begin
		CLK<='0';
		wait for CLOCK_PERIOD/2;
		CLK<='1';
		wait for CLOCK_PERIOD/2;
	end process;
   
	tb : PROCESS
	BEGIN
        RST<='1'; wait for CLOCK_PERIOD;
	RST<='0'; wait for 50*CLOCK_PERIOD;
	wait; -- will wait forever
	END PROCESS;

END;
