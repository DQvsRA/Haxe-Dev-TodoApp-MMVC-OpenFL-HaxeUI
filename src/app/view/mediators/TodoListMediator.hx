package app.view.mediators;

import app.controller.signals.todolist.ToggleTodoSignal;
import app.controller.signals.todolist.UpdateTodoSignal;
import app.controller.signals.todolist.DeleteTodoSignal;
import app.controller.signals.TodoListMediatorMessageSignal;
import consts.actions.TodoAction;
import app.model.vos.TodoVO;
import app.view.components.TodoList;
import mmvc.impl.Mediator;

class TodoListMediator extends Mediator<TodoList>
{
    @inject public var messageSignal:TodoListMediatorMessageSignal;

    @inject public var deleteTodoSignal:DeleteTodoSignal;
    @inject public var updateTodoSignal:UpdateTodoSignal;
    @inject public var toggleTodoSignal:ToggleTodoSignal;

    override public function onRegister()
    {
        super.onRegister();

        trace("-> onRegister: view = " + view);
        trace("-> onRegister: interestsSignal = " + messageSignal);

        messageSignal.add(HandleMessageSignal);

        var todoList:TodoList = cast getViewComponent();
        todoList.onAction = HandleTodoListAction;
    }

    private function HandleTodoListAction(id:Int, action:TodoAction, data:Dynamic):Void {
        var todoList:TodoList = cast getViewComponent();
        todoList.lock();
        trace(id+":"+action+":"+data);
        switch(action) {
            case TodoAction.UPDATE:
            {
                updateTodoSignal.complete.addOnce(function(success:Bool):Void {
                    todoList.unlock();
                });
                var text:String = cast data;
                updateTodoSignal.dispatch(id, text);
            }
            case TodoAction.TOGGLE:
            {
                toggleTodoSignal.complete.addOnce(function(success:Bool):Void {
                    todoList.unlock();
                    if(success == false) {
                        todoList.toggleTodo(id);
                    }
                });
                var selected:Bool = cast data;
                toggleTodoSignal.dispatch(id);
            }
            case TodoAction.DELETE:
            {
                deleteTodoSignal.complete.addOnce(function(?id:Int):Void {
                    var success = id != null;
                    if(success) todoList.deleteTodo(id);
                    todoList.unlock();
                });
                deleteTodoSignal.dispatch(id);
            }
        }
    }

    private function HandleMessageSignal(type:String, ?data:Dynamic):Void
    {
        switch(type) {
            case TodoListMediatorMessageSignal.ADD_TODO:
            {
                var todo:TodoVO = cast data;
                var todoList:TodoList = cast getViewComponent();
                todoList.addTodo(todo.id, todo.text, todo.completed);
            }
            case TodoListMediatorMessageSignal.SETUP_TODOS:
            {
                var arr:Array<TodoVO> = cast data;
                var todoList:TodoList = cast getViewComponent();
                for(todo in arr) todoList.addTodo(
                    todo.id,
                    todo.text,
                    todo.completed,
                    true
                );
            }
        }
    }

    override public function onRemove():Void
    {
        super.onRemove();
    }
}
