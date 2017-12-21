package app.view.components.todolist;
import consts.actions.TodoAction;
import haxe.ui.components.Button;
import haxe.ui.components.CheckBox;
import haxe.ui.components.TextField;
import haxe.ui.core.Component;
import haxe.ui.core.MouseEvent;
import haxe.ui.Toolkit;
import motion.Actuate;
import openfl.display.Sprite;
import openfl.events.Event;

class TodoListItem extends Sprite
{
    private var _chb:CheckBox;
    private var _txt:TextField;
    private var _upd:Button;
    private var _del:Button;

    private var _initial:Bool;

    public var layout(default, null):Component;
    public var id(default, default):Int;

    private var _eventHandler:Int->TodoAction->Dynamic->Void;

    private var PADDING(default, never):Int = 16;

    public function registerEventListener(value:Int->TodoAction->Dynamic->Void){
        _eventHandler = value;
        _chb.onClick = HandleCheckBoxChangedEvent;
        _upd.onClick = HandleUpdateButtonEvent;
        _del.onClick = HandleDeleteButtonEvent;
    }

    private function HandleDeleteButtonEvent(e:MouseEvent):Void {
        _eventHandler(this.id, TodoAction.DELETE, true);
    }

    private function HandleUpdateButtonEvent(e:MouseEvent):Void {
        _eventHandler(this.id, TodoAction.UPDATE, _txt.text);
    }

    private function HandleCheckBoxChangedEvent(e:MouseEvent):Void {
        _eventHandler(this.id, TodoAction.TOGGLE, _chb.selected );
    }

    public var completed(get, set):Bool;
    public function get_completed():Bool { return _chb.selected; }
    public function set_completed(value:Bool) {
        _chb.selected = value;
        return value;
    }

    public var text(get, set):String;
    public function get_text():String { return _txt.text; }
    public function set_text(value:String) {
        _txt.text = value;
        return value;
    }

    public function new(initial:Bool)
    {
        super();

        this.addEventListener( Event.ADDED_TO_STAGE, Layout );

        this.layout = Toolkit.componentFromString(
        '
            <hbox opacity="0">
                <checkbox id="chb" text="" selected="false" horizontalAlign="left" verticalAlign="center"/>
                <textfield width="400" id="txt" text=""/>
                <button id="update" text="update" horizontalAlign="right"/>
                <button id="delete" text="delete" horizontalAlign="right"/>
            </hbox>
        ', "xml");
        this.addChild(layout);

        layout.includeInLayout = false;
        _chb = layout.findComponent("chb", CheckBox);
        _txt = layout.findComponent("txt", TextField);
        _upd = layout.findComponent("update", Button);
        _del = layout.findComponent("delete", Button);
    }

    public function Layout(e:Event):Void
    {
        this.removeEventListener( Event.ADDED_TO_STAGE, Layout );
        var W:Int = cast this.parent.width;

        this.x = PADDING;
        var that = this;

        haxe.Timer.delay(function(){
            _txt.width += W - layout.width - PADDING * 2;
            Actuate.tween(layout, 1, {opacity: 1}).delay(_initial ? this.parent.getChildIndex(this) * 0.5 : 0);
            updatePosition();
        }, 0);
    }

    public function updatePosition():Void
    {
        this.y = PADDING + this.parent.getChildIndex(this) * (layout.height + PADDING);
    }
}
