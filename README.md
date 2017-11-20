"# Haxe-Dev-TodoApp-MMVC-OpenFL-HaxeUI"

This project created in IntelliJ IDEA on Windows
Setup:
1. Open project in IDEA
2. Install json-server and pm2:
    npm install -g json-server && npm install -g pm2@latest
3. Start Server from ./bat/server.bat or with command:
    cd bat && pm2 startOrRestart ../server/server.config.js --watch -i 0 && pm2 logs 0
4. Be sure that haxelib contains nessesary libraries:
    haxelib install openfl
    haxelib install actuate
    haxelib install haxeui-core
    haxelib install  haxeui-openfl
5. Run project in Flash only
