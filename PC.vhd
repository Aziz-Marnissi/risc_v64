library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk    : in std_logic;
        reset  : in std_logic;
        pc_out : out unsigned(63 downto 0)
    );
end PC;

architecture behaviour of PC is
    signal reg_pc : unsigned(63 downto 0) := (others => '0'); -- signal interne
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg_pc <= (others => '0');
        elsif rising_edge(clk) then
            reg_pc <= reg_pc + 1;
        end if;
    end process;

    pc_out <= reg_pc; -- assignation vers la sortie
end behaviour;
