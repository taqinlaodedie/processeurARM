library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UniteTraitement is 
port(
	Clk, Reset			 : in std_logic; 
	OP 					 : in std_logic_vector(1 downto 0); 
	WE, COM0, COM1, WrEn : in std_logic; 
	RA, RB, RW			 : in std_logic_vector(3 downto 0); 
	Imm					 : in std_logic_vector(7 downto 0);
	busW				 : inout std_logic_vector(31 downto 0);
	flag        		 : out std_logic);
end entity UniteTraitement; 

Architecture RTL of UniteTraitement is 
signal A,B, busB, Im, DataOut, ALUout: std_logic_vector(31 downto 0); 

Begin
	REG: entity work.BancDeRegistres(RTL) port map (
		Reset => Reset,
		CLK => CLK, 	   
		W 	=> busW,  
		RA  => RA,
		RB  => RB,
		RW  => RW,
		WE 	=> WE,  
		A   => A,
		B 	=> busB);
	ALU: entity work.UAL(RTL) port map(
		OP => OP,
		A => A,
		B => B,
		S => ALUout,	 
		N => flag);  
	EXT: entity work.ExtentionDeSigne(RTL) 
		generic map(N => 8)
		port map(
		E => Imm,
		S => Im);
	MX0: entity work.Multiplexeur2(RTL) 
		generic map(N => 32)
		port map(
		A => busB,
		B => Im,
		COM => COM0,
		S => B);
	MEM: entity work.MemoireDeDonnees(RTL) port map(
		CLK => Clk,
		WrEn => WrEn,
		DataIn => busB,
		DataOut => DataOut,
		Addr => ALUout(5 downto 0));
	MX1: entity work.Multiplexeur2(RTL) 
		generic map (N => 32)
		port map(
		A => ALUout,
		B => DataOut,
		COM => COM1,
		S => busW);		
end architecture RTL;
