package app.view.components;

import haxe.ui.containers.VBox;
import haxe.ui.containers.ScrollView;
import consts.actions.TodoAction;
import consts.Defaults;
import app.view.components.todolist.TodoListItem;
import openfl.display.Graphics;
import openfl.events.Event;
import openfl.display.Sprite;

class TodoList extends Sprite
{
//    private var _scrollList:ScrollView = new ScrollView();
//    private var _layout:VBox = new VBox();

    public var onAction(null, set):Int->TodoAction->Dynamic->Void;
    public function set_onAction(value:Int->TodoAction->Dynamic->Void){
        this.onAction = value;
        return value;
    }

    public function new() {
        super();
        this.addEventListener( Event.ADDED_TO_STAGE, Handle_AddedToStage );
    }

    private function Handle_AddedToStage(e:Event):Void
    {
        this.removeEventListener( Event.ADDED_TO_STAGE, Handle_AddedToStage );

        var W:Int = cast stage.width * Defaults.COMPONENT__FACTOR__WIDTH;
        var H:Int = cast stage.height * Defaults.COMPONENT__FACTOR__TODOLIST;

        var g:Graphics = this.graphics;
        g.beginFill(0xf8f8f8);
        g.drawRect(0,0, W, H);
        g.endFill();

//        _scrollList.width = W;
//        _scrollList.height = H;
//        _scrollList.addChild(_layout);
//        this.addChild(_scrollList);

        this.x = (stage.width - W ) * 0.5;
        this.y = stage.height - H;
    }

    public function lock():Void { this.mouseEnabled = false; }
    public function unlock():Void { this.mouseEnabled = true; }

    public function toggleTodo(id:Int):Void {
        var counter:Int = 0;
        var child:TodoListItem;
        while(counter < this.numChildren) {
            child = cast getChildAt(counter);
            if(child.id == id) {
                child.completed = !child.completed;
                break;
            }
        }
    }

    public function deleteTodo(id:Int):Void
    {
        var counter:Int = 0;
        var child:TodoListItem;
        while(counter < this.numChildren) {
            child = cast getChildAt(counter);
            if(child.id == id) {
                this.removeChild(child);
            } else {
                child.updatePosition();
                counter++;
            }
        }
    }

    public function addTodo(id:Int, text:String, completed:Bool, initial:Bool = false):Void
    {
        var item:TodoListItem = new TodoListItem(initial);
        item.id = id;
        item.text = text;
        item.completed = completed;
        item.registerEventListener(this.onAction);
//        _layout.addChild(item.layout);
        this.addChild(item);
    }
}
