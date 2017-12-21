"# Haxe-Dev-TodoApp-MMVC-OpenFL-HaxeUI"

This project created in IntelliJ IDEA on Windows
Setup:
1. Open project in IDEA
2.1 Install server dependencies: npm install
2.2 Install process manager - pm2: npm install pm2 -g
3. Start server by running in terminal: pm2 startOrRestart ./server/server.config.js --watch -i 0 && pm2 logs 0 --lines 100
4. Be sure that haxelib contains nessesary libraries:
    <br>haxelib install openfl
    <br>haxelib install actuate
    <br>haxelib install haxeui-core
    <br>haxelib install haxeui-openfl
5. Run: openfl test html5

![How it's looks like](https://s1.gifyu.com/images/animka00.gif)
