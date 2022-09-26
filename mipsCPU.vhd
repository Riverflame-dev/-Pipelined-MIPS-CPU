
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mipsCPU is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end mipsCPU;

architecture Behavioral of mipsCPU is

   component mipsPCReg is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PCIN : in  STD_LOGIC_VECTOR (5 downto 0);
           PCOUT : out  STD_LOGIC_VECTOR (5 downto 0));
   end component mipsPCReg;

   component mipsinstr is
    Port ( 
           ADDRESS : in  STD_LOGIC_VECTOR (5 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0));
   end component mipsinstr;

   component mipsregister is
    Port ( CLK : in std_logic;
           RST : in std_logic;
           DIN : in std_logic_vector(31 downto 0);
           RegWrite : in std_logic;
		   SElWR: in std_logic_vector(4 downto 0);
           SELA : in std_logic_vector(4 downto 0);
           SELB : in std_logic_vector(4 downto 0);
           OUT1 : out std_logic_vector(31 downto 0);
           OUT2 : out std_logic_vector(31 downto 0));
   end component mipsregister;

   component mipsalu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUCTRL : in  STD_LOGIC_VECTOR (3 downto 0);
           ALUOUT : out  STD_LOGIC_VECTOR (31 downto 0);
           ZOUT : out  STD_LOGIC);
   end component mipsalu;

   component mipsmemory is
    Port (
	   DIN : in  STD_LOGIC_VECTOR (31 downto 0);
           ADDRESS : in  STD_LOGIC_VECTOR (5 downto 0);
           MemWrite : in  STD_LOGIC;
           MemRead : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0));
   end component mipsmemory;
	
   component  mipsaluctrl is
    Port ( ALUOp : in  STD_LOGIC_VECTOR (1 downto 0);
           FUN : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUCTRL : out  STD_LOGIC_VECTOR (3 downto 0));
   end component mipsaluctrl;


  component mipsctrl is
    Port ( INSTR : in  STD_LOGIC_VECTOR (5 downto 0);
	   FUNCT : in  STD_LOGIC_VECTOR (5 downto 0);	 
           RegDst : out  STD_LOGIC;
           BranchBEQ : out  STD_LOGIC;
			  BranchBNE : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR (1 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
			  JUMP:  out STD_LOGIC);
   end component mipsctrl;
   
	-- all the signal declarations are here
	 
	--register file
	signal reg_write_dest: std_logic_vector(4 downto 0);
	signal reg_write_data: std_logic_vector(31 downto 0);
	signal reg_read_addr_1: std_logic_vector(4 downto 0);
	signal reg_read_data_1: std_logic_vector(31 downto 0);
	signal reg_read_addr_2: std_logic_vector(4 downto 0);
	signal reg_read_data_2: std_logic_vector(31 downto 0);
	
	--alu
	signal A: std_logic_vector(31 downto 0);
	signal B: std_logic_vector(31 downto 0);
	signal ALUResult: std_logic_vector(31 downto 0);
	signal Zero: std_logic;
	
	--Instruction Memory
	signal instr_read_addr : std_logic_vector (5 downto 0);
	signal instr_out :   std_logic_vector (31 downto 0);
	
	--PC
    signal PCIN :   std_logic_vector (5 downto 0);
    signal PCOUT :   std_logic_vector (5 downto 0);
	
	--Memory
	signal DIN :   std_logic_vector (31 downto 0);
    signal ADDRESS :  std_logic_vector (5 downto 0);
    signal MemWrite :  std_logic;
    signal MemRead :   std_logic;
    signal DOUT :  std_logic_vector (31 downto 0);
	
	--ALU Control
	signal ALUOp :   std_logic_vector (1 downto 0);
    signal FUN :   std_logic_vector (5 downto 0);
    signal ALUCTRL :   std_logic_vector (3 downto 0);
	
	--Control
	signal INSTR :   std_logic_vector (5 downto 0);
	signal FUNCT :   std_logic_vector (5 downto 0);	 
    signal RegDst :   std_logic;
    signal BranchBEQ :   std_logic;
	signal BranchBNE :   std_logic;
    signal MemRead :   std_logic;
    signal MemtoReg :   std_logic;
    signal ALUOp :   std_logic_vector (1 downto 0);
    signal MemWrite :   std_logic;
    signal ALUSrc :   std_logic;
    signal RegWrite :   std_logic;
	signal JUMP:   std_logic);
	
	--Other
	signal four: std_logic_vector (4 downto 0);
	signal pcplusfour: std_logic_vector (4 downto 0);
	signal sgnextended_shifted_instr: std_logic_vector (31 downto 0);
begin
   U1: mipsPCReg port map( 	CLK   => CLK,
							RST   => RST,
							PCIN  => PCIN,
							PCOUT => PCOUT   );
   
   
   U2: mipsinstr port map( 	ADDRESS => instr_read_addr,
							DOUT 	=> instr_out );
							
   U3: mipsregister port map( CLK => CLK,
							RST => RST,
							DIN => reg_write_data,
							RegWrite => RegWrite,
							SElWR => reg_write_dest,
							SELA => reg_read_addr_1,
							SELB => reg_read_addr_2,
							OUT1 => reg_read_data_1,
							OUT2 => reg_read_data_2);
   
   U4: mipsaluctrl port map(ALUOp => ALUOp,
							FUN => FUN,
							ALUCTRL => ALUCTRL);
   
   U5: mipsalu port map( 	A => reg_read_data_1,
							B => B,
							ALUCTRL => ALUCTRL,
							ALUOUT => ALUResult,
							ZOUT => ZOUT);
							
   U6: mipsmemory port map(    DIN => reg_read_data_2,
							   ADDRESS => ALUResult,
							   MemWrite => MemWrite,
							   MemRead => MemRead,
							   DOUT => DOUT   );
							   
   U7: mipsctrl port map( 	INSTR => INSTR,
							FUNCT => FUNCT,
							RegDst => RegDst,
							BranchBEQ => BranchBEQ,
							BranchBNE => BranchBNE,
							MemRead => MemRead,
							MemtoReg => MemtoReg,
							ALUOp => ALUOp,
							MemWrite => MemWrite,
							ALUSrc => ALUSrc,
							RegWrite => RegWrite,
							JUMP=>  JUMP);

	

	four <= "00100";
  ---------------------------------------------
  REGISTER_INPUTS_PROCESS: process () begin
  ---------------------------------------------
        
	if (RegDst = '1') then
		reg_write_dest  <= instr_out(15 downto 11);
	elsif(RegDst = '0') then
		reg_write_dest  <= instr_out(20 downto 16);
	end if;
    
	
	if (MemtoReg = '1') then
		reg_write_data  <= DOUT;
	elsif(MemtoReg = '0') then
		reg_write_data  <= ALUResult;
	end if;
	
    end process;
	
	reg_read_addr_1 <= instr_out(25 downto 21);
	reg_read_addr_2 <= instr_out(20 downto 16);
	
  ---------------------------------------------
  ALU_INPUTS_PROCESS: process () begin
  ---------------------------------------------	
  
	if(ALUSrc = '1') then
		B <= SXT(instr_out(15 downto 0),32);
	elsif(ALUSrc = '0') then
		B <= reg_read_data_2;
	end if;	
  
  sgnextended_shifted_instr<=SXT(instr_out(15 downto 0),32) & "00";
  ---------------------------------------------
  PC_INPUT_PROCESS: process () begin
  ---------------------------------------------	
	if(JUMP = '1') then
		PCIN <= instr_out(25 downto 0) & "00" & B;
	
	
end Behavioral;
