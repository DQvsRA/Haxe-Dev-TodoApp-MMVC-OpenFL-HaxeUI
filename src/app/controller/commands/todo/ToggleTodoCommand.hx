package app.controller.commands.todo;

import app.model.vos.Todo;
import app.controller.signals.InfoPopupMediatorMessageSignal;
import consts.strings.MessageStrings;
import app.controller.signals.todolist.ToggleTodoSignal;
import app.model.TodoModel;
import mmvc.impl.Command;

class ToggleTodoCommand extends Command
{
    @inject public var infoPopupMediatorSignal:InfoPopupMediatorMessageSignal;

    @inject public var todoModel:TodoModel;

    @inject public var id:Int;

    override public function execute():Void
    {
        trace("-> execute");
        todoModel.toggleTodo(id, ToggleTodoCallback);
    }

    private function ToggleTodoCallback(success:Bool):Void
    {
        var toggleSignal:ToggleTodoSignal = cast signal;
        toggleSignal.complete.dispatch(success);

        var message:String = success ?
            MessageStrings.TODO_COMPETE
        :   MessageStrings.PROBLEM_UPDATE_TODO
        ;

        var todo:Todo = todoModel.findTodoByID(id);

        infoPopupMediatorSignal.dispatch(
            InfoPopupMediatorMessageSignal.SHOW_INFO,
            StringTools.replace(
                StringTools.replace(message, "%id%", Std.string(id)),
                "%completed%", Std.string(todo.completed)
            )
        );
    }

    public function new() { super(); }
}
