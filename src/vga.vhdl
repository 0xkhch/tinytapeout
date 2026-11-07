library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        tile_x : out unsigned(4 downto 0);
        tile_y : out unsigned(3 downto 0);
        hsync : out std_logic;
        vsync : out std_logic;
        hpos : out unsigned(9 downto 0);
        vpos : out unsigned(9 downto 0)
    );
end entity;

architecture Behavioral of vga is
    signal hpos_int : unsigned(9 downto 0) := (others => '0');
    signal vpos_int : unsigned(9 downto 0) := (others => '0');
begin
    hpos <= hpos_int;
    vpos <= vpos_int;
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            hpos_int <= (others => '0');
            vpos_int <= (others => '0');
        elsif rising_edge(clk) then
            if hpos_int = 799 then
                hpos_int <= (others => '0');
                if vpos_int = 524 then
                    vpos_int <= (others => '0');
                else
                    vpos_int <= vpos_int + 1;
                end if;
            else
                hpos_int <= hpos_int + 1;
            end if;
        end if;
    end process;
    tile_x <= hpos_int(9 downto 5);
    tile_y <= vpos_int(9 downto 6);
    hsync <= '0' when hpos_int < 96 else
             '1';
    vsync <= '0' when vpos_int < 2 else
             '1';
end Behavioral;