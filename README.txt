StackMod (Spigot 1.21.8) – Offline Build Kit

Voraussetzungen:
- Java JDK 21 installiert (javac und jar im PATH)
- Spigot-API JAR (z.B. org.spigotmc:spigot-api:1.21.8-R0.1-SNAPSHOT)

Schritte:
1) Lege die Spigot-API JAR in den Ordner 'libs' und benenne sie:
   libs/spigot-api-1.21.8-R0.1-SNAPSHOT.jar
   (Eine nahe Version wie 1.21.4 funktioniert i.d.R. auch.)
2) Linux/macOS:   ./build.sh
   Windows (CMD): build.bat
3) Ergebnis liegt unter: build/StackMod-Spigot-1.21.8.jar

Diese JAR ist ein normales Spigot-Plugin (nur API als compileOnly),
und wird von deinem Server bereitgestellt. Die JAR bitte in den
'plugins/'-Ordner deines Spigot/Paper-Servers legen.
