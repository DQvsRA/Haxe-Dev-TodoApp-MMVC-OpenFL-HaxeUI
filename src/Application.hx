package ;

import motion.easing.Quad;
import motion.Actuate;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import consts.strings.MessageStrings;
import haxe.ui.Toolkit;
import app.ApplicationContext;
import mmvc.api.IViewContainer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.display.Graphics;
import openfl.display.Sprite;

class Application extends Sprite implements IViewContainer
{
    public var viewAdded:Dynamic -> Void;
    public var viewRemoved:Dynamic -> Void;

    private var _context:ApplicationContext;

    public function new() {
        super();

        if(this.stage != null) Init();
        else this.addEventListener(Event.ADDED_TO_STAGE, Init);
    }

    private function Init(?e:Event = null) {
        if(e != null) this.removeEventListener(Event.ADDED_TO_STAGE, Init);

        Toolkit.init();

        var g:Graphics = this.graphics;
        g.beginFill(0x212121);
        g.drawRect(0,0, this.stage.stageWidth, this.stage.stageHeight);
        g.endFill();

        _context = new ApplicationContext(this, true);
    }

    public function isAdded(view:Dynamic):Bool
    {
        return true;
    }
}
