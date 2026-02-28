library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ram is
	generic(
		data_width:integer:=64;--longueur de data
		adr_width:integer:=6
	);
	port(
		clk:in std_logic;
		wr_en:in std_logic;
		adr:in unsigned(adr_width-1 downto 0);--adresse du mot a lire ou ecrire
		data_in:in unsigned(data_width- 1 downto 0);--donnée a ecrire
		data_out:out unsigned(data_width- 1 downto 0)--donnée lu
		);
	end ram;
architecture behaviour of ram is
	type ram_type is array(0 to 2**adr_width -1) of unsigned(0 to data_width-1);--ram es un tableau de 64 mot qui ont 64 adresses
	signal memory:ram_type:=(others=>(others=>'0'));

begin
	data_out<=memory(to_integer(adr));--memory:tableau,to_integer(adr)=indice de l adresse
	process(clk)
	begin
		if rising_edge(clk) then
			if wr_en='1' then--l info a ecrire est stocké dans la case du tableau memory si le signal d ecriture est dééclenché
				memory(to_integer(adr))<=data_in;
			end if;
		end if;
	end process;
end behaviour;
	
	
	