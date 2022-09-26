----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:51 11/09/2007 
-- Design Name: 
-- Module Name:    miscPCReg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mipsPCReg is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PCIN : in  STD_LOGIC_VECTOR (5 downto 0);
           PCOUT : out  STD_LOGIC_VECTOR (5 downto 0));
end mipsPCReg;

architecture Behavioral of mipsPCReg is
begin

	process(CLK, RST)
	begin
		if rising_edge(CLK) then
			if(RST = '1') then
				PCOUT <= (others=>'0');
			else
				PCOUT <= PCIN;
			end if;
		end if;
		
	end process;


end Behavioral;

