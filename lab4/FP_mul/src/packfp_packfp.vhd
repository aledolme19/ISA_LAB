--
-- VHDL Architecture HAVOC.PackFP.PackFP
--
-- Created:
--          by - Guillermo
--          at - ITESM, 09:57:50 07/16/03
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2002.1b (Build 7)
--
-- hds interface_start
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY PackFP IS
    PORT(
        SIGN  : IN  std_logic;
        EXP   : IN  std_logic_vector(7 DOWNTO 0);
        SIG   : IN  std_logic_vector(22 DOWNTO 0);
        isNaN : IN  std_logic;
        isINF : IN  std_logic;
        isZ   : IN  std_logic;
        FP    : OUT std_logic_vector(31 DOWNTO 0)
    );

    -- Declarations

END PackFP;

-- hds interface_end
ARCHITECTURE PackFP OF PackFP IS
BEGIN
    PROCESS(isNaN, isINF, isZ, SIGN, EXP, SIG)
    BEGIN
        IF (isNaN = '1') THEN
            FP(31)           <= SIGN;
            FP(30 DOWNTO 23) <= X"FF";
            FP(22 DOWNTO 0)  <= "100" & X"00000";
        ELSIF (isINF = '1') THEN
            FP(31)           <= SIGN;
            FP(30 DOWNTO 23) <= X"FF";
            FP(22 DOWNTO 0)  <= (OTHERS => '0');
        ELSIF (isZ = '1') THEN
            FP(31)           <= SIGN;
            FP(30 DOWNTO 23) <= X"00";
            FP(22 DOWNTO 0)  <= (OTHERS => '0');
        ELSE
            FP(31)           <= SIGN;
            FP(30 DOWNTO 23) <= EXP;
            FP(22 DOWNTO 0)  <= SIG;
        END IF;
    END PROCESS;

END PackFP;

