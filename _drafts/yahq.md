1. Nutz nicht cabal direkt, sondern 'stack'

    docs.haskellstack.org
    Das ist quasi noch mal ein extra tool, was noch ein bisschen mehr project management macht als cabal (benuttz intern auch cabal, hat aber noch extra features)
    z.b. kann stack für dich mehrere GHC versionen auf dem system managen
    und du kannst unheimlich einfach lokale packages (also welche die nicht in hackage sind zu deinem projekt hinzufügen)
    Vor allem händelt der aber die libraries snapshot based. D.h. der hat eine selection von packages + versions die gut zusammenpassen (getestet)
    Steht aber auch alles gut in den docs drin.

2. Library management immer über das .cabal file
    
    - Wenn du eine neue library für dein projekt brauchst einfach in der "build-depends" section deines .cabal files eintragen, das nächste mal, wenn du dann dein Project baust mit `stack build` wird er automatisch die library runterladen. Wenn du stack benutzt, brauchst du dich erst mal nicht un version bounds kümmern, einfach nur den namen in die comma separated list eintrage, done.

    - Stack's default setup sieht auch vor, dass du dein projekt in "library" und "executable" unterteils, (das siehst du in dem .cabal file, nach dem du `stack new` aufgerufen hast). Diese unterteilung ist eigentlich immer sinnvoll, du kannst aber natürlich am anfang auch erst mal allen code einfach nur in die "Main.hs" schreiben und beachtest die library gar nicht. Später merkt man manchmal, dass man einige funktionalität des projekts doch gerne noch mal in einem anderen Prijekt wiederverwenden würde, dann kann man die library sehr einfach importieren. Die Executable kannst du übrigens mit `stack install` auf deinem system "global" installieren oder lokal mit `stack exec <executable-name> <arguments>` ausführen.

3. IDE

    - Es gibt für haskell mehrere möglichkeiten IDE's zu benutzen, allen voran `ghc-mod` und plugins die darauf aufbauen, z.b. in emacs oder atom gibt es haskell-ide plugins die das benutzen. Allerdings hat ghc-mod manchmal so seine macken, ich empfehle daher `ghcid`. Einfach installieren mit `stack install ghcid` und dann im root folder deines projekts mit `ghcid` auf der kommandozeile aufrufen. Der zeigt die dann immer live den compiler output an, aka type errors, parse errors etc, und der lädt automtisch neu, wenn du files speicherst. `ghcid` ist bei weitem die stabilste Haskell "IDE".

4. Searching

    - Auf hackage.haskell.org findest du open source libaries und du kannst dort auch danach suchen. Allerdings nur nach library namen und description glaube ich. Häufig ist es besser, wenn du nach einer guten library suchst einfach google zu nehmen, das bringt dich meist zur besten hackage library für deine bedürfnisse. Was du auf Hackage for allem findest ist die Dokumentation für die Libraries. Pro tip, du kannst auch die komplette dokumentation für die libraries, welche du in deinem projekt verwendest lokal installieren (dabei ist auch die dokumentation, die du für das projekt selber geschrieben hast dabei ;) ) mit `stack haddock`. Danach findest du die KOMBINIERTE doku unter <project>/.stack-work/install/doc/all/index.html (oder so ähnlich). Da kannst du die doku dann nach modulen browsen.

    - Wenn du nach speziellen funktionen, typklassen oder typen suchst gibt es die suchmaschine "hoogle" (haskell.org/hoogle). Dort kannst du funktionen nach namen suchen, oder aber auch nach typen!!! also di kannst funktionene nach typsignatur suchen. Wenn du zum beispiel nach einer möglichkeit suchst einen `String` zu `Text` zu machen kannst du in hoogle einfach nach `String -> Text` suchen :). Pro tip: Wenn hoogle mal nicht das richtige findet, liegt es vielleicht dara, dass er nicht die richtigen libraries durchsucht, mit '+' kannst du ihm sagen zusätzliche libraries zu durchsuchen, z.B. `Text -> String +text` durchsucht zusätzliche die `text` library.

5. Library empfehlungen

    Einige Libraries, die du auf jeden fall brauchen wirst:
        - `mtl` (useful monads)
        - `containers` (Sets, Efficient lists, general purpose tree, Maps (dict))
        - `unordered-containers` (HashSet, HashMap) kannst aber auch `containers` nehmen, wenn es nicht unbedingt HashMap sein muss :D
        - `aeson` (JSON parsing + encoding)
        - `directory` and `filepath` (Directory and filepath manipulation and reading/writing)

        und vielleicht noch
        - `process` (execute other programs, shell commands and the like) 
        
    Früher oder später stößt du auch auf die typen `Text` und `Bytestring`, das sind effiziente strings in Haskell (im gegensatz zu `String`), die libraries dazu sind `text` und `bytestring` und die sind am anfang manchmal bisschen anstrengend, sag bescheid, wenn du da nicht hilfe brauchst.