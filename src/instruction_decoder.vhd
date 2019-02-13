library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_decoder is port(
	Instruction 									   : in std_logic_vector(31 downto 0);
	PSRout											   : in std_logic_vector(31 downto 0);
	nPCsel, RegWr, RegSel, Alusrc, PSREn, MemWr, WrSrc : out std_logic;
	Aluctr 											   : out std_logic_vector(1 downto 0));
end entity;

architecture RTL of instruction_decoder is
	type enum_instructrion is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
	signal instr_courante: enum_instructrion;
begin
	
