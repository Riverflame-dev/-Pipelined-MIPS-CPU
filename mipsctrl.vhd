
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mipsctrl is
    Port ( INSTR : in  STD_LOGIC_VECTOR (5 downto 0); -- Operation code
	   FUNCT : in  STD_LOGIC_VECTOR (5 downto 0); -- Function code
           RegDst : out  STD_LOGIC;
           BranchBEQ : out  STD_LOGIC;
	   BranchBNE : out STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR (1 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           Jump: out std_logic);
end mipsctrl;

architecture Behavioral of mipsctrl is
begin

	process (INSTR, FUNCT)
	begin

		case INSTR is		--R type
			when "000000" 	=> 	if(FUNCT = "000000") then
									RegDst 		<= '0';
									BranchBEQ	<= '0'; 
									BranchBNE	<= '0'; 
									MemRead		<= '0';
									MemtoReg	<= '0';
									ALUOp		<= "00";
									MemWrite	<= '0';
									ALUSrc		<= '0';
									RegWrite	<= '0';
									Jump		<= '0';
								else
									RegDst 		<= '1';
									BranchBEQ	<= '0'; 
									BranchBNE	<= '0'; 
									MemRead		<= '0';
									MemtoReg	<= '0';
									ALUOp		<= "10";
									MemWrite	<= '0';
									ALUSrc		<= '0';
									RegWrite	<= '1';
									Jump		<= '0';
								end if;
			--lw	
			when "100011" 	=> 	RegDst 		<= '0';
								BranchBEQ	<= '0';
								BranchBNE	<= '0';
								MemRead		<= '1';
								MemtoReg	<= '1';
								ALUOp		<= "00";
								MemWrite	<= '0';
								ALUSrc		<= '1';
								RegWrite	<= '1';
								Jump		<= '0';
			
			--sw	
			when "101011" 	=> RegDst 		<= '-';
								BranchBEQ	<= '0';
								BranchBNE	<= '0';
								MemRead		<= '0';
								MemtoReg	<= '0';
								ALUOp		<= "00";
								MemWrite	<= '1';
								ALUSrc		<= '0';
								RegWrite	<= '0';
								Jump		<= '0';
			
			--beq
			when "000100" 	=> 	RegDst 		<= '-';
								BranchBEQ	<= '1';
								BranchBNE	<= '0';
								MemRead		<= '0';
								MemtoReg	<= '-';
								ALUOp		<= "01";
								MemWrite	<= '0';
								ALUSrc		<= '0';
								RegWrite	<= '0';
								Jump		<= '0';
							
			--bne
			when "000101" 	=> 	RegDst 		<= '-';
								BranchBEQ	<= '0';
								BranchBNE	<= '1';
								MemRead		<= '0';
								MemtoReg	<= '-';
								ALUOp		<= "01";
								MemWrite	<= '0';
								ALUSrc		<= '0';
								RegWrite	<= '0';
								Jump		<= '0';
			
			--jump
			when "000010" 	=> RegDst 		<= '-';
								BranchBEQ	<= '0';
								BranchBNE	<= '0';
								MemRead		<= '0';
								MemtoReg	<= '-';
								ALUOp		<= "00";
								MemWrite	<= '0';
								ALUSrc		<= '0';
								RegWrite	<= '0';
								Jump		<= '1';
							
			--addi
			when "001000" 	=> 	RegDst 		<= '0';
								BranchBEQ	<= '0';
								BranchBNE	<= '0';
								MemRead		<= '0';
								MemtoReg	<= '0';
								ALUOp		<= "11";
								MemWrite	<= '0';
								ALUSrc		<= '1';
								RegWrite	<= '1';
								Jump		<= '1';
			
			when others		=> null;
		end case;
	end process;

end Behavioral;


