library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PSR is port(
	DATAIN : in std_logic_vector(31 downto 0);
	RST, CLK, WE : in std_logic;
	DATAOUT : out std_logic_vector(31 downto 0));
end entity;

architecture RTL of PSR is 
	signal ETAT : std_logic_vector(31 downto 0);
begin
	process(RST, CLK)
	begin
		if(RST = '1') then
			ETAT <= X"00000000";
		elsif((rising_edge(CLK)) and (WE = '1')) then
			ETAT <= DATAIN;
		end if;
	end process;
	
	DATAOUT <= ETAT;
end architecture RTL;
