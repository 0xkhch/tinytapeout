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
    tile_x <= hpos(9 downto 5);
    tile_y <= vpos(9 downto 6);
    hsync <= '0' when hpos < 96 else
             '1';
    vsync <= '0' when vpos < 2 else
             '1';
end Behavioral;