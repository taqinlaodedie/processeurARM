library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoireDeDonnees is port(
	CLK, WrEn: in std_logic;
	DataIn : in std_logic_vector(31 downto 0);
	DataOut : out std_logic_vector(31 downto 0);
	Addr : in std_logic_vector(5 downto 0)
);
end entity MemoireDeDonnees;

architecture RTL of MemoireDeDonnees is
	-- Declaration Type Tableau Memoire
	type table is array(63 downto 0) of std_logic_vector(31 downto 0);

	--Fonction d'Initialisation du Banc de Registres
	function init_mem return table is
	variable result : table;
	begin
		for i in 63 downto 43 loop
			result(i) := (others=>'0');
		end loop;
		for i in 41 downto 33 loop
			result(i) := (others=>'0');
		end loop;
		for i in 31 downto 0 loop
			result(i) := (others=>'0');
		end loop;
		result(42) := std_logic_vector(to_unsigned(7,32));
		result(32) := std_logic_vector(to_unsigned(8,32));
		return result;
	end init_mem;
	
	--Declaration et Initialisation du Banc de Registres 16*32 bits
	signal Memoire : table:=init_mem;
begin
	DataOut <= Memoire(to_integer(unsigned(Addr)));
	process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(WrEn <= '1') then
				Memoire(to_integer(unsigned(Addr))) <= DataIn;
			end if;
		end if;
	end process;
end architecture RTL;
