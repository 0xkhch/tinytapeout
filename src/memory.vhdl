library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    port ( 
            data : in std_logic_vector(7 downto 0);
            addr : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0);
            we : in std_logic;
            reset : in std_logic;
            clk: in std_logic
    );
end memory;

architecture Behavioral of memory is
    type mem_array is array((2**8)-1 downto 0) of 
        std_logic_vector(7 downto 0);        
    signal mem : mem_array := (others => (others => '0'));
begin
    data_out <= mem(to_integer(unsigned(addr)));
    process(clk, reset) 
    begin
        if rising_edge(clk) then 
            if we = '1' then
                mem(to_integer(unsigned(addr))) <= data;
            end if;
        end if;
    end process;
end Behavioral;