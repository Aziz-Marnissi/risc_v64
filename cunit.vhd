library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cunit is
    port(
        clk      : in  std_logic;
        reset    : in  std_logic;
        instr_in : in  unsigned(63 downto 0);

        -- signaux de contrôle
        reg_wr   : out std_logic;
        aluop    : out std_logic_vector(2 downto 0);
        pcwr     : out std_logic;
        mem_wr   : out std_logic;
        alu_src  : out std_logic;

        -- registres et immédiat
        rs1_addr : out unsigned(5 downto 0);
        rs2_addr : out unsigned(5 downto 0);
        rd_addr  : out unsigned(5 downto 0);
        imm_out  : out unsigned(39 downto 0)
    );
end cunit;

architecture behaviour of cunit is
    signal opcode : unsigned(5 downto 0);
begin
    process(instr_in)
    begin
        opcode   <= instr_in(63 downto 58);
        rs1_addr <= instr_in(57 downto 52);
        rs2_addr <= instr_in(51 downto 46);
        rd_addr  <= instr_in(45 downto 40);
        imm_out  <= instr_in(39 downto 0);

        reg_wr  <= '0';
        aluop   <= "000";
        pcwr    <= '0';
        mem_wr  <= '0';
        alu_src <= '0';

        case opcode is
            when "000000" => -- ADD
                aluop <= "000";
                reg_wr <= '1';
            when "000001" => -- SUB
                aluop <= "001";
                reg_wr <= '1';
            when "000010" => -- AND
                aluop <= "010";
                reg_wr <= '1';
            when "000011" => -- OR
                aluop <= "011";
                reg_wr <= '1';
            when "000100" => -- XOR
                aluop <= "100";
                reg_wr <= '1';
            when "000101" => -- ADDI
                aluop <= "000";
                alu_src <= '1';
                reg_wr <= '1';
            when "000110" => -- LOAD
                aluop <= "000";
                alu_src <= '1';
                reg_wr <= '1';
            when "000111" => -- STORE
                aluop <= "000";
                alu_src <= '1';
                mem_wr <= '1';
            when "001000" => -- BEQ
                aluop <= "001";
            when "001001" => -- JUMP
                pcwr <= '1';
            when others =>
                null;
        end case;
    end process;
end behaviour;
