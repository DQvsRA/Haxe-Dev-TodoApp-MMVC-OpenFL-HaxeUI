package app.model;
import app.model.services.ServerService;
import app.model.vos.Todo;
import consts.network.ServerAPI;
import mmvc.impl.Actor;
import openfl.net.URLRequestMethod;

class TodoModel extends Actor
{
    private var _data:Array<Todo> = new Array<Todo>();
    private var _serverService:ServerService = ServerService.getInstance();

    private var SERVER_TODO_ROUTE(default, never):String = ServerAPI.GATEWAY + ServerAPI.ROUTE_TODOS;

    public function findTodoByID(value:Int):Todo { for(todo in _data) { if(todo.id == value) return todo; } return null; }

    public function toggleTodo(id:Int, callback:Bool -> Void):Void
    {
        var todoVO:Todo = findTodoByID(id);
        _serverService.performRequest(

            SERVER_TODO_ROUTE + "/" + id,
            URLRequestMethod.PUT,

            function(error:String, result:Dynamic):Void
            {
                trace("-> updateTodo: error = " + error + " result = " + result);
                var success:Bool = error == null;
                if(success) todoVO.completed = !todoVO.completed;
                callback(success);
            },

            ["text" => todoVO.text, "completed" => !todoVO.completed]
        );
    }

    public function updateTodo(id:Int, text:String, callback:Bool -> Void):Void
    {
        trace("-> updateTodo: id = " + id + " text = " + text);

        var todoVO:Todo = findTodoByID(id);
        _serverService.performRequest(

            SERVER_TODO_ROUTE + "/" + id,
            URLRequestMethod.PUT,

            function(error:String, result:Dynamic):Void
            {
                trace("-> updateTodo: error = " + error + " result = " + result);
                callback(error == null);
            },

            ["text" => text, "completed" => todoVO.completed]
        );
    }

    public function createTodo(text:String, callback:?Todo -> Void):Void
    {
        trace("-> createTodo: text = " + text);

        _serverService.performRequest(

            SERVER_TODO_ROUTE,
            URLRequestMethod.POST,

            function(error:String, result:Dynamic):Void
            {
                if(error != null) callback(null);
                else {
                    var todoVO:Todo = new Todo(
                        result.id,
                        result.text,
                        result.completed ? result.completed != "false" : false
                    );
                    _data.push(todoVO);
                    callback(todoVO);
                }
            },

            ["text" => text, "completed" => false]
        );
    }

    public function deleteTodo(id:Int, callback:Bool -> Void):Void
    {
        trace("-> deleteTodo: id = " + id);

        _serverService.performRequest(

            SERVER_TODO_ROUTE + "/" + id,
            URLRequestMethod.DELETE,

            function(error:String, result:Dynamic):Void
            {
                var success:Bool = (error == null);
                callback(success);
            }
        );
    }

    public function loadTodos( callback: Array<Todo> -> Void):Void
    {
        trace("-> loadTodos");

        _serverService.performRequest(

            SERVER_TODO_ROUTE,
            URLRequestMethod.GET,

            function(error:String, result:Array<Dynamic>):Void
            {
                if(error != null) callback(null);
                else {
                    var iter:Iterator<Dynamic> = result.iterator();
                    var item:Dynamic;
                    while(iter.hasNext()) {
                        item = iter.next();
                        _data.push(new Todo(
                            item.id,
                            item.text,
                            item.completed ? item.completed != "false" : false
                        ));
                    }
                    callback(_data);
                }
            }
        );
    }

    public function new() { super(); }
}
