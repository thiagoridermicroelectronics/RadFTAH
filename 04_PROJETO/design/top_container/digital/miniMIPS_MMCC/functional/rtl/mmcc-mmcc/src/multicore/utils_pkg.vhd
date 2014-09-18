-- =================================================================================
-- Project          :  MIPS Multi-core
-- FileName         :  utils_pkg.vhd
-- FileType         :  VHDL - Source code
-- Author           :  Jorge Tortato Junior, UFPR
-- Reviewer         :  -x-x-x-x-
-- Version          :  0.1 from 21/oct/2008
-- 
-- Information      :  Synthesis : -x-x-x-x-
--                     Simulator : ModelSim
-- 
-- ---------------------------------------------------------------------------------
-- >>>  Proprietary Information                                                  <<<
-- =================================================================================

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

package utils_pkg is

   -- Types
   type slv32vec is array (natural range <>) of std_logic_vector(31 downto 0);
   type slv31vec is array (natural range <>) of std_logic_vector(30 downto 0);
   type slv30vec is array (natural range <>) of std_logic_vector(29 downto 0);
   type slv29vec is array (natural range <>) of std_logic_vector(28 downto 0);
   type slv28vec is array (natural range <>) of std_logic_vector(27 downto 0);
   type slv27vec is array (natural range <>) of std_logic_vector(26 downto 0);
   type slv26vec is array (natural range <>) of std_logic_vector(25 downto 0);
   type slv25vec is array (natural range <>) of std_logic_vector(24 downto 0);
   type slv24vec is array (natural range <>) of std_logic_vector(23 downto 0);
   type slv23vec is array (natural range <>) of std_logic_vector(22 downto 0);
   type slv22vec is array (natural range <>) of std_logic_vector(21 downto 0);
   type slv21vec is array (natural range <>) of std_logic_vector(20 downto 0);
   type slv20vec is array (natural range <>) of std_logic_vector(19 downto 0);
   type slv19vec is array (natural range <>) of std_logic_vector(18 downto 0);
   type slv18vec is array (natural range <>) of std_logic_vector(17 downto 0);
   type slv17vec is array (natural range <>) of std_logic_vector(16 downto 0);
   type slv16vec is array (natural range <>) of std_logic_vector(15 downto 0);
   type slv15vec is array (natural range <>) of std_logic_vector(14 downto 0);
   type slv14vec is array (natural range <>) of std_logic_vector(13 downto 0);
   type slv13vec is array (natural range <>) of std_logic_vector(12 downto 0);
   type slv12vec is array (natural range <>) of std_logic_vector(11 downto 0);
   type slv11vec is array (natural range <>) of std_logic_vector(10 downto 0);
   type slv10vec is array (natural range <>) of std_logic_vector( 9 downto 0);
   type slv9vec  is array (natural range <>) of std_logic_vector( 8 downto 0);
   type slv8vec  is array (natural range <>) of std_logic_vector( 7 downto 0);
   type slv7vec  is array (natural range <>) of std_logic_vector( 6 downto 0);
   type slv6vec  is array (natural range <>) of std_logic_vector( 5 downto 0);
   type slv5vec  is array (natural range <>) of std_logic_vector( 4 downto 0);
   type slv4vec  is array (natural range <>) of std_logic_vector( 3 downto 0);
   type slv3vec  is array (natural range <>) of std_logic_vector( 2 downto 0);
   type slv2vec  is array (natural range <>) of std_logic_vector( 1 downto 0);
   type slv1vec  is array (natural range <>) of std_logic_vector( 0 downto 0);

   -- find minimum number of bits required to
   -- represent N as an unsigned binary number
   --
   function log2_ceil(N: natural) return natural;

   -- A^B:
   function power(A: integer; B: integer) return integer;
   
   -- find max. number between two
   --
   function max_int(A: integer; B: integer) return integer;

   -- converts std_logic_vector to ASCII
   --
   function std_to_ascii(A: std_logic_vector(7 downto 0)) return character;

   -- Semaphores                                                                                                                                                     
   subtype sem_operation is std_logic_vector(1 downto 0);
   constant SEM_CREATE : sem_operation := "11";
   constant SEM_P : sem_operation := "01";
   constant SEM_V : sem_operation := "10";
   -- Semaphores Table                                                                                                                                               
   constant NUM_SEM : integer := 1024;   -- Amount of available semaphores                                                                                           
   constant SEM_SIZE : integer := 9;    -- Number of bits for each semaphore value                                                                                   
   constant SEM_START_ADDR : integer := 229376 ; -- x38000 -- Initial address for the semaphores
                                                --
   constant SEM_END_ADDR: integer := SEM_START_ADDR+power(2, SEM_SIZE);

    -- Semaphores Table:                                                                                                                                                
    --type sem_type is array (0 to SEM_SIZE) of std_logic ;                                                                                                             
    subtype sem_type is std_logic_vector(SEM_SIZE downto 0);
  
    -- Table entry type                                                                                                                                                 
    type table_item is 
    record 
        valid : std_logic;
        sem_value : sem_type;
    end record;

type table_type is array (natural range 0 to NUM_SEM) of table_item;



end;

package body utils_pkg is
   -- find minimum number of bits required to
   -- represent N as an unsigned binary number
   --
   function log2_ceil(N: natural) return natural is
   begin
      if N < 2 then
         return 0;
      else
         return 1 + log2_ceil(N/2);
      end if;
   end;

   function power(A: integer; B: integer) return integer is
   begin
     if B < 1 then
       return 1;
     else
       return power(A, B-1) * A;
     end if;
   end;
   
   -- find max. number between two
   --
   function max_int(A: integer; B: integer) return integer is
   begin
      if A > B then
         return A;
      else
         return B;
      end if;
   end;

   -- converts std_logic_vector to ASCII
   --
   function std_to_ascii(A: std_logic_vector(7 downto 0)) return character is
   variable ascii_table : string(1 to 256) := (
      nul, soh, stx, etx, eot, enq, ack, bel, 
      bs,  ht,  lf,  vt,  ff,  cr,  so,  si, 
      dle, dc1, dc2, dc3, dc4, nak, syn, etb, 
      can, em,  sub, esc, fsp, gsp, rsp, usp, 

      ' ', '!', '"', '#', '$', '%', '&', ''', 
      '(', ')', '*', '+', ',', '-', '.', '/', 
      '0', '1', '2', '3', '4', '5', '6', '7', 
      '8', '9', ':', ';', '<', '=', '>', '?', 

      '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 
      'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 
      'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 
      'X', 'Y', 'Z', '[', '\', ']', '^', '_', 

      '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 
      'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 
      'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 
      'x', 'y', 'z', '{', '|', '}', '~', del,

      c128, c129, c130, c131, c132, c133, c134, c135,
      c136, c137, c138, c139, c140, c141, c142, c143,
      c144, c145, c146, c147, c148, c149, c150, c151,
      c152, c153, c154, c155, c156, c157, c158, c159,

      -- the character code for 160 is there (NBSP), 
      -- but prints as no char 

      ' ', '¡', '¢', '£', '¤', '¥', '¦', '§',
      '¨', '©', 'ª', '«', '¬', '­', '®', '¯',
      '°', '±', '²', '³', '´', 'µ', '¶', '·',
      '¸', '¹', 'º', '»', '¼', '½', '¾', '¿',

      'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç',
      'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï',
      'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', '×',
      'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß',

      'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç',
      'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï',
      'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷',
      'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ' );
   begin
      return ascii_table(conv_integer(A) + 1); 
   end;

end;
