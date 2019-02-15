library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processeur_tb is
end entity;

architecture bench of processeur_tb is
signal W: std_logic_vector(31 downto 0);
signal clk, rst : std_logic;
begin
	clk_gen: process
	begin
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	end process;
	
	process
	begin
		rst <= '1';
		wait for 1 ns;
		rst <= '0';
		wait for 100 ns;
		wait;
	end process;
	
	UTT: entity work.processeur port map(Clk => clk, Reset => rst ,W => W);
end bench;
