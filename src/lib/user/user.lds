OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
  /* Read-only sections, merged into text segment: */
  
  __executable_start = 0x08048000 + SIZEOF_HEADERS ;
  
   . = 0x08048000 + SIZEOF_HEADERS;
  .text : { *(.text) } = 0x90
  .rodata : { *(.rodata) }

  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = ALIGN (0x1000) - ((0x1000 - .) & (0x1000 - 1)); 
  . = DATA_SEGMENT_ALIGN (0x1000, 0x1000);

  .data : { *(.data) }
/*  .bss : { *(.bss) *(.testEndmem) } */
/* DEH 
   added *(COMMON) which will force uninitialized global variables to be placed in the .bss
   section before the .testEndmem section (which is dst, defined in boundary.c, and must be
   placed at the end of the .bss section).  The ony variable that seemed to mess this up is 
   test_name, defined in lib.c .
*/
  .bss : { *(.bss) *(COMMON) *(.testEndmem) }

  /* Stabs debugging sections.  */
  .stab          0 : { *(.stab) }
  .stabstr       0 : { *(.stabstr) }
  .stab.excl     0 : { *(.stab.excl) }
  .stab.exclstr  0 : { *(.stab.exclstr) }
  .stab.index    0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment       0 : { *(.comment) }

  /* DWARF debug sections.
  Symbols in the DWARF debugging sections are relative to the beginning
  of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames  0 : { *(.debug_varnames) }
  /DISCARD/ : { *(.note.GNU-stack) }
  /DISCARD/ : { *(.eh_frame) }
}
