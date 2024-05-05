library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity InstructionFetch is
  Port (clk: in std_logic;
        branchAddr: in std_logic_vector(15 downto 0);
        jumpAddr: in std_logic_vector(15 downto 0);
        Jump: in std_logic; 
        PCSrc: in std_logic;
        pcEn: in std_logic; 
        pcReset: in std_logic; 
        Instruction: out std_logic_vector(15 downto 0);
        pc_out: out std_logic_vector(15 downto 0));
end InstructionFetch;

architecture Behavioral of InstructionFetch is
type memory is array (0 to 15) of std_logic_vector(15 downto 0);
    signal memorie: memory := (
         B"000_001_001_001_0_110", -- 0: x0496 Initialize counter (XOR $1, $1, $1)
        B"100_000_001_0000000",   -- 1:  x8080 Initialize counter with 0 (ADDI $1, $0, 0)
        B"000_100_100_100_0_110", -- 2:  x1246 Initialize result (XOR $4, $4, $4)
        B"100_000_100_0000001",   -- 3:  x8201 Initialize result with 1 (ADDI $4, $0, 1)
        B"010_001_100_0000101",   -- 4:  Loop condition check (BEQ $1, $4, 5)
        B"111_000_100_0000001",   -- 5:  xE201 Update result if current number is greater (SW $1, 1($4))
        B"100_001_001_0000010",   -- 6:  Increment counter (ADDI $1, $1, 1)
        B"001_0000000000011",     -- 7:  Jump back to loop condition check (J 4)
        others => X"0000"
    );
     signal pc: std_logic_vector(15 downto 0) := (others=>'0');
signal adderOut: std_logic_vector(15 downto 0) := (others=>'0');
signal muxBranch: std_logic_vector(15 downto 0) := (others=>'0');
signal nextAddr: std_logic_vector(15 downto 0) := (others=>'0');
                      
begin

process(clk, pcReset)
begin 
    if pcReset = '1' then
         pc <= X"0000";
    elsif rising_edge(clk) and pcEn ='1'  then
         pc <= nextAddr;
    end if;
end process;
     
Instruction <= memorie(conv_integer(pc(4 downto 0)));

adderOut <= pc + 1;   
pc_out <= adderOut; 
process(PCSrc, adderOut, branchAddr)
begin
  case PCSrc is
      when '0' => muxBranch <= adderOut;
      when '1' => muxBranch <= branchAddr;
      when others => muxBranch <= X"0000";
  end case;
end process;

process(Jump, jumpAddr, muxBranch)
begin
  case Jump is
      when '0' => nextAddr <= muxBranch;
      when '1' => nextAddr <= jumpAddr;
      when others => nextAddr <= X"0000";
  end case;
end process;

end Behavioral;