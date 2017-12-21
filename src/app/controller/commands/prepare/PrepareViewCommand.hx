package app.controller.commands.prepare;
import app.view.components.popups.InfoPopup;
import app.view.components.TodoForm;
import app.view.components.TodoList;
import app.view.mediators.ApplicationMediator;
import app.view.mediators.InfoPopupMediator;
import app.view.mediators.TodoFormMediator;
import app.view.mediators.TodoListMediator;
import flash.display.Sprite;
import mmvc.impl.Command;

class PrepareViewCommand extends Command
{
    override public function execute():Void
    {
        trace("-> execute");

        var appMediator         : ApplicationMediator   = new ApplicationMediator();
        var infoPopupMediator   : InfoPopupMediator     = new InfoPopupMediator();
        var todoListMediator    : TodoListMediator      = new TodoListMediator();
        var todoFormMediator    : TodoFormMediator      = new TodoFormMediator();

        var appRoot     : Sprite    = cast contextView;
        var todoList    : TodoList  = new TodoList();
        var todoForm    : TodoForm  = new TodoForm();
        var infoPopup   : InfoPopup = new InfoPopup();

        appRoot.addChild(todoList);
        appRoot.addChild(todoForm);
        appRoot.addChild(infoPopup);

        injector.injectInto(appMediator);
        injector.injectInto(infoPopupMediator);
        injector.injectInto(todoListMediator);
        injector.injectInto(todoFormMediator);

        mediatorMap.registerMediator(appRoot, appMediator);
        mediatorMap.registerMediator(infoPopup, infoPopupMediator);
        mediatorMap.registerMediator(todoList, todoListMediator);
        mediatorMap.registerMediator(todoForm, todoFormMediator);
    }

    public function new() { super(); }
}
