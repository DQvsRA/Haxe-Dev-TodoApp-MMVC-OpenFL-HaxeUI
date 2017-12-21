package app.controller.commands.todo;

import app.controller.signals.InfoPopupMediatorMessageSignal;
import app.controller.signals.todoform.CreateTodoSignal;
import app.controller.signals.TodoFormMediatorMessageSignal;
import app.controller.signals.TodoListMediatorMessageSignal;
import consts.strings.MessageStrings;
import app.model.vos.Todo;
import app.model.TodoModel;
import mmvc.impl.Command;

class CreateTodoCommand extends Command
{
    @inject public var infoPopupMediatorSignal:InfoPopupMediatorMessageSignal;
    @inject public var todoListMediatorSignal:TodoListMediatorMessageSignal;
    @inject public var todoFormMediatorSignal:TodoFormMediatorMessageSignal;

    @inject public var todoModel:TodoModel;
    @inject public var text:String;

    override public function execute():Void
    {
        trace("-> execute");

        var isNotEmpty:Bool = text.length > 0;
        var message:String;

        if(isNotEmpty)
        {
            message = MessageStrings.SAVING_NEW_TODO;
            todoModel.createTodo(text, CreateTodoCallback);
        }
        else
        {
            message = MessageStrings.EMPTY_TODO;
            var createSignal:CreateTodoSignal = cast signal;
            createSignal.complete.dispatch(false);
        }

        infoPopupMediatorSignal.dispatch(
            InfoPopupMediatorMessageSignal.SHOW_INFO,
            message
        );
    }

    private function CreateTodoCallback(?todoVO:Todo = null):Void
    {
        var success:Bool = todoVO != null;

        var createSignal:CreateTodoSignal = cast signal;
        createSignal.complete.dispatch(success);

        if(success){
            todoListMediatorSignal.dispatch( TodoListMediatorMessageSignal.ADD_TODO, todoVO );
            todoFormMediatorSignal.dispatch( TodoFormMediatorMessageSignal.CLEAR_FORM, null );
        }

        infoPopupMediatorSignal.dispatch(
            InfoPopupMediatorMessageSignal.SHOW_INFO,
            success ?
                MessageStrings.TODO_SAVED
            :   MessageStrings.PROBLEM_SAVING_TODO
        );
    }

    public function new() { super(); }
}
