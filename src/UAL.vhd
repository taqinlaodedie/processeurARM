library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UAL is port(
	OP 	 : in std_logic_vector(1 downto 0);
	A, B : in std_logic_vector(31 downto 0);
	S 	 : out std_logic_vector(31 downto 0);
	N 	 : out std_logic);
end entity UAL;

architecture RTL of UAL is
	signal Y: signed(31 downto 0);
begin
	process(OP, A, B)
	begin
		if(OP = "00") then
			Y <= signed(A) + signed(B);
		elsif(OP = "01") then
			Y <= signed(B);
		elsif(OP = "10") then
			Y <= signed(A) - signed(B);
		else
			Y <= signed(A);
		end if;
		
		if(Y < 0) then
			N <= '1';
		else
			N <= '0';
		end if;
	end process;
	
	S <= std_logic_vector(Y);
end architecture RTL;
