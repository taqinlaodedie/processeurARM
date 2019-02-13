library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_Counter is port(
	Addr, PC: in std_logic_vector(31 downto 0);
	nPCsel	: in std_logic;
	S   	: out std_logic_vector(31 downto 0));
end entity;

architecture RTL of PC_Counter is
begin
	process(PC, Addr, nPCsel)
	begin
		if(nPCsel = '0') then
			S <= std_logic_vector(unsigned(Addr) + 1);
		else
			S <= std_logic_vector(unsigned(Addr) + 1 + unsigned(PC));
		end if;
	end process;
end architecture RTL;
