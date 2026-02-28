library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;--opérations + - ...

entity ALU is
    generic(n : integer := 64);
    port(
        a   : in  unsigned(n-1 downto 0);--entrée1
        b   : in  unsigned(n-1 downto 0);--entrée2
        op  : in  std_logic_vector(2 downto 0);--opération(8 opérations car cpu 8 bits)
        res : out unsigned(n-1 downto 0);--resultat
        c   : out std_logic;--bit carry
        z   : out std_logic;--bit de zero(si res=0 donc z=1)
        o   : out std_logic;--(cas de op)
        n_f : out std_logic
    );
end ALU;

architecture behaviour of ALU is
    signal temp     : signed(n downto 0);
    signal res_int  : unsigned(n-1 downto 0);  -- signal interne pour res
begin
    process(a, b, op)--etude des cas des opération éffectué sur a et b
    begin
        -- ALU operations
        case op is
            when "000" =>  -- ADD
                temp    <= signed('0' & a) + signed('0' & b);--concatener 0 à gauche pour ne pas perdre le bit(au cas ou on est obligé d avoir 9 bits pas 8
					 --temp est divisé en 2 blocs:resultat (8 bits) et carry(1 bits)
                res_int <= unsigned(temp(n-1 downto 0));
                c       <= temp(n);

            when "001" =>  -- SUB
                temp    <= signed('0' & a) - signed('0' & b);
                res_int <= unsigned(temp(n-1 downto 0));
                c       <= temp(n);

            when "010" =>  -- AND
                res_int <= a and b;
                c       <= '0';

            when "011" =>  -- OR
                res_int <= a or b;
                c       <= '0';

            when "100" =>  -- XOR
                res_int <= a xor b;
                c       <= '0';

            when others =>
                res_int <= (others => '0');
                c       <= '0';
        end case;

        -- Flags
        if res_int = 0 then
            z <= '1';
        else
            z <= '0';
        end if;

        n_f <= res_int(n-1);

        if op = "000" then
            o <= (a(n-1) xor b(n-1)) xor (a(n-1) xor res_int(n-1));
        elsif op = "001" then
            o <= (a(n-1) xor b(n-1)) and (a(n-1) xor res_int(n-1));
        else
            o <= '0';
        end if;

    end process;

    -- assigner le signal interne au port
    res <= res_int;

end behaviour;
