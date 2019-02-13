library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity BancDeRegistres is port(
	CLK, Reset : in std_logic;
	W 		   : in std_logic_vector(31 downto 0);
	RA, RB, RW : in std_logic_vector(3 downto 0);
	WE 		   : in std_logic;
	A, B 	   : out std_logic_vector(31 downto 0));
	--Reset	   : in std_logic);
end entity BancDeRegistres;

architecture RTL of BancDeRegistres is
	-- Declaration Type Tableau Memoire
	type table is array(15 downto 0) of std_logic_vector(31 downto 0);

	--Fonction d'Initialisation du Banc de Registres
	function init_banc return table is
	variable result : table;
	begin
		for i in 14 downto 0 loop		--pour le testbench
			result(i) := (others=>'0');
		end loop;
			result(15) := X"00000030";
			return result;
	end init_banc;
	
	--Declaration et Initialisation du Banc de Registres 16*32 bits
	signal Banc : table:=init_banc;
begin
	A <= Banc(to_integer(unsigned(RA)));
	B <= Banc(to_integer(unsigned(RB)));
	process(CLK)
	begin
		if(Reset = '1') then
			for i in 14 downto 0 loop
				Banc(i) <= X"00000000";
			end loop;
			Banc(15) <= std_logic_vector(to_signed(15,32));
		elsif(rising_edge(CLK)) then
			if(WE = '1') then
				Banc(to_integer(unsigned(RW))) <= W;
			end if;
		end if;
	end process;
end architecture RTL;
