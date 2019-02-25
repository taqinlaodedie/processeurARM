library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_decoder is port(
	Instruction 									   : in std_logic_vector(31 downto 0);
	flag											   : in std_logic_vector(31 downto 0);
	nPCsel, RegWr, RegSel, Alusrc, MemWr, WrSrc, PSREn : out std_logic;
	Aluctr 											   : out std_logic_vector(1 downto 0));
end entity;

architecture RTL of instruction_decoder is
	type enum_instructrion is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, DEFAUT);
	signal instr_courante: enum_instructrion;
	signal OpCode, Cond: std_logic_vector(3 downto 0);
	signal Id: std_logic_vector(1 downto 0);
	signal Imm: std_logic;
begin
	OpCode <= Instruction(24 downto 21);
	Imm <= Instruction(25);
	Id <= Instruction(27 downto 26);
	Cond <= Instruction(31 downto 28);
	
	process(Instruction,id,imm,opcode,cond)
	begin
		case Id is
			when "00"=>
				if(OpCode = "0100" and Cond = "1110") then
					if(Imm = '1') then
						instr_courante <= ADDi;
					else
						instr_courante <= ADDr;
					end if;
				elsif(OpCode = "1101" and Cond = "1110") then
					instr_courante <= MOV;
				elsif(OpCode = "1010" and Cond = "1110") then
					instr_courante <= CMP;
				end if;
			when "01"=>
				if(Instruction(20) = '1') then
					instr_courante <= LDR;
				else
					instr_courante <= STR;
				end if;
			when "10"=>
				if(Cond = "1110") then
					instr_courante <= BAL;
				elsif(Cond = "1011") then
					instr_courante <= BLT;
				end if;
			when others=>
				instr_courante <= DEFAUT;
		end case;
	end process; 
			 
	process(flag, instr_courante)
	begin
		case instr_courante is
		when ADDi=> nPCsel <= '0';
					RegWr <= '1';
					Alusrc <= '1';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
					
		when ADDr=> nPCsel <= '0';
					RegWr <= '1';
					Alusrc <= '0';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
					
		when BAL => nPCsel <= '1';
					RegWr <= '0';
					Alusrc <= '0';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
					
		when BLT => RegWr <= '0';
					Alusrc <= '1';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
					if(flag(0) = '1') then
						nPCsel <= '1';
					else
						nPCsel <= '0';
					end if;
				
		when CMP => nPCsel <= '0';
					RegWr <= '0';
					Alusrc <= '1';
					Aluctr <= "10";
					PSREn <= '1';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
					
		when LDR => nPCsel <= '0';
					RegWr <= '1';
					Alusrc <= '1';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '1';
					RegSel <= '0';
					
		when MOV => nPCsel <= '0';
					RegWr <= '1';
					Alusrc <= '1';
					Aluctr <= "01";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
				
		when STR => nPCsel <= '0';
					RegWr <= '0';
					Alusrc <= '1';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '1';
					WrSrc <= '0';
					RegSel <= '1';
					
		when others => nPCsel <= '0';
					RegWr <= '0';
					Alusrc <= '0';
					Aluctr <= "00";
					PSREn <= '0';
					MemWr <= '0';
					WrSrc <= '0';
					RegSel <= '0';
		end case;
	end process;
end architecture RTL;
	
