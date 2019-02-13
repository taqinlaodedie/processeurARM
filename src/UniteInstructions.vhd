library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UniteInstructions is port(
	Offset 			 : in std_logic_vector(23 downto 0);
	nPCsel, Clk, Rst : in std_logic;
	Instruction 	 : out std_logic_vector(31 downto 0));
end entity;

architecture RTL of UniteInstructions is
	signal PC, Addr, pc1: std_logic_vector(31 downto 0);
begin
	C0: entity work.PC_Extender(RTL)
	port map(
		Offset => Offset,
		S => PC);
		
	C1: entity work.PC_Counter(RTL)
	port map(
		Addr => Addr, 
		PC => PC,
		nPCsel => nPCsel,
		S => pc1);
		
	C2: entity work.PC(RTL)
	port map(
		E => pc1,
		S => Addr,
		Reset => Rst,
		Clk => Clk);
	
	C3: entity work.instruction_memory(RTL)
	port map(
		PC => Addr,
		Instruction => Instruction);
end architecture RTL;
