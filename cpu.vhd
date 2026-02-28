library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
    generic(N: integer := 64);
    port(
        clk   : in std_logic;
        reset : in std_logic
    );
end CPU;

architecture arch of CPU is
    -- Signals
    signal pc_out      : unsigned(63 downto 0);
    signal instr_rom   : unsigned(N-1 downto 0);
    signal instr_ifid  : unsigned(N-1 downto 0);
    signal pc_ifid     : unsigned(63 downto 0);

    signal rs1_sig, rs2_sig, rd_sig : unsigned(5 downto 0);
    signal rd1, rd2, res             : unsigned(N-1 downto 0);
    signal alu_in2                    : unsigned(N-1 downto 0);
    signal imm_sig                    : unsigned(39 downto 0);
    signal op_sig                     : std_logic_vector(2 downto 0);
    signal wr_en_sig                  : std_logic;
    signal mem_wr_sig                 : std_logic;
    signal alu_src_sig                 : std_logic;
begin

    -- Program Counter
    pc_inst: entity work.PC
        port map(clk => clk, reset => reset, pc_out => pc_out);

    -- ROM
    rom_inst: entity work.rom
        generic map(n => N, nb_ins => 16)
        port map(clk => clk, addr => pc_out(3 downto 0), data_out => instr_rom);

    -- IF/ID Register
    ifid_inst: entity work.ifidreg
        generic map(n => N)
        port map(
            clk       => clk,
            reset     => reset,
            instr_in  => instr_rom,
            instr_out => instr_ifid,
            pc_in     => pc_out,
            pc_out    => pc_ifid
        );

    -- Control Unit
    cunit_inst: entity work.cunit
        port map(
            clk      => clk,
            reset    => reset,
            instr_in => instr_ifid,
            reg_wr   => wr_en_sig,
            aluop    => op_sig,
            pcwr     => open,
            mem_wr   => mem_wr_sig,
            alu_src  => alu_src_sig,
            rs1_addr => rs1_sig,
            rs2_addr => rs2_sig,
            rd_addr  => rd_sig,
            imm_out  => imm_sig
        );

    -- Register File
    reg_inst: entity work.registre
        generic map(n => N, r => 64)
        port map(
            clk       => clk,
            reset     => reset,
            rd_ad1    => rs1_sig,
            rd_ad2    => rs2_sig,
            rd_d1     => rd1,
            rd_d2     => rd2,
            wr_ad     => rd_sig,
            wr_d      => res,
            wr_signal => wr_en_sig
        );

    -- ALU MUX
    mux_inst: entity work.mux
        generic map(n => N)
        port map(
            a   => rd2,
            b   => resize(imm_sig,N),
            sel => alu_src_sig,
            y   => alu_in2
        );

    -- ALU
    alu_inst: entity work.ALU
        generic map(n => N)
        port map(
            a   => rd1,
            b   => alu_in2,
            op  => op_sig,
            res => res,
            c   => open,
            z   => open,
            o   => open,
            n_f => open
        );

end arch;  -- <-- Correction principale : fin de l'architecture
