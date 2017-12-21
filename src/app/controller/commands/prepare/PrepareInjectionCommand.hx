package app.controller.commands.prepare;
import app.controller.signals.ApplicationMediatorMessageSignal;
import app.controller.signals.InfoPopupMediatorMessageSignal;
import app.controller.signals.todoform.CreateTodoSignal;
import app.controller.signals.TodoFormMediatorMessageSignal;
import app.controller.signals.todolist.DeleteTodoSignal;
import app.controller.signals.todolist.ToggleTodoSignal;
import app.controller.signals.todolist.UpdateTodoSignal;
import app.controller.signals.TodoListMediatorMessageSignal;
import app.model.TodoModel;
import mmvc.impl.Command;

class PrepareInjectionCommand extends Command
{
    override public function execute():Void
    {
        trace("-> execute");

        injector.mapSingleton( CreateTodoSignal );
        injector.mapSingleton( ToggleTodoSignal );
        injector.mapSingleton( UpdateTodoSignal );
        injector.mapSingleton( DeleteTodoSignal );

        injector.mapSingleton( ApplicationMediatorMessageSignal );
        injector.mapSingleton( InfoPopupMediatorMessageSignal );
        injector.mapSingleton( TodoListMediatorMessageSignal );
        injector.mapSingleton( TodoFormMediatorMessageSignal );

        injector.mapSingleton(TodoModel);
    }

    public function new() { super(); }
}
