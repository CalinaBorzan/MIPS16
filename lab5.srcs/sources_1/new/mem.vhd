
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity memory is
  Port (clk: in std_logic;
        en: in std_logic;
        MemWrite: in std_logic;	
        ALUResIn: in std_logic_vector(15 downto 0);
        WriteData: in std_logic_vector(15 downto 0);	
        MemData: out std_logic_vector(15 downto 0);
        ALUResOut: out std_logic_vector(15 downto 0) );
end memory;

architecture Behavioral of memory is

type mem_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal memorie : mem_type:=(
		X"000A",
		X"000B",
		X"000C",
		X"000D",
		X"000E",
		X"000F",
		X"0009",
		X"0008",
		others =>X"0000");
		
begin

process(clk) 			
begin
	if rising_edge(clk) then
		if en='1' and MemWrite='1' then
				memorie(conv_integer(ALUResIn(4 downto 0))) <= WriteData;			
		end if;	
	end if;
end process;


MemData <= memorie(conv_integer(ALUResIn(4 downto 0)));
ALUResOut <= ALUResIn;

end Behavioral;






