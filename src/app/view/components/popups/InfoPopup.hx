package app.view.components.popups;
import consts.strings.MessageStrings;
import motion.Actuate;
import motion.easing.Quad;
import openfl.display.Graphics;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

class InfoPopup extends Sprite
{
    public var _messageTF:TextField;
    private var _messageBox:Sprite;
    private var _messageTweenActive:Bool = false;
    private var _messageStack:Array<String> = [];

    public function new() { super();

        _messageTF = new TextField();
        _messageTF.width = 200;
        _messageTF.autoSize = TextFieldAutoSize.LEFT;
        _messageTF.multiline = true;
        _messageTF.textColor = 0xfafafa;
        _messageTF.defaultTextFormat.size = 6;
        _messageTF.defaultTextFormat.align = TextFormatAlign.CENTER;
        _messageTF.x = 16;
        _messageTF.y = 8;

        this.addChild(_messageTF);
        this.addEventListener( Event.ADDED_TO_STAGE, HandleAddedToStage );
    }

    private function HandleAddedToStage(e:Event):Void {
        this.removeEventListener( Event.ADDED_TO_STAGE, HandleAddedToStage );
        showMessage( MessageStrings.PREPARING );
    }

    public function showMessage(text:String):Void
    {
        trace("-> showMessage : " + !_messageTweenActive + " text = " + text);
        if(_messageTweenActive == false)
        {
            _messageTF.text = text;

            var W:Int = cast _messageTF.x * 2 + _messageTF.textWidth;
            var H:Int = cast _messageTF.y * 2 + _messageTF.textHeight;
            var T:Float = H / 200;

            var g:Graphics = this.graphics;
            g.clear();
            g.lineStyle(1, 0x323232);
            g.beginFill(0x121212);
            g.drawRect(0, 0, W, H);
            g.endFill();

            var endPosition:Int = cast this.stage.stageHeight - H;
            var startPostion:Int = cast endPosition + H + 2;

            trace("-> position start|end = " + startPostion +"|" + endPosition);

            this.x = (this.stage.width - W) * 0.5;
            this.y = startPostion;

            this.visible = true;
            _messageTweenActive = true;

            Actuate.tween (this, T, { y: endPosition }).ease(Quad.easeOut).onComplete(function(){
                Actuate.tween (this, T * 0.8, { y: startPostion }).delay(_messageStack.length > 0 ? 0.5 : 2).ease(Quad.easeIn).onComplete(function(){
                    _messageTweenActive = false;
                    if(_messageStack.length > 0) showMessage(_messageStack.shift());
                });
            });
        } else _messageStack.push(text);
    }
}
