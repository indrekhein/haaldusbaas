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

  return transcribe_en ($word) if $language eq 'en';
  return transcribe_fi ($word) if $language eq 'fi';
  return transcribe_de ($word) if $language eq 'de';
  return transcribe_xx ($word);
}

sub transcribe_en {
  my $w = shift;
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

# additional rules for phenomena that tend to pop up regardless of language
sub transcribe_xx {
  my $w = shift;

  $w =~ tr/æ/ä/;
  
  $w =~ s/sch/š/gi;
  $w =~ s/sh/š/gi;
  $w =~ s/^kh/h/i;

  return $w;
}

