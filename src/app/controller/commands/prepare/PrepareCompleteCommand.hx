package app.controller.commands.prepare;

import app.controller.signals.InfoPopupMediatorMessageSignal;
import app.controller.signals.TodoListMediatorMessageSignal;
import consts.strings.MessageStrings;
import app.model.TodoModel;
import mmvc.impl.Command;

class PrepareCompleteCommand extends Command
{
    @inject public var todoModel:TodoModel;

    @inject public var infoPopupMediatorSignal:InfoPopupMediatorMessageSignal;
    @inject public var todoListMediatorSignal:TodoListMediatorMessageSignal;

    override public function execute():Void
    {
        trace("-> execute");
        trace("-> execute > todoModel = " + todoModel);

        todoModel.loadTodos(function(todos)
        {
            trace("-> loadTodos: " + todos);
            var message:String = MessageStrings.FAIL_TO_LOAD_DATA;
            if(todos != null) {
                todoListMediatorSignal.dispatch(TodoListMediatorMessageSignal.SETUP_TODOS, todos);
                message = MessageStrings.DATA_READY;
            }
            infoPopupMediatorSignal.dispatch(InfoPopupMediatorMessageSignal.SHOW_INFO, message);
        });
    }

    public function new() { super(); }
}
