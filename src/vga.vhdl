library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- TinyTapeout-pinout VGA checkerboard demo.
-- A clean intro to VGA: just hsync/vsync timing and a 1-bit pattern from
-- two position bits XOR-ed together.
--
-- ui_in[2:0] : sets the dark-square colour (RGB bits)
-- ui_in[5:4] : square size: 00=32px, 01=64px, 10=128px, 11=16px
--
-- Inspired by the classic "your first VGA design" pattern from fpga4fun
-- and Nandland's VGA tutorial.
entity vga is
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        idx : out std_logic_vector(3 downto 0);
        hsync : out std_logic;
        vsync : out std_logic
    );
end entity;

architecture Behavioral of vga is
    signal hpos : unsigned(9 downto 0) := (others => '0');
    signal vpos : unsigned(9 downto 0) := (others => '0');
begin
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            hpos <= (others => '0');
            vpos <= (others => '0');
        elsif rising_edge(clk) then
            if hpos = 799 then
                hpos <= (others => '0');
                if vpos = 524 then
                    vpos <= (others => '0');
                else
                    vpos <= vpos + 1;
                end if;
            else
                hpos <= hpos + 1;
            end if;
        end if;
    end process;

    hsync <= '0' when hpos < 96 else
             '1';
    vsync <= '0' when vpos < 2 else
             '1';
end Behavioral;