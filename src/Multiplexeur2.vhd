library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

generic N:= 32;

entity Multiplexeur2 is 
port(
	A,B : in std_logic_vector(N-1 downto 0); 
	COM : in std_logic;
	S: out std_logic_vector(N-1 downto 0));
end entity Multiplexeur2; 

Architecture RTL of Multiplexeur2 is 
Begin 
	process(A,B,COM) 
	begin 
	
	if COM='0' then 
		S<=A; 
	else 
		S<=B; 
	end if; 
	end process; 

end RTL; 
