---
title: "Die ersten Wochen: PhD"
date: 27-01-2020
author: Justus Adam
---

## PhD

Der PhD kommt sehr gut voran. Ich denke für die wenige Zeit, die ich bis jetzt
hatte um daran zu arbeiten bin ich schon weit voran gekommen. Aber um das ganze
mal etwas in den Zusammenhang zu setzen sollte ich vielleicht kurz erklären
worum es eigentlich geht. Das hat zumindest Robert vorgeschlagen.

### Worum es eigentlich geht

Mein PhD beschäftigt sich mit Type Checking. Genauer gesagt versuche ich
die Untersuchungen von fortschrittlicheren, stärkeren Typsystemen auf ältere,
schwächere Typsysteme anzuwenden indem ich teile der Programme symbolisch
ausführe.

Das hat jetzt sicher keiner verstanden, daher beschreibe ich das noch mal ein
wenig anwendungsbezogener. Ein Computerprogramm besteht essentiell aus 2 Dingen.
Einerseits Daten, zum Beispiel Zahlen, Text oder Listen davon. Dazu kommen dann
Operationen auf diesen Daten, zum Beispiel Addition oder formen der Inspektion
wie beispielsweise das Zählen von Buchstaben.

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

### Neuigkeiten ###

- kickstart phd
- PGR induction
- plan for the new year
- very good first study
- master note?
- microsoft internship
- Cake day in the office

## Freizeit

- 20th
  - Choir
- Sports plans
  - Signup
  - Bouldering
- the hike
- marlenes visit
- Netflix Vegetarian Documentary

## Organisatorisches

- health insurance
- money
- Got a bike, its nice and pretty cheap, the chap caring for them is also nice
- Got a phone number, don't have reception though

## In der nächsten Folge

- Pictures from the school
