LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity UniteTraitement_tb is
end entity UniteTraitement_tb;

architecture Bench1 of UniteTraitement_tb is
signal Clk, WE, COM0, COM1, WrEn, flag, Reset, RegSel: std_logic;
signal OP: std_logic_vector(1 downto 0);
signal RA, RB, RW : std_logic_vector(3 downto 0);
signal busW : std_logic_vector(31 downto 0);
signal Imm : std_logic_vector(7 downto 0);
begin
	clock_gen:process
	begin
		clk <= '1';
		wait for 0.5 ns;
		clk <= '0';
		wait for 0.5 ns;
	end process;
	
	Rst: process
	begin
		Reset <= '1';
		wait for 1 ns;
		Reset <= '0';
		wait;
	end process;
	
	process
	begin
		COM1 <= '0';
		COM0 <= '0';
		OP <= "11";
		RegSel <= '0';
		wait for 5 ns;
		--R(1) = R(15) + R(0)
		WrEn <= '0';
		WE <= '0';
		RA <= "1111";
		RB <= "0000";
		COM0 <= '0';
		OP <= "00";
		COM1 <= '0';
		wait for 1 ns;
		RW <= "0001";
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		OP <= "11";
		wait for 5 ns;
		
		--R(1) = R(15) + 1
		RA <= "1111";
		COM0 <= '1';
		Imm <= "00000001";
		OP <= "00";
		wait for 1 ns;
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		OP <= "11";
		wait for 5 ns;
		
		--R(1) = R(15) - R(0)
		RA <= "1111";
		COM0 <= '0';
		OP <= "10";
		wait for 1 ns;
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		OP <= "00";
		wait for 5 ns;
		
		--R(1) = R(15) - 1
		COM0 <= '1';
		Imm <= "00000001";
		RA <= "1111";
		OP <= "10";
		wait for 1 ns;
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		OP <= "11";
		wait for 5 ns;
		
		--R(1) = R(15)
		COM0 <= '0';
		RA <= "1111";
		wait for 1 ns;
		RW <= "0001";
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		wait for 5 ns;
		
		--R(1) = MEM(48)
		COM1 <= '1';
		wait for 1 ns;
		WE <= '1';
		wait for 1 ns;
		WE <= '0';
		RA <= "0001";
		COM1 <= '0';
		wait for 5 ns;
		
		--MEM(48) = R(0)
		WrEn <= '1';
		COM1 <= '1';
		wait for 5 ns;
		
		wait;
	end process;
	
	UUT: entity work.UniteTraitement(RTL) port map(
		Clk => Clk, 
		Reset => Reset, 
		RegSel => RegSel,	 
		OP => Op,					 
		WE => WE, 
		COM0 => COM0, 
		COM1 => COM1, 
		WrEn => WrEn, 
		RA => RA, 
		RB => RB, 
		RW => RW,			 
		Imm	=> Imm,				 
		busW => busW,				 
		flag => flag);
end Bench1;
