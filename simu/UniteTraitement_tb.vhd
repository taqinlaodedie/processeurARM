LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity UniteTraitement_tb is
end entity UniteTraitement_tb;

architecture Bench of UniteTraitement_tb is
signal Reset, Clk, WE, N : std_logic;
signal OP : std_logic_vector(1 downto 0);
signal RA, RB, RW : std_logic_vector(3 downto 0);
signal busW : std_logic_vector(31 downto 0);

begin
	clock_gen: process
	begin
		clk <= '1';
		wait for 0.5 ns;
		clk <= '0';
		wait for 0.5 ns;
	end process;
	
	rst: process
	begin
		Reset <= '0';
		wait for 1 ns;
		Reset <= '1';
		wait;
	end process;
	
	process
	begin
		wait for 5 ns;
		
		--lire R(15)
		WE <= '0';
		RA <= "1111";
		OP <= "11";
		wait for 5 ns;
		
		--ecrire R(15) dans R(1)
		WE <= '1';
		RW <= "0001";
		wait for 1.5 ns;
		
		--lire R(1)
		WE <= '0';
		RA <= "0001";
		OP <= "11";
		wait for 5 ns;
		
		--R(1) = R(1) + R(15)
		RA <= "0001";
		RB <= "1111";
		OP <= "00";
		WE <= '1';
		wait for 1.5 ns;
		WE <= '0';
		OP <= "11";
		wait for 5 ns;
		
		--R(2) = R(1) + R(15)
		OP <= "00";
		RW <= "0010";
		WE <= '1';
		wait for 2 ns;
		WE <= '0';
		RA <= "0010";
		OP <= "11";
		wait for 5 ns;
		
		--R(3) = R(1) - R(15)
		OP <= "10";
		RA <= "0001";
		RB <= "1111";
		wait for 5 ns;
		WE <= '1';
		wait for 1.5 ns;
		WE <= '0';
		RA <= "0011";
		OP <= "11";
		wait for 5 ns;
		
		--R(5) = R(7) - R(15)
		OP <= "10";
		RA <= "0111";
		RB <= "1111";
		RW <= "0101";
		WE <= '1';
		wait for 1.5 ns;
		WE <= '0';
		RA <= "0101";
		OP <= "11";
		wait for 5 ns;
		
		wait;
	end process;
	
	UUT: entity work.UniteTraitement(RTL) port map(
		Reset => Reset,
		Clk => Clk,
		OP => OP,
		WE => WE,
		RA => RA, 
		RB => RB, 
		RW => RW,	
		busW => busW,
		N => N);
end architecture Bench;

architecture Bench1 of UniteTraitement_tb is
signal Clk, WE, WE, COM0, COM1, WrEn, flag : std_logic;
signal OP : std_logic_vector(1 downto 0);
signal RA, RB, RW : std_logic_vector(3 downto 0);
signal busW : std_logic_vector(31 downto 0);
signal Imm : std_logic_vector(7 downto 0);
begin
	
