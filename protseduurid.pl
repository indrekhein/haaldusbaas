# sisse eeldatav käändelõpp
# välja 0 kui lõpp ei sobi, 1 kui sobib. 1 asemel võib olla ka täpsustav
# 'C' või 'V' kui häälduselt eeldatakse vastavalt konsonant- või vokaallõppu

sub on_kaandelopp {
  my ($lopp) = @_;

  # sidekriipsuga
  # NATO-sse, ÜRO-d, 3-sid
  return 1 if $lopp =~ /^\-(d|t|sse|s|st|le|l|lt|ks|ni|na|ta|ga|sid)$/o;
  return 1 if $lopp =~ /^\-(de|te)(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;

  # ülakomaga
  # kõige prostam omastav, tüve alusel ei saa otsustada
  # Marat', Andrew'ga
  return 'V' if $lopp =~ /^(\')(d|sse|s|st|le|l|lt|ks|ni|na|ta|ga|sid)?$/o;
  return 'V' if $lopp =~ /^(\'de)(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;
  
  # Anne'i (aga vabalt ka Bastille'i)
  return 'C' if $lopp =~ /^(\'1)(sse|s|st|le|l|lt|ks|ni|na|ta|ga|d|sid)?$/o;
  return 'C' if $lopp =~ /^(\'ide)(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;
  # Constable'eid, Drake'e, performance'eid
  return 'C' if  $lopp =~ /^\'e(id)?$/o;
  
  # "tavalised" käändelõpud
  # Mary, Maryt, EMOsse, ...
  return 'V' if $lopp =~ /^(t|sse|s|st|le|l|lt|ks|ni|na|ta|ga|d|sid)?$/o;
  return 'V' if $lopp =~ /^(de)(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;
  # John, Johni, ...
  # Barkereid, Barkeritega, ...
  return 'C' if $lopp =~ /^eid$/o;
  return 'C' if $lopp =~ /^(i)(sse|s|st|le|l|lt|ks|ni|na|ta|ga|d|sid)?$/o;
  return 'C' if $lopp =~ /^i[td]e(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;
  # harvemad juhud on e-, a- ja u-lõpulise omastavaga
  # Egiptuse, Cedricuga
  return 'C' if $lopp =~ /^(u)id$/o;
  return 'C' if $lopp =~ /^(e|u)(sse|s|st|le|l|lt|ks|ni|na|ta|ga|d)?$/o;
  return 'C' if $lopp =~ /^(u)?te(sse|s|st|le|l|lt|ks|ni|na|ta|ga)?$/o;

  return 0;
}
