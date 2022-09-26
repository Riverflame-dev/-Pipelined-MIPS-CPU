-- MIPS ALU 
-- ALU operation inputs: (See page 302 of the textbook)
-- 0000: AND, 0001: OR, 0010: ADD, 0110: SUB,  0111: SET on less than 
-- Only MIPS instructions AND, OR, ADD, SUBTRACT, LW, SW are implemented

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mipsalu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUCTRL : in  STD_LOGIC_VECTOR (3 downto 0);
           ALUOUT : out  STD_LOGIC_VECTOR (31 downto 0);
           ZOUT : out  STD_LOGIC);
end mipsalu;

architecture Behavioral of mipsalu is

begin


end Behavioral;