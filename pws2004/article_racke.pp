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

==Interchange

Interchange ist eine fast ausschlie�lich in Perl programmierte 
Open-Source-Software, die sich von einem minimalen Warenkorb zu einem
ausgewachsenen Applikationsserver entwickelt hat. Gleichzeitig ist
das Entwicklungsteam von einer One-Man-Show auf eine weltweit vertretende
Gruppe (\X<ICDEVGROUP>) mit dem Schwerpunkt in den USA gewachsen.

==Organisation

Gr��ere Programmierprojekte werden h�ufig als Teamwork durchgef�hrt.
Die Zusammenarbeit der einzelnen Mitglieder ist ein wichtiger Aspekt,
besonders wenn die Team-Mitglieder keinen oder seltenen direkten
Kontakt miteinander haben, wie es bei OpenSource-Projekten h�ufig
der Fall ist.

Folgende Punkte sind f�r gro�e Programmierprojekte wichtig:

* Styleguide

* Versionsverwaltung

* Freigabepolitik

* Regressiontests

* Pflege

F�r das Erlernen von Programmiertechniken, dem Einsatz von
Versionskontrollsystemen und Testverfahren sind die B�cher
der Pragmatic Programmers sehr gut geeignet.

===Versionsverwaltung

===Freigabepolitik

===Regressiontests

===Pflege

Gro�e Anwendungen haben �blicherweise eine Reihe von Schnittstellen,
deren Definition teilweise durch externe Anbieter geschieht. 
Diese sind somit u.U. laufenden �nderungen unterworfen, was eine
st�ndige Anpassung erfordert. 

Die Verwendung von externen Perlmodulen z.B. aus dem CPAN unterliegt
einer �hnlichen Problematik, sobald diese Module ihre Schnittstelle
�ndern. Dabei ist zu bedenken, da� die Benutzer der Anwendung
gew�hnlich verschiedene Versionen dieser Module installiert haben.

===Mailingliste, Website

==Schnittstellen (Module)

===Externe Module

Die Verwendung von externen Module verk�rzt oftmals die Entwicklungszeit,
es sind jedoch einige Punkte zu bedenken.

Gerade wenn Benutzer gew�hnlich die Software selbst in ihrer Perlumgebung
installieren, kann es Schwierigkeiten geben, wenn die Module ihre
Schnittstellen �ndern.

Ein typisches Beispiel f�r so ein Problem waren �nderungen in
\C<SQL::Statement>, die zu Fehlern bei Interchanges internen SQL-Parser
gef�hrt haben. Letztendlich wurde \C<SQL::Statement> durch ein eigenes
Interchange-Modul \C<Vend::SQL_Parser> ersetzt.

Dagegen wurden mit anderen wichtigen Modulen wie \C<DBI> gute
Erfahrungen gemacht.

===Interne Module

Die Aufteilung der Anwendung in internen Module ist grunds�tzlich sinnvoll,
um den Quellcode �bersichtlich zu halten und m�glichst saubere
Schnittstellen zwischen den einzelnen Bestandteilen der Anwendung
zu schaffen.

Ein besonders guter Ansatz ist die Schaffung von Basismodule f�r bestimmte
Funktionalit�ten, da dies Erweiterungen, auch von anderen Entwicklern
m�glich macht.

In Interchange gibt es diese Basismodule f�r

* Datenquellen (Modul \C<Vend::Table::Common>)

* Suchverfahren (Modul \C<Vend::Search>)

* Zahlungsgateways (Modul \C<Vend::Payment>)

Diese stellen die Grundfunktionen zur Verf�gung und sorgen f�r die
Abstraktion der jeweiligen Aufgabe.

Nun k�nnen weitere Module auf der Grundlage dieser Basismodule geschaffen
werden, z.B. \C<Vend::Table::DBI>, um mit SQL-Datenquellen zu kommunizieren.

Besonders offensichtlich ist im Fall von Interchange der Vorteil bei
den Zahlungsgateways. Um ein weiteres Zahlungsgateway an Interchange
an zu binden, kann man ein vorhandenes \C<Vend::Payment> Modul an die
Gegebenheiten des gew�nschten Gateways anpassen und in kurzer Zeit
f�r seinen Onlineshop die Zahlungsfunktionalit�t zur Verf�gung stellen.
Auf diese Weise sind auch etliche Zahlungsmodule in den Quellcode von
Interchange zur�ckgeflossen, wie folgende Tabelle verdeutlicht.

@|
Typ	| Modul	| Beschreibung
Table | \C<Vend::Table::DBI> | SQL-Datenquellen
Table | \C<Vend::Table::LDAP> | LDAP-Datenquellen
Table | \C<Vend::Table::GDBM> | GDBM-Datenquellen 
Table | \C<Vend::Table::SDBM> | SDBM-Datenquellen 
Payment | \C<Vend::Payment::AuthorizeNet> |
Payment | \C<Vend::Payment::BoA> |
Payment | \C<Vend::Payment::CyberCash> |
Payment | \C<Vend::Payment::ECHO> |
Payment | \C<Vend::Payment::EFSNet> |
Payment | \C<Vend::Payment::Linkpoint> |
Payment | \C<Vend::Payment::MCVE> |
Payment | \C<Vend::Payment::PSiGate> |
Payment | \C<Vend::Payment::Signio> |
Payment | \C<Vend::Payment::Skipjack> |
Payment | \C<Vend::Payment::TCLink> |
Payment | \C<Vend::Payment::TestPayment> |
Payment | \C<Vend::Payment::WellsFargo> |
Payment | \C<Vend::Payment::iTransact> |
Search | \C<Vend::DbSearch> | Suche in einer Datenbank
Search | \C<Vend::TextSearch> | Textsuche mit \C<Search::Dict>
Search | \C<Vend::Swish> | Textsuche mit Swish-e 

=== Objektorientierte Programmierung

==Flexibilit�t

Gro�e Anwendungen sollte ein hohes Ma� an Flexibilit�t ausweisen, um
dem Benutzer weitgehende Konfigurations- und Erweiterungsm�glichkeiten
zu geben.

Perl erleichtert es dem Programmierer in seiner Anwendung Flexibilit�t
anzubieten, z.B. durch:

* eval()

* AUTOLOAD

=== eval und Safe

Mit eval bietet Perl eine hervorragende M�glichkeit, selbstgeschriebenen
Code einer Anwendung hinzuf�gen. Um nicht die Stabilit�t der gesamten
Anwendung zu gef�hrden sowie fremden Code nur geringen Spielraum f�r
b�swilligen Aktivit�ten zu geben, bietet sich es an, mit Hilfe von
C<Safe> bzw. C<Safe::Hole> den Code in einer abgeschottenen Umgebung
ablaufen zu lassen. Allerdings verhindert das nicht das Lahmlegen
der Anwendung durch Endlosschleifen bzw. �berm��igen 
Speicherplatzverbrauch.

=== Interchange-Erweiterungen

Interchange bietet dazu u.a. die folgenden M�glichkeiten:

* eigene Usertags

* eigene Paymentmodule

==Praktischer Einsatz

===Perl mit Threadunterst�tzung

Aktuelle Linuxdistributionen werden mit einem Perl ausgeliefert, das
mit Threadunterst�tzung kompiliert wurde, obwohl die Perlautoren
selber davon abraten und nur wenige Anwendungen die Threadunterst�tzung
wirklich benutzen.

Interchange an sich sollte keinerlei Probleme damit haben, aber das
kann nicht f�r alle benutzten Module garantiert werden. Deshalb weigert
sich Interchange zur Zeit, mit dieser Perlvariante zu starten. Das
f�hrt dazu, da� viele Anwender gezwungen sind, sich ihr eigenes Perl
zu bauen.

===Performance

Die Wahl von Perl als Programmiersprache f�r Interchange war auch in
Hinsicht auf die Performance der Anwendung als gut erwiesen. Mit
�hnlichen Systemen in anderen Programmiersprache ist Interchange
konkurrenzf�hig und wird f�r gro�en Websites mit viel Traffic 
eingesetzt. Selbstredend sind dann Optimierungsma�nahmen erforderlich.

===Portierungsprobleme

Eigentlich sollte durch die Verwendung einer Skriptsprache wie Perl
das Betriebssystem wenig Einflu� auf die Anwendung haben.
In der Praxis sind bei der Entwicklung von Interchange doch eine
Reihe von teilweise unerwarteten und nur schwierig zu l�senden
Problemen aufgetreten:

* fehlerhaftes Verhalten von \C<getppid> auf Linuxsystemen mit threaded
  Perl, als Workaround wurde eine Konfigurationsm�glichkeit geschaffen,
  die Interchange anweist \C<getppid> durch \C<syscall(64)> zu ersetzen

==Bibliographie

# ICDEVGROUP. \I<Interchange-Homepage.> \C<http://www.icdevgroup.org>

# Andrew Hunt, David Thomas. \I<The Pragmatic Programmer: From Journeyman to
Master>. Addison-Wesley, 1999. \C<http://www.pragmaticprogrammer.com/>

# Dave Thomas, Andrew Hunt. \I<Pragmatic Version Control with CVS>. The
Pragmatic Bookshelf, 2003.