/**********************************************************************

  main.c -

  $Author$
  $Date$
  created at: Fri Aug 19 13:19:58 JST 1994

  Copyright (C) 1993-2007 Yukihiro Matsumoto

**********************************************************************/

#undef RUBY_EXPORT
#include "ruby/ruby.h"
#include <locale.h>

RUBY_GLOBAL_SETUP

int
main(int argc, char **argv, char **envp)
{
#ifdef RUBY_DEBUG_ENV
    extern void ruby_set_debug_option(const char *);
    ruby_set_debug_option(getenv("RUBY_DEBUG"));
#endif
    setlocale(LC_CTYPE, "");

    ruby_sysinit(&argc, &argv);
    {
	RUBY_INIT_STACK;
	ruby_init();
	return ruby_run_node(ruby_options(argc, argv));
    }
}
