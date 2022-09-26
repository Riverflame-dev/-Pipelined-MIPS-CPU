library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--
-- Memory write in the second clock, as used in the pipelined version

entity mipsmemory is
    Port ( DIN : in  STD_LOGIC_VECTOR (31 downto 0);
           ADDRESS : in  STD_LOGIC_VECTOR (5 downto 0);
           MemWrite : in  STD_LOGIC;
           MemRead : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end mipsmemory;

architecture Behavioral of mipsmemory is
   
begin

end Behavioral;
