
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MainControl is
  Port (
        input: in std_logic_vector(2 downto 0);
        RegDst: out std_logic;
        Extop: out std_logic;
        ALUSrc: out std_logic;
        branch: out std_logic;
        jump: out std_logic;
        ALUOp: out std_logic_vector(2 downto 0);
        MemWrite: out std_logic;
        MemtoReg: out std_logic;
        RegWrite: out std_logic
   );
end MainControl;

architecture Behavioral of MainControl is
begin
    process(input)
    begin
        RegDst <= '0';
        ExtOp <= '0';
        ALUSrc <= '0';
        Branch <= '0';
        Jump <= '0';
        ALUOp <= "000";
        MemWrite <= '0';
        MemtoReg <= '0';
        RegWrite <= '0';

        case input is
            when "000" => -- r-type instruction 
                RegDst <= '1';
                ALUSrc <= '0';
                MemtoReg <= '0';
                RegWrite <= '1';
                ALUOp <= input; 

            when "001" => -- i-type instruction 
                RegDst <= '0';
                ALUSrc <= '1';
                MemtoReg <= '0';
                RegWrite <= '1';
                ALUOp <= input; 

            when "010" => -- load instruction (lw)
                ALUSrc <= '1';
                MemtoReg <= '1';
                RegWrite <= '1';
                ALUOp <= input; 

            when "011" => -- store instruction (sw)
                ALUSrc <= '1';
                MemWrite <= '1';
                ALUOp <= input; 

            when "100" => -- branch equal (beq)
                Branch <= '1';
                ALUOp <= input; 
                        
            when "101" => 
                RegDst <= '0';
                ALUSrc <= '1';
                MemtoReg <= '0';
                RegWrite <= '1';
                ALUOp <= input; 
            when "110" => -- ORI
                    RegDst <= '0';
                    ALUSrc <= '1';
                    MemtoReg <= '0';
                    RegWrite <= '1';
                    ALUOp <= input;

            when others =>
                Jump<='1';
                ALUOp<=input;
        end case;
    end process;
end Behavioral;
