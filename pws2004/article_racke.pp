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

==Interchange

Interchange ist eine fast ausschließlich in Perl programmierte 
Open-Source-Software, die sich von einem minimalen Warenkorb zu einem
ausgewachsenen Applikationsserver entwickelt hat. Gleichzeitig ist
das Entwicklungsteam von einer One-Man-Show auf eine weltweit vertretende
Gruppe (\X<ICDEVGROUP>) mit dem Schwerpunkt in den USA gewachsen.

==Organisation

Größere Programmierprojekte werden häufig als Teamwork durchgeführt.
Die Zusammenarbeit der einzelnen Mitglieder ist ein wichtiger Aspekt,
besonders wenn die Team-Mitglieder keinen oder seltenen direkten
Kontakt miteinander haben, wie es bei OpenSource-Projekten häufig
der Fall ist.

Folgende Punkte sind für große Programmierprojekte wichtig:

* Styleguide

* Versionsverwaltung

* Freigabepolitik

* Regressiontests

* Pflege

Für das Erlernen von Programmiertechniken, dem Einsatz von
Versionskontrollsystemen und Testverfahren sind die Bücher
der Pragmatic Programmers sehr gut geeignet.

===Versionsverwaltung

===Freigabepolitik

===Regressiontests

===Pflege

Große Anwendungen haben üblicherweise eine Reihe von Schnittstellen,
deren Definition teilweise durch externe Anbieter geschieht. 
Diese sind somit u.U. laufenden Änderungen unterworfen, was eine
ständige Anpassung erfordert. 

Die Verwendung von externen Perlmodulen z.B. aus dem CPAN unterliegt
einer ähnlichen Problematik, sobald diese Module ihre Schnittstelle
ändern. Dabei ist zu bedenken, daß die Benutzer der Anwendung
gewöhnlich verschiedene Versionen dieser Module installiert haben.

===Mailingliste, Website

==Schnittstellen (Module)

===Externe Module

Die Verwendung von externen Module verkürzt oftmals die Entwicklungszeit,
es sind jedoch einige Punkte zu bedenken.

Gerade wenn Benutzer gewöhnlich die Software selbst in ihrer Perlumgebung
installieren, kann es Schwierigkeiten geben, wenn die Module ihre
Schnittstellen ändern.

Ein typisches Beispiel für so ein Problem waren Änderungen in
\C<SQL::Statement>, die zu Fehlern bei Interchanges internen SQL-Parser
geführt haben. Letztendlich wurde \C<SQL::Statement> durch ein eigenes
Interchange-Modul \C<Vend::SQL_Parser> ersetzt.

Dagegen wurden mit anderen wichtigen Modulen wie \C<DBI> gute
Erfahrungen gemacht.

===Interne Module

Die Aufteilung der Anwendung in internen Module ist grundsätzlich sinnvoll,
um den Quellcode übersichtlich zu halten und möglichst saubere
Schnittstellen zwischen den einzelnen Bestandteilen der Anwendung
zu schaffen.

Ein besonders guter Ansatz ist die Schaffung von Basismodule für bestimmte
Funktionalitäten, da dies Erweiterungen, auch von anderen Entwicklern
möglich macht.

In Interchange gibt es diese Basismodule für

* Datenquellen (Modul \C<Vend::Table::Common>)

* Suchverfahren (Modul \C<Vend::Search>)

* Zahlungsgateways (Modul \C<Vend::Payment>)

Diese stellen die Grundfunktionen zur Verfügung und sorgen für die
Abstraktion der jeweiligen Aufgabe.

Nun können weitere Module auf der Grundlage dieser Basismodule geschaffen
werden, z.B. \C<Vend::Table::DBI>, um mit SQL-Datenquellen zu kommunizieren.

Besonders offensichtlich ist im Fall von Interchange der Vorteil bei
den Zahlungsgateways. Um ein weiteres Zahlungsgateway an Interchange
an zu binden, kann man ein vorhandenes \C<Vend::Payment> Modul an die
Gegebenheiten des gewünschten Gateways anpassen und in kurzer Zeit
für seinen Onlineshop die Zahlungsfunktionalität zur Verfügung stellen.
Auf diese Weise sind auch etliche Zahlungsmodule in den Quellcode von
Interchange zurückgeflossen, wie folgende Tabelle verdeutlicht.

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

==Flexibilität

Große Anwendungen sollte ein hohes Maß an Flexibilität ausweisen, um
dem Benutzer weitgehende Konfigurations- und Erweiterungsmöglichkeiten
zu geben.

Perl erleichtert es dem Programmierer in seiner Anwendung Flexibilität
anzubieten, z.B. durch:

* eval()

* AUTOLOAD

=== eval und Safe

Mit eval bietet Perl eine hervorragende Möglichkeit, selbstgeschriebenen
Code einer Anwendung hinzufügen. Um nicht die Stabilität der gesamten
Anwendung zu gefährden sowie fremden Code nur geringen Spielraum für
böswilligen Aktivitäten zu geben, bietet sich es an, mit Hilfe von
C<Safe> bzw. C<Safe::Hole> den Code in einer abgeschottenen Umgebung
ablaufen zu lassen. Allerdings verhindert das nicht das Lahmlegen
der Anwendung durch Endlosschleifen bzw. übermäßigen 
Speicherplatzverbrauch.

=== Interchange-Erweiterungen

Interchange bietet dazu u.a. die folgenden Möglichkeiten:

* eigene Usertags

* eigene Paymentmodule

==Praktischer Einsatz

===Perl mit Threadunterstützung

Aktuelle Linuxdistributionen werden mit einem Perl ausgeliefert, das
mit Threadunterstützung kompiliert wurde, obwohl die Perlautoren
selber davon abraten und nur wenige Anwendungen die Threadunterstützung
wirklich benutzen.

Interchange an sich sollte keinerlei Probleme damit haben, aber das
kann nicht für alle benutzten Module garantiert werden. Deshalb weigert
sich Interchange zur Zeit, mit dieser Perlvariante zu starten. Das
führt dazu, daß viele Anwender gezwungen sind, sich ihr eigenes Perl
zu bauen.

===Performance

Die Wahl von Perl als Programmiersprache für Interchange war auch in
Hinsicht auf die Performance der Anwendung als gut erwiesen. Mit
ähnlichen Systemen in anderen Programmiersprache ist Interchange
konkurrenzfähig und wird für großen Websites mit viel Traffic 
eingesetzt. Selbstredend sind dann Optimierungsmaßnahmen erforderlich.

===Portierungsprobleme

Eigentlich sollte durch die Verwendung einer Skriptsprache wie Perl
das Betriebssystem wenig Einfluß auf die Anwendung haben.
In der Praxis sind bei der Entwicklung von Interchange doch eine
Reihe von teilweise unerwarteten und nur schwierig zu lösenden
Problemen aufgetreten:

* fehlerhaftes Verhalten von \C<getppid> auf Linuxsystemen mit threaded
  Perl, als Workaround wurde eine Konfigurationsmöglichkeit geschaffen,
  die Interchange anweist \C<getppid> durch \C<syscall(64)> zu ersetzen

==Bibliographie

# ICDEVGROUP. \I<Interchange-Homepage.> \C<http://www.icdevgroup.org>

# Andrew Hunt, David Thomas. \I<The Pragmatic Programmer: From Journeyman to
Master>. Addison-Wesley, 1999. \C<http://www.pragmaticprogrammer.com/>

# Dave Thomas, Andrew Hunt. \I<Pragmatic Version Control with CVS>. The
Pragmatic Bookshelf, 2003.