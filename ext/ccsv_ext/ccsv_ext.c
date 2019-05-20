#include <limits.h>
#include "ccsv_ext.h"

static VALUE rb_cC;

/* Ccsv.parse_line(string ,delimiter) */

#define MAX_INTERVALS 1024

static VALUE parse_line(VALUE self, VALUE str, VALUE delimiter) {
  char *line = RSTRING_PTR(str);
  char *delim = RSTRING_PTR(delimiter);
  int len = RSTRING_LEN(str);
  char token[MAX_INTERVALS * 5];

  /* chomp! */
  if(line[len] == EOL){
    if(line[len-1] == CR)
      len -= 1;
    line[len] = '\0';
  }

  VALUE ary = rb_ary_new();

  /* skip empty line */
  if (len < 2) {
    return ary;
  }

  int i = 0;
  long pos = 0;
  int has_quote = 0;

  do {
    token[pos++] = line[i];
    if (!has_quote && (line[i] == delim[0] || line[i] == EOL)) {
      token[pos - 1] = 0;
      rb_ary_push(ary, rb_enc_str_new(&token[0], strlen(&token[0]), rb_utf8_encoding()));
      pos = 0;
      memset(token, 0, sizeof(token));
    }
    if (line[i] == QUOTE && line[i + 1] != QUOTE) {
      pos--;
      has_quote = !has_quote;
    }
    if (line[i] == QUOTE && line[i + 1] == QUOTE) {
      if (!has_quote && line[i + 2] == delim[0])
        token[pos - 1] = 0;
      i++;
    }
  } while (line[++i]);

  if (line[i - 1] == delim[0])
    rb_ary_push(ary, rb_str_new2(""));
  else if (line[i - 1] == QUOTE) {
    token[pos] = 0;
    rb_ary_push(ary, rb_enc_str_new(&token[0], strlen(&token[0]), rb_utf8_encoding()));
  }
  else if (line[i - 1] != EOL)
    rb_ary_push(ary, rb_enc_str_new(&token[0], strlen(&token[0]), rb_utf8_encoding()));

  rb_ary_dup(ary);
}

void
Init_ccsv_ext()
{
  rb_cC = rb_define_class("CcsvExt", rb_cObject);
  rb_define_singleton_method(rb_cC, "parse_line", parse_line, 2);
}
