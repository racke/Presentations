=Entwicklung gro�er Perlanwendungen am Beispiel von Interchange

==Autor

Stefan Hornburg (Racke) \C<<racke@linuxia.de>>

==Abstract

Interchange ist die f�hrende Open-Source-Software f�r eCommerce und wird
ebenfalls als Datenbankfrontend oder CMS eingesetzt. Interchange ist
komplett in Perl implementiert und nutzt zahlreiche Module aus dem CPAN.   
Der Einsatz von Perl erlaubt ein gro�es Ma� an Flexibilit�t, ohne die
Performance entscheidend zu beeintr�chtigen. 

Dieser Vortrag von einem leitenden Interchange-Programmierer berichtet �ber
die Erfahrungen und Probleme, die im Verlaufe des 8-j�hrigen
Entwicklungsprozesses gesammelt wurden.

==Kolloboration

Gr��ere Programmierprojekte werden h�ufig als Teamwork durchgef�hrt.
Die Zusammenarbeit der einzelnen Mitglieder ist ein wichtiger Aspekt.

==Versionsverwaltung

==Testsuite

==Module

===Externe Module

Die Verwendung von externen Module verk�rzt oftmals die Entwicklungszeit,
es sind jedoch einige Punkte zu bedenken.

Gerade wenn Benutzer gew�hnlich die Software selbst in ihrer Perlumgebung
installieren, kann es Schwierigkeiten geben, wenn die Module ihre
Schnittstellen �ndern.

Ein typisches Beispiel f�r so ein Problem waren �nderungen in
SQL::Statement, die zu Fehlern bei Interchanges internen SQL-Parser
gef�hrt haben. Letztendlich wurde SQL::Statement durch ein eigenes
Interchange-Modul Vend::SQL_Parser ersetzt.

===Interne Module

==Flexibilit�t

Gro�e Anwendungen sollte ein hohes Ma� an Flexibilit�t ausweisen, um
dem Benutzer weitgehende Konfigurations- und Erweiterungsm�glichkeiten
zu geben.

Interchange bietet dazu u.a. die folgenden M�glichkeiten:

* eigene Usertags

* eigene Paymentmodule

==Performance

==Portierungsprobleme

==Grundregeln

Die Beitr�ge werden durch uns konvertiert und als je ein Kapitel
eines LateX-Gesamt\-Dokumentes eingebunden. Damit sich alle Beitr�ge
zusammenf�gen, hier die wichtigsten Hinweise.

* Der Beitrag ist eine Datei \I<article_AUTORK�RZEL.pp>

* Der Beitrag beginnt mit

<<EOC
       =Artikelthema�berschrift
EOC

* Alle anderen �berschriften sind mindestens eine �berchriftenebene
  tiefer, also


<<EOC
       ==�berschrift
EOC


* Wir liefern eine LaTeX-Umgebung zum Testen mit, in welcher der
konvertierte Text funktionieren mu�. Die Rahmendatei ist \I<main.tex>,
welche den nach LaTeX konvertierten Artikel importiert und strukturell
die letztendliche LaTeX-Umgebung simuliert. Um die PerlPoint-Datei zu
konvertieren, wird von uns folgendes Kommando (ohne den Zeilenumbruch)
verwendet:

<<EOC
       pp2latex --prolog=prolog.inc article_racke.pp
         | perl filter.pl > article_racke.tex
EOC

* Labels f�r Verweise, Bibliographie-Eintr�ge, m�ssen mit
einem eindeutigen Pr�fix versehen werden, z.B. mit dem
AUTORENK�RZEL. Im vorliegenden Beispielartikel wird durchg�ngig
\C<racke> verwendet. 

* Zus�tzliche Dateien (z.B. Grafiken) m�ssen in genau einem getrennten
Unterverzeichnis abgelegt werden, z.B. bestehend aus dem
Autorenk�rzel. Im vorliegenden Beispielartikel wurde \C<racke>
verwendet.

Der vorliegende Artikel dient als Beispiel f�r einen korrekten Artikel
und demonstriert wichtige PerlPoint-Elemente.

==Sonderzeichen

Einige Zeichen, insbesondere am Zeilenanfang werden normalerweise als
PerlPoint-Anweisungen interpretiert. Sie k�nnen aber durch "Escapen"
direkt im Text dargestellt werden. Dies geschieht durch einen
vorangestellten Backslash.

Die PerlPoint-Kommandos bitte dem Quelltext entnehmen.

:Doppelpunkt:  \:

:Istgleich:  \=

:Stern:  \*

:Gr��erAls:  \>

:KleinerAls:  \<

:Backslash:  \\

:Doppel-Slash: \//

:Tilde:  \~

:AT:  \@

:Gartenzaun: \#

:Fragezeichen: \?


==Index

Im folgenden Abschnitt sind beispielhaft viele W�rter f�r den Index
markiert. Die markierten W�rter werden im Index am Ende des Dokumentes
aufgelistet. F�r die Markierung eines Worts den Index wird folgendes
Kommando verwendet:

<<EOC
       \X<Indexwort>
EOC

* Der \X<Scheik> von \X<Alessandria>, \X<Ali Banu>, war ein
sonderbarer \X<Mann>; wenn er morgens durch die Stra�en der
Stadt ging, angetan mit einem \X<Turban>, aus den
\X<k�stlich>sten \X<Kaschmir>s gewunden, mit dem
\X<Festkleide> und dem reichen \X<G�rtel>, der
\X<f�nfzig> \X<Kamele> wert war, wenn er einherging
langsamen, gravit�tischen Schrittes, seine \X<Stirn>e in
finstere Falten gelegt, seine \X<Augenbrauen> zusammengezogen, die
\X<Augen> niedergeschlagen und alle f�nf Schritte \X<gedankenvoll>
seinen langen, schwarzen Bart streichend; wenn er so hinging nach der
\X<Moschee>, um, wie es seine \X<W�rde> forderte, den \X<Gl�ubige>n
\X<Vorlesungen> �ber den \X<Koran> zu halten: da blieben die Leute auf
der Stra�e stehen, schauten ihm nach und sprachen zueinander: "Es ist
doch ein sch�ner, stattlicher Mann, und reich, ein reicher \X<Herr>",
setzte wohl ein anderer hinzu, "sehr reich; hat er nicht ein
\X<Schlo�> am \X<Hafen von Stambul>?  Hat er nicht \X<G�ter> und
\X<Felder> und viele tausend St�ck \X<Vieh> und viele \X<Sklaven>?"

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

Bilder k�nnen f�r ein jeweiliges Ausgabeformat eingebunden
werden. F�r den Tagungsband wird hierf�r LaTeX-Code eingebettet.
Hier ein Bild, in Originalgr��e und zentriert.

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

==Aufz�hlungen

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

# Wilhelm Hauff. \I<M�rchen-Almanach auf das Jahr
1827>. Project Gutenberg, 2003. \C<http://gutenberg.net>.

# Free Software Foundation. \I<GNU's not Unix.> \C<http://www.gnu.org>

# Sabine Mustermann. \I<The Example Manual -
Doing by Learning.> Addison-Snipes, Writing, Massachusetts, 1991.

# D. E. Knudson. \I<1966 World Gnus Almanac.>

# Charles Zomtec, Inc. \I<Zomtec.> Green Bottle, Oregon, 2001.

# German Perl Workshop. \I<German Perl Workshop Website.>
\C<http://www.perlworkshop.de>


