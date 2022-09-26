----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:14:47 11/09/2007 
-- Design Name: 
-- Module Name:    mipsaluctrl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- page 302 figure 5.12 

entity mipsaluctrl is
    Port ( ALUOp : in  STD_LOGIC_VECTOR (1 downto 0);
           FUN : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUCTRL : out  STD_LOGIC_VECTOR (3 downto 0));
end mipsaluctrl;

architecture Behavioral of mipsaluctrl is
begin 

	process(ALUOp, FUN)
	begin
		case ALUOp is
			when "00" => ALUCTRL <= "0010";									--lw/sw (addition in ALU)
			when "01" => ALUCTRL <= "0110";									--beq
			when "10" => if		(FUN = "100000") then ALUCTRL <= "0010";	--add
						 elsif	(FUN = "100010") then ALUCTRL <= "0110";	--sub
						 elsif	(FUN = "100100") then ALUCTRL <= "0000";	--and
						 elsif	(FUN = "100101") then ALUCTRL <= "0001";	--or
						 elsif	(FUN = "101010") then ALUCTRL <= "0111";	--slt
						 end if;
			when others => ALUCTRL <= "0000";
		end case;
	end process;

end Behavioral;

