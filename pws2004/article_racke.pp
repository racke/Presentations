=Entwicklung großer Perlanwendungen am Beispiel von Interchange

==Autor

Stefan Hornburg (Racke) \C<<racke@linuxia.de>>

==Abstract

Interchange ist die führende Open-Source-Software für eCommerce und wird
ebenfalls als Datenbankfrontend oder CMS eingesetzt. Interchange ist
komplett in Perl implementiert und nutzt zahlreiche Module aus dem CPAN.   
Der Einsatz von Perl erlaubt ein großes Maß an Flexibilität, ohne die
Performance entscheidend zu beeinträchtigen. 

Dieser Vortrag von einem leitenden Interchange-Programmierer berichtet über
die Erfahrungen und Probleme, die im Verlaufe des 8-jährigen
Entwicklungsprozesses gesammelt wurden.

==Kolloboration

Größere Programmierprojekte werden häufig als Teamwork durchgeführt.
Die Zusammenarbeit der einzelnen Mitglieder ist ein wichtiger Aspekt.

==Versionsverwaltung

==Testsuite

==Module

===Externe Module

Die Verwendung von externen Module verkürzt oftmals die Entwicklungszeit,
es sind jedoch einige Punkte zu bedenken.

Gerade wenn Benutzer gewöhnlich die Software selbst in ihrer Perlumgebung
installieren, kann es Schwierigkeiten geben, wenn die Module ihre
Schnittstellen ändern.

Ein typisches Beispiel für so ein Problem waren Änderungen in
SQL::Statement, die zu Fehlern bei Interchanges internen SQL-Parser
geführt haben. Letztendlich wurde SQL::Statement durch ein eigenes
Interchange-Modul Vend::SQL_Parser ersetzt.

===Interne Module

==Flexibilität

Große Anwendungen sollte ein hohes Maß an Flexibilität ausweisen, um
dem Benutzer weitgehende Konfigurations- und Erweiterungsmöglichkeiten
zu geben.

Interchange bietet dazu u.a. die folgenden Möglichkeiten:

* eigene Usertags

* eigene Paymentmodule

==Performance

==Portierungsprobleme

==Grundregeln

Die Beiträge werden durch uns konvertiert und als je ein Kapitel
eines LateX-Gesamt\-Dokumentes eingebunden. Damit sich alle Beiträge
zusammenfügen, hier die wichtigsten Hinweise.

* Der Beitrag ist eine Datei \I<article_AUTORKÜRZEL.pp>

* Der Beitrag beginnt mit

<<EOC
       =Artikelthemaüberschrift
EOC

* Alle anderen Überschriften sind mindestens eine Überchriftenebene
  tiefer, also


<<EOC
       ==Überschrift
EOC


* Wir liefern eine LaTeX-Umgebung zum Testen mit, in welcher der
konvertierte Text funktionieren muß. Die Rahmendatei ist \I<main.tex>,
welche den nach LaTeX konvertierten Artikel importiert und strukturell
die letztendliche LaTeX-Umgebung simuliert. Um die PerlPoint-Datei zu
konvertieren, wird von uns folgendes Kommando (ohne den Zeilenumbruch)
verwendet:

<<EOC
       pp2latex --prolog=prolog.inc article_racke.pp
         | perl filter.pl > article_racke.tex
EOC

* Labels für Verweise, Bibliographie-Einträge, müssen mit
einem eindeutigen Präfix versehen werden, z.B. mit dem
AUTORENKÜRZEL. Im vorliegenden Beispielartikel wird durchgängig
\C<racke> verwendet. 

* Zusätzliche Dateien (z.B. Grafiken) müssen in genau einem getrennten
Unterverzeichnis abgelegt werden, z.B. bestehend aus dem
Autorenkürzel. Im vorliegenden Beispielartikel wurde \C<racke>
verwendet.

Der vorliegende Artikel dient als Beispiel für einen korrekten Artikel
und demonstriert wichtige PerlPoint-Elemente.

==Sonderzeichen

Einige Zeichen, insbesondere am Zeilenanfang werden normalerweise als
PerlPoint-Anweisungen interpretiert. Sie können aber durch "Escapen"
direkt im Text dargestellt werden. Dies geschieht durch einen
vorangestellten Backslash.

Die PerlPoint-Kommandos bitte dem Quelltext entnehmen.

:Doppelpunkt:  \:

:Istgleich:  \=

:Stern:  \*

:GrößerAls:  \>

:KleinerAls:  \<

:Backslash:  \\

:Doppel-Slash: \//

:Tilde:  \~

:AT:  \@

:Gartenzaun: \#

:Fragezeichen: \?


==Index

Im folgenden Abschnitt sind beispielhaft viele Wörter für den Index
markiert. Die markierten Wörter werden im Index am Ende des Dokumentes
aufgelistet. Für die Markierung eines Worts den Index wird folgendes
Kommando verwendet:

<<EOC
       \X<Indexwort>
EOC

* Der \X<Scheik> von \X<Alessandria>, \X<Ali Banu>, war ein
sonderbarer \X<Mann>; wenn er morgens durch die Straßen der
Stadt ging, angetan mit einem \X<Turban>, aus den
\X<köstlich>sten \X<Kaschmir>s gewunden, mit dem
\X<Festkleide> und dem reichen \X<Gürtel>, der
\X<fünfzig> \X<Kamele> wert war, wenn er einherging
langsamen, gravitätischen Schrittes, seine \X<Stirn>e in
finstere Falten gelegt, seine \X<Augenbrauen> zusammengezogen, die
\X<Augen> niedergeschlagen und alle fünf Schritte \X<gedankenvoll>
seinen langen, schwarzen Bart streichend; wenn er so hinging nach der
\X<Moschee>, um, wie es seine \X<Würde> forderte, den \X<Gläubige>n
\X<Vorlesungen> über den \X<Koran> zu halten: da blieben die Leute auf
der Straße stehen, schauten ihm nach und sprachen zueinander: "Es ist
doch ein schöner, stattlicher Mann, und reich, ein reicher \X<Herr>",
setzte wohl ein anderer hinzu, "sehr reich; hat er nicht ein
\X<Schloß> am \X<Hafen von Stambul>?  Hat er nicht \X<Güter> und
\X<Felder> und viele tausend Stück \X<Vieh> und viele \X<Sklaven>?"

==Tabelle

@|
Sprache   | Eine Nummer  | Weiter Zahlen | Noch etwas
Perl      | 1.0          | 2.1           | 3.2
Python    | 4            | 5             | 6
Ruby      | 7            | 8             | 9

==verbatim

Ein schicke Zahlenkolonne in verbatim:

<<EOC
 040002 45221110
 040002 45221120
 040002 45221160        (!)
 040002 23221110
 040003 45221110
 040003 45221120
 usw.
EOC

==Grafiken

Bilder können für ein jeweiliges Ausgabeformat eingebunden
werden. Für den Tagungsband wird hierfür LaTeX-Code eingebettet.
Hier ein Bild, in Originalgröße und zentriert.

\EMBED{lang=latex}
 \begin{center}
  \includegraphics{racke/hype.eps} % original size
 \end{center}
\END_EMBED

Hier das gleiche Bild, zentriert und auf 25\% der Textbreite skaliert:

\EMBED{lang=latex}
 \begin{center}
  \includegraphics[width=0.25\textwidth]{racke/hype.eps}  % scaled
 \end{center}
\END_EMBED

==Aufzählungen

Sprachen:

# Perl

# Python

# Ruby


Use mehr von diesen:

* strict

* warnings

* diagnostics


==Verbatim Sourcecode

<<EOC
package Lamebrain::Categorization;

use strict;
use warnings;

use Lamebrain::Class;
use base 'Lamebrain::Class';

sub pre_init  {
  my $self   = shift;
  $self->SUPER::pre_init (@_);
  $self->lockfile ('/tmp/lamebrain_categorization.lck');
  $self->verbose (1);
}

sub learn {
  my $self = shift;

  return unless $self->lock;
  my $ds = new LibCPV::Categorizer::DocumentSet
   ({
     show_stats           => $self->dsopts_show_stats,
     filter_min_cpvs      => $self->dsopts_filter_min_cpvs,
     filter_max_cpvs      => $self->dsopts_filter_max_cpvs,
     filter_load_offset   => $self->dsopts_filter_load_offset,
     filter_load_max_docs => $self->dsopts_filter_load_max_docs
    });
  $ds->add_docs_from_dir ($self->opts_learner_docdir);

  my $l = new LibCPV::Categorizer
   ({
     document_set         => $ds,
     learner_rootdir      => $self->opts_learner_rootdir,
     max_docs_per_learner => $self->opts_max_docs_per_learner,
     ks_params            => {
                              tfidf_weighting =>
                              $self->ksopts_tfidf_weighting,

                              features_kept   =>
                              $self->ksopts_features_kept
                             },
     learner_params       => {
                              threshold       =>
                              $self->learneropts_threshold
                             },
     learner_class        => $self->opts_learner_class
    });
  if ($self->clean_before_learn) {
    my $cmd =
     'rm -fr '.
      $self->opts_learner_rootdir.'/'.$self->opts_learner_class;
    print STDERR $cmd."\n" if $self->verbose;
    system ($cmd);
  }
  print STDERR "Learn, Forrest, learn ...!\n" if $self->verbose;
  $l->train;
  $self->unlock;
}

1;
EOC

==Bibliographie

# Wilhelm Hauff. \I<Märchen-Almanach auf das Jahr
1827>. Project Gutenberg, 2003. \C<http://gutenberg.net>.

# Free Software Foundation. \I<GNU's not Unix.> \C<http://www.gnu.org>

# Sabine Mustermann. \I<The Example Manual -
Doing by Learning.> Addison-Snipes, Writing, Massachusetts, 1991.

# D. E. Knudson. \I<1966 World Gnus Almanac.>

# Charles Zomtec, Inc. \I<Zomtec.> Green Bottle, Oregon, 2001.

# German Perl Workshop. \I<German Perl Workshop Website.>
\C<http://www.perlworkshop.de>


