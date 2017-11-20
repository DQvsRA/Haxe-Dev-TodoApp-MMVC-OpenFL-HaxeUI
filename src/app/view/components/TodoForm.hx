package app.view.components;

import haxe.ui.Toolkit;
import haxe.ui.components.Button;
import haxe.ui.components.TextField;
import haxe.ui.core.Component;
import consts.Defaults;
import openfl.events.Event;
import openfl.display.Sprite;

class TodoForm extends Sprite
{
    private var _layout:Component;
    public var textField:TextField;
    public var addButton:Button;

    public function new() { super();
        this.addEventListener( Event.ADDED_TO_STAGE, HandleAddedToStage );
    }

    private function HandleAddedToStage(e:Event):Void
    {
        this.removeEventListener( Event.ADDED_TO_STAGE, HandleAddedToStage );

        var MARGIN_TOP_BOTTOM:Int = 12;
        var MARGIN_LEFT_RIGHT:Int = 0;

        var W:Int = cast this.stage.width * Defaults.COMPONENT__FACTOR__WIDTH - MARGIN_LEFT_RIGHT * 2;
        var H:Int = cast this.stage.height * Defaults.COMPONENT__FACTOR__HEADER - MARGIN_TOP_BOTTOM * 2;

//        var g:Graphics = this.graphics;
//        g.beginFill(0xf1f1f1, 0.5);
//        g.drawRect(0,0, W, H);
//        g.endFill();

        this.x = ( stage.width - W ) * 0.5;
        this.y = MARGIN_TOP_BOTTOM;

        _layout = Toolkit.componentFromString(
            '
            <hbox>
                <textfield width="'+ (W - 40) +'" id="txt" text=""/>
                <button id="add" text="ADD" horizontalAlign="right"/>
            </hbox>
        ', "xml");
        this.addChild(_layout);

        textField = _layout.findComponent("txt", TextField);
        addButton = _layout.findComponent("add", Button);
    }

    public function lock():Void {
        textField.alpha = addButton.alpha = 0.5;
        this.mouseEnabled = false;
    }

    public function unlock():Void {
        textField.alpha = addButton.alpha = 1;
        this.mouseEnabled = true;
    }
}
