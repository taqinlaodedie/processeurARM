library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ExtentionDeSigne is 
generic (N:integer);
port(
	E: in std_logic_vector(N-1 downto 0);
	S: out std_logic_vector(31 downto 0)
);
end entity ExtentionDeSigne; 

Architecture RTL of ExtentionDeSigne is 
Begin 
	
	process(E) 
	begin 
	
	for j in 31 downto N loop 
		S(j) <= E(N-1);
	end loop;
	for i in N-1 downto 0 loop
		S(i) <= E(i);
	end loop;
	
	
	end process; 
	
end RTL; 
