library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is port(
	E : in std_logic_vector(31 downto 0);
	S : out std_logic_vector(31 downto 0);
	Reset, Clk : in std_logic);
end entity;

architecture RTL of PC is
begin
	process(Clk, Reset)
	begin
		if(Reset = '1') then
			S <= X"00000000";
		elsif(rising_edge(Clk)) then
			S <= E;
		end if;
	end process;
end architecture RTL;
