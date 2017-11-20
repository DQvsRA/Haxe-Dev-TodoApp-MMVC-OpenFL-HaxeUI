package app.controller.commands.todo;

import app.controller.signals.InfoPopupMediatorMessageSignal;
import consts.strings.MessageStrings;
import app.controller.signals.todolist.UpdateTodoSignal;
import app.model.TodoModel;
import mmvc.impl.Command;

class UpdateTodoCommand extends Command
{
    @inject public var infoPopupMediatorSignal:InfoPopupMediatorMessageSignal;

    @inject public var todoModel:TodoModel;

    @inject public var id:Int;
    @inject public var text:String;

    override public function execute():Void
    {
        trace("-> execute");
        var isNotEmpty:Bool = text.length > 0;
        var isChanged:Bool = todoModel.findTodoByID(id).text.indexOf(text) == -1;
        if(isNotEmpty && isChanged){
            todoModel.updateTodo(id, text, UpdateTodoCallback);
        } else {
            infoPopupMediatorSignal.dispatch(
                InfoPopupMediatorMessageSignal.SHOW_INFO,
                isChanged ?
                    MessageStrings.TODO_CANT_BE_UPDATED
                :   MessageStrings.SAME_TODO_CANT_UPDATE
            );
        }
    }

    private function UpdateTodoCallback(success:Bool):Void
    {
        var updateSignal:UpdateTodoSignal = cast signal;
        updateSignal.complete.dispatch(success);

        var message:String = success ?
            MessageStrings.TODO_UPDATED
        :   MessageStrings.PROBLEM_UPDATE_TODO
        ;

        infoPopupMediatorSignal.dispatch(
            InfoPopupMediatorMessageSignal.SHOW_INFO,
            StringTools.replace(message, "%id%", cast id)
        );
    }

    public function new() { super(); }
}
