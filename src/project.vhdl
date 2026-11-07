library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_example is
    port (
        ui_in   : in  std_logic_vector(7 downto 0);
        uo_out  : out std_logic_vector(7 downto 0);
        uio_in  : in  std_logic_vector(7 downto 0);
        uio_out : out std_logic_vector(7 downto 0);
        uio_oe  : out std_logic_vector(7 downto 0);
        ena     : in  std_logic;
        clk     : in  std_logic;
        rst_n   : in  std_logic
    );
end tt_um_example;

architecture Behavioral of tt_um_example is
    component vga is
    port (
        clk    : in  std_logic;
        rst_n  : in  std_logic;
        idx  : in  std_logic_vector(3 downto 0);
        hsync : out std_logic;
        vsync : out std_logic;
        r, g, b : out std_logic_vector(1 downto 0)
    );
    end component;
    signal hsync, vsync : std_logic;
    signal r, g, b : std_logic_vector(1 downto 0);
begin
    display : vga port map(
        clk => clk,
        rst_n => rst_n,
        idx => "0000",
        hsync => hsync,
        vsync => vsync,
        r => r, g => g, b => b
    );
    uo_out <= hsync & b(0) & g(0) & r(0) & vsync & b(1) & g(1) & r(1);
    uio_oe <= "00000000";
end Behavioral;