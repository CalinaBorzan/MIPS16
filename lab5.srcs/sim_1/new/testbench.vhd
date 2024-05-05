library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main_mip_tb is
end main_mip_tb;

architecture Behavioral of main_mip_tb is

    -- Component declaration for the DUT (Device Under Test)
    component main_mip is
        Port ( clk : in STD_LOGIC;
               btn : in STD_LOGIC_VECTOR (4 downto 0);
               sw : in STD_LOGIC_VECTOR (15 downto 0);
               led : out STD_LOGIC_VECTOR (15 downto 0);
               an : out STD_LOGIC_VECTOR (3 downto 0);
               cat : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- Test bench signals
    signal clk_tb : STD_LOGIC := '0';
    signal btn_tb : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal sw_tb : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal led_tb : STD_LOGIC_VECTOR (15 downto 0);
    signal an_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal cat_tb : STD_LOGIC_VECTOR (6 downto 0);

    -- Clock process
    constant clk_period : time := 10 ns;
    begin

    -- Clock generation process
    clk_process : process
    begin
        while now < 1000 ns loop  -- Run for 1000 ns
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Instantiate the DUT
    dut : main_mip port map (
        clk => clk_tb,
        btn => btn_tb,
        sw => sw_tb,
        led => led_tb,
        an => an_tb,
        cat => cat_tb
    );

    -- Stimulus process
    stimulus : process
    begin
        -- Initialize inputs
        btn_tb <= (others => '0');
        sw_tb <= (others => '0');
        
        -- Wait a bit for initialization
        wait for 10 ns;
        
        -- Enable the program counter
        btn_tb(0) <= '1';
        
        -- Wait for a few clock cycles
        wait for 10 * clk_period;
        
        -- Reset the program counter
        btn_tb(1) <= '1';
        
        -- Wait for a few clock cycles
        wait for 10 * clk_period;
        
        -- Release the reset
        btn_tb(1) <= '0';
        
        -- Set the switch value to 5
        sw_tb <= "0000000000000101";
        
        -- Wait for a few clock cycles
        wait for 10 * clk_period;
        
        -- Stop the simulation
        wait;
    end process;

end Behavioral;
