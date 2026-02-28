library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre is
    generic(
        n : integer := 64;  -- largeur d’un registre
        r : integer := 64   -- nombre de registres
    );
    port(
        clk       : in  std_logic;
        reset     : in  std_logic;
        rd_ad1    : in  unsigned(5 downto 0);          -- adresse lecture 1
        rd_ad2    : in  unsigned(5 downto 0);          -- adresse lecture 2
        rd_d1     : out unsigned(n-1 downto 0);        -- donnée sortie lecture 1
        rd_d2     : out unsigned(n-1 downto 0);        -- donnée sortie lecture 2
        wr_ad     : in  unsigned(5 downto 0);          -- adresse écriture
        wr_d      : in  unsigned(n-1 downto 0);        -- donnée à écrire
        wr_signal : in  std_logic                      -- signal écriture
    );
end registre;

architecture behaviour of registre is
    type reg_array is array(0 to r-1) of unsigned(n-1 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    -- Lecture asynchrone
    rd_d1 <= registers(to_integer(rd_ad1));
    rd_d2 <= registers(to_integer(rd_ad2));

    -- Écriture synchrone
    process(clk, reset)
    begin
        if reset = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if wr_signal = '1' then
                registers(to_integer(wr_ad)) <= wr_d;
            end if;
        end if;
    end process;
end behaviour;
