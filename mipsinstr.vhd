library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mipsinstr is
    Port ( 
           ADDRESS : in  STD_LOGIC_VECTOR (5 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end mipsinstr;

architecture Behavioral of mipsinstr is

begin

end Behavioral;
