library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

generic N := 8;
 
entity ExtentionDeSigne is 
port(
	E: in std_logic_vector(N-1 downto 0);
	S: out std_logic_vector(31 downto 0)
);
end entity ExtentionDeSigne; 

Architecture RTL of ExtentionDeSigne is 
Begin 
	
	process 
	begin 
	
	for i in N-1 downto 0 loop
		S(i) <= E(i);
	end loop;
	for j in 31 donwto N loop 
		S(j) <= E(N-1);
	end loop;
	
	end process; 
	
end RTL; 
