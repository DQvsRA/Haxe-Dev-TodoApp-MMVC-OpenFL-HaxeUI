package app.controller.commands.todo;

import app.controller.signals.InfoPopupMediatorMessageSignal;
import app.controller.signals.todolist.DeleteTodoSignal;
import consts.strings.MessageStrings;
import app.model.TodoModel;
import mmvc.impl.Command;

class DeleteTodoCommand extends Command
{
    public function new() { super(); }

    @inject public var infoPopupMediatorSignal:InfoPopupMediatorMessageSignal;

    @inject public var todoModel:TodoModel;
    @inject public var id:Int;

    override public function execute():Void
    {
        trace("-> execute: model = " + todoModel);
        trace("-> execute: id = " + id);
        todoModel.deleteTodo(id, DeleteTodoCallback);
    }

    private function DeleteTodoCallback(success:Bool):Void
    {
        var deleteSignal:DeleteTodoSignal = cast signal;
        deleteSignal.complete.dispatch(success ? id : null);

        var message:String = success ?
            MessageStrings.DELETE_ITEM_SUCCESS
        :   MessageStrings.PROBLEM_DELETE_ITEM
        ;

        infoPopupMediatorSignal.dispatch(
            InfoPopupMediatorMessageSignal.SHOW_INFO,
            StringTools.replace(message, "%id%", cast id)
        );
    }
}
