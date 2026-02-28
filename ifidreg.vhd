library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ifidreg is
	generic(
		n:integer:=64--largeur d instruction
	);
	port(
	
		clk:in std_logic;
		reset:in std_logic;
		instr_in:in unsigned(n-1 downto 0);
		instr_out:out unsigned(n-1 downto 0);
		pc_in:in unsigned(63 downto 0);
		pc_out:out unsigned(63 downto 0)
	);
end ifidreg;
architecture behaviour of ifidreg is
	signal pc_inter:unsigned(63 downto 0):=(others=>'0');
	signal reg_inter:unsigned(n-1 downto 0):=(others=>'0');
begin
	process(clk,reset)
	begin
		if reset='1' then
			pc_inter<=(others=>'0');
			reg_inter<=(others=>'0');
		elsif rising_edge(clk) then
			reg_inter<=instr_in;
			pc_inter<=pc_in;
		end if;
	end process;
	instr_out<=reg_inter;
	pc_out<=pc_inter;
end behaviour;

			