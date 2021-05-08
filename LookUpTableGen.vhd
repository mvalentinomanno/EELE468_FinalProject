-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\chorus_try10sin\LookUpTableGen.vhd
-- Created: 2021-04-19 22:46:32
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: LookUpTableGen
-- Source Path: chorus_try10sin/dataplane/double_chorus/NCO HDL Optimized1/WaveformGen/LookUpTableGen
-- Hierarchy Level: 4
-- 
-- Look Up Table Generation Component
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.dataplane_pkg.ALL;

ENTITY LookUpTableGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        lutaddr                           :   IN    std_logic_vector(9 DOWNTO 0);  -- ufix10
        lutoutput                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END LookUpTableGen;


ARCHITECTURE rtl OF LookUpTableGen IS

  -- Constants
  CONSTANT Lookup_Table_data              : vector_of_signed16(0 TO 1023) := 
    (to_signed(16#0000#, 16), to_signed(16#0019#, 16), to_signed(16#0032#, 16), to_signed(16#004B#, 16),
     to_signed(16#0065#, 16), to_signed(16#007E#, 16), to_signed(16#0097#, 16), to_signed(16#00B0#, 16),
     to_signed(16#00C9#, 16), to_signed(16#00E2#, 16), to_signed(16#00FB#, 16), to_signed(16#0114#, 16),
     to_signed(16#012E#, 16), to_signed(16#0147#, 16), to_signed(16#0160#, 16), to_signed(16#0179#, 16),
     to_signed(16#0192#, 16), to_signed(16#01AB#, 16), to_signed(16#01C4#, 16), to_signed(16#01DD#, 16),
     to_signed(16#01F7#, 16), to_signed(16#0210#, 16), to_signed(16#0229#, 16), to_signed(16#0242#, 16),
     to_signed(16#025B#, 16), to_signed(16#0274#, 16), to_signed(16#028D#, 16), to_signed(16#02A6#, 16),
     to_signed(16#02C0#, 16), to_signed(16#02D9#, 16), to_signed(16#02F2#, 16), to_signed(16#030B#, 16),
     to_signed(16#0324#, 16), to_signed(16#033D#, 16), to_signed(16#0356#, 16), to_signed(16#036F#, 16),
     to_signed(16#0388#, 16), to_signed(16#03A1#, 16), to_signed(16#03BB#, 16), to_signed(16#03D4#, 16),
     to_signed(16#03ED#, 16), to_signed(16#0406#, 16), to_signed(16#041F#, 16), to_signed(16#0438#, 16),
     to_signed(16#0451#, 16), to_signed(16#046A#, 16), to_signed(16#0483#, 16), to_signed(16#049C#, 16),
     to_signed(16#04B5#, 16), to_signed(16#04CE#, 16), to_signed(16#04E7#, 16), to_signed(16#0500#, 16),
     to_signed(16#051A#, 16), to_signed(16#0533#, 16), to_signed(16#054C#, 16), to_signed(16#0565#, 16),
     to_signed(16#057E#, 16), to_signed(16#0597#, 16), to_signed(16#05B0#, 16), to_signed(16#05C9#, 16),
     to_signed(16#05E2#, 16), to_signed(16#05FB#, 16), to_signed(16#0614#, 16), to_signed(16#062D#, 16),
     to_signed(16#0646#, 16), to_signed(16#065F#, 16), to_signed(16#0678#, 16), to_signed(16#0691#, 16),
     to_signed(16#06AA#, 16), to_signed(16#06C3#, 16), to_signed(16#06DC#, 16), to_signed(16#06F5#, 16),
     to_signed(16#070E#, 16), to_signed(16#0727#, 16), to_signed(16#0740#, 16), to_signed(16#0759#, 16),
     to_signed(16#0772#, 16), to_signed(16#078B#, 16), to_signed(16#07A4#, 16), to_signed(16#07BD#, 16),
     to_signed(16#07D6#, 16), to_signed(16#07EF#, 16), to_signed(16#0807#, 16), to_signed(16#0820#, 16),
     to_signed(16#0839#, 16), to_signed(16#0852#, 16), to_signed(16#086B#, 16), to_signed(16#0884#, 16),
     to_signed(16#089D#, 16), to_signed(16#08B6#, 16), to_signed(16#08CF#, 16), to_signed(16#08E8#, 16),
     to_signed(16#0901#, 16), to_signed(16#0919#, 16), to_signed(16#0932#, 16), to_signed(16#094B#, 16),
     to_signed(16#0964#, 16), to_signed(16#097D#, 16), to_signed(16#0996#, 16), to_signed(16#09AF#, 16),
     to_signed(16#09C7#, 16), to_signed(16#09E0#, 16), to_signed(16#09F9#, 16), to_signed(16#0A12#, 16),
     to_signed(16#0A2B#, 16), to_signed(16#0A44#, 16), to_signed(16#0A5C#, 16), to_signed(16#0A75#, 16),
     to_signed(16#0A8E#, 16), to_signed(16#0AA7#, 16), to_signed(16#0AC0#, 16), to_signed(16#0AD8#, 16),
     to_signed(16#0AF1#, 16), to_signed(16#0B0A#, 16), to_signed(16#0B23#, 16), to_signed(16#0B3B#, 16),
     to_signed(16#0B54#, 16), to_signed(16#0B6D#, 16), to_signed(16#0B85#, 16), to_signed(16#0B9E#, 16),
     to_signed(16#0BB7#, 16), to_signed(16#0BD0#, 16), to_signed(16#0BE8#, 16), to_signed(16#0C01#, 16),
     to_signed(16#0C1A#, 16), to_signed(16#0C32#, 16), to_signed(16#0C4B#, 16), to_signed(16#0C64#, 16),
     to_signed(16#0C7C#, 16), to_signed(16#0C95#, 16), to_signed(16#0CAE#, 16), to_signed(16#0CC6#, 16),
     to_signed(16#0CDF#, 16), to_signed(16#0CF8#, 16), to_signed(16#0D10#, 16), to_signed(16#0D29#, 16),
     to_signed(16#0D41#, 16), to_signed(16#0D5A#, 16), to_signed(16#0D72#, 16), to_signed(16#0D8B#, 16),
     to_signed(16#0DA4#, 16), to_signed(16#0DBC#, 16), to_signed(16#0DD5#, 16), to_signed(16#0DED#, 16),
     to_signed(16#0E06#, 16), to_signed(16#0E1E#, 16), to_signed(16#0E37#, 16), to_signed(16#0E4F#, 16),
     to_signed(16#0E68#, 16), to_signed(16#0E80#, 16), to_signed(16#0E99#, 16), to_signed(16#0EB1#, 16),
     to_signed(16#0ECA#, 16), to_signed(16#0EE2#, 16), to_signed(16#0EFB#, 16), to_signed(16#0F13#, 16),
     to_signed(16#0F2B#, 16), to_signed(16#0F44#, 16), to_signed(16#0F5C#, 16), to_signed(16#0F75#, 16),
     to_signed(16#0F8D#, 16), to_signed(16#0FA5#, 16), to_signed(16#0FBE#, 16), to_signed(16#0FD6#, 16),
     to_signed(16#0FEE#, 16), to_signed(16#1007#, 16), to_signed(16#101F#, 16), to_signed(16#1037#, 16),
     to_signed(16#1050#, 16), to_signed(16#1068#, 16), to_signed(16#1080#, 16), to_signed(16#1099#, 16),
     to_signed(16#10B1#, 16), to_signed(16#10C9#, 16), to_signed(16#10E1#, 16), to_signed(16#10FA#, 16),
     to_signed(16#1112#, 16), to_signed(16#112A#, 16), to_signed(16#1142#, 16), to_signed(16#115A#, 16),
     to_signed(16#1173#, 16), to_signed(16#118B#, 16), to_signed(16#11A3#, 16), to_signed(16#11BB#, 16),
     to_signed(16#11D3#, 16), to_signed(16#11EB#, 16), to_signed(16#1204#, 16), to_signed(16#121C#, 16),
     to_signed(16#1234#, 16), to_signed(16#124C#, 16), to_signed(16#1264#, 16), to_signed(16#127C#, 16),
     to_signed(16#1294#, 16), to_signed(16#12AC#, 16), to_signed(16#12C4#, 16), to_signed(16#12DC#, 16),
     to_signed(16#12F4#, 16), to_signed(16#130C#, 16), to_signed(16#1324#, 16), to_signed(16#133C#, 16),
     to_signed(16#1354#, 16), to_signed(16#136C#, 16), to_signed(16#1384#, 16), to_signed(16#139C#, 16),
     to_signed(16#13B4#, 16), to_signed(16#13CC#, 16), to_signed(16#13E4#, 16), to_signed(16#13FB#, 16),
     to_signed(16#1413#, 16), to_signed(16#142B#, 16), to_signed(16#1443#, 16), to_signed(16#145B#, 16),
     to_signed(16#1473#, 16), to_signed(16#148B#, 16), to_signed(16#14A2#, 16), to_signed(16#14BA#, 16),
     to_signed(16#14D2#, 16), to_signed(16#14EA#, 16), to_signed(16#1501#, 16), to_signed(16#1519#, 16),
     to_signed(16#1531#, 16), to_signed(16#1549#, 16), to_signed(16#1560#, 16), to_signed(16#1578#, 16),
     to_signed(16#1590#, 16), to_signed(16#15A7#, 16), to_signed(16#15BF#, 16), to_signed(16#15D7#, 16),
     to_signed(16#15EE#, 16), to_signed(16#1606#, 16), to_signed(16#161D#, 16), to_signed(16#1635#, 16),
     to_signed(16#164C#, 16), to_signed(16#1664#, 16), to_signed(16#167C#, 16), to_signed(16#1693#, 16),
     to_signed(16#16AB#, 16), to_signed(16#16C2#, 16), to_signed(16#16DA#, 16), to_signed(16#16F1#, 16),
     to_signed(16#1709#, 16), to_signed(16#1720#, 16), to_signed(16#1737#, 16), to_signed(16#174F#, 16),
     to_signed(16#1766#, 16), to_signed(16#177E#, 16), to_signed(16#1795#, 16), to_signed(16#17AC#, 16),
     to_signed(16#17C4#, 16), to_signed(16#17DB#, 16), to_signed(16#17F2#, 16), to_signed(16#180A#, 16),
     to_signed(16#1821#, 16), to_signed(16#1838#, 16), to_signed(16#184F#, 16), to_signed(16#1867#, 16),
     to_signed(16#187E#, 16), to_signed(16#1895#, 16), to_signed(16#18AC#, 16), to_signed(16#18C3#, 16),
     to_signed(16#18DB#, 16), to_signed(16#18F2#, 16), to_signed(16#1909#, 16), to_signed(16#1920#, 16),
     to_signed(16#1937#, 16), to_signed(16#194E#, 16), to_signed(16#1965#, 16), to_signed(16#197C#, 16),
     to_signed(16#1993#, 16), to_signed(16#19AA#, 16), to_signed(16#19C1#, 16), to_signed(16#19D8#, 16),
     to_signed(16#19EF#, 16), to_signed(16#1A06#, 16), to_signed(16#1A1D#, 16), to_signed(16#1A34#, 16),
     to_signed(16#1A4B#, 16), to_signed(16#1A62#, 16), to_signed(16#1A79#, 16), to_signed(16#1A90#, 16),
     to_signed(16#1AA7#, 16), to_signed(16#1ABE#, 16), to_signed(16#1AD4#, 16), to_signed(16#1AEB#, 16),
     to_signed(16#1B02#, 16), to_signed(16#1B19#, 16), to_signed(16#1B30#, 16), to_signed(16#1B46#, 16),
     to_signed(16#1B5D#, 16), to_signed(16#1B74#, 16), to_signed(16#1B8A#, 16), to_signed(16#1BA1#, 16),
     to_signed(16#1BB8#, 16), to_signed(16#1BCE#, 16), to_signed(16#1BE5#, 16), to_signed(16#1BFC#, 16),
     to_signed(16#1C12#, 16), to_signed(16#1C29#, 16), to_signed(16#1C3F#, 16), to_signed(16#1C56#, 16),
     to_signed(16#1C6C#, 16), to_signed(16#1C83#, 16), to_signed(16#1C99#, 16), to_signed(16#1CB0#, 16),
     to_signed(16#1CC6#, 16), to_signed(16#1CDD#, 16), to_signed(16#1CF3#, 16), to_signed(16#1D0A#, 16),
     to_signed(16#1D20#, 16), to_signed(16#1D36#, 16), to_signed(16#1D4D#, 16), to_signed(16#1D63#, 16),
     to_signed(16#1D79#, 16), to_signed(16#1D90#, 16), to_signed(16#1DA6#, 16), to_signed(16#1DBC#, 16),
     to_signed(16#1DD3#, 16), to_signed(16#1DE9#, 16), to_signed(16#1DFF#, 16), to_signed(16#1E15#, 16),
     to_signed(16#1E2B#, 16), to_signed(16#1E42#, 16), to_signed(16#1E58#, 16), to_signed(16#1E6E#, 16),
     to_signed(16#1E84#, 16), to_signed(16#1E9A#, 16), to_signed(16#1EB0#, 16), to_signed(16#1EC6#, 16),
     to_signed(16#1EDC#, 16), to_signed(16#1EF2#, 16), to_signed(16#1F08#, 16), to_signed(16#1F1E#, 16),
     to_signed(16#1F34#, 16), to_signed(16#1F4A#, 16), to_signed(16#1F60#, 16), to_signed(16#1F76#, 16),
     to_signed(16#1F8C#, 16), to_signed(16#1FA2#, 16), to_signed(16#1FB7#, 16), to_signed(16#1FCD#, 16),
     to_signed(16#1FE3#, 16), to_signed(16#1FF9#, 16), to_signed(16#200F#, 16), to_signed(16#2024#, 16),
     to_signed(16#203A#, 16), to_signed(16#2050#, 16), to_signed(16#2065#, 16), to_signed(16#207B#, 16),
     to_signed(16#2091#, 16), to_signed(16#20A6#, 16), to_signed(16#20BC#, 16), to_signed(16#20D1#, 16),
     to_signed(16#20E7#, 16), to_signed(16#20FD#, 16), to_signed(16#2112#, 16), to_signed(16#2128#, 16),
     to_signed(16#213D#, 16), to_signed(16#2153#, 16), to_signed(16#2168#, 16), to_signed(16#217D#, 16),
     to_signed(16#2193#, 16), to_signed(16#21A8#, 16), to_signed(16#21BE#, 16), to_signed(16#21D3#, 16),
     to_signed(16#21E8#, 16), to_signed(16#21FE#, 16), to_signed(16#2213#, 16), to_signed(16#2228#, 16),
     to_signed(16#223D#, 16), to_signed(16#2253#, 16), to_signed(16#2268#, 16), to_signed(16#227D#, 16),
     to_signed(16#2292#, 16), to_signed(16#22A7#, 16), to_signed(16#22BC#, 16), to_signed(16#22D2#, 16),
     to_signed(16#22E7#, 16), to_signed(16#22FC#, 16), to_signed(16#2311#, 16), to_signed(16#2326#, 16),
     to_signed(16#233B#, 16), to_signed(16#2350#, 16), to_signed(16#2365#, 16), to_signed(16#237A#, 16),
     to_signed(16#238E#, 16), to_signed(16#23A3#, 16), to_signed(16#23B8#, 16), to_signed(16#23CD#, 16),
     to_signed(16#23E2#, 16), to_signed(16#23F7#, 16), to_signed(16#240B#, 16), to_signed(16#2420#, 16),
     to_signed(16#2435#, 16), to_signed(16#244A#, 16), to_signed(16#245E#, 16), to_signed(16#2473#, 16),
     to_signed(16#2488#, 16), to_signed(16#249C#, 16), to_signed(16#24B1#, 16), to_signed(16#24C5#, 16),
     to_signed(16#24DA#, 16), to_signed(16#24EF#, 16), to_signed(16#2503#, 16), to_signed(16#2518#, 16),
     to_signed(16#252C#, 16), to_signed(16#2541#, 16), to_signed(16#2555#, 16), to_signed(16#2569#, 16),
     to_signed(16#257E#, 16), to_signed(16#2592#, 16), to_signed(16#25A6#, 16), to_signed(16#25BB#, 16),
     to_signed(16#25CF#, 16), to_signed(16#25E3#, 16), to_signed(16#25F8#, 16), to_signed(16#260C#, 16),
     to_signed(16#2620#, 16), to_signed(16#2634#, 16), to_signed(16#2648#, 16), to_signed(16#265C#, 16),
     to_signed(16#2671#, 16), to_signed(16#2685#, 16), to_signed(16#2699#, 16), to_signed(16#26AD#, 16),
     to_signed(16#26C1#, 16), to_signed(16#26D5#, 16), to_signed(16#26E9#, 16), to_signed(16#26FD#, 16),
     to_signed(16#2711#, 16), to_signed(16#2724#, 16), to_signed(16#2738#, 16), to_signed(16#274C#, 16),
     to_signed(16#2760#, 16), to_signed(16#2774#, 16), to_signed(16#2788#, 16), to_signed(16#279B#, 16),
     to_signed(16#27AF#, 16), to_signed(16#27C3#, 16), to_signed(16#27D6#, 16), to_signed(16#27EA#, 16),
     to_signed(16#27FE#, 16), to_signed(16#2811#, 16), to_signed(16#2825#, 16), to_signed(16#2838#, 16),
     to_signed(16#284C#, 16), to_signed(16#2860#, 16), to_signed(16#2873#, 16), to_signed(16#2886#, 16),
     to_signed(16#289A#, 16), to_signed(16#28AD#, 16), to_signed(16#28C1#, 16), to_signed(16#28D4#, 16),
     to_signed(16#28E7#, 16), to_signed(16#28FB#, 16), to_signed(16#290E#, 16), to_signed(16#2921#, 16),
     to_signed(16#2935#, 16), to_signed(16#2948#, 16), to_signed(16#295B#, 16), to_signed(16#296E#, 16),
     to_signed(16#2981#, 16), to_signed(16#2994#, 16), to_signed(16#29A7#, 16), to_signed(16#29BB#, 16),
     to_signed(16#29CE#, 16), to_signed(16#29E1#, 16), to_signed(16#29F4#, 16), to_signed(16#2A07#, 16),
     to_signed(16#2A1A#, 16), to_signed(16#2A2C#, 16), to_signed(16#2A3F#, 16), to_signed(16#2A52#, 16),
     to_signed(16#2A65#, 16), to_signed(16#2A78#, 16), to_signed(16#2A8B#, 16), to_signed(16#2A9D#, 16),
     to_signed(16#2AB0#, 16), to_signed(16#2AC3#, 16), to_signed(16#2AD6#, 16), to_signed(16#2AE8#, 16),
     to_signed(16#2AFB#, 16), to_signed(16#2B0D#, 16), to_signed(16#2B20#, 16), to_signed(16#2B33#, 16),
     to_signed(16#2B45#, 16), to_signed(16#2B58#, 16), to_signed(16#2B6A#, 16), to_signed(16#2B7D#, 16),
     to_signed(16#2B8F#, 16), to_signed(16#2BA1#, 16), to_signed(16#2BB4#, 16), to_signed(16#2BC6#, 16),
     to_signed(16#2BD8#, 16), to_signed(16#2BEB#, 16), to_signed(16#2BFD#, 16), to_signed(16#2C0F#, 16),
     to_signed(16#2C21#, 16), to_signed(16#2C34#, 16), to_signed(16#2C46#, 16), to_signed(16#2C58#, 16),
     to_signed(16#2C6A#, 16), to_signed(16#2C7C#, 16), to_signed(16#2C8E#, 16), to_signed(16#2CA0#, 16),
     to_signed(16#2CB2#, 16), to_signed(16#2CC4#, 16), to_signed(16#2CD6#, 16), to_signed(16#2CE8#, 16),
     to_signed(16#2CFA#, 16), to_signed(16#2D0C#, 16), to_signed(16#2D1E#, 16), to_signed(16#2D2F#, 16),
     to_signed(16#2D41#, 16), to_signed(16#2D53#, 16), to_signed(16#2D65#, 16), to_signed(16#2D76#, 16),
     to_signed(16#2D88#, 16), to_signed(16#2D9A#, 16), to_signed(16#2DAB#, 16), to_signed(16#2DBD#, 16),
     to_signed(16#2DCF#, 16), to_signed(16#2DE0#, 16), to_signed(16#2DF2#, 16), to_signed(16#2E03#, 16),
     to_signed(16#2E15#, 16), to_signed(16#2E26#, 16), to_signed(16#2E37#, 16), to_signed(16#2E49#, 16),
     to_signed(16#2E5A#, 16), to_signed(16#2E6B#, 16), to_signed(16#2E7D#, 16), to_signed(16#2E8E#, 16),
     to_signed(16#2E9F#, 16), to_signed(16#2EB0#, 16), to_signed(16#2EC2#, 16), to_signed(16#2ED3#, 16),
     to_signed(16#2EE4#, 16), to_signed(16#2EF5#, 16), to_signed(16#2F06#, 16), to_signed(16#2F17#, 16),
     to_signed(16#2F28#, 16), to_signed(16#2F39#, 16), to_signed(16#2F4A#, 16), to_signed(16#2F5B#, 16),
     to_signed(16#2F6C#, 16), to_signed(16#2F7D#, 16), to_signed(16#2F8D#, 16), to_signed(16#2F9E#, 16),
     to_signed(16#2FAF#, 16), to_signed(16#2FC0#, 16), to_signed(16#2FD0#, 16), to_signed(16#2FE1#, 16),
     to_signed(16#2FF2#, 16), to_signed(16#3002#, 16), to_signed(16#3013#, 16), to_signed(16#3024#, 16),
     to_signed(16#3034#, 16), to_signed(16#3045#, 16), to_signed(16#3055#, 16), to_signed(16#3066#, 16),
     to_signed(16#3076#, 16), to_signed(16#3087#, 16), to_signed(16#3097#, 16), to_signed(16#30A7#, 16),
     to_signed(16#30B8#, 16), to_signed(16#30C8#, 16), to_signed(16#30D8#, 16), to_signed(16#30E8#, 16),
     to_signed(16#30F9#, 16), to_signed(16#3109#, 16), to_signed(16#3119#, 16), to_signed(16#3129#, 16),
     to_signed(16#3139#, 16), to_signed(16#3149#, 16), to_signed(16#3159#, 16), to_signed(16#3169#, 16),
     to_signed(16#3179#, 16), to_signed(16#3189#, 16), to_signed(16#3199#, 16), to_signed(16#31A9#, 16),
     to_signed(16#31B9#, 16), to_signed(16#31C8#, 16), to_signed(16#31D8#, 16), to_signed(16#31E8#, 16),
     to_signed(16#31F8#, 16), to_signed(16#3207#, 16), to_signed(16#3217#, 16), to_signed(16#3227#, 16),
     to_signed(16#3236#, 16), to_signed(16#3246#, 16), to_signed(16#3255#, 16), to_signed(16#3265#, 16),
     to_signed(16#3274#, 16), to_signed(16#3284#, 16), to_signed(16#3293#, 16), to_signed(16#32A3#, 16),
     to_signed(16#32B2#, 16), to_signed(16#32C1#, 16), to_signed(16#32D0#, 16), to_signed(16#32E0#, 16),
     to_signed(16#32EF#, 16), to_signed(16#32FE#, 16), to_signed(16#330D#, 16), to_signed(16#331D#, 16),
     to_signed(16#332C#, 16), to_signed(16#333B#, 16), to_signed(16#334A#, 16), to_signed(16#3359#, 16),
     to_signed(16#3368#, 16), to_signed(16#3377#, 16), to_signed(16#3386#, 16), to_signed(16#3395#, 16),
     to_signed(16#33A3#, 16), to_signed(16#33B2#, 16), to_signed(16#33C1#, 16), to_signed(16#33D0#, 16),
     to_signed(16#33DF#, 16), to_signed(16#33ED#, 16), to_signed(16#33FC#, 16), to_signed(16#340B#, 16),
     to_signed(16#3419#, 16), to_signed(16#3428#, 16), to_signed(16#3436#, 16), to_signed(16#3445#, 16),
     to_signed(16#3453#, 16), to_signed(16#3462#, 16), to_signed(16#3470#, 16), to_signed(16#347F#, 16),
     to_signed(16#348D#, 16), to_signed(16#349B#, 16), to_signed(16#34AA#, 16), to_signed(16#34B8#, 16),
     to_signed(16#34C6#, 16), to_signed(16#34D4#, 16), to_signed(16#34E2#, 16), to_signed(16#34F1#, 16),
     to_signed(16#34FF#, 16), to_signed(16#350D#, 16), to_signed(16#351B#, 16), to_signed(16#3529#, 16),
     to_signed(16#3537#, 16), to_signed(16#3545#, 16), to_signed(16#3553#, 16), to_signed(16#3561#, 16),
     to_signed(16#356E#, 16), to_signed(16#357C#, 16), to_signed(16#358A#, 16), to_signed(16#3598#, 16),
     to_signed(16#35A5#, 16), to_signed(16#35B3#, 16), to_signed(16#35C1#, 16), to_signed(16#35CE#, 16),
     to_signed(16#35DC#, 16), to_signed(16#35EA#, 16), to_signed(16#35F7#, 16), to_signed(16#3605#, 16),
     to_signed(16#3612#, 16), to_signed(16#3620#, 16), to_signed(16#362D#, 16), to_signed(16#363A#, 16),
     to_signed(16#3648#, 16), to_signed(16#3655#, 16), to_signed(16#3662#, 16), to_signed(16#366F#, 16),
     to_signed(16#367D#, 16), to_signed(16#368A#, 16), to_signed(16#3697#, 16), to_signed(16#36A4#, 16),
     to_signed(16#36B1#, 16), to_signed(16#36BE#, 16), to_signed(16#36CB#, 16), to_signed(16#36D8#, 16),
     to_signed(16#36E5#, 16), to_signed(16#36F2#, 16), to_signed(16#36FF#, 16), to_signed(16#370C#, 16),
     to_signed(16#3718#, 16), to_signed(16#3725#, 16), to_signed(16#3732#, 16), to_signed(16#373F#, 16),
     to_signed(16#374B#, 16), to_signed(16#3758#, 16), to_signed(16#3765#, 16), to_signed(16#3771#, 16),
     to_signed(16#377E#, 16), to_signed(16#378A#, 16), to_signed(16#3797#, 16), to_signed(16#37A3#, 16),
     to_signed(16#37B0#, 16), to_signed(16#37BC#, 16), to_signed(16#37C8#, 16), to_signed(16#37D5#, 16),
     to_signed(16#37E1#, 16), to_signed(16#37ED#, 16), to_signed(16#37F9#, 16), to_signed(16#3805#, 16),
     to_signed(16#3812#, 16), to_signed(16#381E#, 16), to_signed(16#382A#, 16), to_signed(16#3836#, 16),
     to_signed(16#3842#, 16), to_signed(16#384E#, 16), to_signed(16#385A#, 16), to_signed(16#3866#, 16),
     to_signed(16#3871#, 16), to_signed(16#387D#, 16), to_signed(16#3889#, 16), to_signed(16#3895#, 16),
     to_signed(16#38A1#, 16), to_signed(16#38AC#, 16), to_signed(16#38B8#, 16), to_signed(16#38C3#, 16),
     to_signed(16#38CF#, 16), to_signed(16#38DB#, 16), to_signed(16#38E6#, 16), to_signed(16#38F2#, 16),
     to_signed(16#38FD#, 16), to_signed(16#3909#, 16), to_signed(16#3914#, 16), to_signed(16#391F#, 16),
     to_signed(16#392B#, 16), to_signed(16#3936#, 16), to_signed(16#3941#, 16), to_signed(16#394C#, 16),
     to_signed(16#3958#, 16), to_signed(16#3963#, 16), to_signed(16#396E#, 16), to_signed(16#3979#, 16),
     to_signed(16#3984#, 16), to_signed(16#398F#, 16), to_signed(16#399A#, 16), to_signed(16#39A5#, 16),
     to_signed(16#39B0#, 16), to_signed(16#39BB#, 16), to_signed(16#39C5#, 16), to_signed(16#39D0#, 16),
     to_signed(16#39DB#, 16), to_signed(16#39E6#, 16), to_signed(16#39F0#, 16), to_signed(16#39FB#, 16),
     to_signed(16#3A06#, 16), to_signed(16#3A10#, 16), to_signed(16#3A1B#, 16), to_signed(16#3A25#, 16),
     to_signed(16#3A30#, 16), to_signed(16#3A3A#, 16), to_signed(16#3A45#, 16), to_signed(16#3A4F#, 16),
     to_signed(16#3A59#, 16), to_signed(16#3A64#, 16), to_signed(16#3A6E#, 16), to_signed(16#3A78#, 16),
     to_signed(16#3A82#, 16), to_signed(16#3A8D#, 16), to_signed(16#3A97#, 16), to_signed(16#3AA1#, 16),
     to_signed(16#3AAB#, 16), to_signed(16#3AB5#, 16), to_signed(16#3ABF#, 16), to_signed(16#3AC9#, 16),
     to_signed(16#3AD3#, 16), to_signed(16#3ADD#, 16), to_signed(16#3AE6#, 16), to_signed(16#3AF0#, 16),
     to_signed(16#3AFA#, 16), to_signed(16#3B04#, 16), to_signed(16#3B0E#, 16), to_signed(16#3B17#, 16),
     to_signed(16#3B21#, 16), to_signed(16#3B2A#, 16), to_signed(16#3B34#, 16), to_signed(16#3B3E#, 16),
     to_signed(16#3B47#, 16), to_signed(16#3B50#, 16), to_signed(16#3B5A#, 16), to_signed(16#3B63#, 16),
     to_signed(16#3B6D#, 16), to_signed(16#3B76#, 16), to_signed(16#3B7F#, 16), to_signed(16#3B88#, 16),
     to_signed(16#3B92#, 16), to_signed(16#3B9B#, 16), to_signed(16#3BA4#, 16), to_signed(16#3BAD#, 16),
     to_signed(16#3BB6#, 16), to_signed(16#3BBF#, 16), to_signed(16#3BC8#, 16), to_signed(16#3BD1#, 16),
     to_signed(16#3BDA#, 16), to_signed(16#3BE3#, 16), to_signed(16#3BEC#, 16), to_signed(16#3BF5#, 16),
     to_signed(16#3BFD#, 16), to_signed(16#3C06#, 16), to_signed(16#3C0F#, 16), to_signed(16#3C17#, 16),
     to_signed(16#3C20#, 16), to_signed(16#3C29#, 16), to_signed(16#3C31#, 16), to_signed(16#3C3A#, 16),
     to_signed(16#3C42#, 16), to_signed(16#3C4B#, 16), to_signed(16#3C53#, 16), to_signed(16#3C5B#, 16),
     to_signed(16#3C64#, 16), to_signed(16#3C6C#, 16), to_signed(16#3C74#, 16), to_signed(16#3C7D#, 16),
     to_signed(16#3C85#, 16), to_signed(16#3C8D#, 16), to_signed(16#3C95#, 16), to_signed(16#3C9D#, 16),
     to_signed(16#3CA5#, 16), to_signed(16#3CAD#, 16), to_signed(16#3CB5#, 16), to_signed(16#3CBD#, 16),
     to_signed(16#3CC5#, 16), to_signed(16#3CCD#, 16), to_signed(16#3CD5#, 16), to_signed(16#3CDD#, 16),
     to_signed(16#3CE4#, 16), to_signed(16#3CEC#, 16), to_signed(16#3CF4#, 16), to_signed(16#3CFB#, 16),
     to_signed(16#3D03#, 16), to_signed(16#3D0B#, 16), to_signed(16#3D12#, 16), to_signed(16#3D1A#, 16),
     to_signed(16#3D21#, 16), to_signed(16#3D28#, 16), to_signed(16#3D30#, 16), to_signed(16#3D37#, 16),
     to_signed(16#3D3F#, 16), to_signed(16#3D46#, 16), to_signed(16#3D4D#, 16), to_signed(16#3D54#, 16),
     to_signed(16#3D5B#, 16), to_signed(16#3D63#, 16), to_signed(16#3D6A#, 16), to_signed(16#3D71#, 16),
     to_signed(16#3D78#, 16), to_signed(16#3D7F#, 16), to_signed(16#3D86#, 16), to_signed(16#3D8D#, 16),
     to_signed(16#3D93#, 16), to_signed(16#3D9A#, 16), to_signed(16#3DA1#, 16), to_signed(16#3DA8#, 16),
     to_signed(16#3DAF#, 16), to_signed(16#3DB5#, 16), to_signed(16#3DBC#, 16), to_signed(16#3DC2#, 16),
     to_signed(16#3DC9#, 16), to_signed(16#3DD0#, 16), to_signed(16#3DD6#, 16), to_signed(16#3DDD#, 16),
     to_signed(16#3DE3#, 16), to_signed(16#3DE9#, 16), to_signed(16#3DF0#, 16), to_signed(16#3DF6#, 16),
     to_signed(16#3DFC#, 16), to_signed(16#3E03#, 16), to_signed(16#3E09#, 16), to_signed(16#3E0F#, 16),
     to_signed(16#3E15#, 16), to_signed(16#3E1B#, 16), to_signed(16#3E21#, 16), to_signed(16#3E27#, 16),
     to_signed(16#3E2D#, 16), to_signed(16#3E33#, 16), to_signed(16#3E39#, 16), to_signed(16#3E3F#, 16),
     to_signed(16#3E45#, 16), to_signed(16#3E4A#, 16), to_signed(16#3E50#, 16), to_signed(16#3E56#, 16),
     to_signed(16#3E5C#, 16), to_signed(16#3E61#, 16), to_signed(16#3E67#, 16), to_signed(16#3E6C#, 16),
     to_signed(16#3E72#, 16), to_signed(16#3E77#, 16), to_signed(16#3E7D#, 16), to_signed(16#3E82#, 16),
     to_signed(16#3E88#, 16), to_signed(16#3E8D#, 16), to_signed(16#3E92#, 16), to_signed(16#3E98#, 16),
     to_signed(16#3E9D#, 16), to_signed(16#3EA2#, 16), to_signed(16#3EA7#, 16), to_signed(16#3EAC#, 16),
     to_signed(16#3EB1#, 16), to_signed(16#3EB6#, 16), to_signed(16#3EBB#, 16), to_signed(16#3EC0#, 16),
     to_signed(16#3EC5#, 16), to_signed(16#3ECA#, 16), to_signed(16#3ECF#, 16), to_signed(16#3ED4#, 16),
     to_signed(16#3ED8#, 16), to_signed(16#3EDD#, 16), to_signed(16#3EE2#, 16), to_signed(16#3EE7#, 16),
     to_signed(16#3EEB#, 16), to_signed(16#3EF0#, 16), to_signed(16#3EF4#, 16), to_signed(16#3EF9#, 16),
     to_signed(16#3EFD#, 16), to_signed(16#3F02#, 16), to_signed(16#3F06#, 16), to_signed(16#3F0A#, 16),
     to_signed(16#3F0F#, 16), to_signed(16#3F13#, 16), to_signed(16#3F17#, 16), to_signed(16#3F1C#, 16),
     to_signed(16#3F20#, 16), to_signed(16#3F24#, 16), to_signed(16#3F28#, 16), to_signed(16#3F2C#, 16),
     to_signed(16#3F30#, 16), to_signed(16#3F34#, 16), to_signed(16#3F38#, 16), to_signed(16#3F3C#, 16),
     to_signed(16#3F40#, 16), to_signed(16#3F43#, 16), to_signed(16#3F47#, 16), to_signed(16#3F4B#, 16),
     to_signed(16#3F4F#, 16), to_signed(16#3F52#, 16), to_signed(16#3F56#, 16), to_signed(16#3F5A#, 16),
     to_signed(16#3F5D#, 16), to_signed(16#3F61#, 16), to_signed(16#3F64#, 16), to_signed(16#3F68#, 16),
     to_signed(16#3F6B#, 16), to_signed(16#3F6E#, 16), to_signed(16#3F72#, 16), to_signed(16#3F75#, 16),
     to_signed(16#3F78#, 16), to_signed(16#3F7B#, 16), to_signed(16#3F7F#, 16), to_signed(16#3F82#, 16),
     to_signed(16#3F85#, 16), to_signed(16#3F88#, 16), to_signed(16#3F8B#, 16), to_signed(16#3F8E#, 16),
     to_signed(16#3F91#, 16), to_signed(16#3F94#, 16), to_signed(16#3F97#, 16), to_signed(16#3F99#, 16),
     to_signed(16#3F9C#, 16), to_signed(16#3F9F#, 16), to_signed(16#3FA2#, 16), to_signed(16#3FA4#, 16),
     to_signed(16#3FA7#, 16), to_signed(16#3FAA#, 16), to_signed(16#3FAC#, 16), to_signed(16#3FAF#, 16),
     to_signed(16#3FB1#, 16), to_signed(16#3FB4#, 16), to_signed(16#3FB6#, 16), to_signed(16#3FB8#, 16),
     to_signed(16#3FBB#, 16), to_signed(16#3FBD#, 16), to_signed(16#3FBF#, 16), to_signed(16#3FC1#, 16),
     to_signed(16#3FC4#, 16), to_signed(16#3FC6#, 16), to_signed(16#3FC8#, 16), to_signed(16#3FCA#, 16),
     to_signed(16#3FCC#, 16), to_signed(16#3FCE#, 16), to_signed(16#3FD0#, 16), to_signed(16#3FD2#, 16),
     to_signed(16#3FD4#, 16), to_signed(16#3FD5#, 16), to_signed(16#3FD7#, 16), to_signed(16#3FD9#, 16),
     to_signed(16#3FDB#, 16), to_signed(16#3FDC#, 16), to_signed(16#3FDE#, 16), to_signed(16#3FE0#, 16),
     to_signed(16#3FE1#, 16), to_signed(16#3FE3#, 16), to_signed(16#3FE4#, 16), to_signed(16#3FE6#, 16),
     to_signed(16#3FE7#, 16), to_signed(16#3FE8#, 16), to_signed(16#3FEA#, 16), to_signed(16#3FEB#, 16),
     to_signed(16#3FEC#, 16), to_signed(16#3FED#, 16), to_signed(16#3FEF#, 16), to_signed(16#3FF0#, 16),
     to_signed(16#3FF1#, 16), to_signed(16#3FF2#, 16), to_signed(16#3FF3#, 16), to_signed(16#3FF4#, 16),
     to_signed(16#3FF5#, 16), to_signed(16#3FF6#, 16), to_signed(16#3FF7#, 16), to_signed(16#3FF7#, 16),
     to_signed(16#3FF8#, 16), to_signed(16#3FF9#, 16), to_signed(16#3FFA#, 16), to_signed(16#3FFA#, 16),
     to_signed(16#3FFB#, 16), to_signed(16#3FFC#, 16), to_signed(16#3FFC#, 16), to_signed(16#3FFD#, 16),
     to_signed(16#3FFD#, 16), to_signed(16#3FFE#, 16), to_signed(16#3FFE#, 16), to_signed(16#3FFE#, 16),
     to_signed(16#3FFF#, 16), to_signed(16#3FFF#, 16), to_signed(16#3FFF#, 16), to_signed(16#4000#, 16),
     to_signed(16#4000#, 16), to_signed(16#4000#, 16), to_signed(16#4000#, 16), to_signed(16#4000#, 16));  -- sfix16 [1024]

  -- Signals
  SIGNAL lutaddr_unsigned                 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL lutaddrInReg                     : unsigned(9 DOWNTO 0) := to_unsigned(16#000#, 10);  -- ufix10
  SIGNAL Lookup_Table_k                   : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL lutout                           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL lutout_reg                       : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16_En14
  SIGNAL lutoutput_tmp                    : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  lutaddr_unsigned <= unsigned(lutaddr);

  -- Look up table address input register
  LUTaddrRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb_1_2048_0 = '1' THEN
        lutaddrInReg <= lutaddr_unsigned;
      END IF;
    END IF;
  END PROCESS LUTaddrRegister_process;


  -- Quarter sine wave table
  
  Lookup_Table_k <= to_unsigned(16#000#, 10) WHEN lutaddrInReg = to_unsigned(16#000#, 10) ELSE
      to_unsigned(16#3FF#, 10) WHEN lutaddrInReg = to_unsigned(16#3FF#, 10) ELSE
      lutaddrInReg;
  lutout <= Lookup_Table_data(to_integer(Lookup_Table_k));

  -- Lookup table output register
  LUToutResetRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb_1_2048_0 = '1' THEN
        lutout_reg <= lutout;
      END IF;
    END IF;
  END PROCESS LUToutResetRegister_process;


  LUToutRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      lutoutput_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_2048_0 = '1' THEN
        lutoutput_tmp <= lutout_reg;
      END IF;
    END IF;
  END PROCESS LUToutRegister_process;


  lutoutput <= std_logic_vector(lutoutput_tmp);

END rtl;

