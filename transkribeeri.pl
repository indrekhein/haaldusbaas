#!/usr/bin/perl

sub transkribeeri {
  my ($self, $word, $language) = @_;
  $language = lc $language;
  $language =~ tr/a-z-//cd;
  $language = $` if $language =~ /\-/;

  # cleaning up the input should be caller's responsibility
  # we accept letters, dash and apostrophe only
  $word =~ s/[^\pL\-\']//g;

  return 'Mäk' . transcribe_en ($1) if $word =~ /^Ma?c(\p{Lu}.*)/;
  return 'Ou ' . transcribe_en ($1) if $word =~ /^O\'(\p{Lu}.*)/;

  # we no longer need uppercase distinction (output is all lowercase)
  # and leave it free for keeping track what is already replaced 
  $word = lc $word;

  return transcribe_en ($word) if $language eq 'en';
  return transcribe_fi ($word) if $language eq 'fi';
  return transcribe_de ($word) if $language eq 'de';
  return transcribe_cn ($word) if $language eq 'cn';
  return transcribe_xx ($word);
}

sub transcribe_en {
  my $w = shift;
  $w =~ s/zz/ZZ/gi;
  return transcribe_xx($w);
}

sub transcribe_fi {
  my $w = shift;
  $w =~ s/y/ü/gi;
  return transcribe_xx($w);
}

sub transcribe_de {
  my $w = shift;
  $w =~ s/([aeiouü])h([nr])/$1$1$2/gi;
  return transcribe_xx($w);
}

sub transcribe_cn {
  my $w = shift;
  $w =~ s/ei/EI/g;
  $w =~ s/ie/IE/g;
  $w =~ s/i([aeiou])/J$1/g;
  $w =~ s/(c|ch|sh|z|zh)i/$1Õ/g;
  $w =~ s/e/Õ/g;
  $w =~ s/ao/AU/g;
  $w =~ s/ju/TSÜ/g;
  $w =~ s/xu/ŠÜ/g;
  $w =~ s/qu/TSHÜ/g;
  $w =~ s/yu/JÜ/g;
  $w =~ s/wu/U/g;
  $w =~ s/ong/UNG/g;
  $w =~ s/ng/NG/g;
  $w =~ s/sh/Š/g;
  $w =~ s/zh/TŠ/g;
  $w =~ s/ch/TŠH/g;
  $w =~ s/j/TS/g;
  $w =~ s/q/TSH/g;
  $w =~ s/c/TSH/g;
  $w =~ s/z/TS/g;
  $w =~ s/x/S/g;
  $w =~ s/[kpt]/$&H/;
  $w =~ s/r/Ž/g;
  $w =~ s/y/J/g;
  return transcribe_xx(lc $w);
}


# additional rules for phenomena that tend to pop up regardless of language
sub transcribe_xx {
  my $w = shift;

  $w =~ tr/æø/äö/;
  $w =~ s/å/oo/gi;

  $w =~ s/ć/tš/gi;
  $w =~ s/sch/š/gi;
  $w =~ s/sh/š/gi;
  $w =~ s/^kh/h/i;

  $w =~ s/zz/ts/i;

  return $w;
}

