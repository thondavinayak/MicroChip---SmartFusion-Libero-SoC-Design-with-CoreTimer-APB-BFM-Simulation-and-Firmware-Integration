
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity APB_LED_CTRL is
port (
    PCLK     : in  std_logic;
    PRESETN  : in  std_logic;
    PSEL     : in  std_logic;
    PENABLE  : in  std_logic;
    PWRITE   : in  std_logic;
    PADDR    : in  std_logic_vector(7 downto 0);
    PWDATA   : in  std_logic_vector(31 downto 0);
    PRDATA   : out std_logic_vector(31 downto 0);
    PREADY   : out std_logic;
    PSLVERR  : out std_logic;
    LED_OUT  : out std_logic_vector(7 downto 0);
    IRQ      : out std_logic
);
end APB_LED_CTRL;

architecture rtl of APB_LED_CTRL is

signal reg_control : std_logic_vector(31 downto 0) := (others => '0');
signal reg_pattern : std_logic_vector(31 downto 0) := (others => '0');
signal reg_period  : std_logic_vector(31 downto 0) := (others => '0');
signal reg_status  : std_logic_vector(31 downto 0) := (others => '0');

signal counter     : unsigned(31 downto 0) := (others => '0');
signal led_reg     : std_logic_vector(7 downto 0) := (others => '0');
signal irq_int     : std_logic := '0';

begin

PREADY  <= '1';
PSLVERR <= '0';
IRQ     <= irq_int;
LED_OUT <= led_reg;

process(PCLK)
begin
    if rising_edge(PCLK) then
        if PRESETN = '0' then
            reg_control <= (others => '0');
            reg_pattern <= (others => '0');
            reg_period  <= (others => '0');
            reg_status  <= (others => '0');
        elsif (PSEL = '1' and PENABLE = '1' and PWRITE = '1') then
            case PADDR(7 downto 2) is
                when "000000" => reg_control <= PWDATA;
                when "000001" => reg_pattern <= PWDATA;
                when "000010" => reg_period  <= PWDATA;
                when "000100" => reg_status(0) <= '0';
                when others   => null;
            end case;
        end if;
    end if;
end process;

process(PADDR, reg_control, reg_pattern, reg_period, reg_status)
begin
    case PADDR(7 downto 2) is
        when "000000" => PRDATA <= reg_control;
        when "000001" => PRDATA <= reg_pattern;
        when "000010" => PRDATA <= reg_period;
        when "000011" => PRDATA <= reg_status;
        when others   => PRDATA <= (others => '0');
    end case;
end process;

process(PCLK)
begin
    if rising_edge(PCLK) then
        if PRESETN = '0' then
            counter <= (others => '0');
            led_reg <= (others => '0');
            irq_int <= '0';
        else
            if reg_control(0) = '1' then
                if counter = 0 then
                    counter <= unsigned(reg_period);
                    led_reg <= reg_pattern(7 downto 0);
                    reg_status(0) <= '1';
                    if reg_control(1) = '1' then
                        irq_int <= '1';
                    end if;
                else
                    counter <= counter - 1;
                end if;
            else
                counter <= (others => '0');
                irq_int <= '0';
            end if;
        end if;
    end if;
end process;

end rtl;
