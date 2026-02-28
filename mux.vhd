library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
	generic(
		n:integer:=64
	);
	port(
		sel:in std_logic;
		a:in unsigned(n-1 downto 0);
		b:in unsigned(n-1 downto 0);
		y:out unsigned(n-1 downto 0)
	);
end mux;
architecture behaviour of mux is
begin
	process(sel,a,b)
	begin
		case sel is
			when '1'=>y<=b;
			when '0'=>y<=a;
			when others => y <= (others => '0'); -- cas par défaut
		end case;
	end process;
end behaviour;
		

		