library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_Extender is port(
	Offset: in std_logic_vector(23 downto 0);
	S	  : out std_logic_vector(31 downto 0));
end entity PC_Extender; 

Architecture RTL of PC_Extender is 
Begin 
	
	process(Offset) 
	begin 
	
	for j in 31 downto 24 loop 
		S(j) <= Offset(23);
	end loop;
	for i in 23 downto 0 loop
		S(i) <= Offset(i);
	end loop;
	
	end process; 
	
end RTL; 
