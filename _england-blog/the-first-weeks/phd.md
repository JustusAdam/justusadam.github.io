---
title: "Die ersten Wochen: PhD"
date: 29-01-2020
author: Justus Adam
---


Der PhD kommt sehr gut voran. Ich denke für die wenige Zeit, die ich bis jetzt
hatte um daran zu arbeiten bin ich schon weit voran gekommen. Aber um das ganze
mal etwas in den Zusammenhang zu setzen sollte ich vielleicht kurz erklären
worum es eigentlich geht. Das hat zumindest Robert vorgeschlagen.

## Worum es eigentlich geht

Mein PhD beschäftigt sich mit Type Checking. Genauer gesagt versuche ich
die Untersuchungen von fortschrittlicheren, stärkeren Typsystemen auf ältere,
schwächere Typsysteme anzuwenden indem ich teile der Programme symbolisch
ausführe.

Das hat jetzt sicher keiner verstanden, daher beschreibe ich das noch mal ein
wenig anwendungsbezogener. Ein Computerprogramm besteht essentiell aus 2 Dingen.
Einerseits Daten, zum Beispiel Zahlen, Text oder Listen davon. Dazu kommen dann
Operationen auf diesen Daten, zum Beispiel Addition oder formen der Inspektion
wie beispielsweise das Zählen von Buchstaben.

### Grundlagen der Typtheorie

In einem **Typsystem** wird jedem Datenitem ein Typ, d.h. eine Bezeichnung
zugewiesen, entweder durch den Programmierer oder automatisch durch das System.
In der Regel ist der Typ für eine ganze Zahl `Integer`, für Text `String` und
eine liste davon wäre entsprechend `List<Integer>` oder `List<String>`.

Dazu werden jeder Operation die Typen für die Argumente zugewiesen, sowie die
der Typ von Daten, den die Operation zurück gibt. Also Addition zum Beispiel
hätte die Argumenttypen `(Integer, Integer)` und den Rückgabetyp `Integer`. Die
Operation, welche Buchstaben in einem Text zählt hat die Argumenttypen
`(String)` und den Rückgabetyp `Integer`.

Ein **Typchecker** untersucht dann das Programm und stellt sicher, dass
die Typen der Argumente einer Operationen immer zu den deklarierten
Argumenttypen passen. Zum Beispiel `1 + 1` ist legal, da `1` ein `Integer` ist
was mit den Argumenttypen für Addition übereinstimmt. In selber Weise ist
`ZähleBuchstaben("Ein Stück text")`[^2] legal.

[^2]: In den meisten Programmiersprachen wird Text mit doppelten
    Anführungszeichen dargestellt.

### Generische Typen und Casts

Das sind jetzt sehr einfache Beispiele, die ich hier darstelle. Wenn Programme
größer werden braucht man bisweilen wesentlich kompliziertere Interaktionen
zwischen den Typen. Besonders häufig muss man Daten die zwar strukturell
unterschiedlich sind, aber sich zum gewissen Grad gleich behandeln lassen
manchmal als die Gemeinsamkeit behandeln (*generisch*) oder als ihre eigentliche
Struktur.

Als Beispiel aus der echten Welt nehmen wir ein gelochtes Blatt Papier
(`Papier`) und eine Klarsichtfolie (`Folie`). Beide sind offensichtlich sehr
unterschiedlich in ihrer Struktur. Allerdings sind beide gelocht und können
daher eingeheftet werden. In einem Programm würde man dafür einen neuen Typ
einführen nenn wir ihn mal `Heftbar`. sagen wir mal ich wöllte diese jetzt
einheften, dann wäre eine mögliche Operation vielleicht `einheften(Hefter,
Heftbar) -> Hefter`. Diese Operation nimmt also einen `Hefter` und gibt den
`Hefter` wieder zurück, mit dem neuen `Heftbar` eingeheftet. Da sowohl `Papier`
als auch `Folie` `Heftbar` sind kann ich also beide in den gleichen `Hefter`
einheften. Ich denke es ist jedem klar, dass das praktisch ist.

Das eigentliche Problem tritt jetzt auf wenn ich wieder aushefte. Eine
Operation, die das tun könnte wäre `ausheften(Hefter) -> (Hefter, Heftbar)`.
Wie ihr seht ist die Signatur dieser Operation genau umgekehrt wie `einheften`.
Das ist problematisch, da ich jetzt also ein `Heftbar` erhalte und kein `Papier`
oder `Folie`. Warum? Weil der `Hefter` nicht weiß ob es eine `Folie` oder ein
`Papier` ist. Darum kümmert sich der `Hefter` nicht. Ihn interessiert nur, dass
alles `Heftbar` ist. Wenn ich das soeben Ausgeheftete aber zum Beispiel
beschreiben möchte muss ich aber wissen, ob es sich um ein `Papier` oder eine
`Folie` handelt. Denn auf das `Papier` könnte ich schreiben, auf die `Folie`
nicht. Manchmal tritt nun die Situation auf, dass ein Programmierer ganz sicher
weiß (oder denkt zu wissen), dass in *diesem* `Hefter` *ausschließlich* `Papier`
eingeheftet wird. Dann kann er das Ausgeheftete einfach als `Papier` behandeln
und drauf los schreiben. In der Programmierung nennen wir das einen **cast**.
Sähe dann ungefähr so aus `beschreibe((Papier) ausgeheftetes, "Was zum
draufschreiben")`. Der cast ist `(Papier) ausgeheftetes` womit man dem
Typchecker sagt "benutze `ausgeheftetes` als `Papier`".

### Inhalt des PhD

Meine Arbeit beschäftigt sich nun damit sicher zu stellen, dass das okay ist.
Ich werde ein Programm schreiben, dass in solchen Fällen das Programm analysiert
und sicher stellt, dass in diesem `Hefter` wirklich nur `Papier` ist, da der
normale Typchecker es nicht kann. Besonders vorteilhaft hier ist, dass die
Analyse schon läuft wenn das Programm geschrieben wird und man dem Programmierer
solche Fehler direkt melden kann anstatt erst später, wenn das Programm schon
läuft.

Ich sollte vielleicht dazu sagen, dass solche *casts* vor allem in älteren
Programmiersprachen oft vorkommen. Es gibt neuere Typsysteme, die etwas
komplizierter zu verwenden sind, aber solche `Hefter` besser modellieren.

Die Art und Weise, auf die mein Werkzeug diese Typen checken soll ist indem es
die Teile des Programms extrahiert, die einen Einfluss darauf haben was in dem
`Hefter` landet. Dann simuliert es diese Teile auszuführen um feststellen zu
können, welche Arten von Typen *effektiv* in dem `Hefter` landen könnten.

## Das erste Jahr

Mittlerweile habe ich mit meinem Dokotorvater einen Plan aufgestellt, was im
ersten Jahr so passieren wird.

Üblicherweise ist der großteil des ersten Jahres gefüllt mit Literaturrecherche.
Ganz entlang dieser Tradition werde auch ich jetzt erst mal vor allem Paper
lesen. Dabei kommt es vor allem darauf an herauszufinden was für Werkzeuge es
bereits gibt die ähnliche Hilfen bieten. Dabei gilt es folgendes
herauszufinden:

1. Welche Arten von (Programmier-)Fehlern treten wie oft auf.
2. Welche existierenden Werkzeuge können welche dieser Fehler finden.
3. Wie viel zusätzliche Informationen brauchen diese Werkzeuge von Programmierer.
3. Wie lange brauche diese Werkzeuge um Antworten zu liefern.

Ein Werkzeug, was nur wenige Sekunden braucht ist dafür geeignet während der
Entwicklungsphase kontinuierlich zu laufen, während eines was mehrere Stunden
braucht viel seltener verwendet werden wird (z.B. läuft später über Nacht).

Das ist deswegen interessant, weil mein Projekt zum Ziel hätte einen bestimmten
*Teil* der möglichen Fehler zu finden, ohne zusätzliche Informationen durch den
Programmierer und in kurzer Zeit. Dazu gilt es jetzt zu klären, ob eben genau
diese Nische schon abgedeckt ist. Ich habe für meine Kategorisierung der Fehler
auch schon eine sehr gute erste Studie gefunden!

Gleichzeitig zur dieser Recherche werde ich auch noch verschiedenste Sachen über
die Technologien lesen, die wir für das Werkzeug verwenden wollen. Daraus werde
ich mir dann im laufe der Zeit einen Prototypen des Systems bauen.

Zum Ende des Jahres hin werde ich dann aufschreiben, was bei diesen Recherchen,
sowie weiter eigener Tests und Nachforschungen herausgekommen ist. Daraus soll
dann ein Paper werden, was wir bei einem Workshop einreichen werden. Je nach dem
wie umfangreich alles war wird es ein Paper oder je eins separat für die
Prototyp Experimente/Forschung und die Analyse der Fehler und bestehenden
Werkzeuge.

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

Auf den Plan bin ich gekommen bei der "Kickstart your PhD" Veranstaltung. Die
war jetzt zwar nicht so super interessant und hilfreich, hat aber Denkanstöße
bewirkt. Kurz darauf hatte ich mein 2. Treffen mit Stephen und im Gespräch hat
sich dann dieser Plan ganz natürlich ergeben.

Diese Woche gab es auch noch mal eine Einführung für PhD Studenten in der School
of Computing im speziellen. Das war ganz interessant, weil da vor allem die
Prüfungsmodalitäten erklärt wurden, was für Hardware zur Verfügung seht für
Experimente etc.

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
genommen wurde, aber am ende ist es eine 1.4 für den gesamten Master geworden.
Das ist schon ganz nett.

Und jetzt hab ich noch ein paar ganz spannende Neuigkeiten. Es steht zwar noch
nicht 100% fest, aber es sieht wohl ganz so aus als würde ich über den Sommer
nicht nur für meine geplanten 2 Wochen Konferenzen in den Staaten sein, sondern
ganze 3 Monate. Ich wurde nämlich von Microsoft Research gefragt, ob ich Lust
hätte ein Forschungspraktikum zu machen. Gestern Abend habe ich mit zwei von
deren Forschern gesprochen und ich denke ich hab dabei einen ganz guten Eindruck
gemacht. Wir wollen uns in 2 Wochen noch einmal unterhalten und bis dahin soll
ich mir mal die Projekte ihrer Gruppe anschauen und sagen ob mich irgendwas
davon interessieren würde. Das klingt schon mal ganz nice, zumal ich gehört
habe, dass solche Praktika in der Regel ganz gut bezahlt werden.

Ach ja und als letztes wollte ich noch erwähnen, dass es hier (fast) jeden
Dienstag um halb vier Kuchen gibt. :D

Leider hab ich davon kein Foto gemacht ...
