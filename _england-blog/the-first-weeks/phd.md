---
title: "Die ersten Wochen: PhD"
date: 29-01-2020
author: Justus Adam
published: true
---


Der PhD (steht für Doctor of Philosophy) kommt sehr gut voran. Ich denke für die
wenige Zeit, die ich bis jetzt hatte um daran zu arbeiten bin ich schon weit
voran gekommen. Aber um das ganze mal etwas in den Zusammenhang zu setzen sollte
ich vielleicht kurz erklären worum es eigentlich geht. Das hat zumindest Robert
vorgeschlagen.

## Worum es eigentlich geht

Mein PhD beschäftigt sich mit Type Checking. Genauer gesagt versuche ich
die Untersuchungen von Datentypen, wie es sie in fortschrittlicheren, stärkeren
Typsystemen schon gibt, auf ältere und schwächere Typsysteme zu adaptieren.

Das hat jetzt sicher kaum einer verstanden, daher beschreibe ich das noch mal ein
wenig anwendungsbezogener. Ein Computerprogramm besteht essentiell aus 2 Dingen.
Einerseits Daten, zum Beispiel Zahlen, Text oder Listen davon. Und andererseits
Operationen auf diesen Daten, zum Beispiel Addition oder Formen der Inspektion
wie beispielsweise das Zählen von Buchstaben.

### Grundlagen der Typtheorie

In einem **Typsystem** wird jedem Datenitem ein Typ, d.h. eine Bezeichnung
zugewiesen, entweder durch den Programmierer oder automatisch durch das System.
In der Regel ist der Typ für eine ganze Zahl `Integer`, für Text `String` und
eine Liste davon wäre entsprechend `List<Integer>` oder `List<String>`.

Dazu werden jeder Operation die Typen für die Argumente zugewiesen, sowie die
der Typ von Daten, den die Operation zurück gibt. Also Addition zum Beispiel
hätte die Argumenttypen `(Integer, Integer)` und den Rückgabetyp `Integer`.
Sie addiert zwei ganze Zahlen und gibt eine als Ergebnis zurück. Die
Operation, welche Buchstaben in einem Text zählt hat die Argumenttypen
`(String)` und den Rückgabetyp `Integer`.

Ein **Typchecker** untersucht dann das Programm und stellt sicher, dass
die Typen der Argumente einer Operationen immer zu den deklarierten
Argumenttypen passen. Zum Beispiel `1 + 1` ist legal, da `1` ein `Integer` ist
und es somit mit den Argumenttypen für Addition übereinstimmt. In selber Weise ist
`ZähleBuchstaben("Ein Stück Text")`[^1] legal.

[^1]: In den meisten Programmiersprachen wird Text mit doppelten
    Anführungszeichen dargestellt.

### Casts

Das sind jetzt sehr einfache Beispiele. Wenn Programme größer werden braucht man
bisweilen wesentlich kompliziertere Interaktionen zwischen den Typen. Besonders
häufig muss man Daten, die zwar strukturell unterschiedlich sind, aber eine
Gemeinsamkeit ausweisen, generalisieren und diese Gemeinsamkeit als Datentyp für
jene Daten verwenden.

Als Beispiel aus der realen Welt nehmen wir ein gelochtes Blatt Papier
(`Papier`) und eine Klarsichtfolie (`Folie`). Beide sind offensichtlich sehr
unterschiedlich in ihrer Struktur. Allerdings sind beide gelocht und können
daher eingeheftet werden. In einem Programm würde man dafür einen neuen Typ
einführen, nennen wir ihn mal `Heftbar`. Sagen wir mal ich wöllte diese jetzt
einheften, dann wäre eine mögliche Operation vielleicht `einheften(Hefter,
Heftbar) -> Hefter`. Diese Operation nimmt also einen `Hefter` und gibt den
`Hefter` wieder zurück, mit dem neuen `Heftbar` eingeheftet. Da sowohl `Papier`
als auch `Folie` `Heftbar` sind kann ich also beide in den gleichen `Hefter`
einheften. Ich denke es ist jedem klar, dass das praktisch ist.

Das eigentliche Problem tritt jetzt auf wenn ich wieder aushefte. Eine
Operation, die das tun könnte wäre `ausheften(Hefter) -> (Hefter, Heftbar)`. Wie
ihr seht ist die Signatur dieser Operation genau umgekehrt zu `einheften`. Das
ist problematisch, da ich jetzt also ein `Heftbar` erhalte und kein `Papier`
oder eine `Folie`. Warum? Weil der `Hefter` nicht weiß ob es eine `Folie` oder
ein `Papier` ist. Darum kümmert sich der `Hefter` nicht. Ihn interessiert nur,
dass alles `Heftbar` ist. Wenn ich das soeben Ausgeheftete aber zum Beispiel
beschreiben möchte muss ich aber wissen, ob es sich um ein `Papier` oder eine
`Folie` handelt. Denn auf das `Papier` könnte ich schreiben, auf die `Folie`
nicht.

Manchmal tritt nun die Situation auf, dass ein Programmierer ganz sicher weiß
(oder zu wissen glaubt), dass in *diesem* `Hefter` *ausschließlich* `Papier`
eingeheftet wurde . Dann kann er das Ausgeheftete einfach als `Papier`
behandeln und drauf los schreiben. In der Programmierung nennen wir das einen
**cast**. Das sähe dann ungefähr so aus: `beschreibe((Papier)
ausgeheftetesBlatt, "Text zum draufschreiben")`. Der cast ist `(Papier)
ausgeheftetesBlatt` womit man dem Typchecker sagt "benutze
`ausgeheftetesBlatt` als `Papier`!".

Mit dieser Operation umgeht man die Sicherheiten des Typsystems. Dieses kann nun
nicht mehr garantieren, das wir die Daten in unserem Programm korrekt verwenden.
Wenn so ein cast falsch angewendet wird, also zum Beispiel *doch* eine `Folie`
in dem Hefter war dann können, je nach Programmiersprache schlimme Dinge
geschehen.

In Java beispielsweise wird eine `Exception` geworfen. Das bedeutet, das
Programm ist im Ausnahmezustand und wird beginnen die Ausführung zu beenden bis
ein anderer Programmteil die Situation untersucht und verarbeitet oder, wenn das
nicht passiert, terminiert das Programm. Das ist eine unangenehme Überraschung
für einen Benutzer, wenn plötzlich, ohne Vorwarnung, das Programm abstürzt.

Allerdings sind die Java Fehler noch harmlos. In C beispielsweise wird das
Programm gar nicht *merken*, dass es einen falschen Cast gemacht hat. Es wird
sehr wahrscheinlich die Daten korrumpieren[^k] und andere Programmteile werden
sie nicht mehr korrekt verwenden können. Das ist im Prinzip passiert genau das
was man erwarten würde. Die `beschreibe` Operation tut einfach so, als hätte sie
ein `Papier` vor sich und fängt an auf der Folie herum zu kritzeln. Die Folie
ist danach natürlich nicht mehr zu gebrauchen, was das Programm aber ebenfalls
nicht merkt, sondern es wir einfach nicht mehr lesen können was in der Folie
ist, weil die Kritzeleien das Darunterliegende zu unleserlich machen.

[^k]: Ich habe keine bessere Übersetzung dafür gefunden. Es heißt im prinzip nur
    so viel, dass die Daten in einen Zustand gebracht werden, in dem sie nicht
    sein sollten oder nicht sein dürfen.

### 🎓 Inhalt des PhD

Meine Arbeit beschäftigt sich nun damit sicher zu stellen, dass das auch funktioniert.
Ich werde ein Werkzeug entwerfen und bauen[^w], das in solchen Fällen das Programm analysiert
und prüft, dass in diesem `Hefter` wirklich nur `Papier` ist, da der
normale Typchecker das nicht kann. Besonders vorteilhaft hier ist, dass die
Analyse schon läuft während das Programm geschrieben wird und man dem Programmierer
solche Fehler direkt melden kann, anstatt erst später wenn das Programm schon
läuft.

[^w]: Mit Werkzeug ist hier natürlich auch ein Programm gemein. Programme, die
    Programme analysieren, ja, soetwas gibt es in meiner Informatik-Unterkategorie
    dauernd :D

Ich sollte vielleicht dazu sagen, dass solche *casts* vor allem bei älteren
Typsystemen notwendig sind. Mittlerweile gibt es viele neuere Typsysteme, die
*diese* Arten von Fehlern nicht mehr haben. In der Regel spricht man dann von
einem *stärkeren* Typsystem. Stärke wird hier im Sinne von "Können" verwendet,
solche Typsysteme *können* diese komplizierteren Zusammenhänge abbilden und
verstehen.

Leider ist es aber so, dass Typsysteme in der regel sehr stark mit ihrer
jeweiligen Programmiersprache verbunden sind. Man kann nicht so einfach einer
alten Programmiersprache ein neues Typsystem verpassen. Das führt mindestens
dazu, dass einige Programme, die in dieser Sprache geschrieben sind, dann mit
der neueren Version nicht mehr funktionieren. Und bisweilen ist es tatsächlich
*beweisbar*, dass man es nicht tun kann ohne den fundamentalen Charakter der
Sprache zu verändern. Man müsste also, um ein stärkeres Typsystem verwenden zu
können, sein Programm in einer neuen Sprache neu schreiben, und das ist je nach
Größe des Programms schwierig bis effektiv unmöglich.

### 🔧 Wie arbeitet mein Werkzeug?

Die Art und Weise, auf die mein Werkzeug diese Typen checken soll, ist, indem es
zunächst die Teile des Programms, die einen Einfluss darauf haben was in dem
`Hefter` landet, extrahiert. Diese Technik nennt man "Program Slicing", also
"Programm Zerschneidung" oder "Zerteilung". Ein "slice" ist im wahrsten Sinne
des Wortes eine Scheibe. Mein Werkzeug schaut sich also an wo die Dinge
herkommen, die im `Hefter` sind.

Das kann man sich so vorstellen als würde man die Frage stellen "Was weiß Justus
Adam über Computer" aber man dürfte mich nicht direkt fragen. Man könnte es
berechnen, wenn man wüsste, was ich über Computer alles gelernt habe. Dazu würde
man die Chronologie meines Lebens nehmen und alle die Momente heraussuchen, in
denen ich etwas gelernt habe, **und dann**, für jeden der Menschen, die mir
etwas beigebracht haben heraussuchen wann **sie** etwas gelernt haben und so
weiter, bis alle Ursprünge meines Wissens gefunden worden wären.[^5]

[^5]: Das Beispiel ist nicht ganz richtig, da es keinen gut definierten Ursprung
    für Wissen gibt, während ein Programm definitiv einen wohl definierten
    Beginn hat (nämlich wenn man es startet). Die suche nach dem Wissen würde
    also nie enden, während die Suche im Programm spätestens dann endet, wenn
    wir am Start ankommen.

In diesem Beispiel ist mein Computerwissen die möglichen Typen von Daten, die im
`Hefter` gelandet sein könnten und die Chronologie ist das ganze Programm. Mit
der Suche von gerade eben haben wir einen *slice* der Geschichte erstellt, was nur
darauf ausgelegt ist, mein Computerwissen zu erzeugen. Wenn wir also wissen
wollen, was dieses Wissen ist, können wir einfach den Ablauf dieser
Lernereignisse simulieren und so das Wissen berechnen.

In der echten Welt ist das schwierig, aber in einem Programm steht ja ganz genau
drin, was passiert. Und genau das tut mein Werkzeug. Es nimmt sich den *slice*
und simuliert die Ausführung, um (ich wechsle hier wieder die Analogien)
feststellen zu können, welche (Arten von) Typen *effektiv* in dem `Hefter`
landen könnten.

Diese Technik nennt sich "Symbolic Execution", also symbolische Ausführung. Sie
ist sehr rechenintensiv, weshalb wir vorher das *slicing* anwenden, um das
Programm auf die Berechnung einiger interssanter Werte zu reduzieren.

## 📅 Das erste Jahr


Mittlerweile habe ich mit meinem Dokotorvater einen Plan aufgestellt, was im
ersten Jahr so passieren wird.

Üblicherweise ist der Großteil des ersten Jahres gefüllt mit Literaturrecherche.
Ganz getreu dieser Tradition werde auch ich jetzt erst mal vor allem Paper
lesen. Es vor allem wichtig herauszufinden was für Werkzeuge bereits existieren
die ähnliche Hilfen bieten. Dabei gilt es folgendes herauszufinden:

1. Welche Arten von (Programmier-)Fehlern treten wie oft auf.
2. Welche existierenden Werkzeuge können welche dieser Fehler finden.
3. Wie viel zusätzliche Informationen brauchen diese Werkzeuge von Programmierer.
3. Wie lange brauche diese Werkzeuge um Antworten zu liefern.

Ein Werkzeug, was nur wenige Sekunden braucht eignet sich besonders während der
Entwicklungsphase kontinuierlich zu laufen, während eines, was mehrere Stunden
benötigt, viel seltener verwendet werden wird. (man lässt es dann zB. über Nacht laufen)

Das ist deswegen interessant, weil mein Projekt zum Ziel hat einen bestimmten
*Teil* der möglichen Fehler in kurzer Zeit zu finden, und das ohne zusätzliche
Informationen durch den Programmierer. Nun gilt es jetzt zu klären, ob eben genau
diese Nische schon abgedeckt wurde. Ich habe für meine Kategorisierung der Fehler
auch schon eine sehr gute erste Studie gefunden!

Gleichzeitig zur dieser Recherche werde ich auch noch verschiedenste Sachen über
die Technologien lesen, die wir für das Werkzeug verwenden wollen. Daraus werde
ich mir dann im Laufe der Zeit einen Prototypen des Systems bauen.

Zum Ende des Jahres hin werde ich dann aufschreiben, was bei diesen Recherchen,
sowie weiter eigener Tests und Nachforschungen herausgekommen ist. Daraus
zaubern wir dann ein Paper, was wir bei einem Workshop einreichen werden. Je
nach dem wie umfangreich alles war wird es entweder ein Paper oder zwei, eins
für die Experimente/Forschung mit dem Prototypen, und eins für die Analyse der
Fehler und die bestehenden Werkzeuge.

Und so sieht die Zeittabelle aus, die ich dafür entworfen habe:

| Months              | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---------------------|---|---|---|---|---|---|---|---|---|----|----|----|
| Literature Review   | x | x | x | x | x | x | x |   |   |    |    |    |
| Prototype           |   | x | x | x | x | x | x | x | x |    |    |    |
| Audience Evaluation |   |   |   |   |   | x | x | x | x | x  | x  |    |
| Paper               |   |   |   |   |   |   |   |   |   | x  | x  | x  |
| Networking          |   |   |   |   |   |   | x |   |   |    |    | x  |
|---------------------|---|---|---|---|---|---|---|---|---|----|----|----|

Wie ihr seht steht da auch *Networking* drin, damit ist gemein zu Konferenzen zu
fahren. Mindestens einmal für das/die Paper und vielleicht noch ein zweites Mal,
etwas früher, einfach nur so.

## Neuigkeiten

Auf die Idee bin ich bei der "Kickstart your PhD" Veranstaltung gekommen. Die
war zwar jetzt nicht so super interessant und hilfreich, hat aber Denkanstöße
bewirkt. Kurz darauf hatte ich mein 2. Treffen mit Stephen, meinem Doktorvater,
und im Gespräch hat sich dann dieser Plan ganz natürlich ergeben.

Diese Woche gab es auch noch mal eine Einführung für PhD Studenten in der School
of Computing im speziellen. Das war ganz interessant, weil da vor allem die
Prüfungsmodalitäten erklärt wurden, also was für Hardware für Experimente etc.
zur Verfügung seht.

Hier in England ist die Verteidigung nämlich anders. Das ist kein öffentlicher
Vortrag, sondern ganz privat, nur mit den 2 Prüfern. Es gibt auch keine Noten
("Suma cum laude" und so) dafür aber "corrections". Das bedeutet, dass man (in
der Regel) nach der Verteidigung eine Liste mit Verbesserungen bekommt, die man
noch in die Arbeit einpflegen muss, bevor die Endgültige Version abgenickt wird.
Das können kleinere Änderungen sein ("minor corrections") oder größere
("revision") oder man muss die Arbeit ein Jahr später noch mal abgeben
("resubmission").

Apropos Noten, ich hab mittlerweile auch die Endnote für meinen Master noch
erfahren. Nicht das es irgendjemanden interessiert, da ich ja eh schon hier
genommen wurde, aber am Ende ist es eine 1.4 für den gesamten Master geworden.
Das ist schon ganz nett. Ich bin Justus und ich bin ein alter Streber und Angeber![^3]

[^3]: Kommentar des Lektors

Und jetzt hab ich noch ein paar ganz spannende Neuigkeiten. Es steht zwar noch
nicht 100% fest, aber es sieht wohl ganz so aus als würde ich über den Sommer
nicht nur für meine geplanten 2 Wochen Konferenzen in den Staaten sein, sondern
ganze 3 Monate. Ich wurde nämlich von Microsoft Research gefragt, ob ich Lust
hätte ein Forschungspraktikum zu machen. Gestern Abend habe ich mit zwei von
deren Forschern gesprochen und ich denke ich hab dabei einen ganz guten Eindruck
hinterlassen. Wir wollen uns in 2 Wochen noch einmal unterhalten und bis dahin soll
ich mir mal die Projekte ihrer Gruppe anschauen und sagen ob mich irgendwas
davon interessieren würde. Das klingt schon mal ganz nice, zumal ich gehört
habe, dass solche Praktika in der Regel ganz gut bezahlt werden.

Ach ja und als letztes wollte ich noch erwähnen, dass es hier (fast) jeden
Dienstag um halb vier Kuchen gibt. 🍰💟

Leider hab ich davon kein Foto gemacht ...

Und damit bin ich am Ende. Heute war ein bisschen starker Tobak, aber ich hoffe
das hilft euch ein bisschen besser zu verstehen, was ich in nächster Zeit so
versuchen werde zu tun.

🇪🇺🇬🇧 Heute ist Brexit Tag, oder wie es in der Kaffeeküche schon sarkastisch genannt
wurde "Independence Day". Ich grüße euch also alle jetzt offiziell von außerhalb
der EU. 😢 👋 🇬🇧🇪🇺
