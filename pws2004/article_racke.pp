=Entwicklung großer Perlanwendungen am Beispiel von Interchange

==Autor

Stefan Hornburg (Racke) \C<<racke@linuxia.de>>

==Abstract

Interchange ist die führende Open Source-Software für eCommerce und wird
ebenfalls als Datenbankfrontend oder CMS eingesetzt. Interchange ist
fast ausschließlich in Perl implementiert und nutzt zahlreiche Module aus dem CPAN.   
Der Einsatz von Perl erlaubt ein großes Maß an Flexibilität, ohne die
Performance entscheidend zu beeinträchtigen. 

Interchange hat sich von einem minimalen Warenkorb zu einem
ausgewachsenen Applikationsserver entwickelt hat. Gleichzeitig ist
das Entwicklungsteam von einer One-Man-Show auf eine weltweit vertretende
Gruppe (\X<ICDEVGROUP>) mit dem Schwerpunkt in den USA gewachsen.

Dieser Vortrag von einem leitenden Interchange-Programmierer berichtet über
die Erfahrungen und Probleme, die im Verlaufe des 8-jährigen
Entwicklungsprozesses gesammelt wurden.

==Funktionsweise von Interchange

Zum besseren Verständnis der folgenden Ausführungen erläutern wir hier kurz
die Funktionsweise und Architektur von Interchange.

Interchange ist ein Applikationsserver, der prinzipiell beliebige viele
als Kataloge bezeichnete Anwendungen unterstützt. Im klassischen
Anwendungsfall entspricht jeder Katalog einem Onlineshop.

Die Kommunikation mit den Benutzern wird durch einen Webserver vermittelt.
Beim Abruf einer Webseite werden die URL, CGI-Parameter und Umgebungsvariable
an ein kleines CGI-Programm weitergeleitet. Dieses CGI-Programm kontaktiert
den Interchange-Dämon über einen Unix- oder TCP/IP-Socket und gibt diese
Daten weiter. Der Interchange-Dämon parst die Daten im Kontext des
jeweiligen Katalogs und gibt eine fertige HTML-Seite über CGI-Programm
und Webserver an den Benutzer zurück. 

===Kataloge und ITL

Ein Katalog setzt sich aus folgende Komponenten zusammen:

* Konfiguration (catalog.cfg, eigene Funktionen)

* Datenquellen

* Seiten, Templates und Komponenten

Letztere setzen sich aus HTML und ITL (Interchange Tag Language) zusammen.

==Organisation

Größere Programmierprojekte werden häufig in Teamarbeit durchgeführt.
Die Zusammenarbeit der einzelnen Mitglieder ist ein wichtiger Aspekt,
besonders wenn die Team-Mitglieder selten oder niemals direkten
Kontakt miteinander haben, wie es in Open Source-Projekten häufig
der Fall ist.

Auf einige wichtige Gesichtspunkte bezüglich großer Programmierprojekte
gehe ich im folgenden ein:

* Styleguide

* Versionsverwaltung

* Regressiontests

* Pflege

===Styleguide

Ein Styleguide erlaubt es den Programmieren, den Quellcode
einheitlich aufzubauen und zu gestalten. Das erleichtert
Neulingen den Einstieg und außerdem die Arbeit mit der Versionsverwaltung.

===Versionsverwaltung

Eine Versionsverwaltung ist für jedes Programmierprojekt zu
empfehlen, selbst wenn es klein ist und nur ein Entwickler
daran arbeitet. Zwingend erforderlich ist es bei einer
verteilten Gruppe von Programmieren, die zudem mehrere
Entwicklungsstränge verfolgen und pflegen müssen.

Die \C<ICDEVGROUP> setzt CVS für Interchange ein, weitere
Open Source-Versionverwaltungen wie subversion sind verfügbar.
Spezielle Probleme mit Perlanwendungen und CVS sind dem
Autor nicht bekannt.

===Regressiontests

Regressiontests haben eine wichtige Bedeutung bei jeder Art
von Programmierprojekten. Diese Tests können überraschende
Verhaltungsänderungen ans Tageslicht bringen und vermeiden
somit Probleme vor Auslieferung der Software. Perl bietet
eine umfangreiche Infrastruktur für Tests.

Die Interchange CVS-Version enthält einen Testkatalog, mit
dessen Hilfe Regressiontests durchgeführt werden können.

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

Für die Kommunikation der Entwickler untereinander und mit den
Anwendern sind weiterhin u.a. Mailinglisten und eine Website
hilfreich. Die Website \C<http://www.icdevgroup.org/> ist gleichzeitig
auch eine Interchange-Anwendung.

===Lesetip

Für das Erlernen von Programmiertechniken, dem Einsatz von
Versionskontrollsystemen und Testverfahren sind die Bücher
der Pragmatic Programmers (siehe Bibliographie) sehr gut geeignet.

==Schnittstellen (Module)

Umfangreiche Anwendungen zeichnen sich gewöhnlich durch ein
Angebot an eigenen Schnittstellen und die Nutzung externer
Schnittstellen aus.

Module bieten sich für die Realisierung von Schnittstellen
in Perlanwendungen an.

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

In Interchange gibt es diese Basismodule u.a. für

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
Datenquellen | \C<Vend::Table::DBI> | SQL-Datenbank
Datenquellen | \C<Vend::Table::LDAP> | LDAP-Verzeichnis
Datenquellen | \C<Vend::Table::GDBM> | Unix-Datenbank (GDBM)
Datenquellen | \C<Vend::Table::SDBM> | Unix-Datenbank (SDBM)
Datenquellen | \C<Vend::Table::DB_File> | Unix-Datenbank (Berkeley)
Datenquellen | \C<Vend::Table::InMemory> | Datenbank im Hauptspeicher
Datenquellen | \C<Vend::Table::Shadow> | Hülle für verschiedenen Datenbanken
Payment | \C<Vend::Payment::AuthorizeNet> | AuthorizeNet
Payment | \C<Vend::Payment::BoA> | Bank of America
Payment | \C<Vend::Payment::CyberCash> | CyberCash
Payment | \C<Vend::Payment::ECHO> | ECHO
Payment | \C<Vend::Payment::EFSNet> | Concord EFSNet
Payment | \C<Vend::Payment::iTransact> | iTransact
Payment | \C<Vend::Payment::Linkpoint> | Linkpoint
Payment | \C<Vend::Payment::MCVE> | Mainstreet Credit Verification Engine
Payment | \C<Vend::Payment::PSiGate> | PSiGate
Payment | \C<Vend::Payment::Signio> | Verisign/Signio Payflow Prow
Payment | \C<Vend::Payment::Skipjack> | Skipjack
Payment | \C<Vend::Payment::TCLink> | TrustCommerce
Payment | \C<Vend::Payment::TestPayment> | Test module
Payment | \C<Vend::Payment::WellsFargo> | WellsFargo
Search | \C<Vend::DbSearch> | Suche in einer Datenbank
Search | \C<Vend::TextSearch> | Textsuche mit \C<Search::Dict>
Search | \C<Vend::Swish> | Textsuche mit Swish-e 

===Objektorientierte Programmierung

Perl bietet in seinem typischen geradlinigen und pragmatischen Ansatz
die Möglichkeit der objektorientierten Programmierung mit fast allem,
was dazugehört. Auch und gerade diese Eigenschaften sind in großen
Anwendungen hilfreich, wenn man sie nicht auf die Spitze treibt.

==Flexibilität

Große Anwendungen sollte ein hohes Maß an Flexibilität ausweisen, um
dem Benutzer weitgehende Konfigurations- und Erweiterungsmöglichkeiten
zu geben.

Perl erleichtert es dem Programmierer in seiner Anwendung Flexibilität
anzubieten, z.B. durch:

* eval()

* AUTOLOAD

===eval und Safe

Mit eval bietet Perl eine hervorragende Möglichkeit, selbstgeschriebenen
Code einer Anwendung hinzufügen. Um nicht die Stabilität der gesamten
Anwendung zu gefährden sowie fremden Code nur geringen Spielraum für
böswilligen Aktivitäten zu geben, bietet sich es an, mit Hilfe von
\C<\X<Safe>> bzw. \C<\X<Safe::Hole>> den Code in einer abgeschottenen Umgebung
ablaufen zu lassen. Allerdings verhindert das nicht das Lahmlegen
der Anwendung durch Endlosschleifen bzw. übermäßigen 
Speicherplatzverbrauch.

Der folgende Ausschnitt aus dem Interchange-Quellcode erzeugt eine
solche abgeschottene Umgebung:

<<EOC
...
else {
	my $pkg = 'MVSAFE' . int(rand(100000));
	undef $MVSAFE::Safe;
	$ready_safe = new Safe $pkg;
	$ready_safe->share_from('MVSAFE', ['$safe']);
	$ready_safe->trap(@{$Global::SafeTrap});
	$ready_safe->untrap(@{$Global::SafeUntrap});
	no strict 'refs';
	$Document   = new Vend::Document;
	*Log = \&Vend::Util::logError;
	*Debug = \&Vend::Util::logDebug;
	*uneval = \&Vend::Util::uneval_it;
	*HTML = \&Vend::Document::HTML;
	$ready_safe->share(@Share_vars, @Share_routines);
	$DbSearch   = new Vend::DbSearch;
	$TextSearch = new Vend::TextSearch;
	$Tag        = new Vend::Tags;
}
$Tmp        = {};
undef $s;
undef $q;
undef $item;
%Db = ();
%Sql = ();
undef $Shipping;
$Vend::Calc_reset = 1;
undef $Vend::Calc_initialized;
return $ready_safe;
EOC

Diese Safe-Umgebungen werden auch verwendet, um embedded Perl
in Interchange-Seiten zu implementieren:

<<EOC
<html>
<head>
<title>Embedded Perl Example</title>
<body>
[perl]
return 'Hello world';
[/perl]
</body>
</html>
EOC

Die Abarbeitung der \C<[perl]>-Blocks geschieht im wesentlichen
mit folgenden Aufruf:

<<EOC
$result = $ready_safe->reval($body);
EOC

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

Die Wahl von Perl als Programmiersprache für Interchange hat sich auch
im Hinblick auf die Performance der Anwendung als gut erwiesen. Mit
ähnlichen Systemen in anderen Programmiersprache ist Interchange
konkurrenzfähig und wird für großen Websites mit viel Traffic 
eingesetzt. Selbstredend sind dann Optimierungsmaßnahmen erforderlich.

===Portierungsprobleme

Eigentlich sollte durch die Verwendung einer Skriptsprache wie Perl
das Betriebssystem wenig Einfluß auf die Anwendung haben.
In der Praxis sind bei der Entwicklung von Interchange doch eine
Reihe von teilweise unerwarteten und nur schwierig zu lösenden
Problemen aufgetreten wie z.B. folgendes:

* fehlerhaftes Verhalten von \C<\X<getppid>> auf Linuxsystemen mit threaded
  Perl, als Workaround wurde eine Konfigurationsmöglichkeit geschaffen,
  die Interchange anweist \C<getppid> durch \C<\X<syscall(64)>> zu ersetzen

==Bibliographie

# ICDEVGROUP. \I<Interchange-Homepage.> \C<http://www.icdevgroup.org>

# Dave Thomas, Andrew Hunt. \I<The Pragmatic Programmer: From Journeyman to
Master>. Addison-Wesley, 1999. \C<http://www.pragmaticprogrammer.com/>

# Dave Thomas, Andrew Hunt. \I<Pragmatic Version Control with CVS>. The
Pragmatic Bookshelf, 2003. \C<http://www.pragmaticprogrammer.com/>