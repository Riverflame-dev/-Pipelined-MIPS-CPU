library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mipsregister is
    Port ( CLK : in std_logic;
           RST : in std_logic;
           DIN : in std_logic_vector(31 downto 0);
           RegWrite : in std_logic;
			  SElWR: in std_logic_vector(4 downto 0);
           SELA : in std_logic_vector(4 downto 0);
           SELB : in std_logic_vector(4 downto 0);
           OUT1 : out std_logic_vector(31 downto 0);
           OUT2 : out std_logic_vector(31 downto 0));
end mipsregister;

architecture Behavioral of mipsregister is


begin

end Behavioral;