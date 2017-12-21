package app.view.components;
import app.view.components.todolist.TodoListItem;
import consts.actions.TodoAction;
import consts.Defaults;
import openfl.display.Graphics;
import openfl.display.Sprite;
import openfl.events.Event;

class TodoList extends Sprite
{
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
        this.addChild(item);
    }
}
