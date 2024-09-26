library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JohnsonCounter is
    Port (
        clk       : in  STD_LOGIC;
        reverse   : in  STD_LOGIC := '0';
        stop      : in  STD_LOGIC := '0';
        fullblink : in  STD_LOGIC := '0';
        Q         : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
    );
end JohnsonCounter;

architecture Behavioral of JohnsonCounter is
    type State is (noll, ett, tvo, tre, fyra, fem, sex, sju);
    signal current_state, next_state : State;
begin

    -- Clock process to update the current state
    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Process for state transitions
    process(reverse, stop, fullblink, current_state)
    begin
        case current_state is
            when noll =>
                Q <= "0000";
                if stop = '1' then
                    next_state <= noll;
                elsif fullblink = '1' then
                    next_state <= fyra;
                elsif reverse = '1' then
                    next_state <= sju;
                else
                    next_state <= ett;
                end if;
                
            when ett =>
                Q <= "1000";
                if stop = '1' then
                    next_state <= ett;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= tvo;
                elsif fullblink = '1' then
                    next_state <= noll;
                else
                    next_state <= noll;
                end if;
                
            when tvo =>
                Q <= "1100";
                if stop = '1' then
                    next_state <= tvo;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= tre;
                elsif fullblink = '1' then
                    next_state <= noll;
                else
                    next_state <= ett;
                end if;
                
            when tre =>
                Q <= "1110";
                if stop = '1' then
                    next_state <= tre;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= fyra;
                elsif fullblink = '1' then
                    next_state <= fyra;
                else
                    next_state <= tvo;
                end if;
                
            when fyra =>
                Q <= "1111";
                if stop = '1' then
                    next_state <= fyra;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= fem;
                elsif fullblink = '1' then
                    next_state <= noll;
                else
                    next_state <= tre;
                end if;
                
            when fem =>
                Q <= "0111";
                if stop = '1' then
                    next_state <= fem;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= sex;
                elsif fullblink = '1' then
                    next_state <= fyra;
                else
                    next_state <= fyra;
                end if;
                
            when sex =>
                Q <= "0011";
                if stop = '1' then
                    next_state <= sex;
                elsif reverse = '0' and fullblink = '0' then
                    next_state <= sju;
                elsif fullblink = '1' then
                    next_state <= fyra;
                else
                    next_state <= fem;
                end if;
                
            when sju =>
                Q <= "0001";
                if stop = '1' then
                    next_state <= sju;
                elsif stop = '0' and reverse = '0' and fullblink = '0' then
                    next_state <= noll;
                elsif fullblink = '1' then
                    next_state <= noll;
                else
                    next_state <= sex;
                end if;
        end case;
    end process;

end Behavioral;
