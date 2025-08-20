#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
API_JAR="libs/spigot-api-1.21.8-R0.1-SNAPSHOT.jar"
if [ ! -f "$API_JAR" ]; then
  echo "Fehlt: $API_JAR"
  echo "Lege die Spigot-API JAR (genaue oder nahe Version) in libs/ ab und benenne sie entsprechend."
  exit 1
fi
echo "Kompiliere mit JDK 21..."
mkdir -p build/classes
find src -name "*.java" > build/sources.txt
javac --release 21 -encoding UTF-8 -cp "$API_JAR" -d build/classes @build/sources.txt
echo "Erzeuge JAR..."
cd build/classes
jar --create --file ../StackMod-Spigot-1.21.8.jar -C . .
cd ..
jar --update --file StackMod-Spigot-1.21.8.jar -C "$SCRIPT_DIR" plugin.yml
echo "Fertig: build/StackMod-Spigot-1.21.8.jar"
