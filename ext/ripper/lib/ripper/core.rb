# This file is automatically generated from core.rb.in and parse.y.
# DO NOT MODIFY!!!!!!

#
# ripper/core.rb
#
# Copyright (C) 2003,2004 Minero Aoki
#
# This program is free software.
# You can distribute and/or modify this program under the Ruby License.
# For details of Ruby License, see ruby/COPYING.
#

require 'ripper.so'

class Ripper
  # Parses Ruby program read from _src_.
  # _src_ must be a String or a IO or a object which has #gets method.
  def Ripper.parse(src, filename = '(ripper)', lineno = 1)
    new(src, filename, lineno).parse
  end

  # This table contains name of parser events and its arity.
  PARSER_EVENT_TABLE = {
    :BEGIN => 1,
    :END => 1,
    :alias => 2,
    :alias_error => 1,
    :aref => 2,
    :aref_field => 2,
    :arg_ambiguous => 0,
    :arg_paren => 1,
    :arglist_add => 2,
    :arglist_add_block => 2,
    :arglist_add_star => 2,
    :arglist_new => 0,
    :arglist_prepend => 2,
    :array => 1,
    :assign => 2,
    :assign_error => 1,
    :assoc_new => 2,
    :assoclist_from_args => 1,
    :bare_assoc_hash => 1,
    :begin => 1,
    :binary => 3,
    :blockvar_add_block => 2,
    :blockvar_add_star => 2,
    :blockvar_new => 1,
    :bodystmt => 4,
    :brace_block => 2,
    :break => 1,
    :call => 3,
    :case => 2,
    :class => 3,
    :class_name_error => 1,
    :command => 2,
    :command_call => 4,
    :const_ref => 1,
    :constpath_field => 2,
    :constpath_ref => 2,
    :def => 3,
    :defined => 1,
    :defs => 5,
    :do_block => 2,
    :dot2 => 2,
    :dot3 => 2,
    :dyna_symbol => 1,
    :else => 1,
    :elsif => 3,
    :ensure => 1,
    :fcall => 1,
    :field => 3,
    :for => 3,
    :hash => 1,
    :if => 3,
    :if_mod => 2,
    :ifop => 3,
    :iter_block => 2,
    :massign => 2,
    :method_add_arg => 2,
    :mlhs_add => 2,
    :mlhs_add_star => 2,
    :mlhs_new => 0,
    :mlhs_paren => 1,
    :module => 2,
    :mrhs_add => 2,
    :mrhs_add_star => 2,
    :mrhs_new => 0,
    :mrhs_new_from_arglist => 1,
    :next => 1,
    :opassign => 3,
    :param_error => 1,
    :params => 4,
    :paren => 1,
    :parse_error => 1,
    :program => 1,
    :qwords_add => 2,
    :qwords_new => 0,
    :redo => 0,
    :regexp_literal => 1,
    :rescue => 4,
    :rescue_mod => 2,
    :restparam => 1,
    :retry => 0,
    :return => 1,
    :return0 => 0,
    :sclass => 2,
    :space => 1,
    :stmts_add => 2,
    :stmts_new => 0,
    :string_add => 2,
    :string_concat => 2,
    :string_content => 0,
    :string_dvar => 1,
    :string_embexpr => 1,
    :string_literal => 1,
    :super => 1,
    :symbol => 1,
    :symbol_literal => 1,
    :topconst_field => 1,
    :topconst_ref => 1,
    :unary => 2,
    :undef => 1,
    :unless => 3,
    :unless_mod => 2,
    :until => 2,
    :until_mod => 2,
    :var_alias => 2,
    :var_field => 1,
    :var_ref => 1,
    :void_stmt => 0,
    :when => 3,
    :while => 2,
    :while_mod => 2,
    :word_add => 2,
    :word_new => 0,
    :words_add => 2,
    :words_new => 0,
    :xstring_add => 2,
    :xstring_literal => 1,
    :xstring_new => 0,
    :yield => 1,
    :yield0 => 0,
    :zsuper => 0
  }

  # This array contains name of parser events.
  PARSER_EVENTS = PARSER_EVENT_TABLE.keys

  # This table contains name of scanner events and its arity
  # (arity is always 1 for all scanner events).
  SCANNER_EVENT_TABLE = {
    :CHAR => 1,
    :__end__ => 1,
    :backref => 1,
    :backtick => 1,
    :comma => 1,
    :comment => 1,
    :const => 1,
    :cvar => 1,
    :embdoc => 1,
    :embdoc_beg => 1,
    :embdoc_end => 1,
    :embexpr_beg => 1,
    :embexpr_end => 1,
    :embvar => 1,
    :float => 1,
    :gvar => 1,
    :heredoc_beg => 1,
    :heredoc_end => 1,
    :ident => 1,
    :ignored_nl => 1,
    :int => 1,
    :ivar => 1,
    :kw => 1,
    :lbrace => 1,
    :lbracket => 1,
    :lparen => 1,
    :nl => 1,
    :op => 1,
    :period => 1,
    :qwords_beg => 1,
    :rbrace => 1,
    :rbracket => 1,
    :regexp_beg => 1,
    :regexp_end => 1,
    :rparen => 1,
    :semicolon => 1,
    :sp => 1,
    :symbeg => 1,
    :tstring_beg => 1,
    :tstring_content => 1,
    :tstring_end => 1,
    :words_beg => 1,
    :words_sep => 1
  }

  # This array contains name of scanner events.
  SCANNER_EVENTS = SCANNER_EVENT_TABLE.keys

  # This table contains name of all ripper events.
  EVENTS = PARSER_EVENTS + SCANNER_EVENTS

  ###                ###
  ### Event Handlers ###
  ###                ###

  private

  # This method is called when weak warning is produced by the parser.
  # _fmt_ and _args_ is printf style.
  def warn(fmt, *args)
  end

  # This method is called when strong warning is produced by the parser.
  # _fmt_ and _args_ is printf style.
  def warning(fmt, *args)
  end

  # This method is called when the parser found syntax error.
  def compile_error(msg)
  end

  #
  # Parser Events
  #

  def on_BEGIN(a)
    a
  end

  def on_END(a)
    a
  end

  def on_alias(a, b)
    a
  end

  def on_alias_error(a)
    a
  end

  def on_aref(a, b)
    a
  end

  def on_aref_field(a, b)
    a
  end

  def on_arg_ambiguous
    nil
  end

  def on_arg_paren(a)
    a
  end

  def on_arglist_add(a, b)
    a
  end

  def on_arglist_add_block(a, b)
    a
  end

  def on_arglist_add_star(a, b)
    a
  end

  def on_arglist_new
    nil
  end

  def on_arglist_prepend(a, b)
    a
  end

  def on_array(a)
    a
  end

  def on_assign(a, b)
    a
  end

  def on_assign_error(a)
    a
  end

  def on_assoc_new(a, b)
    a
  end

  def on_assoclist_from_args(a)
    a
  end

  def on_bare_assoc_hash(a)
    a
  end

  def on_begin(a)
    a
  end

  def on_binary(a, b, c)
    a
  end

  def on_blockvar_add_block(a, b)
    a
  end

  def on_blockvar_add_star(a, b)
    a
  end

  def on_blockvar_new(a)
    a
  end

  def on_bodystmt(a, b, c, d)
    a
  end

  def on_brace_block(a, b)
    a
  end

  def on_break(a)
    a
  end

  def on_call(a, b, c)
    a
  end

  def on_case(a, b)
    a
  end

  def on_class(a, b, c)
    a
  end

  def on_class_name_error(a)
    a
  end

  def on_command(a, b)
    a
  end

  def on_command_call(a, b, c, d)
    a
  end

  def on_const_ref(a)
    a
  end

  def on_constpath_field(a, b)
    a
  end

  def on_constpath_ref(a, b)
    a
  end

  def on_def(a, b, c)
    a
  end

  def on_defined(a)
    a
  end

  def on_defs(a, b, c, d, e)
    a
  end

  def on_do_block(a, b)
    a
  end

  def on_dot2(a, b)
    a
  end

  def on_dot3(a, b)
    a
  end

  def on_dyna_symbol(a)
    a
  end

  def on_else(a)
    a
  end

  def on_elsif(a, b, c)
    a
  end

  def on_ensure(a)
    a
  end

  def on_fcall(a)
    a
  end

  def on_field(a, b, c)
    a
  end

  def on_for(a, b, c)
    a
  end

  def on_hash(a)
    a
  end

  def on_if(a, b, c)
    a
  end

  def on_if_mod(a, b)
    a
  end

  def on_ifop(a, b, c)
    a
  end

  def on_iter_block(a, b)
    a
  end

  def on_massign(a, b)
    a
  end

  def on_method_add_arg(a, b)
    a
  end

  def on_mlhs_add(a, b)
    a
  end

  def on_mlhs_add_star(a, b)
    a
  end

  def on_mlhs_new
    nil
  end

  def on_mlhs_paren(a)
    a
  end

  def on_module(a, b)
    a
  end

  def on_mrhs_add(a, b)
    a
  end

  def on_mrhs_add_star(a, b)
    a
  end

  def on_mrhs_new
    nil
  end

  def on_mrhs_new_from_arglist(a)
    a
  end

  def on_next(a)
    a
  end

  def on_opassign(a, b, c)
    a
  end

  def on_param_error(a)
    a
  end

  def on_params(a, b, c, d)
    a
  end

  def on_paren(a)
    a
  end

  def on_parse_error(a)
    a
  end

  def on_program(a)
    a
  end

  def on_qwords_add(a, b)
    a
  end

  def on_qwords_new
    nil
  end

  def on_redo
    nil
  end

  def on_regexp_literal(a)
    a
  end

  def on_rescue(a, b, c, d)
    a
  end

  def on_rescue_mod(a, b)
    a
  end

  def on_restparam(a)
    a
  end

  def on_retry
    nil
  end

  def on_return(a)
    a
  end

  def on_return0
    nil
  end

  def on_sclass(a, b)
    a
  end

  def on_space(a)
    a
  end

  def on_stmts_add(a, b)
    a
  end

  def on_stmts_new
    nil
  end

  def on_string_add(a, b)
    a
  end

  def on_string_concat(a, b)
    a
  end

  def on_string_content
    nil
  end

  def on_string_dvar(a)
    a
  end

  def on_string_embexpr(a)
    a
  end

  def on_string_literal(a)
    a
  end

  def on_super(a)
    a
  end

  def on_symbol(a)
    a
  end

  def on_symbol_literal(a)
    a
  end

  def on_topconst_field(a)
    a
  end

  def on_topconst_ref(a)
    a
  end

  def on_unary(a, b)
    a
  end

  def on_undef(a)
    a
  end

  def on_unless(a, b, c)
    a
  end

  def on_unless_mod(a, b)
    a
  end

  def on_until(a, b)
    a
  end

  def on_until_mod(a, b)
    a
  end

  def on_var_alias(a, b)
    a
  end

  def on_var_field(a)
    a
  end

  def on_var_ref(a)
    a
  end

  def on_void_stmt
    nil
  end

  def on_when(a, b, c)
    a
  end

  def on_while(a, b)
    a
  end

  def on_while_mod(a, b)
    a
  end

  def on_word_add(a, b)
    a
  end

  def on_word_new
    nil
  end

  def on_words_add(a, b)
    a
  end

  def on_words_new
    nil
  end

  def on_xstring_add(a, b)
    a
  end

  def on_xstring_literal(a)
    a
  end

  def on_xstring_new
    nil
  end

  def on_yield(a)
    a
  end

  def on_yield0
    nil
  end

  def on_zsuper
    nil
  end

  #
  # Lexer Events
  #

  def on_CHAR(token)
    token
  end

  def on___end__(token)
    token
  end

  def on_backref(token)
    token
  end

  def on_backtick(token)
    token
  end

  def on_comma(token)
    token
  end

  def on_comment(token)
    token
  end

  def on_const(token)
    token
  end

  def on_cvar(token)
    token
  end

  def on_embdoc(token)
    token
  end

  def on_embdoc_beg(token)
    token
  end

  def on_embdoc_end(token)
    token
  end

  def on_embexpr_beg(token)
    token
  end

  def on_embexpr_end(token)
    token
  end

  def on_embvar(token)
    token
  end

  def on_float(token)
    token
  end

  def on_gvar(token)
    token
  end

  def on_heredoc_beg(token)
    token
  end

  def on_heredoc_end(token)
    token
  end

  def on_ident(token)
    token
  end

  def on_ignored_nl(token)
    token
  end

  def on_int(token)
    token
  end

  def on_ivar(token)
    token
  end

  def on_kw(token)
    token
  end

  def on_lbrace(token)
    token
  end

  def on_lbracket(token)
    token
  end

  def on_lparen(token)
    token
  end

  def on_nl(token)
    token
  end

  def on_op(token)
    token
  end

  def on_period(token)
    token
  end

  def on_qwords_beg(token)
    token
  end

  def on_rbrace(token)
    token
  end

  def on_rbracket(token)
    token
  end

  def on_regexp_beg(token)
    token
  end

  def on_regexp_end(token)
    token
  end

  def on_rparen(token)
    token
  end

  def on_semicolon(token)
    token
  end

  def on_sp(token)
    token
  end

  def on_symbeg(token)
    token
  end

  def on_tstring_beg(token)
    token
  end

  def on_tstring_content(token)
    token
  end

  def on_tstring_end(token)
    token
  end

  def on_words_beg(token)
    token
  end

  def on_words_sep(token)
    token
  end
end
