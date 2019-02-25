library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;

entity processeur is port(
	Clk, Reset: in std_logic;
	W		  : inout std_logic_vector(31 downto 0));
end processeur;

architecture RTL of processeur is
	signal Instruction, busW, flag, flag1: std_logic_vector(31 downto 0);
	signal nPCsel, RegWr, ALUsrc, MemWr, WrSrc, RegSel, PSREn: std_logic;
	signal Offset: std_logic_vector(23 downto 0);
	signal Rn, Rd, Rm: std_logic_vector(3 downto 0);
	signal ALUctr: std_logic_vector(1 downto 0);
begin
	Rm <= Instruction(3 downto 0);
	Rn <= Instruction(19 downto 16);
	Rd <= Instruction(15 downto 12);
	W <= busW;
	
	UGI: entity work.UniteInstructions(RTL) 
	port map(
		Offset => Instruction(23 downto 0),
		nPCsel => nPCsel, 
		Clk => Clk, 
		Rst => Reset,
		Instruction => Instruction);
	
	INS: entity work.instruction_decoder(RTL)
	port map(
		Instruction => Instruction,
		flag => flag1,
		PSREn => PSREn,
		nPCsel => nPCsel, 
		RegWr => RegWr, 
		RegSel => RegSel, 
		Alusrc => ALUsrc,  
		MemWr => MemWr, 
		WrSrc => WrSrc,
		Aluctr => ALUctr);
		
	PSR: entity work.PSR(RTL)
	port map(
		DATAIN => flag,
		RST => Reset, 
		CLK => Clk, 
		WE => PSREn,
		DATAOUT => flag1);
		
	UT: entity work.UniteTraitement(RTL)
	port map(
		Clk => Clk, 
		Reset => Reset, 
		RegSel => RegSel,	 
		OP => ALUctr,					 
		WE => RegWr, 
		COM0 => ALUsrc, 
		COM1 => WrSrc, 
		WrEn => RegWr, 
		RA => Rn, 
		RB => Rm, 
		RW => Rd,			 
		Imm	=> Instruction(7 downto 0),				 
		busW => busW,				 
		flag => flag(0));
end architecture RTL;
