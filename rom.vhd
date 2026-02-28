library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    generic (
        n       : integer := 64;
        nb_ins  : integer := 16
    );
    port(
        clk      : in  std_logic;
        addr     : in  unsigned(3 downto 0); -- 16 instructions
        data_out : out unsigned(n-1 downto 0)
    );
end rom;

architecture rtl of rom is
    type rom_type is array(0 to nb_ins-1) of unsigned(n-1 downto 0);
    signal rom_mem : rom_type := (
        0  => x"0000000000000000", -- ADD
        1  => x"0001000000000000", -- SUB
        2  => x"0002000000000000", -- AND
        3  => x"0003000000000000", -- OR
        4  => x"0004000000000000", -- XOR
        5  => x"0005000000000001", -- ADDI
        6  => x"0006000000000010", -- LOAD
        7  => x"0007000000000011", -- STORE
        8  => x"0010000000000100", -- BEQ
        9  => x"0010010000000101", -- JUMP
        others => (others=>'0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data_out <= rom_mem(to_integer(addr));
        end if;
    end process;
end rtl;
